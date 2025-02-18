<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css">
        <style>
            .main-content {
                margin-left: 250px;
                padding: 20px;
                border-collapse: collapse;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 12px;
                text-align: left;
                vertical-alignment: middle;
            }

            th {
                background-color: #f8f9fa;
            }

            .section-body {
                font-family: Arial, sans-serif;
                max-width: 1000px;
                margin: 40px auto;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
        </style>
    </head>
    )<tbody>
        <c:forEach row="products">
            <tr><td colspan="7" class="text-center border-b">Product Details</td>
                <td><a href="#" class="waves-effect waves-light btn btn-primary mark-for-lev">View</a></td>
            </tr>
        </c:forEach>

        <!-- Product Details Modal -->
    <div class="modal fade" id="productDetailsModal" tabindex="-1" role="dialog" aria-labelledby="productDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productDetailsModalLabel">Product Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="products" method="post">
                    <div class="modal-body">
                        <!-- Hidden fields -->
                        <input type="hidden" name="action" value="insert">

                        <!-- Product Details Fields -->
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

                        <!-- Row Actions -->
                        <div class="row-actions">
                            <button onclick="deleteProduct(event)" class="btn btn-danger row-action-btn">Delete</button>
                            <button onclick="markForLeverage(event)" class="btn btn-success row-action-btn">Mark for Leverage</button>
                        </div>
                    </div>
                    <!-- Modal Footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update Product</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal for Adding Product -->
    <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="products" method="post">
                    <div class="modal-body">
                        <!-- Hidden field -->
                        <input type="hidden" name="action" value="insert">

                        <!-- Form Fields -->
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
                    </div>
                    <!-- Modal Footer -->
                    <div class="modal-footer">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <button type="submit" class="btn btn-primary">Add Product</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Required Scripts -->
    <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>