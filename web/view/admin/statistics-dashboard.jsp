<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Trend Statistics Dashboard</title>

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
            
            .stat-card {
                background-color: #fff;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
            }
            
            .stat-card:hover {
                transform: translateY(-5px);
            }
            
            .stat-card h5 {
                margin-bottom: 15px;
                color: #333;
            }
            
            .stat-card .value {
                font-size: 24px;
                font-weight: 600;
                color: #007bff;
            }
            
            .trend-up {
                color: #28a745;
            }
            
            .trend-down {
                color: #dc3545;
            }
            
            .chart-container {
                position: relative;
                height: 300px;
                width: 100%;
            }
            
            .table-responsive {
                margin-top: 15px;
            }
            
            .nav-tabs .nav-link {
                border: none;
                color: #495057;
                font-weight: 500;
                padding: 10px 15px;
            }
            
            .nav-tabs .nav-link.active {
                color: #007bff;
                background-color: transparent;
                border-bottom: 2px solid #007bff;
            }
            
            .tab-content {
                padding: 20px 0;
            }
            
            .badge-zone {
                background-color: #17a2b8;
                color: white;
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 12px;
                margin-right: 5px;
            }
            
            .product-pair {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
                border-left: 4px solid #007bff;
            }
            
            .product-pair .frequency {
                font-weight: 600;
                color: #007bff;
            }
            
            .trending-product {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
                padding: 10px;
                border-radius: 8px;
                background-color: #f8f9fa;
            }
            
            .trending-product .product-name {
                flex-grow: 1;
                font-weight: 500;
            }
            
            .trending-product .growth {
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
            }
            
            .growth-positive {
                background-color: #d4edda;
                color: #155724;
            }
            
            .growth-negative {
                background-color: #f8d7da;
                color: #721c24;
            }
            
            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            
            .section-header h1 {
                margin: 0;
                font-size: 24px;
                font-weight: 600;
            }
            
            .section-header .btn-group {
                margin-left: auto;
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
                            <h1>User Trend Statistics Dashboard</h1>
                            <div class="btn-group ml-auto">
                                <a href="${pageContext.request.contextPath}/statistics?action=top-products" class="btn btn-outline-primary">
                                    Top Products
                                </a>
                                <a href="${pageContext.request.contextPath}/statistics?action=time-analysis" class="btn btn-outline-primary">
                                    Time Analysis
                                </a>
                            </div>
                        </div>

                        <!-- Summary Cards -->
                        <div class="row">
                            <div class="col-md-3">
                                <div class="stat-card">
                                    <h5>Top Product This Week</h5>
                                    <c:choose>
                                        <c:when test="${not empty topWeeklyProducts}">
                                            <div class="value">${topWeeklyProducts[0].productName}</div>
                                            <div class="text-muted">${topWeeklyProducts[0].salesCount} units sold</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="value">No data</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stat-card">
                                    <h5>Top Product This Month</h5>
                                    <c:choose>
                                        <c:when test="${not empty topMonthlyProducts}">
                                            <div class="value">${topMonthlyProducts[0].productName}</div>
                                            <div class="text-muted">${topMonthlyProducts[0].salesCount} units sold</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="value">No data</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stat-card">
                                    <h5>Busiest Day</h5>
                                    <c:choose>
                                        <c:when test="${not empty dailyStats}">
                                            <c:set var="busiestDay" value="${dailyStats[0]}" />
                                            <c:forEach var="day" items="${dailyStats}">
                                                <c:if test="${day.orderCount > busiestDay.orderCount}">
                                                    <c:set var="busiestDay" value="${day}" />
                                                </c:if>
                                            </c:forEach>
                                            <div class="value">${busiestDay.timeSlot}</div>
                                            <div class="text-muted">${busiestDay.orderCount} orders</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="value">No data</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <!-- Top Products -->
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Top Selling Products</h5>
                                    </div>
                                    <div class="card-body">
                                        <ul class="nav nav-tabs" id="productTabs" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" id="weekly-tab" data-toggle="tab" href="#weekly" role="tab">This Week</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="monthly-tab" data-toggle="tab" href="#monthly" role="tab">This Month</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content" id="productTabsContent">
                                            <div class="tab-pane fade show active" id="weekly" role="tabpanel">
                                                <div class="chart-container">
                                                    <canvas id="weeklyProductsChart"></canvas>
                                                </div>
                                                <div class="table-responsive">
                                                    <table class="table table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>Product</th>
                                                                <th>Units Sold</th>
                                                                <th>Revenue</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="product" items="${topWeeklyProducts}">
                                                                <tr>
                                                                    <td>${product.productName}</td>
                                                                    <td>${product.salesCount}</td>
                                                                    <td><fmt:formatNumber value="${product.totalRevenue}" type="currency"/></td>
                                                                </tr>
                                                            </c:forEach>
                                                            <c:if test="${empty topWeeklyProducts}">
                                                                <tr>
                                                                    <td colspan="3" class="text-center">No data available</td>
                                                                </tr>
                                                            </c:if>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="monthly" role="tabpanel">
                                                <div class="chart-container">
                                                    <canvas id="monthlyProductsChart"></canvas>
                                                </div>
                                                <div class="table-responsive">
                                                    <table class="table table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>Product</th>
                                                                <th>Units Sold</th>
                                                                <th>Revenue</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="product" items="${topMonthlyProducts}">
                                                                <tr>
                                                                    <td>${product.productName}</td>
                                                                    <td>${product.salesCount}</td>
                                                                    <td><fmt:formatNumber value="${product.totalRevenue}" type="currency"/></td>
                                                                </tr>
                                                            </c:forEach>
                                                            <c:if test="${empty topMonthlyProducts}">
                                                                <tr>
                                                                    <td colspan="3" class="text-center">No data available</td>
                                                                </tr>
                                                            </c:if>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Time Analysis -->
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Order Time Analysis</h5>
                                    </div>
                                    <div class="card-body">
                                        <ul class="nav nav-tabs" id="timeTabs" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" id="daily-tab" data-toggle="tab" href="#daily" role="tab">By Day</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content" id="timeTabsContent">
                                            <div class="tab-pane fade show active" id="daily" role="tabpanel">
                                                <div class="chart-container">
                                                    <canvas id="dailyChart"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <!-- Trending Products -->
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Trending Products</h5>
                                    </div>
                                    <div class="card-body">
                                        <c:forEach var="product" items="${trendingProducts}">
                                            <div class="trending-product">
                                                <div class="product-name">${product.productName}</div>
                                                <div class="growth ${product.totalRevenue >= 0 ? 'growth-positive' : 'growth-negative'}">
                                                    <i class="fas ${product.totalRevenue >= 0 ? 'fa-arrow-up' : 'fa-arrow-down'}"></i>
                                                    <fmt:formatNumber value="${product.totalRevenue}" type="number" maxFractionDigits="1"/>%
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${empty trendingProducts}">
                                            <div class="text-center">No trending products data available</div>
                                        </c:if>
                                        <div class="text-center mt-3">
                                            <a href="${pageContext.request.contextPath}/statistics?action=trends" class="btn btn-outline-primary btn-sm">
                                                View All Trends
                                            </a>
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
            
            // Weekly Products Chart
            const weeklyProductsCtx = document.getElementById('weeklyProductsChart').getContext('2d');
            const weeklyProductsChart = new Chart(weeklyProductsCtx, {
                type: 'bar',
                data: {
                    labels: [
                        <c:forEach var="product" items="${topWeeklyProducts}" varStatus="status">
                            '${product.productName}'${!status.last ? ',' : ''}
                        </c:forEach>
                    ],
                    datasets: [{
                        label: 'Units Sold',
                        data: [
                            <c:forEach var="product" items="${topWeeklyProducts}" varStatus="status">
                                ${product.salesCount}${!status.last ? ',' : ''}
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
            
            // Monthly Products Chart
            const monthlyProductsCtx = document.getElementById('monthlyProductsChart').getContext('2d');
            const monthlyProductsChart = new Chart(monthlyProductsCtx, {
                type: 'bar',
                data: {
                    labels: [
                        <c:forEach var="product" items="${topMonthlyProducts}" varStatus="status">
                            '${product.productName}'${!status.last ? ',' : ''}
                        </c:forEach>
                    ],
                    datasets: [{
                        label: 'Units Sold',
                        data: [
                            <c:forEach var="product" items="${topMonthlyProducts}" varStatus="status">
                                ${product.salesCount}${!status.last ? ',' : ''}
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
                        label: 'Orders',
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
        </script>
    </body>
</html> 