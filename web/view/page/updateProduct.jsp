<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Product</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
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

                            <div class="form-group">
                                <label for="image">Image URL:</label>
                                <input type="text" class="form-control" id="image" name="image" value="${product.image}" placeholder="Enter image URL">
                            </div>

                            <button type="submit" class="btn btn-primary">Update Product</button>
                            <a href="products" class="btn btn-secondary">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>

            <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.bundle.min.js"></script>
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