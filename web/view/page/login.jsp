<%-- 
    Document   : Login
    Created on : Feb 7, 2025, 3:37:07 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

<!------ Include the above in your HEAD tag  ---------->


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <link href="css/login.css" rel="stylesheet" type="text/css"/>
        <title>Login Form</title>
    </head>
    <body>
        <style>
            /* Enhanced custom styles for login form */
            /*            body {
                            background: linear-gradient(135deg, #f0f5ff 0%, #e0eafc 100%);
                            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                        }*/

            body {
                background: url('https://wallpapers.com/images/high/rice-background-vjwqohrsk3b78x65.webp') no-repeat center center fixed;
                background-size: cover;
            }

            #logreg-forms {
                width: 412px;
                margin: 10vh auto;
                background-color: #ffffff;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
                transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
                padding: 40px;
                border-radius: 12px;
                animation: fadeIn 0.5s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            #logreg-forms:hover {
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            }

            #logreg-forms form {
                width: 100%;
                max-width: 410px;
                padding: 15px;
                margin: auto;
            }

            #logreg-forms .form-control {
                position: relative;
                box-sizing: border-box;
                height: auto;
                padding: 12px 15px;
                font-size: 16px;
                border: 2px solid #e0e0e0;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            #logreg-forms .form-control:focus {
                z-index: 2;
                border-color: #2563eb;
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2);
                outline: none;
                animation: inputFocus 0.3s ease;
            }

            #logreg-forms .form-signin input[type="text"],
            #logreg-forms .form-signin input[type="password"] {
                margin-bottom: 15px;
                border-radius: 8px;
            }

            /* Password input group styles */
            .input-group {
                position: relative;
                display: flex;
                flex-wrap: wrap;
                align-items: stretch;
                width: 100%;
            }

            #logreg-forms .form-signin input[type="password"] {
                border-top-right-radius: 0;
                border-bottom-right-radius: 0;
                margin-bottom: 0;
            }

            .eye-button {
                border: 2px solid #2563eb;
                border-left: none;
                background-color: #ffffff;
                color: #2563eb;
                border-top-right-radius: 8px;
                border-bottom-right-radius: 8px;
                padding: 0 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }

            .eye-button:hover,
            .eye-button:focus {
                background-color: #f0f5ff; /* Lighter background on hover */
                color: #2563eb;
                outline: none;
            }

            .input-group-append {
                display: flex;
                margin-left: -2px; /* Adjust this value to align with the input border */
            }

            /* Ensure the input and button heights match */
            #logreg-forms .form-control,
            .eye-button {
                height: 48px; /* Adjust this value as needed */
            }

            /* Remove bottom margin from the password input group */
            .input-group.mb-3 {
                margin-bottom: 15px !important;
            }

            #logreg-forms .btn-block {
                font-size: 1rem;
                font-weight: 600;
                letter-spacing: 0.05rem;
                padding: 12px 20px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            #logreg-forms .btn-success {
                background-color: #2563eb;
                border-color: #2563eb;
                box-shadow: 0 4px 6px rgba(37, 99, 235, 0.2);
            }

            #logreg-forms .btn-success:hover,
            #logreg-forms .btn-success:focus,
            #logreg-forms .btn-success:active {
                background-color: #1d4ed8;
                border-color: #1d4ed8;
                box-shadow: 0 6px 8px rgba(29, 78, 216, 0.3);
                transform: translateY(-2px);
            }

            #logreg-forms a {
                color: #2563eb;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            #logreg-forms a:hover {
                color: #1d4ed8;
                text-decoration: underline;
            }

            .text-danger {
                color: #dc2626 !important;
                font-weight: 500;
            }

            .text-success {
                color: #16a34a !important;
                font-weight: 500;
            }

            .h3 {
                color: #2563eb;
                font-weight: 700;
                margin-bottom: 25px;
                text-align: center;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .input-group-append {
                margin-left: -1px;
            }

            .input-group-append .btn {
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
            }

            /* Add a subtle animation to form inputs */
            @keyframes inputFocus {
                0% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.02);
                }
                100% {
                    transform: scale(1);
                }
            }

            /* Style for the "Register here" link */
            .text-center a {
                display: inline-block;
                margin-top: 15px;
                padding: 8px 15px;
                background-color: #e6eeff; /* Lighter initial background */
                color: #2563eb;
                border-radius: 20px;
                transition: all 0.3s ease;
            }

            .text-center a:hover {
                background-color: #ffffff; /* Even lighter background on hover */
                color: #2563eb;
                text-decoration: none;
                box-shadow: 0 4px 6px rgba(37, 99, 235, 0.2);
            }
        </style>
        <div id="logreg-forms">
            <form class="form-signin" action="${pageContext.request.contextPath}/login" method="post">
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center">Đăng nhập</h1>
                <p class="text-danger">${mess}</p>
                <p class="text-danger">${mess1}</p>
                <p style="color: green">${mess2}</p>
                <p style="color: green">${success}</p>
                <p style="color: green">${successMessage}</p>
                <input name="name"  type="text" id="inputEmail" class="form-control" placeholder="Tên tài khoản" value="${name}" autofocus="">
                <div class="input-group mb-3">
                    <input name="password"  type="password" id="inputPassword" class="form-control" placeholder="Mật khẩu" value="${password}" >
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary eye-button" type="button" id="toggleNewPassword">
                            <i class="fa fa-eye fa-eye-slash" aria-hidden="true"></i>
                        </button>
                    </div>
                </div>
<!--                <input name="pass"  type="password" id="inputPassword" class="form-control" placeholder="Password" value="${pass}" required="">-->

                <div class="form-group form-check">
                    <!--                    <input name="remember" value="1" type="checkbox" class="form-check-input" id="exampleCheck1">-->

                    <a href="view/page/forgotPassword.jsp " >Quên mật khẩu?</a>
                </div>

                <button class="btn btn-success btn-block" type="submit"><i class="fas fa-sign-in-alt"></i> Đăng nhập</button>

                <hr>
                <div class="text-center">
                    Bạn chưa có tài khoản? <a href="view/page/signup.jsp" class="ml-1">Đăng ký ở đây</a>
                </div>
            </form>
            <br>

        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>
            function toggleResetPswd(e) {
                e.preventDefault();
                $('#logreg-forms .form-signin').toggle() // display:block or none
                $('#logreg-forms .form-reset').toggle() // display:block or none
            }

            function toggleSignUp(e) {
                e.preventDefault();
                $('#logreg-forms .form-signin').toggle(); // display:block or none
                $('#logreg-forms .form-signup').toggle(); // display:block or none
            }

            $(() => {
                // Login Register Form
                $('#logreg-forms #forgot_pswd').click(toggleResetPswd);
                $('#logreg-forms #cancel_reset').click(toggleResetPswd);
                $('#logreg-forms #btn-signup').click(toggleSignUp);
                $('#logreg-forms #cancel_signup').click(toggleSignUp);
            })
            function togglePasswordVisibility(button) {
                const inputField = document.getElementById('inputPassword');
                const type = inputField.getAttribute('type') === 'password' ? 'text' : 'password';
                inputField.setAttribute('type', type);
                button.querySelector('i').classList.toggle('fa-eye-slash');
            }

            document.getElementById('toggleNewPassword').addEventListener('click', function () {
                togglePasswordVisibility(this);
            });
        </script>
    </body>
</html>