<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Booking" %>
<%@ page import="Controller.PaymentController" %>
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
                <li class="breadcrumb-item active">Đặt phòng</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section dashboard">
        <div class="col-12">
            <table class="table datatable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Loại phòng</th>
                    <th>Khách sạn</th>
                    <th>Ngày check in</th>
                    <th>Ngày check out</th>
                    <th>Trạng thái</th>
                    <th>Giá</th>
                    <th>Đặt lúc</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                    <% ArrayList<Booking> bookings = (ArrayList<Booking>) request.getAttribute("bookings");%>
                    <% for (int i = 0; i < bookings.size(); i++) { %>
                        <tr>
                            <td><%=bookings.get(i).id%></td>
                            <td><%=bookings.get(i).room_type_name%></td>
                            <td><%=bookings.get(i).hotel_name%></td>
                            <td><%=bookings.get(i).check_in_date%></td>
                            <td><%=bookings.get(i).check_out_date%></td>
                            <td><%=bookings.get(i).status%></td>
                            <td><%=bookings.get(i).payment_id == 0 ? bookings.get(i).temp_price * PaymentController.GetVNPayUrlServlet.countDays(bookings.get(i).check_in_date, bookings.get(i).check_out_date) : bookings.get(i).price%></td>
                            <td><%=bookings.get(i).created_at%></td>
                            <td>
                                <% if (bookings.get(i).payment_id == 0 ) { %>
                                    <form id="<%=bookings.get(i).id%>" action="<%=request.getContextPath()%>/customer/get-vnpay-url">
                                        <input type="hidden" name="booking_id" value="<%=bookings.get(i).id%>">
                                        <input type="hidden" name="bankCode" value="">
                                        <input type="hidden" name="language" value="vn">
                                        <button onclick="getVnpayUrl(<%=bookings.get(i).id%>)" class="btn btn-success" type="button">
                                            Thanh toán
                                        </button>
                                    </form>
                                <% } else { %>
                                    <p>Đã thanh toán</p>
                                <% } %>

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
    function getVnpayUrl(id) {
        console.log(123)
        var postData = $("#" + id).serialize();
        var submitUrl = $("#" + id).attr("action");
        $.ajax({
            type: "POST",
            url: submitUrl,
            data: postData,
            dataType: 'JSON',
            success: function (x) {
                if (x.code === '00') {
                    if (window.vnpay) {
                        vnpay.open({width: 768, height: 600, url: x.data});
                    } else {
                        location.href = x.data
                    }
                    return false;
                } else {
                    alert(x.Message);
                }
            }
        });
        return false;
    }
</script>
</html>