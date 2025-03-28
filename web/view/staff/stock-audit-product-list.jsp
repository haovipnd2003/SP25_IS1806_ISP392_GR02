<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kiểm Kho Theo Sản Phẩm</title>

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

            .main-sidebar {
                transition: all 0.3s ease;
            }

            .main-content {
                transition: margin-left 0.3s ease;
            }

            .section-header {
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .section-header h1 {
                margin: 0;
                font-size: 24px;
                font-weight: 600;
            }

            .search-container {
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
            }

            .product-card {
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-bottom: 15px;
                padding: 15px;
                transition: all 0.3s ease;
            }

            .product-card:hover {
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .product-name {
                font-weight: bold;
                font-size: 18px;
                margin-bottom: 5px;
            }

            .product-id {
                color: #666;
                font-size: 14px;
                margin-bottom: 10px;
            }

            .product-quantity {
                font-size: 16px;
                color: #007bff;
                margin-bottom: 10px;
            }

            .last-audit {
                font-size: 14px;
                color: #666;
                margin-bottom: 15px;
            }

            .audit-button {
                text-align: right;
            }
        </style>
    </head>
    <body>
        <div id="app">
            <div class="main-wrapper">

                <!-- Sidebar -->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                    <div style="position: absolute; top: 15px; right: 20px; z-index: 1000;">
                    <c:if test="${sessionScope.acc != null}">
                        <div class="dropdown">
                            <button class="btn btn-light dropdown-toggle" type="button" id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-user"></i> ${sessionScope.acc.name}
                            </button>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">
                                    <i class="ion ion-android-person"></i> Hồ sơ
                                </a>
                                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">
                                    <i class="ion ion-log-out"></i> Đăng xuất
                                </a>
                            </div>
                        </div>
                    </c:if>
                </div>
                <!-- Main Content -->
                <div class="main-content" style="margin-left: 250px; padding: 20px;">
                    <button id="sidebarToggle" class="btn btn-secondary mb-3">
                        <i class="fas fa-bars"></i>
                    </button>
                    <section class="section">
                        <div class="section-header">
                            <h1>Kiểm Kho Theo Sản Phẩm</h1>
                        </div>

                        <div class="section-body">
                            <div class="search-container">
                                <form action="stock-audit" method="get" class="row align-items-center">
                                    <input type="hidden" name="action" value="form">
                                    <div class="col-md-8">
                                        <div class="input-group">
                                            <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm sản phẩm..." value="${keyword}">
                                            <div class="input-group-append">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-search"></i> Tìm Kiếm
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <div class="row">
                                <c:forEach var="product" items="${products}">
                                    <div class="col-md-6">
                                        <div class="product-card">
                                            <div class="product-name">${product.name}</div>
                                            <div class="product-id">Mã SP: ${product.id}</div>
                                            <div class="product-quantity">Số lượng: ${product.quantity}</div>
                                            <div class="last-audit">
                                                <c:choose>
                                                    <c:when test="${lastAuditDates[product.id] != null}">
                                                        Kiểm kho gần nhất: <fmt:formatDate value="${lastAuditDates[product.id]}" pattern="dd/MM/yyyy" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        Chưa có kiểm kho
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="audit-button">
                                                <a href="stock-audit?action=audit-product&productId=${product.id}" class="btn btn-primary">
                                                    <i class="fas fa-clipboard-check"></i> Kiểm Kho
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${empty products}">
                                    <div class="col-12">
                                        <div class="alert alert-info">
                                            Không tìm thấy sản phẩm nào.
                                        </div>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Thêm phân trang sau danh sách sản phẩm -->
                            <div class="row">
                                <div class="col-12">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-center">
                                            <c:if test="${currentPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="stock-audit?action=form&page=${currentPage - 1}${not empty keyword ? '&keyword='.concat(keyword) : ''}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="stock-audit?action=form&page=${i}${not empty keyword ? '&keyword='.concat(keyword) : ''}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <c:if test="${currentPage < totalPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="stock-audit?action=form&page=${currentPage + 1}${not empty keyword ? '&keyword='.concat(keyword) : ''}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </section>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/js/iziToast.min.js"></script>

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

            // Toast message display
            document.addEventListener('DOMContentLoaded', function () {
                var toastMessage = "${sessionScope.toastMessage}";
                var toastType = "${sessionScope.toastType}";
                if (toastMessage) {
                    iziToast.show({
                        title: toastType === 'success' ? 'Thành công' : 'Lỗi',
                        message: toastMessage,
                        position: 'topRight',
                        color: toastType === 'success' ? 'green' : 'red',
                        timeout: 5000
                    });

                    // Clear toast messages from session
            <% 
                        session.removeAttribute("toastMessage");
                        session.removeAttribute("toastType");
            %>
                }
            });
        </script>
    </body>
</html>