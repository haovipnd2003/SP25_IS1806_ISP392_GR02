<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Add Product</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                max-width: 600px;
                margin-top: 50px;
            }
            .form-group {
                margin-bottom: 1.5rem;
            }
            .btn-primary {
                width: 100%;
                padding: 10px;
                font-size: 1.1rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h1 class="card-title text-center">Add New Product</h1>
                </div>
                <div class="card-body">
                    <form action="products" method="post">
                        <input type="hidden" name="action" value="insert">

                        <div class="form-group">
                            <label for="id" class="form-label">ID:</label>
                            <input type="text" class="form-control" id="id" name="id" required>
                        </div>
                        <div class="form-group">
                            <label for="name" class="form-label">Name:</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="form-group">
                            <label for="describe" class="form-label">Description:</label>
                            <textarea class="form-control" id="describe" name="describe" rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="price" class="form-label">Price:</label>
                            <input type="number" class="form-control" id="price" name="price" step="0.01" required>
                        </div>
                        <div class="form-group">
                            <label for="quantity" class="form-label">Quantity:</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" step="1" min="1" required>
                        </div>
                        <div class="form-group">
                            <label for="zoneId" class="form-label">Zone ID:</label>
                            <input type="text" class="form-control" id="zoneId" name="zoneId" required>
                        </div>
                        <div class="form-group">
                            <label for="isActive" class="form-label">Active:</label>
                            <select class="form-select" id="isActive" name="isActive" required>
                                <option value="true">Yes</option>
                                <option value="false">No</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary mt-3">Add Product</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS (optional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>