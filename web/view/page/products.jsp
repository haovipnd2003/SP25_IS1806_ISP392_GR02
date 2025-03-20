<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.min.css">
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
                /* max-width: 1000px; */
                /* margin: 40px auto; */
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .description-cell {
                max-width: 100px; /* Adjust as needed */
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                cursor: pointer;
            }
            .description-cell:hover {
                white-space: normal;
                overflow: visible;
            }
            .pagination {
                margin-top: 20px;
            }

            .page-item.active .page-link {
                background-color: #007bff;
                border-color: #007bff;
            }

            .page-link {
                color: #007bff;
            }

            .page-link:hover {
                color: #0056b3;
                .main-sidebar {
                    transition: all 0.3s ease;
                }

                .main-content {
                    transition: margin-left 0.3s ease;
                }

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
                        <button id="sidebarToggle" class="btn btn-secondary mb-3">
                            <i class="fas fa-bars"></i>
                        </button>
                        <section class="section">
                            <div class="section-header">
                                <h1>Product List</h1>
                            </div>
                        <c:if test="${roletype == 2}">
                            <div class="text-right mb-3">
                                <a href="products?action=add" class="btn btn-primary btn-lg">
                                    <i class="fas fa-plus"></i> Add Product
                                </a>
                            </div>
                        </c:if>
                        <!-- Search and Filter -->
                        <div class="d-flex align-items-center mb-3">
                            <div class="search-container mr-3">
                                <form action="products" method="get" class="form-inline">
                                    <input type="hidden" name="action" value="search">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="keyword" placeholder="Search products..." value="${param.keyword}">
                                        <div class="input-group-append">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="filter-container">
                                <form action="products" method="get" class="form-inline">
                                    <input type="hidden" name="action" value="filter">
                                    <div class="form-group mr-2">
                                        <label for="isActive" class="mr-2">Active Status:</label>
                                        <select name="isActive" id="isActive" class="form-control">
                                            <option value="default">All Statuses</option>
                                            <option value="true">Active</option>
                                            <option value="false">Inactive</option>
                                        </select>
                                    </div>
                                    <div class="form-group mr-2">
                                        <label for="zoneId" class="mr-2">Zone:</label>
                                        <select name="zoneId" id="zoneId" class="form-control">
                                            <option value="default">All Zones</option>
                                            <c:forEach var="zone" items="${zones}">
                                                <option value="${zone.id}" ${param.zoneId == zone.id ? 'selected' : ''}>
                                                    ${zone.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Filter</button>
                                </form>
                            </div>
                        </div>
                        <!-- Product Table -->
                        <table class="table table-bordered section-body">
                            <thead class="thead-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Image</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Packaging(kg)</th>
                                    <th>Zone</th>
                                    <th>Active</th>
                                        <c:if test="${roletype == 2}">
                                        <th>Action</th>
                                        </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty productList}">
                                        <c:forEach var="product" items="${productList}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>${product.name}</td>
                                                <td>
                                                    <c:if test="${not empty product.image}">
                                                        <img src="${product.image}" alt="${product.name}" style="max-width: 100px; max-height: 100px;">
                                                    </c:if>
                                                </td>
                                                <td class="description-cell" title="${fn:escapeXml(product.describe)}">
                                                    ${fn:escapeXml(product.describe)}
                                                </td>
                                                <td>
                                                    <fmt:setLocale value="vi_VN"/>
                                                    <fmt:formatNumber value="${product.price}" type="number" pattern="#,##0.##" var="formattedPrice" />
                                                    ${formattedPrice.replace(',', '.')}<span>đ</span>
                                                </td>
                                                <td>${product.quantity}</td>
                                                <td>${product.packaging}</td>
                                                <td>
                                                    <c:if test="${not empty product.zoneIds}">
                                                        <c:forEach var="zoneId" items="${product.zoneIds}" varStatus="status">
                                                            <c:forEach var="zone" items="${zones}">
                                                                <c:if test="${zone.id == zoneId}">
                                                                    ${zone.name}<c:if test="${!status.last}">, </c:if>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:forEach>
                                                    </c:if>
                                                </td>
                                                <td style="color: ${product.active ? 'green' : 'red'}">${product.active ? 'Yes' : 'No'}</td>
                                                <c:if test="${roletype == '2'}">
                                                    <td>
                                                        <a href="products?action=edit&id=${product.id}" class="btn btn-primary">Update</a>
                                                    </td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr><td colspan="10" class="text-center">No products found.</td></tr>
                                    </c:otherwise>

                                </c:choose>
                            </tbody>
                        </table>
                        <!-- Phần phân trang -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="products?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="products?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="products?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                        <!-- Required Scripts -->
                        <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
                        <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.bundle.min.js"></script>
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

        <script>
            function deleteProduct(event) {
                event.preventDefault(); // Prevent the form from submitting immediately
                if (confirm('Are you sure you want to delete this product?')) {
                    event.target.submit(); // Submit the form if user confirms
                }
                return false; // Prevent form submission if user cancels
            }
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
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var toastMessage = "${sessionScope.toastMessage}";
                var toastType = "${sessionScope.toastType}";
                if (toastMessage) {
                    iziToast.show({
                        title: toastType === 'success' ? 'Success' : 'Error',
                        message: toastMessage,
                        position: 'topRight',
                        color: toastType === 'success' ? 'green' : 'red',
                        timeout: 5000
                    });
                    
                    // Clear toast messages from session immediately after showing
                    <% 
                        session.removeAttribute("toastMessage");
                        session.removeAttribute("toastType");
                    %>
                }
            });
        </script>
    </body>
</html>