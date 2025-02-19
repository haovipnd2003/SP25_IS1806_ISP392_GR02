<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Update Product</title>
    </head>
    <body>
        <h1>Update Product</h1>
        <form action="products" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="${param.id}">

            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" value="${product.name}" required>
            </div>
            <div class="form-group">
                <label for="describe">Description:</label>
                <textarea class="form-control" id="describe" name="describe" rows="3">${product.describe}</textarea>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number