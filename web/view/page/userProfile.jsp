<%-- 
    Document   : dashboard
    Created on : 15 thg 2, 2025, 00:01:05
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
        <title>Components &rsaquo; Toastr &mdash; Stisla</title>

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
            
            /* User Profile Container */
            .user-profile-container {
                display: flex;
                flex-direction: row;
                gap: 30px;
            }
            
            .user-avatar {
                flex-shrink: 0;
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
            
            .user-info {
                flex-grow: 1;
            }
            
            /* User Information Table */
            .user-info-table {
                width: 100%;
                margin-bottom: 30px;
            }
            
            .user-info-table tr {
                border-bottom: 1px solid #f2f2f2;
            }
            
            .user-info-table tr:last-child {
                border-bottom: none;
            }
            
            .info-label {
                width: 100px;
                padding: 15px 10px 15px 0;
                vertical-align: top;
            }
            
            .info-label h4 {
                color: #6c757d;
                font-weight: 600;
                margin: 0;
                font-size: 1rem;
            }
            
            .info-value {
                padding: 15px 0;
            }
            
            .info-value h4 {
                color: #34395e;
                font-weight: 700;
                margin: 0;
                font-size: 1rem;
            }
            
            /* Action Buttons */
            .action-buttons {
                display: flex;
                gap: 15px;
                margin-top: 20px;
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
                text-decoration: none;
            }
            
            .btn-change-password {
                background-color: #ffa426;
                color: white;
            }
            
            .btn-change-password:hover {
                background-color: #ff8c00;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(255, 164, 38, 0.3);
                color: white;
                text-decoration: none;
            }
            
            /* Alert styling */
            .alert-light {
                background-color: #ffffff;
                border: none;
                padding: 0;
            }
            
            /* Responsive Styles */
            @media (max-width: 768px) {
                .user-profile-container {
                    flex-direction: column;
                    align-items: center;
                    text-align: center;
                }
                
                .user-avatar {
                    margin-bottom: 20px;
                }
                
                .info-label {
                    width: 80px;
                }
                
                .action-buttons {
                    justify-content: center;
                }
            }
        </style>
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
                                            <h2>Information</h2>
                                        </div>
                                        <div class="card-body">
                                            <div class="alert alert-light">
                                                <c:set value="${sessionScope.acc}" var="u"></c:set>
                                                <div class="user-profile-container">
                                                    <!-- User Avatar -->
                                                    <div class="user-avatar">
                                                        <div class="avatar-placeholder">
                                                            <span>${fn:substring(u.getName(), 0, 1)}</span>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- User Information -->
                                                    <div class="user-info">
                                                        <table class="user-info-table">
                                                            <tbody>
                                                                <tr>
                                                                    <td class="info-label"><h4>Name:</h4></td>
                                                                    <td class="info-value"><h4><c:out value="${u.getName()}"></c:out></h4></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="info-label"><h4>Email:</h4></td>
                                                                    <td class="info-value"><h4><c:out value="${u.getEmail()}"></c:out></h4></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="info-label"><h4>Phone: </h4></td>
                                                                    <td class="info-value"><h4><c:out value="${u.getPhone()}"></c:out></h4></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="info-label"><h4>Address:</h4></td>
                                                                    <td class="info-value"><h4><c:out value="${u.getAddress()}"></c:out></h4></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                        
                                                        <!-- Action Buttons -->
                                                        <div class="action-buttons">
                                                            <a href="${pageContext.request.contextPath}/updateProfile" class="btn-custom btn-update">
                                                                <i class="fas fa-user-edit"></i> Update Profile
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/changePassword" class="btn-custom btn-change-password">
                                                                <i class="fas fa-key"></i> Change Password
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
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