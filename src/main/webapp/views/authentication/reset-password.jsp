<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<%@include file="../master/head.jsp"%>
<body>
<main>
    <div class="container">

        <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

                        <div class="d-flex justify-content-center py-4">
                            <a href="<%=request.getContextPath()%>/" class="logo d-flex align-items-center w-auto">
                                <img src="<%=request.getContextPath()%>/assets/img/logo.png" alt="">
                                <span class="d-none d-lg-block">NiceAdmin</span>
                            </a>
                        </div><!-- End Logo -->

                        <div class="card mb-3">

                            <div class="card-body">

                                <div class="pt-4 pb-2">
                                    <h5 class="card-title text-center pb-0 fs-4">Đặt lại mật khẩu của bạn</h5>
                                </div>

                                <form class="row g-3 needs-validation" action="<%=request.getContextPath()%>/reset-password" method="post" novalidate>

                                    <div class="col-12">
                                        <div class="col-12">
                                            <label for="password" class="form-label">Password</label>
                                            <input type="password" name="password" class="form-control" id="password" required>
                                            <div class="invalid-feedback">Please enter your password!</div>
                                        </div>

                                        <div class="col-12">
                                            <label for="re_password" class="form-label">Re password</label>
                                            <input type="password" name="re_password" class="form-control" id="re_password" required>
                                            <div class="invalid-feedback">Please enter your password!</div>
                                        </div>
                                        <input type="hidden" value="<%=request.getParameter("token")%>" name="token">
                                    </div>

                                    <div class="col-12">
                                        <button class="btn btn-primary w-100" type="submit">Đặt lại mật khẩu</button>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </section>

    </div>
</main>
<!-- End #main -->

<%@include file="../master/js.jsp"%>

</body>

</html>