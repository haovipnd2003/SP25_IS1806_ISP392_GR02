<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Add Customer</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <div id="app">
            <div class="main-wrapper">
                <jsp:include page="/view/common/nav_bar.jsp"></jsp:include>
                    <!--MAIN-SIDEBAR-JSP-INCLUDE-->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                    <!--MAIN-SIDEBAR-JSP-INCLUDE-->
                    <!--MAIN CONTENT-->
                    <div class="main-content" style="min-height: 600px;">
                        <section class="section">
                            <div class="section-body">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h2>Add New Customer</h2>
                                            </div>
                                            <div class="card-body">
                                                <!---------------------- ADD CUSTOMER ----------------------------->
                                                <form action="customer" method="post">
                                                    <input type="hidden" name="action" value="add">
                                                    <div class="form-group">
                                                        <label >Name</label>
                                                        <input type="text" name="name"  class="form-control"required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label >Phone</label>
                                                        <input type="text" name="phone"  class="form-control"required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label >Email</label>
                                                        <input type="text" name="email"  class="form-control"required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label >Address</label>
                                                        <input type="text" name="address"  class="form-control"required>
                                                    </div>
                                                    <div class="form-group">
                                                        <button type="submit" class="btn btn-primary mt-4 w-20" >Add Customer</button>
                                                        <a href="customer" class="btn btn-secondary mt-4 w-20">Cancel</a>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                    </div>
                </div>
            </section>
        </div>               
        <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/modules/popper.js"></script>
    <script src="${pageContext.request.contextPath}/modules/tooltip.js"></script>
    <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/modules/nicescroll/jquery.nicescroll.min.js"></script>
    <script src="${pageContext.request.contextPath}/modules/scroll-up-bar/dist/scroll-up-bar.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/sa-functions.js"></script>

    <script src="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
    <script src="${pageContext.request.contextPath}/js/custom.js"></script>
    <script src="${pageContext.request.contextPath}/js/demo.js"></script>
</body>
</html>
