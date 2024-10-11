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
                <li class="breadcrumb-item active">Hotel panel</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section dashboard">
        <div class="row">
            <a href="<%=request.getContextPath()%>/hotel/manage-room-type">
                <button class="col-6 m-1 btn btn-success">Quản lý loại phòng</button>
            </a>
        </div>

        <div class="row">
            <a href="<%=request.getContextPath()%>/hotel/manage-room">
                <button class="col-6 m-1 btn btn-success">Quản lý phòng</button>
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