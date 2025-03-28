<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Phân Tích Thời Gian</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>
            .main-content {
                margin-left: 250px;
                padding: 20px;
            }

            .card {
                margin-bottom: 20px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                border-radius: 8px;
            }

            .card-header {
                background-color: #f8f9fa;
                border-bottom: 1px solid #e9ecef;
                padding: 15px 20px;
                font-weight: 600;
            }

            .card-body {
                padding: 20px;
            }

            .chart-container {
                position: relative;
                height: 400px;
                width: 100%;
                margin-bottom: 30px;
            }

            .table-responsive {
                margin-top: 15px;
            }

            .heatmap-container {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 5px;
                margin-top: 20px;
            }

            .heatmap-cell {
                padding: 10px;
                text-align: center;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 500;
                color: white;
            }

            .heatmap-header {
                background-color: #f8f9fa;
                color: #333;
                font-weight: 600;
                padding: 10px;
                text-align: center;
                border-radius: 4px;
            }

            .heat-level-1 {
                background-color: #d4f7d4;
                color: #333;
            }
            .heat-level-2 {
                background-color: #a2e9a2;
                color: #333;
            }
            .heat-level-3 {
                background-color: #70db70;
                color: #333;
            }
            .heat-level-4 {
                background-color: #39cc39;
                color: white;
            }
            .heat-level-5 {
                background-color: #2eb82e;
                color: white;
            }
            .heat-level-6 {
                background-color: #248f24;
                color: white;
            }
            .heat-level-7 {
                background-color: #1a661a;
                color: white;
            }
            .heat-level-8 {
                background-color: #0f3d0f;
                color: white;
            }
        </style>
    </head>
    <body>
        <div id="app">
            <div class="main-wrapper">
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                    <div class="main-content">
                        <section class="section">
                            <h1 class="section-header">
                                <div>Phân Tích Thời Gian</div>
                                <button id="sidebarToggle" class="btn btn-primary d-md-none">
                                    <i class="fa fa-bars"></i>
                                </button>
                            </h1>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h5>Đơn Hàng Theo Ngày Trong Tuần</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="chart-container">
                                                <canvas id="dailyChart"></canvas>
                                            </div>
                                            <div class="table-responsive">
                                                <table class="table table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>Ngày</th>
                                                            <th>Số Đơn Hàng</th>
                                                            <th>Doanh Thu</th>
                                                            <th>% Tổng Đơn Hàng</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:set var="totalOrders" value="0" />
                                                    <c:forEach var="day" items="${dailyStats}">
                                                        <c:set var="totalOrders" value="${totalOrders + day.orderCount}" />
                                                    </c:forEach>

                                                    <c:forEach var="day" items="${dailyStats}">
                                                        <tr>
                                                            <td>${day.timeSlot}</td>
                                                            <td>${day.orderCount}</td>
                                                            <td><fmt:formatNumber value="${day.totalRevenue}" type="currency"/></td>
                                                            <td>
                                                                <c:if test="${totalOrders > 0}">
                                                                    <fmt:formatNumber value="${(day.orderCount / totalOrders) * 100}" type="number" maxFractionDigits="1"/>%
                                                                </c:if>
                                                                <c:if test="${totalOrders == 0}">
                                                                    0%
                                                                </c:if>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty dailyStats}">
                                                        <tr>
                                                            <td colspan="4" class="text-center">Không có dữ liệu</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Đơn Hàng Theo Tháng</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="chart-container">
                                            <canvas id="monthlyChart"></canvas>
                                        </div>
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Tháng</th>
                                                        <th>Số Đơn Hàng</th>
                                                        <th>Doanh Thu</th>
                                                        <th>% Tổng Đơn Hàng</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="totalOrders" value="0" />
                                                    <c:forEach var="month" items="${monthlyStats}">
                                                        <c:set var="totalOrders" value="${totalOrders + month.orderCount}" />
                                                    </c:forEach>

                                                    <c:forEach var="month" items="${monthlyStats}">
                                                        <tr>
                                                            <td>${month.timeSlot}</td>
                                                            <td>${month.orderCount}</td>
                                                            <td><fmt:formatNumber value="${month.totalRevenue}" type="currency"/></td>
                                                            <td>
                                                                <c:if test="${totalOrders > 0}">
                                                                    <fmt:formatNumber value="${(month.orderCount / totalOrders) * 100}" type="number" maxFractionDigits="1"/>%
                                                                </c:if>
                                                                <c:if test="${totalOrders == 0}">
                                                                    0%
                                                                </c:if>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty monthlyStats}">
                                                        <tr>
                                                            <td colspan="4" class="text-center">Không có dữ liệu</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Đề Xuất Nhân Sự</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="alert alert-info">
                                            <h6><i class="fa fa-info-circle"></i> Dựa trên mẫu đơn hàng của bạn, chúng tôi đề xuất:</h6>
                                            <ul>
                                                <li>Tăng nhân sự trong giờ cao điểm (
                                                    <c:forEach var="hour" items="${hourlyStats}" varStatus="status">
                                                        <c:if test="${hour.orderCount >= 5}">
                                                            ${hour.timeSlot}${!status.last ? ', ' : ''}
                                                        </c:if>
                                                    </c:forEach>
                                                    )</li>
                                                <li>Cân nhắc bổ sung nhân viên vào những ngày bận rộn (
                                                    <c:forEach var="day" items="${dailyStats}" varStatus="status">
                                                        <c:if test="${day.orderCount >= 10}">
                                                            ${day.timeSlot}${!status.last ? ', ' : ''}
                                                        </c:if>
                                                    </c:forEach>
                                                    )</li>
                                                <li>Chuẩn bị hàng tồn kho trước thời gian cao điểm để đảm bảo hoạt động trơn tru</li>
                                            </ul>
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
            // Daily Chart
            const dailyCtx = document.getElementById('dailyChart').getContext('2d');
            const dailyChart = new Chart(dailyCtx, {
            type: 'bar',
                    data: {
                    labels: [
            <c:forEach var="day" items="${dailyStats}" varStatus="status">
                    '${day.timeSlot}'${!status.last ? ',' : ''}
            </c:forEach>
                    ],
                            datasets: [{
                            label: 'Đơn Hàng',
                                    data: [
            <c:forEach var="day" items="${dailyStats}" varStatus="status">
                ${day.orderCount}${!status.last ? ',' : ''}
            </c:forEach>
                                    ],
                                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                                    borderColor: 'rgba(54, 162, 235, 1)',
                                    borderWidth: 1
                            }]
                    },
                    options: {
                    responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                            y: {
                            beginAtZero: true
                            }
                            }
                    }
            });
            // Monthly Chart
            const monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
            const monthlyChart = new Chart(monthlyCtx, {
            type: 'bar',
                    data: {
                    labels: [
            <c:forEach var="month" items="${monthlyStats}" varStatus="status">
                    '${month.timeSlot}'${!status.last ? ',' : ''}
            </c:forEach>
                    ],
                            datasets: [{
                            label: 'Đơn Hàng',
                                    data: [
            <c:forEach var="month" items="${monthlyStats}" varStatus="status">
                ${month.orderCount}${!status.last ? ',' : ''}
            </c:forEach>
                                    ],
                                    backgroundColor: 'rgba(75, 192, 192, 0.6)',
                                    borderColor: 'rgba(75, 192, 192, 1)',
                                    borderWidth: 1
                            }]
                    },
                    options: {
                    responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                            y: {
                            beginAtZero: true
                            }
                            }
                    }
            });
        </script>
    </body>
</html> 