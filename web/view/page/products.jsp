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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
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
    <body>

        <div id="app">
            <div class="main-wrapper">

                <!-- Sidebar -->
                <!-- MAIN-SIDEBAR-JSP-INCLUDE -->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                    <!-- MAIN-SIDEBAR-JSP-INCLUDE -->

                    <!-- Main Content -->
                    <div class="main-content" style="margin-left: 250px; padding: 20px;">
                        <section class="section">
                            <div class="section-header">
                                <h1>Product List</h1>
                            </div>

                            <!-- Product Table -->
                            <table class="table table-bordered section-body">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Description</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Zone ID</th>
                                        <th>Active</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty productList}">
                                        <c:forEach var="product" items="${productList}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>${product.name}</td>
                                                <td>${fn:escapeXml(product.describe)}</td>
                                                <td>${product.price}</td>
                                                <td>${product.quantity}</td>
                                                <td>${product.zoneId}</td>
                                                <td>${product.active ? 'Yes' : 'No'}</td>
                                                <td>
                                                    <form action="products" method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${product.id}">
                                                        <div class="row-action">
                                                            <button onclick="deleteProduct(event)" class="btn btn-danger">Delete</button>
                                                            <button onclick="markForLeverage(event)" class="btn btn-success">Mark for Leverage</button>
                                                        </div>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr><td colspan="9" class="text-center">No products found.</td></tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>

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

                        <!-- Required Scripts -->
                        <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
                        <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.bundle.min.js"></script>
                </div>
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
    <script src="${pageContext.request.contextPath}/modules/popper.js"></script>
    <script src="${pageContext.request.contextPath}/modules/tooltip.js"></script>
    <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/modules/nicescroll/jquery.nicescroll.min.js"></script>
    <script src="${pageContext.request.contextPath}/modules/scroll-up-bar/dist/scroll-up-bar.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/sa-functions.js"></script>

    <script src="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
    <script src="${pageContext.request.contextPath}/js/custom.js"></script>
    <script src="${pageContext.request.contextPath}/js/demo.js"></script>
</body>
</html>