<%-- 
    Document   : verifySignUp.jsp
    Created on : Feb 10, 2025, 4:40:58 PM
    Author     : dung.nvan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Page</title>
    </head>
    <body>
        <span>We already send a verification code to your email.</span>
        <form action="VerifyCode" method="post">
            <input type="text" name="authCode">
            <input type="submit" value="verify">
        </form>
        <p class="text-danger text-center">${errorMessage}</p>
    </body>
</html>
