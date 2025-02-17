<%-- 
    Document   : Signup
    Created on : Feb 7, 2025, 3:39:41 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
        <style>
            body {
                background-color: #f7f9fc;
                font-family: Arial, sans-serif;
            }
            #logreg-forms {
                width: 100%;
                max-width: 400px;
                margin: 10vh auto;
                background: #e0f7fa;
                padding: 2rem;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }
            .form-signup h1 {
                margin-bottom: 1rem;
            }
            .captcha-container {
                margin-bottom: 1rem;
                text-align: center;
            }
            .captcha-container img {
                max-height: 100px;
                display: inline-block;
            }
            .captcha-container button {
                margin-left: 10px;
                vertical-align: middle;
            }
            .captcha-input {
                width: 100%;
                max-width: 150px;
                display: inline-block;
                vertical-align: middle;
            }
            .btn-block {
                margin-top: 1rem;
            }
            .text-center {
                text-align: center;
            }
            .text-danger {
                margin-bottom: 1rem;
            }
        </style>
        <title>Sign Up Form</title>
    </head>
    <body>
        <div id="logreg-forms">
            <form action="${pageContext.request.contextPath}/signup" method="post" class="form-signup" id="submitForm">
                <h1 class="h3 mb-3 font-weight-normal text-center">Sign up</h1>
                <p class="text-danger text-center">${err}</p>
                <p style="color: blue">${success}</p>
                <div class="form-group">
                    <input name="email"  id="user-email" class="form-control" placeholder="Email (someone@example.com)" value="${email}">
                </div>
                <div class="form-group">
                    <input name="user" type="text" id="user-name" class="form-control" placeholder="User name" value="${user}" autofocus>
                </div>
                <div class="form-group">
                    <div class="input-group mb-3">
                        <input name="password" type="password" id="password" class="form-control" placeholder="Password" value="${password}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary eye-button" type="button" id="togglePassword">
                                <i class="fa fa-eye" aria-hidden="true"></i>
                            </button>
                        </div>

                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group mb-3">
                        <input name="repass" type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" value="${confirmpassword}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary eye-button" type="button" id="toggleConfirmPassword">
                                <i class="fa fa-eye" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                    <small id="passwordStrength" class="form-text"></small>
                    <small id="passwordMatch" class="form-text"></small>
                </div>

                <button class="btn btn-primary btn-block" id="submitForm" type="submit"><i class="fas fa-user-plus"></i> Sign Up</button>
                <!--                <a href="login" id="cancel_signup" class="btn btn-secondary btn-block"><i class="fas fa-angle-left"></i> Back</a>-->
            </form>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function () {
                $("#refresh-captcha").click(function () {
                    $("#captchaImage").attr("src", "captcha?timestamp=" + new Date().getTime());
                });

                const newPassword = document.getElementById('password');
                const confirmPassword = document.getElementById('confirmPassword');
                const passwordMatch = document.getElementById('passwordMatch');
                const passwordStrength = document.getElementById('passwordStrength');
                const togglePassword = document.getElementById('togglePassword');
                const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
                const form = document.getElementById('submitForm');

                function updatePassword() {
                    const strength = getPasswordStrength(newPassword.value);
                    passwordStrength.textContent = strength.message;
                    passwordStrength.style.color = strength.color;

                    if (newPassword.value === confirmPassword.value) {
                        passwordMatch.textContent = 'Passwords match';
                        passwordMatch.style.color = 'green';
                    } else {
                        passwordMatch.textContent = 'Passwords do not match';
                        passwordMatch.style.color = 'red';
                    }
                }

//                function getPasswordStrength(password) {
//                    let message = '';
//                    let color = '';
//                    const specialChars = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?`~]/;
//    
//    const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?`~]).{8,}$/;
//    const mediumRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?`~]).{6,}$/;
//
//                    if (strongRegex.test(password)) {
//                        message = 'Strong password';
//                        color = 'green';
//                    } else if (mediumRegex.test(password)) {
//                        message = 'Medium strength password';
//                        color = 'orange';
//                    } else {
//                        message = 'Password must have at least 6 characters!';
//                        color = 'red';
//                    }
//                    return {message, color};
//                }
                function getPasswordStrength(password) {
                    let message = '';
                    let color = '';

                    if (password.length >= 6) {
                        message = 'Valid password';
                        color = 'green';
                    } else {
                        message = 'Password must have at least 6 characters!';
                        color = 'red';
                    }
                    return {message, color};
                }
                newPassword.addEventListener('input', updatePassword);
                confirmPassword.addEventListener('input', updatePassword);

                togglePassword.addEventListener('click', function () {
                    togglePasswordVisibility(newPassword, this);
                });

                toggleConfirmPassword.addEventListener('click', function () {
                    togglePasswordVisibility(confirmPassword, this);
                });

                form.addEventListener('submit', function (event) {
                    const strength = getPasswordStrength(newPassword.value);
                    if (newPassword.value !== confirmPassword.value || strength.color === 'red') {
                        event.preventDefault();
                        alert('Password validation failed. Please check the requirements.');
                    }
                });

                function togglePasswordVisibility(inputField, toggleButton) {
                    const type = inputField.getAttribute('type') === 'password' ? 'text' : 'password';
                    inputField.setAttribute('type', type);
                    toggleButton.querySelector('i').classList.toggle('fa-eye-slash');
                }
            });
        </script>
    </body>
</html>