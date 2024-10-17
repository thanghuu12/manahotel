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
                    <form action="<%=request.getContextPath()%>/hotel/update-room" method="post">
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

                            <label>Số phòng</label>
                            <div class="col-6">
                                <label for="number" class="form-label">Số phòng</label>
                                <div class="input-group has-validation">
                                    <input type="number" name="number" class="form-control" id="number" required>
                                    <div class="invalid-feedback">Vui lòng nhập số phòng</div>
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
                    <th>Khả dụng</th>
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
                    <td>
                        <button
                                class="btn btn-warning" type="button" data-bs-toggle="modal" onclick="show_update_modal(<%=rooms.get(i).id%>, <%=rooms.get(i).room_type_id%>, <%=rooms.get(i).number%>)"
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
    function show_update_modal(id, room_type_id, number) {
        $("#update_id").val(id)
        $("#room_type_id_update").val(room_type_id)
        $("#number").val(number)
    }
</script>
</html>