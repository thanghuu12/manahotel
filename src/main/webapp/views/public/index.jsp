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
                <li class="breadcrumb-item active">Dashboard</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section dashboard">
        <form>
            <h4>Selections using Select2</h4>
            <select class="country"
                    multiple
                    style="width: 200px;">
                <option value="1">India</option>
                <option value="2">Japan</option>
                <option value="3">France</option>
            </select>
            <h4>Selections using Chosen</h4>
            <style>
                select.customDropdown::-ms-expand {
                    display: none;
                }

                select.customDropdown {
                    outline : none;
                    overflow : hidden;
                    text-indent : 1px;
                    text-overflow : '';

                    background : url("https://img.icons8.com/material/24/000000/sort-down.png") no-repeat right #fff;

                    -webkit-appearance: none;
                    -moz-appearance: none;
                    -ms-appearance: none;
                    -o-appearance: none;
            </style>
            <select class="country1 customDropdown"
                    multiple>
                <option value="1">India</option>
                <option value="2">Japan</option>
                <option value="3">France</option>
            </select>
        </form>
    </section>

</main>
<!-- End #main -->

<!-- ======= Footer ======= -->
<%@include file="../master/footer.jsp" %>
<!-- End Footer -->

<%@include file="../master/js.jsp" %>

</body>
<%--<script src=
                "https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>--%>

<!--These jQuery libraries for
   chosen need to be included-->
<script src=
                "https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js">
</script>
<link rel="stylesheet"
      href=
              "https://cdnjs.cloudflare.com/ajax/libs/chosen/1.4.2/chosen.min.css" />

<!--These jQuery libraries for select2
    need to be included-->
<%--<script src=
                "https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.1/js/select2.min.js">
</script>
<link rel="stylesheet"
      href=
              "https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.1/css/select2.min.css" />--%>
<script>
    $(document).ready(function () {
        //Select2
/*        $(".country").select2({
            maximumSelectionLength: 2,
        });*/
        //Chosen
        $(".country1").chosen({
            // max_selected_options: 2,
        });
    });
</script>
</html>