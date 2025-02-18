<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entity.Products"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css">
    </head>
    <body>
        <div id="app">
            <div class="main-wrapper">

                <!-- Sidebar -->

                <!--MAIN-SIDEBAR-JSP-INCLUDE-->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                    <!--MAIN-SIDEBAR-JSP-INCLUDE-->

                    <!-- Main Content -->
                    <div class="main-content" style="margin-left: 250px; padding: 20px;">
                        <section class="section">
                            <div class="section-header">
                                <h1>Product List</h1>
                            </div>

                            <div class="section-body">
                                <!-- Button to open Add Product modal -->
                                <div style="margin-bottom: 20px;">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addProductModal">
                                        Add New Product
                                    </button>
                                </div>

                                <!-- Product Table -->
                                <table class="table table-bordered">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>Price</th>
                                            <th>Zone</th>
                                            <th>Quantity</th>
                                            <th>Zone ID</th>
                                            <th>Active</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <% 
                                        List<Products> productList = (List<Products>) request.getAttribute("productList");
                                        if (productList != null) {
                                            for (Products product : productList) {
                                    %>
                                    <tr>
                                        <td><%= product.getId() %></td>
                                        <td><%= product.getName() %></td>
                                        <td><%= product.getDescribe() != null ? product.getDescribe().replaceAll("<", "&lt;").replaceAll(">", "&gt;") : "" %></td>
                                        <td><%= product.getPrice() %></td>
                                        <td><%= product.getZone() %></td>
                                        <td><%= product.getQuantity() %></td>
                                        <td><%= product.getZoneId() %></td>
                                        <td><%= product.isActive() ? "Yes" : "No" %></td>
                                        <td>
                                            <form action="products" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="<%= product.getId() %>">
                                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% 
                                            }
                                        } else {
                                    %>
                                    <tr><td colspan="9" class="text-center">No products found.</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </section>
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
                                <input type="text" class="form-control" id="describe" name="describe" required>
                            </div>
                            <div class="form-group">
                                <label for="price">Price:</label>
                                <input type="number" class="form-control" id="price" name="price" step="0.01" required>
                            </div>
                            <div class="form-group">
                                <label for="zone">Zone:</label>
                                <input type="text" class="form-control" id="zone" name="zone" required>
                            </div>
                            <div class="form-group">
                                <label for="quantity">Quantity:</label>
                                <input type="number" class="form-control" id="quantity" name="quantity" required>
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
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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