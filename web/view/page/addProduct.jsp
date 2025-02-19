<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Add Product</title>
    </head>
    <body>
        <h1>Add New Product</h1>
        <form action="products" method="post">
            <input type="hidden" name="action" value="insert">

            <div class="form-group">
                <label for="id">ID:</label>
                <input type="text" class="form-control" id="id" name="id" required>
            </div>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="describe">Description:</label>
                <textarea class="form-control" id="describe" name="describe" rows="3"></textarea>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" class="form-control" id="price" name="price" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" class="form-control" id="quantity" name="quantity" step="1" min="1" required>
            </div>
            <div class="form-group">
                <label for="zoneId">Zone ID:</label>
                <input type="text" class="form-control" id="zoneId" name="zoneId" required>
            </div>
            <div class="form-group">
                <label for="isActive">Active:</label>
                <select class="form-control" id="isActive" name="isActive" required>
                    <option value="true">Yes</option>
                    <option value="false">No</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Add Product</button>
        </form>
    </body>
</html>