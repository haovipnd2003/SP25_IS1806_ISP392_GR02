<%-- 
    Document   : EnterOtp_reg
    Created on : Feb 8, 2025, 4:53:21 PM
    Author     : Admin
--%>

<!DOCTYPE html>
<html>
    <head>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
        <style type="text/css">
            .form-gap {
                padding-top: 70px;
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
                        countdownElement.innerHTML = "OTP expired";
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
                                <h2 class="text-center">Enter OTP</h2>
                                <div class="panel-body">
                                    <form id="register-form" action="${pageContext.request.contextPath}/VerifyCode" role="form" autocomplete="off" class="form" method="post">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
                                                <input id="otp" name="otp" placeholder="Enter OTP" class="form-control" type="text" value="${code}" >
                                            </div>
                                            <p style="color: red">${error}</p>
                                        </div>
                                        <div class="form-group">
                                            <input name="submit_reg" class="btn btn-lg btn-primary btn-block" value="Submit" type="submit">
                                        </div>
                                        <input type="hidden" class="hide" name="token" id="token" value="">
                                    </form>
                                    <form id="resend-form" action="${pageContext.request.contextPath}/UserVerify" method="post">
                                        <input type="hidden" name="resend_register">
                                        <div class="form-group">
                                            <input class="btn btn-lg btn-secondary btn-block" value="Resend OTP" type="submit">
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
