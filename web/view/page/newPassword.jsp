<%-- 
    Document   : newPassword
    Created on : Feb 8, 2025, 4:50:26 PM
    Author     : Admin
--%>


<!doctype html>
<html>
    <head>
        <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate" />
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Expires" content="0" />
        <meta charset='utf-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <title>Reset Password</title>
        <link
            href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css'
            rel='stylesheet'>
        <link
            href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css'
            rel='stylesheet'>
        <script type='text/javascript'
        src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <style>
            .placeicon {
                font-family: fontawesome
            }

            .custom-control-label::before {
                background-color: #dee2e6;
                border: #dee2e6
            }
            .eye-button {
                border: none;
                background-color: transparent;
                outline: none;

            }
        </style>
    </head>
    <body oncontextmenu='return false' class='snippet-body bg-info'>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-social/5.1.1/bootstrap-social.css">
        <div>
            <!-- Container containing all contents -->
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 mt-5">
                        <!-- White Container -->
                        <div class="container bg-white rounded mt-2 mb-2 px-0">
                            <!-- Main Heading -->
                            <div class="row justify-content-center align-items-center pt-3">
                                <h1>
                                    <strong>Reset Password</strong>
                                </h1>
                            </div>
                            <div class="pt-3 pb-3">
                                <%
// Add headers to prevent caching
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
                                %>
                                <form class="form-horizontal" id="resetForm" action="${pageContext.request.contextPath}/ResetPassword" method="POST">
                                    <input type="hidden" name="email" value="${email}">
                                    <!-- User Name Input -->
                                    <div class="form-group row justify-content-center px-3">
                                        <div class="col-9 px-0">
                                            <div class="input-group mb-3">
                                                <input type="password" id="newPassword" name="newpassword" placeholder="New Password"
                                                       class="form-control border-info placeicon" value="${newpassword}" >
                                                <div class="input-group-append">
                                                    <button class="btn btn-outline-secondary eye-button" type="button" id="toggleNewPassword">
                                                        <i class="fa fa-eye" aria-hidden="true"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="input-group mb-3">
                                                <input type="password" id="confirmPassword" name="confirm-password" placeholder="Confirm Password"
                                                       class="form-control border-info placeicon" value="${confirmpassword}" >
                                                <div class="input-group-append">
                                                    <button class="btn btn-outline-secondary eye-button" type="button" id="toggleConfirmPassword">
                                                        <i class="fa fa-eye" aria-hidden="true"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <small id="passwordStrength" class="form-text"></small>
                                            <small id="passwordMatch" class="form-text"></small>
                                        </div>
                                    </div>
                                    <!-- Log in Button -->
                                    <div class="form-group row justify-content-center">
                                        <div class="col-9 px-0">
                                            <input type="submit" id="resetForm" value="Reset"
                                                   class="btn btn-block btn-info">
                                        </div>
                                    </div>
                                </form>
                                <!-- Alternative Login -->
                                <div class="mx-0 px-0 bg-light">

                                    <!-- Horizontal Line -->
                                    <div class="px-4 pt-5">
                                        <hr>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script type='text/javascript'
            src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'></script>
            <script type='text/javascript'>
                document.addEventListener('DOMContentLoaded', function () {
                    const newPassword = document.getElementById('newPassword');
                    const confirmPassword = document.getElementById('confirmPassword');
                    const passwordStrength = document.getElementById('passwordStrength');
                    const passwordMatch = document.getElementById('passwordMatch');
                    const form = document.getElementById('resetForm');

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

                    // Add event listeners to newPassword and confirmPassword fields
                    newPassword.addEventListener('input', updatePassword);
                    confirmPassword.addEventListener('input', updatePassword);

                    form.addEventListener('submit', function (event) {
                        const strength = getPasswordStrength(newPassword.value);
                        if (newPassword.value !== confirmPassword.value || strength.color === 'red') {
                            event.preventDefault();
                            alert('Password validation failed. Please check the requirements.');
                        }
                    });

//                    function getPasswordStrength(password) {
//                        let message = '';
//                        let color = '';
//                        const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
//                        const mediumRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;
//
//                        if (strongRegex.test(password)) {
//                            message = 'Strong password';
//                            color = 'green';
//                        } else if (mediumRegex.test(password)) {
//                            message = 'Medium strength password';
//                            color = 'orange';
//                        } else {
//                            message = 'Password must have contain uppercase letter,lowercase letter,number,special character and at least 6 characters!';
//                            color = 'red';
//                        }
//                        return {message, color};
//                    }
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

                });
                toggleNewPassword.addEventListener('click', function () {
                    togglePasswordVisibility(newPassword);
                });

                // Toggle password visibility for confirm password
                toggleConfirmPassword.addEventListener('click', function () {
                    togglePasswordVisibility(confirmPassword);
                });

                function togglePasswordVisibility(inputField) {
                    const type = inputField.getAttribute('type') === 'password' ? 'text' : 'password';
                    inputField.setAttribute('type', type);
                    this.querySelector('i').classList.toggle('fa-eye-slash');
                }
            </script>
    </body>

</html>


