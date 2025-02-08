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

<!------ Include the above in your HEAD tag ---------->
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%> 
 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <link href="css/login.css" rel="stylesheet" type="text/css"/>
        <style>
            /* Mã CSS ? ?ây */
/*            body {
                background-image:  url('image/the-dien-thoai.jpg');
                background-size: cover;
                background-repeat: no-repeat;
                background-attachment: fixed;
                height: 100vh;
            }*/
            /* CSS cho ô nh?p li?u CAPTCHA */
            .captcha-input {
                width: auto; /* ??t chi?u r?ng t? ??ng ?? ô nh?p li?u ch? chi?m ph?n còn l?i c?a không gian */
                max-width: 150px; /* ??t chi?u r?ng t?i ?a c?a ô nh?p li?u */
                display: inline-block; /* Hi?n th? ô nh?p li?u trên cùng m?t dòng */
                vertical-align: middle; /* C?n ch?nh theo chi?u d?c */
            }

            /* CSS cho nút làm m?i CAPTCHA */
            .captcha-container button {
                margin-left: 5px; /* T?o kho?ng cách v?i ô nh?p li?u */
                vertical-align: middle; /* C?n ch?nh theo chi?u d?c */
            }

            /* CSS cho hình ?nh CAPTCHA */
            .captcha-container img {
                max-height: 100px; /* ??t chi?u cao t?i ?a c?a hình ?nh */
                vertical-align: middle; /* C?n ch?nh theo chi?u d?c */
            }
        </style>
        <title>Login Form</title>
    </head>
    <body>
        <div id="logreg-forms">


            <form class="form-signin" action="login" method="post">
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center"> Sign in</h1>
                <p class="text-danger">${mess}</p>
                <p class="text-danger">${mess1}</p>
                <p style="color: green">${mess2}</p>
                <p style="color: green">${success}</p>
                <p style="color: green">${successMessage}</p>
                <input name="user"  type="text" id="inputEmail" class="form-control" placeholder="Username" value="${user}" required="" autofocus="">
                <div class="input-group mb-3">
                    <input name="pass"  type="password" id="inputPassword" class="form-control" placeholder="Password" value="${pass}" required="">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary eye-button" type="button" id="toggleNewPassword">
                            <i class="fa fa-eye" aria-hidden="true"></i>
                        </button>
                    </div>
                </div>
<!--                <input name="pass"  type="password" id="inputPassword" class="form-control" placeholder="Password" value="${pass}" required="">-->
                <div class="captcha-container">
                    <img src="captcha" alt="CAPTCHA Image" id="captchaImage">
                    <button type="button" class="btn btn-sm btn-info" id="refresh-captcha">
                        <i class="fas fa-sync-alt"></i>
                    </button>
                    <input type="text" name="captcha" placeholder="Enter CAPTCHA" class="form-control captcha-input" required>
                </div>


                <div class="form-group form-check">
                    <!--                    <input name="remember" value="1" type="checkbox" class="form-check-input" id="exampleCheck1">-->

                    <a href="forgotPassword.jsp " >Forgot password?</a>
                </div>

                <button class="btn btn-success btn-block" type="submit"><i class="fas fa-sign-in-alt"></i> Sign in</button>

                <hr>
                <div class="text-center">
                    Do not have an account? <a href="Signup.jsp" class="ml-1">Register here</a>
                </div>
            </form>
            <br>

        </div>

    </body>
</html>