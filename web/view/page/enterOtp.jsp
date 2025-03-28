<%-- 
    Document   : EnterOtp
    Created on : Feb 8, 2025, 4:38:21 PM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
          <style>
            :root {
                --primary-color: #2563eb;
                --primary-light: #dbeafe;
                --primary-dark: #1e40af;
                --white: #ffffff;
                --gray-light: #f8fafc;
                --text-dark: #1e293b;
                --red: #ef4444;
            }
            
            body {
                background-color: var(--gray-light);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: var(--text-dark);
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                background-image: linear-gradient(135deg, rgba(37, 99, 235, 0.1) 0%, rgba(59, 130, 246, 0.05) 100%);
                margin: 0;
                padding: 0;
            }
            
            .container {
                padding: 20px;
            }
            
            .panel {
                width: 100%;
                max-width: 450px;
                margin: 0 auto;
                background: var(--white);
                padding: 2.5rem;
                box-shadow: 0 10px 25px rgba(37, 99, 235, 0.1);
                border-radius: 12px;
                border-top: 5px solid var(--primary-color);
            }
            
            .text-center {
                text-align: center;
            }
            
            .icon-container {
                margin-bottom: 1.5rem;
                text-align: center;
            }
            
            .icon-container i {
                font-size: 3.5rem;
                color: var(--primary-color);
                background: var(--primary-light);
                width: 100px;
                height: 100px;
                line-height: 100px;
                border-radius: 50%;
                display: inline-block;
            }
            
            h2 {
                margin-bottom: 1.5rem;
                color: var(--primary-color);
                font-weight: 600;
            }
            
            .form-control {
                border-radius: 8px;
                padding: 12px 15px;
                height: auto;
                border: 1px solid #e2e8f0;
                margin-bottom: 1rem;
                transition: all 0.3s ease;
                font-size: 1.1rem;
                letter-spacing: 2px;
                text-align: center;
            }
            
            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.25);
            }
            
            .input-group-addon {
                border-radius: 8px 0 0 8px;
                padding: 0 15px;
                background-color: var(--primary-light);
                color: var(--primary-color);
                border: 1px solid #e2e8f0;
                border-right: none;
                display: flex;
                align-items: center;
            }
            
            .input-group {
                display: flex;
                margin-bottom: 1rem;
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                padding: 12px;
                border-radius: 8px;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                margin-bottom: 10px;
            }
            
            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(37, 99, 235, 0.3);
            }
            
            .btn-secondary {
                background-color: #94a3b8;
                border-color: #94a3b8;
                padding: 12px;
                border-radius: 8px;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
            }
            
            .btn-secondary:hover {
                background-color: #64748b;
                border-color: #64748b;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(100, 116, 139, 0.3);
            }
            
            .btn-block {
                width: 100%;
            }
            
            .text-danger {
                color: var(--red) !important;
                font-weight: 500;
                margin-top: 10px;
            }
            
            #countdown {
                font-size: 1.1rem;
                letter-spacing: 0.5px;
                margin-top: 15px;
            }
            
            .otp-info {
                margin-bottom: 20px;
                color: #64748b;
                font-size: 0.9rem;
            }
            
            .digit-group {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-bottom: 20px;
            }
        </style>
        <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function() {
                var expiryTime = <%= session.getAttribute("otpExpiryTime") %>;
                var countdownElement = document.getElementById("countdown");
                var interval = setInterval(function() {
                    var currentTime = new Date().getTime();
                    var distance = expiryTime - currentTime;

                    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    var seconds = Math.floor((distance % (1000 * 60)) / 1000);

                    countdownElement.innerHTML = minutes + "m " + seconds + "s ";

                    if (distance < 0) {
                        clearInterval(interval);
                        countdownElement.innerHTML = "OTP đã hết hạn";
                    }
                }, 1000);
            });
        </script>
    </head>

    <body>
        <div class="form-gap"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="text-center">
                                <h3><i class="fa fa-lock fa-4x"></i></h3>
                                <h2 class="text-center">Nhập OTP</h2>
                                <div class="panel-body">
                                    <form id="register-form" action="${pageContext.request.contextPath}/VerifyCode" role="form" autocomplete="off" class="form" method="post">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
                                                <input id="otp" name="otp" placeholder="Nhập OTP" class="form-control" type="text" value="${code}" >
                                            </div>
                                            <p style="color: red">${error}</p>
                                        </div>
                                        <div class="form-group">
                                            <input name="submit" class="btn btn-lg btn-primary btn-block" value="Đặt lại mật khẩu" type="submit">
                                        </div>
                                        <input type="hidden" class="hide" name="token" id="token" value="">
                                    </form>
                                    <form id="resend-form" action="${pageContext.request.contextPath}/UserVerify" method="post">
                                        <input type="hidden" name="resend">
                                        <div class="form-group">
                                            <input class="btn btn-lg btn-secondary btn-block" value="Gửi lại OTP" type="submit">
                                        </div>
                                    </form>
                                    <p id="countdown" class="text-danger"></p>
                                    <%
                                        String message = (String) session.getAttribute("message");
                                        if (message != null) {
                                            out.print("<p class='text-danger ml-1'>" + message + "</p>");
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

