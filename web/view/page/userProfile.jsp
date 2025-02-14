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
                <div class="main-sidebar">
                    <aside id="sidebar-wrapper">
                        <div class="sidebar-brand">
                            <a href="index.html">Stisla Lite</a>
                        </div>
                        <div class="sidebar-user">
                            <div class="sidebar-user-picture">
                                <img alt="image" src="../dist/img/avatar/avatar-1.jpeg">
                            </div>
                            <div class="sidebar-user-details">
                                <div class="user-name">Ujang Maman</div>
                                <div class="user-role">
                                    Administrator
                                </div>
                            </div>
                        </div>
                        <ul class="sidebar-menu">
                            <li class="menu-header">Dashboard</li>
                            <li>
                                <a href="index.html"><i class="ion ion-speedometer"></i><span>Dashboard</span></a>
                            </li>

                            <li class="menu-header">Components</li>
                            <li class="active">
                                <a href="#" class="has-dropdown"><i class="ion ion-ios-albums-outline"></i><span>Components</span></a>
                                <ul class="menu-dropdown">
                                    <li><a href="general.html"><i class="ion ion-ios-circle-outline"></i> Basic</a></li>
                                    <li><a href="components.html"><i class="ion ion-ios-circle-outline"></i> Main Components</a></li>
                                    <li><a href="buttons.html"><i class="ion ion-ios-circle-outline"></i> Buttons</a></li>
                                    <li class="active"><a href="toastr.html"><i class="ion ion-ios-circle-outline"></i> Toastr</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#" class="has-dropdown"><i class="ion ion-flag"></i><span>Icons</span></a>
                                <ul class="menu-dropdown">
                                    <li><a href="ion-icons.html"><i class="ion ion-ios-circle-outline"></i> Ion Icons</a></li>
                                    <li><a href="fontawesome.html"><i class="ion ion-ios-circle-outline"></i> Font Awesome</a></li>
                                    <li><a href="flag.html"><i class="ion ion-ios-circle-outline"></i> Flag</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="table.html"><i class="ion ion-clipboard"></i><span>Tables</span></a>
                            </li>
                            <li>
                                <a href="chartjs.html"><i class="ion ion-stats-bars"></i><span>Chart.js</span></a>
                            </li>
                            <li>
                                <a href="simple.html"><i class="ion ion-ios-location-outline"></i><span>Google Maps</span></a>
                            </li>
                            <li>
                                <a href="#" class="has-dropdown"><i class="ion ion-ios-copy-outline"></i><span>Examples</span></a>
                                <ul class="menu-dropdown">
                                    <li><a href="login.html"><i class="ion ion-ios-circle-outline"></i> Login</a></li>
                                    <li><a href="register.html"><i class="ion ion-ios-circle-outline"></i> Register</a></li>
                                    <li><a href="forgot.html"><i class="ion ion-ios-circle-outline"></i> Forgot Password</a></li>
                                    <li><a href="reset.html"><i class="ion ion-ios-circle-outline"></i> Reset Password</a></li>
                                    <li><a href="404.html"><i class="ion ion-ios-circle-outline"></i> 404</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#"><i class="ion ion-heart"></i> Badges <div class="badge badge-primary">10</div></a>
                            </li>
                            <li>
                                <a href="credits.html"><i class="ion ion-ios-information-outline"></i> Credits</a>
                            </li>          </ul>
                    </aside>
                </div>



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
