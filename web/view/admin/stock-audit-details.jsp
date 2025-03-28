<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Kiểm Kho</title>

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

            .zone-card {
                margin-bottom: 30px;
                border: 1px solid #ddd;
                border-radius: 5px;
                overflow: hidden;
            }

            .zone-card .card-header {
                background-color: #f8f9fa;
                padding: 15px;
                font-weight: bold;
                border-bottom: 1px solid #ddd;
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
                            <h1>Chi Tiết Kiểm Kho - <fmt:formatDate value="${auditDate}" pattern="dd/MM/yyyy" /></h1>
                            <div>
                                <a href="stock-audit" class="btn btn-secondary mr-2">
                                    <i class="fas fa-arrow-left"></i> Quay Lại
                                </a>
                                <a href="stock-audit?action=history" class="btn btn-primary">
                                    <i class="fas fa-list"></i> Xem Tất Cả Lịch Sử
                                </a>
                            </div>
                        </div>

                        <div class="section-body">
                            <c:forEach var="entry" items="${auditsByZone}">
                                <c:set var="zoneId" value="${entry.key}" />
                                <c:set var="audits" value="${entry.value}" />
                                <c:set var="zone" value="${zoneMap[zoneId]}" />

                                <div class="zone-card">
                                    <div class="card-header">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h5>Zone: ${zone.name} (${zone.id})</h5>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <span>Nhân viên kiểm kho: ${audits[0].staffName}</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th width="5%">STT</th>
                                                        <th width="10%">Mã SP</th>
                                                        <th width="25%">Tên Sản Phẩm</th>
                                                        <th width="15%">Số Lượng Hệ Thống</th>
                                                        <th width="15%">Số Lượng Thực Tế</th>
                                                        <th width="15%">Chênh Lệch</th>
                                                        <th width="15%">Ghi Chú</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="audit" items="${audits}" varStatus="loop">
                                                        <tr>
                                                            <td>${loop.index + 1}</td>
                                                            <td>${audit.productId}</td>
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
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <c:if test="${empty auditsByZone}">
                                <div class="alert alert-info">
                                    Không có dữ liệu kiểm kho cho ngày này.
                                </div>
                            </c:if>
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
        </script>
    </body>
</html> 