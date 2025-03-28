<%-- 
    Document   : updateProfile
    Created on : 15 thg 2, 2025, 01:20:36
    Author     : binh2
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Update Profile &mdash; Stisla</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        
        <!-- Custom inline styles -->
        <style>
            /* Card Styling */
            .card {
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 25px 0 rgba(0, 0, 0, 0.1);
                border: none;
                transition: all 0.3s ease;
            }
            
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px 0 rgba(0, 0, 0, 0.15);
            }
            
            .card-header {
                background-color: #6777ef !important;
                color: white !important;
                padding: 20px 25px;
                border-bottom: none;
            }
            
            .card-header h2 {
                margin: 0;
                font-weight: 700;
                color: white;
            }
            
            .card-body {
                padding: 30px;
            }
            
            /* Form Styling */
            .profile-form {
                max-width: 600px;
                margin: 0 auto;
            }
            
            .form-group {
                margin-bottom: 25px;
                display: flex;
                flex-wrap: wrap;
                align-items: center;
            }
            
            .form-label {
                width: 120px;
                color: #6c757d;
                font-weight: 600;
                margin-bottom: 0;
                font-size: 1rem;
            }
            
            .form-input {
                flex: 1;
                min-width: 250px;
            }
            
            .form-control {
                border-radius: 8px;
                border: 1px solid #e4e6fc;
                padding: 10px 15px;
                height: auto;
                transition: all 0.3s ease;
            }
            
            .form-control:focus {
                border-color: #6777ef;
                box-shadow: 0 0 0 2px rgba(103, 119, 239, 0.25);
            }
            
            /* Button Styling */
            .btn-container {
                display: flex;
                gap: 15px;
                margin-top: 30px;
                flex-wrap: wrap;
            }
            
            .btn-custom {
                padding: 12px 24px;
                border-radius: 30px;
                font-weight: 600;
                font-size: 0.9rem;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                border: none;
                cursor: pointer;
            }
            
            .btn-custom i {
                margin-right: 8px;
            }
            
            .btn-update {
                background-color: #3abaf4;
                color: white;
            }
            
            .btn-update:hover {
                background-color: #0da8ee;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(58, 186, 244, 0.3);
                color: white;
            }
            
            .btn-back {
                background-color: #6c757d;
                color: white;
            }
            
            .btn-back:hover {
                background-color: #5a6268;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(108, 117, 125, 0.3);
                color: white;
                text-decoration: none;
            }
            
            /* Alert styling */
            .alert-light {
                background-color: #ffffff;
                border: none;
                padding: 0;
            }
            
            /* Message styling */
            .success-message {
                color: #00cc33;
                margin-top: 15px;
                font-weight: 500;
            }
            
            .error-message {
                color: #ff3333;
                margin-top: 15px;
                font-weight: 500;
            }
            
            /* User Avatar */
            .user-avatar {
                margin-bottom: 30px;
                display: flex;
                justify-content: center;
            }
            
            .avatar-placeholder {
                width: 120px;
                height: 120px;
                background-color: #6777ef;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 2.5rem;
                font-weight: bold;
                box-shadow: 0 5px 15px rgba(103, 119, 239, 0.5);
            }
            
            /* Responsive Styles */
            @media (max-width: 768px) {
                .form-group {
                    flex-direction: column;
                    align-items: flex-start;
                }
                
                .form-label {
                    width: 100%;
                    margin-bottom: 8px;
                }
                
                .form-input {
                    width: 100%;
                }
                
                .btn-container {
                    justify-content: center;
                }
            }
        </style>
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
                                    <!-- Notification content -->
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

                <!--MAIN CONTENT-->
                <div class="main-content" style="min-height: 600px;">
                    <section class="section">
                        <div class="section-body">
                            <div class="row">
                                <div class="col-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h2>Update Profile</h2>
                                        </div>
                                        <div class="card-body">
                                            <div class="alert alert-light">
                                                <c:set value="${sessionScope.acc}" var="u"></c:set>
                                                
                                                <!-- User Avatar -->
                                                <div class="user-avatar">
                                                    <div class="avatar-placeholder">
                                                        <span>${fn:substring(u.getName(), 0, 1)}</span>
                                                    </div>
                                                </div>

                                                <form action="${pageContext.request.contextPath}/updateProfile" method="POST" class="profile-form">
                                                    <input type="hidden" name="id" value="${u.getId()}" />

                                                    <div class="form-group">
                                                        <label class="form-label">Name:</label>
                                                        <div class="form-input">
                                                            <input type="text" name="name" value="${u.getName()}" class="form-control" />
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <label class="form-label">Email:</label>
                                                        <div class="form-input">
                                                            <input type="email" name="email" value="${u.getEmail()}" class="form-control" />
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <label class="form-label">Phone:</label>
                                                        <div class="form-input">
                                                            <input type="text" name="phone" value="${u.getPhone()}" class="form-control" />
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <label class="form-label">Address:</label>
                                                        <div class="form-input">
                                                            <input type="text" name="address" value="${u.getAddress()}" class="form-control" />
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="btn-container">
                                                        <button type="submit" class="btn-custom btn-update">
                                                            <i class="fas fa-save"></i> Save Changes
                                                        </button>
                                                        
                                                        <a href="${pageContext.request.contextPath}/profile" class="btn-custom btn-back">
                                                            <i class="fas fa-arrow-left"></i> Back to Profile
                                                        </a>
                                                    </div>
                                                </form>
                                                
                                                <!-- Success/Error Messages -->
                                                <c:if test="${not empty requestScope.mess}">
                                                    <div class="success-message">
                                                        <i class="fas fa-check-circle"></i> ${requestScope.mess}
                                                    </div>
                                                </c:if>
                                                
                                                <c:if test="${not empty requestScope.error}">
                                                    <div class="error-message">
                                                        <i class="fas fa-exclamation-circle"></i> ${requestScope.error}
                                                    </div>
                                                </c:if>
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