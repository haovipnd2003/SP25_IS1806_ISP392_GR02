<%-- 
    Document   : updateProfile
    Created on : 15 thg 2, 2025, 01:20:36
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
                <div class="navbar-bg"></div>
                <nav class="navbar navbar-expand-lg main-navbar">
                    <form class="form-inline mr-auto">
                        <ul class="navbar-nav mr-3">
                            <li><a href="#" data-toggle="sidebar" class="nav-link nav-link-lg"><i class="ion ion-navicon-round"></i></a></li>
                            <li><a href="#" data-toggle="search" class="nav-link nav-link-lg d-sm-none"><i class="ion ion-search"></i></a></li>
                        </ul>

                    </form>
                    <ul class="navbar-nav navbar-right">
                        <li class="dropdown dropdown-list-toggle"><a href="#" data-toggle="dropdown" class="nav-link notification-toggle nav-link-lg beep"><i class="ion ion-ios-bell-outline"></i></a>
                            <div class="dropdown-menu dropdown-list dropdown-menu-right">
                                <div class="dropdown-header">Notifications
                                    <div class="float-right">
                                        <a href="#">View All</a>
                                    </div>
                                </div>
                                <div class="dropdown-list-content">
                                    <a href="#" class="dropdown-item dropdown-item-unread">
                                        <img alt="image" src="../dist/img/avatar/avatar-1.jpeg" class="rounded-circle dropdown-item-img">
                                        <div class="dropdown-item-desc">
                                            <b>Kusnaedi</b> has moved task <b>Fix bug header</b> to <b>Done</b>
                                            <div class="time">10 Hours Ago</div>
                                        </div>
                                    </a>
                                    <a href="#" class="dropdown-item dropdown-item-unread">
                                        <img alt="image" src="../dist/img/avatar/avatar-2.jpeg" class="rounded-circle dropdown-item-img">
                                        <div class="dropdown-item-desc">
                                            <b>Ujang Maman</b> has moved task <b>Fix bug footer</b> to <b>Progress</b>
                                            <div class="time">12 Hours Ago</div>
                                        </div>
                                    </a>
                                    <a href="#" class="dropdown-item">
                                        <img alt="image" src="../dist/img/avatar/avatar-3.jpeg" class="rounded-circle dropdown-item-img">
                                        <div class="dropdown-item-desc">
                                            <b>Agung Ardiansyah</b> has moved task <b>Fix bug sidebar</b> to <b>Done</b>
                                            <div class="time">12 Hours Ago</div>
                                        </div>
                                    </a>
                                    <a href="#" class="dropdown-item">
                                        <img alt="image" src="../dist/img/avatar/avatar-4.jpeg" class="rounded-circle dropdown-item-img">
                                        <div class="dropdown-item-desc">
                                            <b>Ardian Rahardiansyah</b> has moved task <b>Fix bug navbar</b> to <b>Done</b>
                                            <div class="time">16 Hours Ago</div>
                                        </div>
                                    </a>
                                    <a href="#" class="dropdown-item">
                                        <img alt="image" src="../dist/img/avatar/avatar-5.jpeg" class="rounded-circle dropdown-item-img">
                                        <div class="dropdown-item-desc">
                                            <b>Alfa Zulkarnain</b> has moved task <b>Add logo</b> to <b>Done</b>
                                            <div class="time">Yesterday</div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </li>
                        <li class="dropdown"><a href="#" data-toggle="dropdown" class="nav-link dropdown-toggle nav-link-lg">
                                <i class="ion ion-android-person d-lg-none"></i>
                                <div class="d-sm-none d-lg-inline-block">Hi, Ujang Maman</div></a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a href="${pageContext.request.contextPath}/profile" class="dropdown-item has-icon">
                                    <i class="ion ion-android-person"></i> Profile
                                </a>
                                <a href="#" class="dropdown-item has-icon">
                                    <i class="ion ion-log-out"></i> Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>

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

                                                    <form action="${pageContext.request.contextPath}/updateProfile" method="POST">
                                                    <input type="hidden" name="id" value="${u.getId()}" />

                                                    <table border="0">
                                                        <tbody>
                                                            <tr>
                                                                <td><h4>Name:</h4></td>
                                                                <td><input type="text" name="name" value="${u.getName()}" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td><h4>Email:</h4></td>
                                                                <td><input type="text" name="email" value="${u.getEmail()}" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td><h4>Phone: </h4></td>
                                                                <td><input type="text" name="phone" value="${u.getPhone()}" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td><h4>Address:</h4></td>
                                                                <td><input type="text" name="address" value="${u.getAddress()}" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>  <button style="margin: 10px" type="submit" class="btn btn-outline-info">
                                                                        Update Profile
                                                                    </button></td>

                                                            </tr>

                                                        </tbody>
                                                    </table>
                                                </form>
                                                <h6 style="color: #00cc33">${requestScope.mess}</h6>
                                                <h6 style="color: #ff3333">${requestScope.error}</h6>
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

