<%-- 
    Document   : dashboard
    Created on : 15 thg 2, 2025, 00:01:05
    Author     : binh2
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Components &rsaquo; Toastr &mdash; Stisla</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
    </head>

    <body>
        <div id="app">
            <div class="main-wrapper">
                <jsp:include page="/view/common/nav_bar.jsp"></jsp:include>

                <!--MAIN-SIDEBAR-JSP-INCLUDE-->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                    <!--MAIN-SIDEBAR-JSP-INCLUDE-->


                    <!--                MAIN CONTENT-->
                    <div class="main-content" style="min-height: 600px;">
                        <section class="section">


                            <div class="section-body">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h2>Information</h2>
                                            </div>
                                            <div class="card-body">
                                                <div class="alert alert-light">
                                                <c:set value="${sessionScope.acc}" var="u"></c:set>
                                                    <table border="0">
                                                        <tbody>
                                                            <tr>
                                                                <td><h4>Name:</h4></td>
                                                                <td><h4><c:out value="${u.getName()}"></c:out></h4></td>
                                                            </tr>
                                                            <tr>
                                                                <td><h4>Email:</h4></td>
                                                                <td><h4><c:out value="${u.getEmail()}"></c:out></h4></td>
                                                            </tr>
                                                            <tr>
                                                                <td><h4>Phone: </h4></td>
                                                                <td><h4><c:out value="${u.getPhone()}"></c:out></h4></td>
                                                            </tr>
                                                            <tr>
                                                                <td><h4>Address:</h4></td>
                                                                <td><h4><c:out value="${u.getAddress()}"></c:out></h4></td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                                <td></td>
                                                            </tr>
                                                            <tr>
                                                                <td><a  style="margin: 10px" href="${pageContext.request.contextPath}/updateProfile" class="btn btn-outline-info">Update Profile</a></td>
                                                        </tr>
                                                        <tr>

                                                            <td><a  style="margin: 10px" href="${pageContext.request.contextPath}/changePassword" class="btn btn-outline-warning">Change Password</a></td>
                                                        </tr>
                                                    </tbody>
                                                </table>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>




            </div>
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
