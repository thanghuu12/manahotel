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
        <h1>Profile</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/">Home</a></li>
                <li class="breadcrumb-item">Customer</li>
                <li class="breadcrumb-item active">Profile</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section profile">
        <div class="row">
            <div class="col-xl-4">

                <div class="card">
                    <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

                        <img src="<%=customer.avatar.startsWith("http") || customer.avatar.startsWith("https") ? customer.avatar : request.getContextPath() + "/" + customer.avatar%>" alt="Profile" class="rounded-circle">
                        <h2><%=customer.name%></h2>
                        <h3><%=customer.email%></h3>
                        <div class="social-links mt-2">
                            <a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
                            <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
                            <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
                            <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-xl-8">
                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <ul class="nav nav-tabs nav-tabs-bordered">
                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                            </li>

                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                            </li>

                        </ul>
                        <div class="tab-content pt-2">


                            <div class="tab-pane fade show active profile-edit pt-3" id="profile-edit">

                                <!-- Profile Edit Form -->
                                <form action="<%=request.getContextPath()%>/customer/change-avatar" method="post" enctype="multipart/form-data">
                                    <div class="row mb-3">
                                        <label class="col-md-4 col-lg-3 col-form-label">Profile Image</label>
                                        <div class="col-md-8 col-lg-9">
                                            <img src="<%=customer.avatar.startsWith("http") || customer.avatar.startsWith("https") ? customer.avatar : request.getContextPath() + "/" + customer.avatar%>" alt="Profile">
                                            <img hidden="hidden" id="preview" src="" alt="Profile">
                                            <span id="file-name"></span>
                                            <div class="pt-2">
                                                <label for="avatar" class="btn btn-success">Chọn ảnh</label>
                                                <input hidden="hidden" type="file" accept="image/*" name="avatar" id="avatar" required>
                                                <button class="btn btn-success" type="submit">Cập nhật ảnh đại diện</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <form action="<%=request.getContextPath()%>/customer/update-profile" method="post">
                                    <div class="row mb-3">
                                        <label for="name" class="col-md-4 col-lg-3 col-form-label">Tên</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input required name="name" type="text" class="form-control" id="name" value="<%=customer.name%>">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="phone" class="col-md-4 col-lg-3 col-form-label">Số điện thoại</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input required name="phone" type="tel" class="form-control" id="phone" value="<%=customer.phone%>">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input required name="email" type="email" class="form-control" id="email" value="<%=customer.email%>">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="email" class="col-md-4 col-lg-3 col-form-label">Date of birth</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input required name="dob" type="date" class="form-control" id="dob" value="<%=customer.dob%>">
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary">Save Changes</button>
                                    </div>
                                </form>
                                <!-- End Profile Edit Form -->

                            </div>

                            <div class="tab-pane fade pt-3" id="profile-change-password">
                                <!-- Change Password Form -->
                                <form action="<%=request.getContextPath()%>/customer/change-password" method="post">

                                    <div class="row mb-3">
                                        <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="old_password" type="password" class="form-control" id="currentPassword">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input required name="new_password" type="password" class="form-control" id="newPassword">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input required name="re_password" type="password" class="form-control" id="renewPassword">
                                        </div>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary">Change Password</button>
                                    </div>
                                </form><!-- End Change Password Form -->

                            </div>

                        </div><!-- End Bordered Tabs -->

                    </div>
                </div>
            </div>
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
    document.getElementById('avatar').addEventListener('change', function() {
        const fileInput = document.getElementById('avatar');
        document.getElementById('file-name').textContent = fileInput.files.length > 0 ? fileInput.files[0].name : 'No file selected';
        const preview = document.getElementById('preview');
        console.log(preview)
        const file = fileInput.files[0];
        const reader = new FileReader();
        reader.onload = function(e) {
            preview.src = e.target.result;
            preview.style.display = 'block'; // Display the image
            preview.removeAttribute("hidden");
        };
        if (file) {
            reader.readAsDataURL(file); // Read the file as a data URL
        } else {
            preview.src = '';
            preview.style.display = 'none'; // Hide the image if no file is selected
        }
    });
</script>
</html>