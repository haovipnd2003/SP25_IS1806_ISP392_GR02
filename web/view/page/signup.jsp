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
            :root {
                --primary-color: #2563eb;
                --primary-light: #dbeafe;
                --primary-dark: #1e40af;
                --white: #ffffff;
                --gray-light: #f8fafc;
                --text-dark: #1e293b;
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
            }
            
            #logreg-forms {
                width: 100%;
                max-width: 450px;
                margin: 0 auto;
                background: var(--white);
                padding: 2.5rem;
                box-shadow: 0 10px 25px rgba(37, 99, 235, 0.1);
                border-radius: 12px;
                border-top: 5px solid var(--primary-color);
            }
            
            .form-signup h1 {
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
            }
            
            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.25);
            }
            
            .input-group-append .btn {
                border-top-right-radius: 8px;
                border-bottom-right-radius: 8px;
                padding: 0 15px;
                border-color: #e2e8f0;
            }
            
            .input-group-append .btn:hover {
                background-color: var(--primary-light);
                border-color: var(--primary-color);
            }
            
            .eye-button {
                color: var(--primary-color);
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                padding: 12px;
                border-radius: 8px;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
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
            }
            
            .btn-block {
                margin-top: 1.5rem;
            }
            
            .text-center {
                text-align: center;
            }
            
            .text-danger {
                margin-bottom: 1rem;
                color: #ef4444 !important;
            }
            
            .form-text {
                margin-top: 0.5rem;
                font-size: 0.875rem;
            }
            
            .form-group label {
                font-weight: 500;
                color: #475569;
                margin-bottom: 8px;
                display: block;
            }
            
            .logo-area {
                text-align: center;
                margin-bottom: 2rem;
            }
            
            .logo-area i {
                font-size: 3rem;
                color: var(--primary-color);
                background: var(--primary-light);
                width: 80px;
                height: 80px;
                line-height: 80px;
                border-radius: 50%;
            }
            
            .footer-text {
                text-align: center;
                margin-top: 1.5rem;
                font-size: 0.875rem;
                color: #64748b;
            }
            
            .footer-text a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
            }
            
            .input-group .form-control {
                margin-bottom: 0;
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
                                <i class="fa fa-eye fa-eye-slash" aria-hidden="true"></i>
                            </button>
                        </div>

                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group mb-3">
                        <input name="repass" type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" value="${confirmpassword}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary eye-button" type="button" id="toggleConfirmPassword">
                                <i class="fa fa-eye fa-eye-slash" aria-hidden="true"></i>
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