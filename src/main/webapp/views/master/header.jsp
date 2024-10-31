<%@ page import="Model.Customer" %>
<%@ page import="Dao.CustomerDao" %>
<%@ page import="Model.Admin" %>
<%@ page import="Dao.AdminDao" %>
<%@ page import="Model.Hotel" %>
<%@ page import="Dao.HotelDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%String customer_id = request.getSession().getAttribute("customer") == null ? null : request.getSession().getAttribute("customer").toString();%>
<%String admin_id = request.getSession().getAttribute("admin") == null ? null : request.getSession().getAttribute("admin").toString();%>
<%String hotel_id = request.getSession().getAttribute("hotel") == null ? null : request.getSession().getAttribute("hotel").toString();%>
<%Customer customer = null;%>
<%Admin admin = null;%>
<%Hotel hotel = null;%>
<header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
        <a href="<%=request.getContextPath()%>/" class="logo d-flex align-items-center">
            <img src="<%=request.getContextPath()%>/assets/img/logo.png" alt="">
            <span class="d-none d-lg-block"><%=Config.app_name%></span>
        </a>
        <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <div class="search-bar">
        <form class="search-form d-flex align-items-center" method="get" action="<%=request.getContextPath()%>/search">
            <input type="text" name="query" placeholder="Search" title="Enter search keyword">
            <button type="submit" title="Search"><i class="bi bi-search"></i></button>
        </form>
    </div><!-- End Search Bar -->

    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

            <li class="nav-item d-block d-lg-none">
                <a class="nav-link nav-icon search-bar-toggle " href="#">
                    <i class="bi bi-search"></i>
                </a>
            </li><!-- End Search Icon-->

            <li class="nav-item dropdown pe-5">
                <%
                    String name = "";
                    String email = "";
                    String avatar = "";
                    String profile_link = "";
                    if (customer_id != null) {
                        customer = CustomerDao.getCustomerWithId(Integer.parseInt(customer_id));
                        assert customer != null;
                        name = customer.name;
                        email = customer.email;
                        avatar = customer.avatar;
                        profile_link = request.getContextPath() + "/customer/profile";
                    } else if (admin_id != null) {
                        admin = AdminDao.getAdminWithId(Integer.parseInt(admin_id));
                        assert admin != null;
                        name = admin.name;
                        email = admin.username;
                        avatar = admin.avatar;
                        profile_link = request.getContextPath() + "/admin/admin-control?admin_id=" + admin.id;
                    } else if (hotel_id != null) {
                        hotel = HotelDao.getHotelWithId(Integer.parseInt(hotel_id));
                        assert hotel != null;
                        name = hotel.name;
                        email = hotel.email;
                        avatar = hotel.avatar;
                        profile_link = request.getContextPath() + "/hotel/profile";
                    }
                %>
                <% if (customer_id != null || admin != null || hotel != null) { %>
                    <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                        <img src="<%=avatar.startsWith("http") ? avatar : request.getContextPath() + "/" + avatar%>" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%" alt="Profile">
                        <span class="d-none d-md-block dropdown-toggle ps-2"><%=name%></span>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                        <li class="dropdown-header">
                            <h6><%=name%></h6>
                            <span><%=email%></span>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>

                        <li>
                            <a class="dropdown-item d-flex align-items-center" href="<%=profile_link%>">
                                <i class="bi bi-person"></i>
                                <span>Trang cá nhân</span>
                            </a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <% if (admin_id != null) { %>
                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="<%=request.getContextPath()%>/admin">
                                    <i class="ri-settings-3-line"></i>
                                    <span>Trang quản trị</span>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                        <% }  %>
                        <% if (hotel_id != null) { %>
                        <li>
                            <a class="dropdown-item d-flex align-items-center" href="<%=request.getContextPath()%>/hotel">
                                <i class="ri-settings-3-line"></i>
                                <span>Trang quản trị cho khách sạn</span>
                            </a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <% }  %>
                        <li>
                            <a class="dropdown-item d-flex align-items-center" href="<%=request.getContextPath()%>/logout">
                                <i class="bi bi-box-arrow-right"></i>
                                <span>Đăng xuất</span>
                            </a>
                        </li>

                    </ul>
                <% } else { %>
                    <a href="<%=request.getContextPath()%>/login"><button class="btn btn-success">Đăng nhập</button></a>
                    <a href="<%=request.getContextPath()%>/register"><button class="btn btn-info">Đăng kí</button></a>
                <% } %>

            </li>
            <!-- End Profile Nav -->

        </ul>
    </nav><!-- End Icons Navigation -->

</header>
