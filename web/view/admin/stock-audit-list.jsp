<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch Sử Kiểm Kho</title>

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
            
            .audit-dates {
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            
            .date-card {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 15px;
                margin-bottom: 15px;
                transition: all 0.3s ease;
            }
            
            .date-card:hover {
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transform: translateY(-2px);
            }
            
            .date-card .date {
                font-size: 18px;
                font-weight: bold;
                color: #007bff;
            }
            
            .date-card .count {
                font-size: 14px;
                color: #6c757d;
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
                            <h1>Lịch Sử Kiểm Kho</h1>
                            <a href="stock-audit?action=history" class="btn btn-primary">
                                <i class="fas fa-list"></i> Xem Chi Tiết Tất Cả
                            </a>
                        </div>

                        <div class="section-body">
                            <div class="row">
                                <div class="col-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h4>Các Đợt Kiểm Kho Gần Đây</h4>
                                        </div>
                                        <div class="card-body">
                                            <div class="audit-dates">
                                                <div class="row">
                                                    <c:forEach var="date" items="${auditDates}" varStatus="loop">
                                                        <div class="col-md-4">
                                                            <div class="date-card">
                                                                <div class="date">
                                                                    <i class="fas fa-calendar-check"></i>
                                                                    <fmt:formatDate value="${date}" pattern="dd/MM/yyyy" />
                                                                </div>
                                                                <div class="mt-3">
                                                                    <a href="stock-audit?action=details&date=${date}" class="btn btn-info btn-sm">
                                                                        <i class="fas fa-eye"></i> Xem Chi Tiết
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        <c:if test="${loop.index % 3 == 2 || loop.last}">
                                                            </div><div class="row">
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                                
                                                <c:if test="${empty auditDates}">
                                                    <div class="alert alert-info">
                                                        Chưa có dữ liệu kiểm kho nào.
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
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