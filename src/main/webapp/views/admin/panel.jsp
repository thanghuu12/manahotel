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
                <li class="breadcrumb-item active">Admin panel</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section dashboard">
        <div class="row">
            <a href="<%=request.getContextPath()%>/admin/admin-control">
                <button class="col-6 m-1 btn btn-success">Quản lý Admin</button>
            </a>
            <a href="<%=request.getContextPath()%>/admin/customer-control">
                <button class="col-6 m-1 btn btn-success">Quản lý người dùng</button>
            </a>
            <a href="<%=request.getContextPath()%>/admin/hotel-control">
                <button class="col-6 m-1 btn btn-success">Quản lý khách sạn</button>
            </a>
            <a href="<%=request.getContextPath()%>/admin/manage-utility">
                <button class="col-6 m-1 btn btn-success">Quản lý tiên ích</button>
            </a>
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