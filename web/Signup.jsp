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
            <form action="signup" method="post" class="form-signup" id="submitForm">
                <h1 class="h3 mb-3 font-weight-normal text-center">Sign up</h1>
                <p class="text-danger text-center">${err}</p>
                <p style="color: blue">${success}</p>
                <div class="form-group">
                    <input name="email" type="email" id="user-email" class="form-control" placeholder="Email (someone@example.com)" value="${email}">
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
<!--                <div class="captcha-container text-center">
                    <img src="captcha" alt="CAPTCHA Image" id="captchaImage">
                    <button type="button" class="btn btn-sm btn-info" id="refresh-captcha">
                        <i class="fas fa-sync-alt"></i>
                    </button>
                </div>
                <div class="form-group text-center">
                    <input type="text" name="captcha" placeholder="Enter CAPTCHA" class="form-control captcha-input" required>
                </div>-->
                <button class="btn btn-primary btn-block" id="submitForm" type="submit"><i class="fas fa-user-plus"></i> Sign Up</button>
<!--                <a href="login" id="cancel_signup" class="btn btn-secondary btn-block"><i class="fas fa-angle-left"></i> Back</a>-->
            </form>
        </div>
        
    </body>