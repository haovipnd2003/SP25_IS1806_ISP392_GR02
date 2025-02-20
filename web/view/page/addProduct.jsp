<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
    <head>
        <title>Add Product</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
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
        <div id="app">
            <div class="main-wrapper">
                <!-- Sidebar -->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>

                    <!-- Main Content -->
                    <div class="main-content" style="margin-left: 250px; padding: 20px;">
                        <button id="sidebarToggle" class="btn btn-secondary mb-3">
                            <i class="fas fa-bars"></i>
                        </button>
                        <div class="container">
                            <div class="card shadow">
                                <div class="card-header bg-primary text-white">
                                    <h1 class="card-title text-center">Add New Product</h1>
                                </div>
                                <div class="card-body">
                                    <form action="products" method="post">
                                        <input type="hidden" name="action" value="insert">

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
                                        <div class="form-group">
                                            <label for="image" class="form-label">Image URL:</label>
                                            <input type="text" class="form-control" id="image" name="image" placeholder="Enter image URL">
                                        </div>
                                        <button type="submit" class="btn btn-primary mt-3">Add Product</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    // Get existing product names from server
                    const existingProductNames = [
                <c:forEach var="product" items="${productList}" varStatus="loop">
                    "${fn:escapeXml(product.name)}"${!loop.last ? ',' : ''}
                </c:forEach>
                    ];

                    function validateForm() {
                        const productName = document.getElementById('name').value.trim();

                        if (existingProductNames.includes(productName)) {
                            alert('Product name already exists!');
                            return false;
                        }
                        return true;
                    }

                    // Add event listener to form
                    document.querySelector('form').addEventListener('submit', function (event) {
                        if (!validateForm()) {
                            event.preventDefault();
                        }
                    });
            </script>
            <!-- Bootstrap JS (optional) -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
        </div>
    </body>
</html>