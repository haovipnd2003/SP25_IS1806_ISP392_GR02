<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zone Details</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .section-body {
            font-family: Arial, sans-serif;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .zone-info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .product-card {
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
            margin-bottom: 20px;
            transition: transform 0.3s;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .product-image {
            height: 200px;
            width: 100%;
            object-fit: cover;
        }
        .product-details {
            padding: 15px;
        }
        .no-products {
            text-align: center;
            padding: 50px;
            background-color: #f8f9fa;
            border-radius: 5px;
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
                <section class="section">
                    <div class="section-header d-flex justify-content-between align-items-center">
                        <h1>Zone Details</h1>
                        <a href="zoneControl" class="btn btn-primary">
                            <i class="fas fa-arrow-left"></i> Back to Zones
                        </a>
                    </div>

                    <div class="section-body">
                        <div class="zone-info">
                            <div class="row">
                                <div class="col-md-6">
                                    <h3>${zone.name}</h3>
                                    <p><strong>ID:</strong> ${zone.id}</p>
                                    <p><strong>Status:</strong> 
                                        <span class="badge ${zone.isActive ? 'bg-success' : 'bg-danger'}">
                                            ${zone.isActive ? 'Active' : 'Inactive'}
                                        </span>
                                    </p>
                                </div>
                                <div class="col-md-6 text-md-right">
                                    <p><strong>Total Products:</strong> ${zone.productCount}</p>
                                </div>
                            </div>
                        </div>

                        <h4>Products in this Zone</h4>
                        
                        <c:if test="${empty products}">
                            <div class="no-products">
                                <i class="fas fa-box-open fa-3x mb-3"></i>
                                <h5>No products found in this zone</h5>
                            </div>
                        </c:if>
                        
                        <div class="row">
                            <c:forEach var="product" items="${products}">
                                <div class="col-md-4 col-lg-3">
                                    <div class="product-card">
                                        <c:choose>
                                            <c:when test="${not empty product.image}">
                                                <img src="${pageContext.request.contextPath}/images/products/${product.image}" class="product-image" alt="${product.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/images/products/default.jpg" class="product-image" alt="Default Image">
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="product-details">
                                            <h5>${product.name}</h5>
                                            <p class="text-truncate">${product.describe}</p>
                                            <p><strong>Price:</strong> $${product.price}</p>
                                            <p>
                                                <span class="badge ${product.isActive ? 'bg-success' : 'bg-danger'}">
                                                    ${product.isActive ? 'Active' : 'Inactive'}
                                                </span>
                                            </p>
                                            <a href="productControl?action=view&id=${product.id}" class="btn btn-sm btn-primary">View Product</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>

    <script>
        // Toggle sidebar
        document.getElementById('sidebarToggle').addEventListener('click', function () {
            const sidebar = document.querySelector('.main-sidebar');
            const mainContent = document.querySelector('.main-content');

            if (sidebar.style.display === 'none') {
                sidebar.style.display = 'block';
                mainContent.style.marginLeft = '250px';
            } else {
                sidebar.style.display = 'none';
                mainContent.style.marginLeft = '0';
            }
        });
    </script>

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/js/iziToast.min.js"></script>
</body>
</html> 