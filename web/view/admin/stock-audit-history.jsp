<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch Sử Kiểm Kho Chi Tiết</title>

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
            
            .search-filter-container {
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            
            .difference-positive {
                color: green;
                font-weight: bold;
            }
            
            .difference-negative {
                color: red;
                font-weight: bold;
            }
            
            .difference-zero {
                color: #007bff;
                font-weight: bold;
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
                        <div class="section-header">
                            <h1>Lịch Sử Kiểm Kho Chi Tiết</h1>
                            <a href="stock-audit" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Quay Lại
                            </a>
                        </div>

                        <div class="section-body">
                            <div class="search-filter-container">
                                <form action="stock-audit" method="get" class="row">
                                    <input type="hidden" name="action" value="history">
                                    <div class="col-md-4">
                                        <label for="zoneId" class="form-label">Lọc theo Zone:</label>
                                        <select name="zoneId" id="zoneId" class="form-control">
                                            <option value="">-- Tất cả Zone --</option>
                                            <c:forEach var="zone" items="${zones}">
                                                <option value="${zone.id}" ${zone.id eq selectedZoneId ? 'selected' : ''}>${zone.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label">&nbsp;</label>
                                        <button type="submit" class="btn btn-primary form-control">
                                            <i class="fas fa-filter"></i> Lọc
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <div class="card">
                                <div class="card-header">
                                    <h4>Danh Sách Kiểm Kho</h4>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                    <th width="5%">STT</th>
                                                    <th width="10%">Ngày Kiểm</th>
                                                    <th width="15%">Zone</th>
                                                    <th width="15%">Nhân Viên</th>
                                                    <th width="15%">Sản Phẩm</th>
                                                    <th width="10%">SL Hệ Thống</th>
                                                    <th width="10%">SL Thực Tế</th>
                                                    <th width="10%">Chênh Lệch</th>
                                                    <th width="10%">Ghi Chú</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="audit" items="${audits}" varStatus="loop">
                                                    <tr>
                                                        <td>${(currentPage - 1) * 10 + loop.index + 1}</td>
                                                        <td><fmt:formatDate value="${audit.auditDate}" pattern="dd/MM/yyyy" /></td>
                                                        <td>${audit.zoneName}</td>
                                                        <td>${audit.staffName}</td>
                                                        <td>${audit.productName}</td>
                                                        <td>${audit.expectedQuantity}</td>
                                                        <td>${audit.actualQuantity}</td>
                                                        <td>
                                                            <span class="
                                                                <c:choose>
                                                                    <c:when test="${audit.difference > 0}">difference-positive</c:when>
                                                                    <c:when test="${audit.difference < 0}">difference-negative</c:when>
                                                                    <c:otherwise>difference-zero</c:otherwise>
                                                                </c:choose>
                                                            ">
                                                                ${audit.difference}
                                                            </span>
                                                        </td>
                                                        <td>${audit.note}</td>
                                                    </tr>
                                                </c:forEach>
                                                
                                                <c:if test="${empty audits}">
                                                    <tr>
                                                        <td colspan="9" class="text-center">Không có dữ liệu kiểm kho.</td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                    
                                    <!-- Pagination -->
                                    <c:if test="${totalPages > 1}">
                                        <nav aria-label="Page navigation" class="mt-4">
                                            <ul class="pagination justify-content-center">
                                                <c:if test="${currentPage > 1}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="stock-audit?action=history&page=${currentPage - 1}${not empty selectedZoneId ? '&zoneId='.concat(selectedZoneId) : ''}" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>

                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <a class="page-link" href="stock-audit?action=history&page=${i}${not empty selectedZoneId ? '&zoneId='.concat(selectedZoneId) : ''}">${i}</a>
                                                    </li>
                                                </c:forEach>

                                                <c:if test="${currentPage < totalPages}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="stock-audit?action=history&page=${currentPage + 1}${not empty selectedZoneId ? '&zoneId='.concat(selectedZoneId) : ''}" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </nav>
                                    </c:if>
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