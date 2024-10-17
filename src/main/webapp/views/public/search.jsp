<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
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
                <li class="breadcrumb-item active">Tìm kiếm</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section dashboard">
        <div class="col-12 row">
            <div class="card m-1">
                <div class="card-body m-1">
                    <form action="<%=request.getContextPath()%>/search" method="get">
                        <div class="row col-12">
                            <div class="col-6">
                                <div class="row mb-3">
                                    <label for="query" class="col-sm-2 col-form-label">Từ khóa</label>
                                    <div class="col-sm-10">
                                        <input name="query" type="text" class="form-control" id="query" value="<%=request.getParameter("query") == null ? "" : request.getParameter("query")%>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="row mb-3">
                                    <label for="utilities" class="col-sm-2 col-form-label">Tiện ích</label>
                                    <div class="col-sm-10 mt-1">
                                        <select class="reload_chosen" style="width: 100%" name="utility_ids"
                                                id="utilities" multiple>
                                            <% ArrayList<Utility> utilities = (ArrayList<Utility>) request.getAttribute("utilities");%>
                                            <% String[] selected = request.getParameterValues("utility_ids"); selected = selected == null ? new String[]{} : selected;%>
                                            <% for (int i = 0; i < utilities.size(); i++) { %>
                                            <option <%=Arrays.asList(selected).contains(String.valueOf(utilities.get(i).id)) ? "selected" : ""%> value="<%=utilities.get(i).id%>"><%=utilities.get(i).name%>
                                            </option>
                                            <% } %>
                                        </select>
                                        <div class="invalid-feedback">Vui lòng chọn loại phòng</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row col-12">
                            <div class="col-3">
                                <div class="row mb-3">
                                    <label for="from_price" class="col-sm-4 col-form-label">Giá tối thiểu</label>
                                    <div class="col-sm-8">
                                        <input value="<%=request.getParameter("price_from") == null ? "" : request.getParameter("price_from")%>" name="price_from" type="number" class="form-control" id="from_price">
                                    </div>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="row mb-3">
                                    <label for="to_price" class="col-sm-4 col-form-label">Giá tối đa</label>
                                    <div class="col-sm-8">
                                        <input value="<%=request.getParameter("price_to") == null ? "" : request.getParameter("price_to")%>" name="price_to" type="number" class="form-control" id="to_price">
                                    </div>
                                </div>
                            </div>
                            <div class="col-5">
                                <div class="row mb-3">
                                    <label for="sort" class="col-sm-3 col-form-label">Sắp xếp</label>
                                    <div class="col-sm-9">
                                        <select class="form-control" name="sort" id="sort">
                                            <option <%=request.getParameter("sort").equals("1") ? "selected" : ""%> value="1">Giá tăng dần</option>
                                            <option <%=request.getParameter("sort").equals("2") ? "selected" : ""%> value="2">Giá giảm dần</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-1">
                                <button class="btn btn-success" type="submit">Tìm kiếm</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%ArrayList<RoomType> roomTypes = (ArrayList<RoomType>) request.getAttribute("roomTypes");%>
        <%=roomTypes.isEmpty() ? "Không tìm thấy phòng nào" : ""%>
        <div class="col-12 row">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <% for (int i = 0; i < roomTypes.size(); i++) { %>
                    <div class="col">
                    <div class="card shadow-sm">
                        <img style="object-fit: cover" class="bd-placeholder-img card-img-top" width="100%" height="225" src="<%=request.getContextPath()%>/<%=roomTypes.get(i).images[0].url%>" alt="">
                        <div class="card-body">
                            <p class="card-text"><%=roomTypes.get(i).hotel_name%></p>
                            <p class="card-text"><%=roomTypes.get(i).name%></p>
                            <p class="card-text"><%=roomTypes.get(i).description%></p>
                            <p class="card-text"><%=roomTypes.get(i).price%>(vnd)</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <button onclick="toastr.success('Sắp cập nhật')" type="button" class="btn btn-outline-secondary">Xem chi tiết</button>
                                </div>
                                <small class="text-muted">9 mins</small>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
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
    $("#utilities").chosen()
</script>
</html>