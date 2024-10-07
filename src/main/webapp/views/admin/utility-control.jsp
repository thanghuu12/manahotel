<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Utility" %>
<%@ page import="Util.EscapeCharacters" %>
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
                <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/">Quản lý admin</a></li>
                <li class="breadcrumb-item active">Quản lý tiện ích</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section dashboard">
        <div class="row">
            <div class="col-5">
                <form action="<%=request.getContextPath()%>/admin/manage-utility" method="post">
                    <div class="col-12">
                        <label for="name" class="form-label">Tên</label>
                        <div class="input-group has-validation">
                            <input type="text" name="name" class="form-control" id="name" required>
                            <div class="invalid-feedback">Please enter your name.</div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary mt-2">Save changes</button>
                </form>
            </div>
            <div class="col-7">
                <table class="table datatable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Cập nhật</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%ArrayList<Utility> utilities = (ArrayList<Utility>) request.getAttribute("utilities");%>
                    <% for (int i = 0; i < utilities.size(); i++) { %>
                        <tr>
                            <td><%=utilities.get(i).id%></td>
                            <td style="width: 70%"><%=utilities.get(i).name%></td>
                            <td>
                                <button onclick="updateform('<%=utilities.get(i).id%>', '<%=EscapeCharacters.escapeSpecialCharacters(utilities.get(i).name)%>')" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#verticalycentered">
                                    Cập nhật
                                </button>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
                <div class="modal fade" id="verticalycentered" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Thêm mới khách sạn</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="<%=request.getContextPath()%>/admin/update-utility" method="post">
                                <input type="hidden" name="id" id="id">
                                <div class="modal-body">
                                    <div class="col-12">
                                        <label for="name" class="form-label">Tên</label>
                                        <div class="input-group has-validation">
                                            <input type="text" name="name" class="form-control" id="name_update" required>
                                            <div class="invalid-feedback">Please enter your name.</div>
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
            </div>
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
    function updateform(id, name) {
        $("#id").val(id)
        $("#name_update").val(name)
    }
</script>
</html>