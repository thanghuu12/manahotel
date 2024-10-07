<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.RoomType" %>
<%@ page import="Util.EscapeCharacters" %>
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
                <li class="breadcrumb-item active">Quản lý loại phòng</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section dashboard">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#verticalycentered">
            Thêm mới khách sạn
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
                                    <div class="invalid-feedback">Vui lòng nhập tên</div>
                                </div>
                            </div>
                            <div class="col-12">
                                <label for="description" class="form-label">Mô tả</label>
                                <div class="input-group has-validation">
                                    <textarea class="form-control" name="description" id="description" rows="15" required></textarea>
                                    <div class="invalid-feedback">Vui lòng nhập mô tả</div>
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
        <div class="modal fade" id="verticalycentered2" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Cập nhật loại phòng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="<%=request.getContextPath()%>/hotel/update-room-type" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="id" id="id_update">
                            <div class="col-12">
                                <label for="name_update" class="form-label">Tên</label>
                                <div class="input-group has-validation">
                                    <input type="text" name="name" class="form-control" id="name_update" required>
                                    <div class="invalid-feedback">Vui lòng nhập tên</div>
                                </div>
                            </div>
                            <div class="col-12">
                                <label for="description_update" class="form-label">Mô tả</label>
                                <div class="input-group has-validation">
                                    <textarea class="form-control" name="description" id="description_update" rows="10" required></textarea>
                                    <div class="invalid-feedback">Vui lòng nhập mô tả</div>
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
                <%ArrayList<RoomType> roomTypes = (ArrayList<RoomType>) request.getAttribute("roomTypes");%>
                <% for (int i = 0; i < roomTypes.size(); i++) { %>
                <tr>
                    <td style="width: 5%"><%=roomTypes.get(i).id%></td>
                    <td style="width: 15%;"><%=roomTypes.get(i).name%></td>
                    <td style="width: 70%"><%=roomTypes.get(i).description%></td>
                    <td style="width: 10%">
                        <button onclick="test('<%=roomTypes.get(i).id%>', '<%=roomTypes.get(i).name%>', '<%=EscapeCharacters.escapeSpecialCharacters(roomTypes.get(i).description)%>')" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#verticalycentered2" type="button">Cập nhật</button>
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
<%@include file="../master/footer.jsp"%>
<!-- End Footer -->

<%@include file="../master/js.jsp"%>

</body>
<script>
    function test(id, name, des) {
        console.log(id, name, des)
        $("#id_update").val(id)
        $("#name_update").val(name)
        $("#description_update").val(des)
    }
</script>
</html>