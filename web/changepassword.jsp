<%-- 
    Document   : changepassword
    Created on : Feb 8, 2025, 4:47:08 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Change Password</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link href="css/changepassword.css" rel="stylesheet" />
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
    </head>
    <body>
        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row">

                <div class="col-md-5 border-right">
                    <div class="p-3 py-5">
                        <a href="home" style="color: blue; margin-right: 20px;"> <span>Home</span></a>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-right">Change Password</h4>
                        </div>
                        <form action='changepassword' class="form-container" method='POST' id="submitForm">
                            <p class="text-danger">${mess}</p>
                            <p class="text-success">${mess2}</p>
                            <div class="row mt-2">
                                <div class="col-md-12"><label class="labels"></label><input  hidden="" readonly=""name="id" type="text" class="form-control"  value="${listAid.id}"></div>
                                <div class="col-md-12"><label class="labels"></label><input  hidden="" readonly=""name="pass" type="text" class="form-control"  value="${listAid.pass}"></div>
                            </div>
                            <div class="form-group">
                                <div class="input-group mb-3">
                                    <input name="oldPassword" type="password" id="oldPassword" class="form-control" placeholder="Old Password" value="${oldPasswordInput}" required="">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary eye-button" type="button" id="toggleOldPassword">
                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group mb-3">
                                    <input name="password" type="password" id="password" class="form-control" placeholder="Password" value="${password}" required="">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary eye-button" type="button" id="togglePassword">
                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group mb-3">
                                    <input name="confirmPassword" type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" value="${confirmPassword}" required="">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary eye-button" type="button" id="toggleConfirmPassword">
                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                        </button>
                                    </div>
                                </div>
                                <small id="passwordStrength" class="form-text"></small>
                                <small id="passwordMatch" class="form-text"></small>
                            </div>
                            <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="submit">Submit</button></div>
                        </form> 
                    </div>
                </div>
            </div>
        </div>
        
    </body>
</html>



