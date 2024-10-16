<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.*" %>
<%@ page import="java.util.Arrays" %>
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
                <li class="breadcrumb-item active">Quản lý phòng</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section dashboard">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#verticalycentered">
            Thêm mới phòng
        </button>
        <div class="modal fade" id="verticalycentered" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm mới loại phòng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="<%=request.getContextPath()%>/hotel/add-room" method="post"
                          enctype="multipart/form-data">
                        <div class="modal-body">
                            <div class="col-12">
                                <label for="room_type_id" class="form-label">Loại phòng</label>
                                <div class="input-group has-validation">
                                    <select class="form-control" name="room_type_id" id="room_type_id">
                                        <% ArrayList<RoomType> roomTypes = (ArrayList<RoomType>) request.getAttribute("roomTypes");%>
                                        <% for (int i = 0; i < roomTypes.size(); i++) { %>
                                        <option value="<%=roomTypes.get(i).id%>"><%=roomTypes.get(i).name%>
                                        </option>
                                        <% } %>
                                    </select>
                                    <div class="invalid-feedback">Vui lòng chọn loại phòng</div>
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="utilities" class="form-label">Tiện ích</label>
                                <div class="input-group has-validation">
                                    <select class="reload_chosen" style="width: 100%;" name="utility_ids"
                                            id="utilities" multiple>
                                        <% ArrayList<Utility> utilities = (ArrayList<Utility>) request.getAttribute("utilities");%>
                                        <% for (int i = 0; i < utilities.size(); i++) { %>
                                        <option value="<%=utilities.get(i).id%>"><%=utilities.get(i).name%>
                                        </option>
                                        <% } %>
                                    </select>
                                    <div class="invalid-feedback">Vui lòng chọn loại phòng</div>
                                </div>
                            </div>
                            <div class="col-12 row">
                                <label>Số phòng</label>
                                <div class="col-6">
                                    <label for="from" class="form-label">Từ</label>
                                    <div class="input-group has-validation">
                                        <input type="text" name="from" class="form-control" id="from" required>
                                        <div class="invalid-feedback">Vui lòng nhập số phòng</div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <label for="to" class="form-label">Đến (bỏ trống nếu chỉ muốn thêm 1 phòng)</label>
                                    <div class="input-group has-validation">
                                        <input type="text" name="to" class="form-control" id="to">
                                        <div class="invalid-feedback">Vui lòng nhập số phòng</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <label for="area" class="form-label">Diện tích phòng (m²)</label>
                                <div class="input-group has-validation">
                                    <input type="number" min="0" name="area" class="form-control" id="area" required>
                                    <div class="invalid-feedback">Vui lòng nhập diện tích phòng</div>
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="beds" class="form-label">Số giường ngủ</label>
                                <div class="input-group has-validation">
                                    <input type="number" min="0" name="beds" class="form-control" id="beds" required>
                                    <div class="invalid-feedback">Vui lòng nhập số giường ngủ</div>
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="images" class="form-label">Ảnh</label>
                                <div class="input-group has-validation">
                                    <input type="file" accept="image/*" name="images" class="form-control" id="images"
                                           required multiple>
                                    <div class="invalid-feedback">Vui lòng nhập ảnh</div>
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="price" class="form-label">Giá phòng (vnd)</label>
                                <div class="input-group has-validation">
                                    <input type="number" min="0" name="price" class="form-control" id="price" required>
                                    <div class="invalid-feedback">Vui lòng nhập giá phòng</div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal fade" id="update_modal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm mới loại phòng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="<%=request.getContextPath()%>/hotel/update-room" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id" id="update_id">
                        <div class="modal-body">
                            <div class="col-12">
                                <label for="room_type_id_update" class="form-label">Loại phòng</label>
                                <div class="input-group has-validation">
                                    <select class="form-control" name="room_type_id" id="room_type_id_update">
                                        <% for (int i = 0; i < roomTypes.size(); i++) { %>
                                        <option value="<%=roomTypes.get(i).id%>"><%=roomTypes.get(i).name%>
                                        </option>
                                        <% } %>
                                    </select>
                                    <div class="invalid-feedback">Vui lòng chọn loại phòng</div>
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="utilities_update" class="form-label">Tiện ích</label>
                                <div class="input-group has-validation">
                                    <select class="reload_chosen" style="width: 100%;" name="utility_ids"
                                            id="utilities_update" multiple>
                                        <% for (int i = 0; i < utilities.size(); i++) { %>
                                        <option value="<%=utilities.get(i).id%>"><%=utilities.get(i).name%>
                                        </option>
                                        <% } %>
                                    </select>
                                    <div class="invalid-feedback">Vui lòng chọn loại phòng</div>
                                </div>
                            </div>
                            <div class="col-12 row">
                                <label>Số phòng</label>
                                <div class="input-group has-validation">
                                    <input type="text" name="number" class="form-control" id="number" required>
                                    <div class="invalid-feedback">Vui lòng nhập số phòng</div>
                                </div>
                            </div>
                            <div class="col-12">
                                <label for="area_update" class="form-label">Diện tích phòng (m²)</label>
                                <div class="input-group has-validation">
                                    <input type="number" min="0" name="area" class="form-control" id="area_update"
                                           required>
                                    <div class="invalid-feedback">Vui lòng nhập diện tích phòng</div>
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="beds_update" class="form-label">Số giường ngủ</label>
                                <div class="input-group has-validation">
                                    <input type="number" min="0" name="beds" class="form-control" id="beds_update"
                                           required>
                                    <div class="invalid-feedback">Vui lòng nhập số giường ngủ</div>
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="price_update" class="form-label">Giá phòng (vnd)</label>
                                <div class="input-group has-validation">
                                    <input type="number" min="0" name="price" class="form-control" id="price_update"
                                           required>
                                    <div class="invalid-feedback">Vui lòng nhập giá phòng</div>
                                </div>
                            </div>

                            <div class="col-12 mt-1">
                                <div class="row" id="preview_image">

                                </div>
                                <p class="text-danger" hidden id="number_images_delete"></p>
                                <input type="hidden" name="images_to_delete" id="images_to_delete">
                            </div>

                            <div class="col-12">
                                <label for="images_update" class="form-label">Ảnh</label>
                                <div class="input-group has-validation">
                                    <input type="file" accept="image/*" name="images" class="form-control"
                                           id="images_update" multiple>
                                    <div class="invalid-feedback">Vui lòng nhập ảnh</div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="row">
            <table class="table datatable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Số phòng</th>
                    <th>Loại phòng</th>
                    <th>Giá (vnd)</th>
                    <th>Số giường ngủ</th>
                    <th>Diện tích (m²)</th>
                    <th>Khả dụng</th>
                    <th>Tiện ích</th>
                    <th>Cập nhật</th>
                </tr>
                </thead>
                <tbody>
                <% ArrayList<Room> rooms = (ArrayList<Room>) request.getAttribute("rooms");%>
                <% for (int i = 0; i < rooms.size(); i++) { %>
                <tr>
                    <td><%=rooms.get(i).id%>
                    </td>
                    <td><%=rooms.get(i).number%>
                    </td>
                    <td><%=rooms.get(i).room_type_name%>
                    </td>
                    <td><%=rooms.get(i).price%>
                    </td>
                    <td><%=rooms.get(i).beds%>
                    </td>
                    <td><%=rooms.get(i).area%>
                    </td>
                    <td>
                        <% if (rooms.get(i).is_available) { %>
                        <a href='<%=request.getContextPath()%>/hotel/change-availability?id=<%=rooms.get(i).id%>'>
                            <button class='btn btn-success'>Có</button>
                        </a>
                        <% } else { %>
                        <a href='<%=request.getContextPath()%>/hotel/change-availability?id=<%=rooms.get(i).id%>'>
                            <button class='btn btn-warning'>Không</button>
                        </a>
                        <% } %>
                    </td>
                    <td class="col-4"><%=Arrays.toString(rooms.get(i).utility_names).replace("[", "").replace("]", "")%>
                    </td>
                    <td>
                        <button onclick="show_update_modal(<%=rooms.get(i).id%>, <%=rooms.get(i).room_type_id%>, '<%=Arrays.toString(rooms.get(i).utility_ids).replace("[", "").replace("]", "")%>', <%=rooms.get(i).number%>, <%=rooms.get(i).area%>, <%=rooms.get(i).beds%>, <%=rooms.get(i).price%>, '<%=Arrays.toString(rooms.get(i).image_ids).replace("[", "").replace("]", "")%>', '<%=Arrays.toString(rooms.get(i).image_urls).replace("[", "").replace("]", "")%>')"
                                class="btn btn-warning" type="button" data-bs-toggle="modal"
                                data-bs-target="#update_modal">Cập nhật
                        </button>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
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
    $("#utilities").chosen();
    let image_ids_to_delete = []

    function show_update_modal(id, room_type_id, utility_ids, number, area, beds, price, image_ids, image_urls) {
        image_ids_to_delete = []
        let image_urls_arr = []
        let image_ids_arr = []
        $("#update_id").val(id)
        $("#room_type_id_update").val(room_type_id)
        $("#utilities_update").val(utility_ids.split(', ').map(item => parseInt(item.trim())))
        $("#number").val(number)
        $("#area_update").val(area)
        $("#beds_update").val(beds)
        $("#price_update").val(price)
        let html = '';
        image_urls_arr = image_urls.split(', ').map(item => item.trim());
        image_ids_arr = image_ids.split(', ').map(item => parseInt(item.trim()));
        for (let i = 0; i < image_urls_arr.length; i++) {
            html += `<div class="col-4">
                        <img onclick="choose_image_to_delete(` + image_ids_arr[i] + `)" id="` + image_ids_arr[i] + `" src="<%=request.getContextPath()%>/` + image_urls_arr[i] + `" alt="" class="m-1 img-thumbnail" style="width: 100%; max-height: 300px; object-fit: cover">
                    </div>`;
        }
        $("#preview_image").html(html)
    }

    function choose_image_to_delete(id) {
        if (image_ids_to_delete.includes(id)){
            image_ids_to_delete = image_ids_to_delete.filter(item => item !== id)
            $("#" + id).removeClass("border-4 border-danger")
        } else {
            image_ids_to_delete.push(id)
            $("#" + id).addClass("border-4 border-danger")
        }
        if (image_ids_to_delete.length === 0){
            $("#number_images_delete").attr("hidden", "true")
        } else {
            $("#number_images_delete").removeAttr("hidden").text(image_ids_to_delete.length + " ảnh sẽ được xóa.")
        }
        $("#images_to_delete").val(image_ids_to_delete.join(','))
    }
</script>
</html>