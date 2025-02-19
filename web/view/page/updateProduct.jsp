<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Product</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2>Update Product</h2>
            <form action="products" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${product.id}">

                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" class="form-control" id="name" name="name" value="${fn:escapeXml(product.name)}" required>
                </div>

                <div class="form-group">
                    <label for="describe">Description:</label>
                    <textarea class="form-control" id="describe" name="describe" rows="3">${fn:escapeXml(product.describe)}</textarea>
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" class="form-control" id="price" name="price" value="${product.price}" step="0.01" required>
                </div>

                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" value="${product.quantity}" step="1" min="1" required>
                </div>

                <div class="form-group">
                    <label for="zoneId">Zone ID:</label>
                    <input type="text" class="form-control" id="zoneId" name="zoneId" value="${product.zoneId}" required>
                </div>

                <div class="form-group">
                    <label for="isActive">Active:</label>
                    <select class="form-control" id="isActive" name="isActive" required>
                        <option value="true" ${product.active ? 'selected' : ''}>Yes</option>
                        <option value="false" ${!product.active ? 'selected' : ''}>No</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Update Product</button>
                <a href="products" class="btn btn-secondary">Cancel</a>
            </form>
        </div>

        <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>