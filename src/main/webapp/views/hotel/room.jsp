<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<%@include file="../master/head.jsp"%>
<body>
<!-- ======= Header ======= -->
<%@include file="../master/header.jsp"%>
<!-- End Header -->
<!-- ======= Sidebar ======= -->
<%@include file="../master/sidebar.jsp"%>
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
                    <form action="<%=request.getContextPath()%>/hotel/manage-room-type" method="post">
                        <div class="modal-body">
                            <div class="col-12">
                                <label for="name" class="form-label">Tên</label>
                                <div class="input-group has-validation">
                                    <input type="text" name="name" class="form-control" id="name" required>
                                    <div class="invalid-feedback">Vui lòng nhập tên phòng</div>
                                </div>
                            </div>
                            <div class="col-12">
                                <label for="room_type_id" class="form-label">Mô tả</label>
                                <div class="input-group has-validation">
                                    <select class="form-control" name="room_type_id" id="room_type_id">
                                        <% ArrayList<RoomType> roomTypes = (ArrayList<RoomType>) request.getAttribute("roomTypes");%>
                                        <% for (int i = 0; i < roomTypes.size(); i++) { %>
                                            <option value="<%=roomTypes.get(i).id%>"><%=roomTypes.get(i).name%></option>
                                        <% } %>
                                    </select>
                                    <div class="invalid-feedback">Vui lòng chọn loại phòng</div>
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="utilities" class="form-label">Mô tả</label>
                                <div class="input-group has-validation">
                                    <select class="form-control" name="room_type_id" id="utilities">
                                        <% ArrayList<Utility> utilities = (ArrayList<Utility>) request.getAttribute("utilities");%>
                                        <% for (int i = 0; i < utilities.size(); i++) { %>
                                        <option value="<%=utilities.get(i).id%>"><%=utilities.get(i).name%></option>
                                        <% } %>
                                    </select>
                                    <div class="invalid-feedback">Vui lòng chọn loại phòng</div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save changes</button>
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
                    <th>Tên</th>
                    <th>Mô tả</th>
                    <th>Cập nhật</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </section>

</main>
<!-- End #main -->
<!-- ======= Footer ======= -->
<%@include file="../master/footer.jsp"%>
<!-- End Footer -->

<%@include file="../master/js.jsp"%>

</body>
</html>