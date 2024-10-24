<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<%@include file="../master/head.jsp" %>
<body>
<!-- ======= Header ======= -->
<%@include file="../master/header.jsp" %>
<!-- End Header -->
<!-- ======= Sidebar ======= -->
<%@include file="../master/sidebar.jsp" %>
<!-- End Sidebar-->
<main id="main" class="main">
    <div class="pagetitle">
        <h1>Dashboard</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/">Home</a></li>
                <li class="breadcrumb-item active">Dashboard</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section dashboard">
        <div class="col-12 row">
            <% RoomType roomType = (RoomType) request.getAttribute("roomType");%>
            <% Hotel hotel_of_room_type = (Hotel) request.getAttribute("hotel");%>
            <div class="col-5">
                <div class="col-12">
                    <div class="row">
                        <img id="preview_image" style="max-width: 100%; object-fit: cover"
                             class="p-0 img-thumbnail border-4 border-dark" src="" alt="">
                    </div>
                    <div class="row mt-2" id="small_images">
                        <h3>Khách sạn: <%=roomType.hotel_name%></h3>
                    </div>
                </div>
            </div>
            <div class="col-7">
                <h3>Khách sạn:<%=hotel_of_room_type.name%></h3>
                <h3>Loại phòng:<%=roomType.name%></h3>
                <h3>Mô tả:<%=roomType.description%></h3>
                <h5>tiện ích:
                    <% for (int i = 0; i < roomType.utilities.length; i++) { %>
                        <%=roomType.utilities[i].name%>,
                    <% } %>
                </h5>
                <h5>Giá: <%=roomType.price%>(vnd)</h5>
                <form action="" method="get">
                    <p>Chọn ngày để kiểm tra phòng trống.</p>
                    <div class="col-12 row">
                        <input type="hidden" name="id" value="<%=roomType.id%>">
                        <div class="col-6">
                            <label for="from_date" class="form-label">Từ ngày</label>
                            <div class="input-group has-validation">
                                <input type="date" name="from_date" class="form-control" id="from_date" value="<%=request.getParameter("from_date") == null ? "" : request.getParameter("from_date")%>" required>
                                <div class="invalid-feedback">Vui lòng chọn ngày</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <label for="to_date" class="form-label">Đến ngày</label>
                            <div class="input-group has-validation">
                                <input type="date" name="to_date" class="form-control" id="to_date" value="<%=request.getParameter("to_date") == null ? "" : request.getParameter("to_date")%>" required>
                                <div class="invalid-feedback">Vui lòng chọn ngày</div>
                            </div>
                        </div>
                        <div class="col-12 row m-1">
                            <button type="submit" class="btn btn-success">
                                Kiểm tra phòng trống
                            </button>
                        </div>
                    </div>
                </form>
                <div class="col-12 row m-1">
                    <% ArrayList<Room> rooms; %>
                    <% rooms = request.getAttribute("rooms") != null ? (ArrayList<Room>) request.getAttribute("rooms") : new ArrayList<>();%>
                    <% for (int i = 0; i < rooms.size(); i++) { %>
                        <button onclick="chooseRoom(<%=rooms.get(i).id%>)" id="<%=rooms.get(i).id%>" class="btn btn-outline-info col-1 m-1 available-room"><%=rooms.get(i).number%></button>
                    <% } %>
                </div>
                <form action="<%=request.getContextPath()%>/customer/book-room" method="post">
                    <input type="hidden" name="room_id" id="room_id">
                    <input type="hidden" name="room_type_id" id="room_type_id" value="<%=roomType.id%>">
                    <input hidden="hidden" type="date" name="from_date" class="form-control" id="from_date_book" value="<%=request.getParameter("from_date") == null ? "" : request.getParameter("from_date")%>" required>
                    <input hidden="hidden" type="date" name="to_date" class="form-control" id="to_date_book" value="<%=request.getParameter("to_date") == null ? "" : request.getParameter("to_date")%>" required>
                    <button class="btn btn-success" id="submit_book_form" type="submit" disabled>Đặt phòng</button>
                </form>
            </div>
        </div>
        <div class="col-12 row m-1">
            <%=hotel_of_room_type.gg_map_link%>
        </div>
    </section>

</main>
<!-- End #main -->

<!-- ======= Footer ======= -->
<%@include file="../master/footer.jsp" %>
<!-- End Footer -->

<%@include file="../master/js.jsp" %>

</body>
<script>
    const width = $("#small_images").width();
    const each_img_width = Math.floor(width / 4);
    const images = JSON.parse('<%=roomType.getImagesJson()%>')
    changePreview(0)
    function changePreview(i) {
        for (let i = 0; i < images.length; i++) {
            images[i].previewing = false
        }
        images[i].previewing = true
        var html = "";
        for (let i = 0; i < images.length; i++) {
            if (images[i].previewing === true) {
                $("#preview_image").attr("src", images[i].url);
                html += `<img style="object-fit: contain; max-width: ` + (each_img_width - 10) + `px" class="small_images m-1 p-0 img-thumbnail border-3 border-primary" onclick='changePreview(`+i+`)' src='` + images[i].url + `' alt="none">`;
            } else {
                html += `<img style="object-fit: contain; max-width: ` + (each_img_width - 10) + `px" class="small_images m-1 p-0 img-thumbnail" onclick='changePreview(`+i+`)' src='` + images[i].url + `' alt="none">`;
            }
        }
        $("#small_images").html(html)
    }
    function chooseRoom(id) {
        $(".available-room").attr("class", "btn btn-outline-info col-1 m-1 available-room");
        $("#" + id).attr("class", "btn btn-info col-1 m-1 available-room");
        $("#room_id").val(id)
        $("#submit_book_form").prop('disabled', false);
    }
</script>
</html>