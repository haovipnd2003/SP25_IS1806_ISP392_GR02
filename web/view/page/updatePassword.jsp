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
        <title>Change Password &mdash; Stisla</title>

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
            .password-form {
                max-width: 500px;
                margin: 0 auto;
            }
            
            .form-group {
                margin-bottom: 25px;
                display: flex;
                flex-wrap: wrap;
                align-items: center;
            }
            
            .form-label {
                width: 150px;
                color: #6c757d;
                font-weight: 600;
                margin-bottom: 0;
                font-size: 1rem;
            }
            
            .form-input {
                flex: 1;
                min-width: 250px;
                position: relative;
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
            
            .form-control[readonly] {
                background-color: #f9f9f9;
                cursor: not-allowed;
            }
            
            /* Password Field Styling */
            .password-field {
                position: relative;
            }
            
            .toggle-password {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: #6c757d;
                z-index: 10;
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
            
            .btn-change {
                background-color: #ffa426;
                color: white;
            }
            
            .btn-change:hover {
                background-color: #ff8c00;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(255, 164, 38, 0.3);
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
                display: flex;
                align-items: center;
                gap: 8px;
            }
            
            .error-message {
                color: #ff3333;
                margin-top: 15px;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 8px;
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
            
            /* Password Strength Indicator */
            .password-strength {
                height: 5px;
                margin-top: 8px;
                border-radius: 5px;
                background-color: #e9ecef;
                overflow: hidden;
            }
            
            .password-strength-meter {
                height: 100%;
                width: 0;
                transition: width 0.3s ease;
            }
            
            .strength-weak {
                width: 25%;
                background-color: #ff3333;
            }
            
            .strength-medium {
                width: 50%;
                background-color: #ffa426;
            }
            
            .strength-strong {
                width: 75%;
                background-color: #3abaf4;
            }
            
            .strength-very-strong {
                width: 100%;
                background-color: #00cc33;
            }
            
            .password-feedback {
                font-size: 0.8rem;
                margin-top: 5px;
                color: #6c757d;
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
                                            <h2>Change Password</h2>
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

                                                <form action="${pageContext.request.contextPath}/changePassword" method="POST" class="password-form">
                                                    <div class="form-group">
                                                        <label class="form-label">Name:</label>
                                                        <div class="form-input">
                                                            <input type="text" name="name" value="${u.getName()}" readonly class="form-control" />
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <label class="form-label">Old Password:</label>
                                                        <div class="form-input password-field">
                                                            <input type="password" name="old_pass" class="form-control" id="old-password" />
                                                            <span class="toggle-password" onclick="togglePassword('old-password')">
                                                                <i class="fas fa-eye"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <label class="form-label">New Password:</label>
                                                        <div class="form-input password-field">
                                                            <input type="password" name="new_pass" class="form-control" id="new-password" oninput="checkPasswordStrength(this.value)" />
                                                            <span class="toggle-password" onclick="togglePassword('new-password')">
                                                                <i class="fas fa-eye"></i>
                                                            </span>
                                                            <div class="password-strength">
                                                                <div class="password-strength-meter" id="password-strength-meter"></div>
                                                            </div>
                                                            <div class="password-feedback" id="password-feedback"></div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <label class="form-label">Confirm Password:</label>
                                                        <div class="form-input password-field">
                                                            <input type="password" name="confirm_pass" class="form-control" id="confirm-password" oninput="checkPasswordMatch()" />
                                                            <span class="toggle-password" onclick="togglePassword('confirm-password')">
                                                                <i class="fas fa-eye"></i>
                                                            </span>
                                                            <div class="password-feedback" id="password-match-feedback"></div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="btn-container">
                                                        <button type="submit" class="btn-custom btn-change">
                                                            <i class="fas fa-key"></i> Change Password
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
        
        <!-- Custom JavaScript for password functionality -->
        <script>
            // Toggle password visibility
            function togglePassword(inputId) {
                const passwordInput = document.getElementById(inputId);
                const icon = passwordInput.nextElementSibling.querySelector('i');
                
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            }
            
            // Check password strength
            function checkPasswordStrength(password) {
                const meter = document.getElementById('password-strength-meter');
                const feedback = document.getElementById('password-feedback');
                
                // Remove all classes
                meter.className = 'password-strength-meter';
                
                if (!password) {
                    meter.style.width = '0';
                    feedback.textContent = '';
                    return;
                }
                
                // Check password strength
                let strength = 0;
                
                // Length check
                if (password.length >= 8) strength += 1;
                
                // Contains lowercase
                if (/[a-z]/.test(password)) strength += 1;
                
                // Contains uppercase
                if (/[A-Z]/.test(password)) strength += 1;
                
                // Contains number
                if (/[0-9]/.test(password)) strength += 1;
                
                // Contains special character
                if (/[^a-zA-Z0-9]/.test(password)) strength += 1;
                
                // Update meter and feedback
                switch(strength) {
                    case 0:
                    case 1:
                        meter.classList.add('strength-weak');
                        feedback.textContent = 'Weak password';
                        feedback.style.color = '#ff3333';
                        break;
                    case 2:
                        meter.classList.add('strength-medium');
                        feedback.textContent = 'Medium password';
                        feedback.style.color = '#ffa426';
                        break;
                    case 3:
                        meter.classList.add('strength-strong');
                        feedback.textContent = 'Strong password';
                        feedback.style.color = '#3abaf4';
                        break;
                    case 4:
                    case 5:
                        meter.classList.add('strength-very-strong');
                        feedback.textContent = 'Very strong password';
                        feedback.style.color = '#00cc33';
                        break;
                }
            }
            
            // Check if passwords match
            function checkPasswordMatch() {
                const newPassword = document.getElementById('new-password').value;
                const confirmPassword = document.getElementById('confirm-password').value;
                const feedback = document.getElementById('password-match-feedback');
                
                if (!confirmPassword) {
                    feedback.textContent = '';
                    return;
                }
                
                if (newPassword === confirmPassword) {
                    feedback.textContent = 'Passwords match';
                    feedback.style.color = '#00cc33';
                } else {
                    feedback.textContent = 'Passwords do not match';
                    feedback.style.color = '#ff3333';
                }
            }
        </script>
    </body>
</html>