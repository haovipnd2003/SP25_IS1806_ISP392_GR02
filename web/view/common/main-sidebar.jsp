<%-- 
    Document   : main-sidebar
    Created on : 16 thg 2, 2025, 00:43:03
    Author     : binh2
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <a href="${pageContext.request.contextPath}/sale"><i class="ion ion-clipboard"></i><span>Sale</span></a>
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
