<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Top Products Analysis</title>

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
        </style>
    </head>
    <body>
        <div id="app">
            <div class="main-wrapper">

                <div class="main-content">
                    <section class="section">
                        <h1 class="section-header">
                            <div>Top Products Analysis</div>
                            <button id="sidebarToggle" class="btn btn-primary d-md-none">
                                <i class="fa fa-bars"></i>
                            </button>
                        </h1>

                        <div class="row">
                            <div class="col-md-12">
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
                                                                <th>#</th>
                                                                <th>Product</th>
                                                                <th>Units Sold</th>
                                                                <th>Revenue</th>
                                                                <th>% of Total Sales</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:set var="totalWeeklySales" value="0" />
                                                            <c:forEach var="product" items="${topWeeklyProducts}">
                                                                <c:set var="totalWeeklySales" value="${totalWeeklySales + product.salesCount}" />
                                                            </c:forEach>
                                                            
                                                            <c:forEach var="product" items="${topWeeklyProducts}" varStatus="status">
                                                                <tr>
                                                                    <td>${status.index + 1}</td>
                                                                    <td>${product.productName}</td>
                                                                    <td>${product.salesCount}</td>
                                                                    <td><fmt:formatNumber value="${product.totalRevenue}" type="currency"/></td>
                                                                    <td>
                                                                        <c:if test="${totalWeeklySales > 0}">
                                                                            <fmt:formatNumber value="${(product.salesCount / totalWeeklySales) * 100}" type="number" maxFractionDigits="1"/>%
                                                                        </c:if>
                                                                        <c:if test="${totalWeeklySales == 0}">
                                                                            0%
                                                                        </c:if>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                            <c:if test="${empty topWeeklyProducts}">
                                                                <tr>
                                                                    <td colspan="5" class="text-center">No data available</td>
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
                                                                <th>#</th>
                                                                <th>Product</th>
                                                                <th>Units Sold</th>
                                                                <th>Revenue</th>
                                                                <th>% of Total Sales</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:set var="totalMonthlySales" value="0" />
                                                            <c:forEach var="product" items="${topMonthlyProducts}">
                                                                <c:set var="totalMonthlySales" value="${totalMonthlySales + product.salesCount}" />
                                                            </c:forEach>
                                                            
                                                            <c:forEach var="product" items="${topMonthlyProducts}" varStatus="status">
                                                                <tr>
                                                                    <td>${status.index + 1}</td>
                                                                    <td>${product.productName}</td>
                                                                    <td>${product.salesCount}</td>
                                                                    <td><fmt:formatNumber value="${product.totalRevenue}" type="currency"/></td>
                                                                    <td>
                                                                        <c:if test="${totalMonthlySales > 0}">
                                                                            <fmt:formatNumber value="${(product.salesCount / totalMonthlySales) * 100}" type="number" maxFractionDigits="1"/>%
                                                                        </c:if>
                                                                        <c:if test="${totalMonthlySales == 0}">
                                                                            0%
                                                                        </c:if>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                            <c:if test="${empty topMonthlyProducts}">
                                                                <tr>
                                                                    <td colspan="5" class="text-center">No data available</td>
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
                        </div>
                        
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Sales Distribution</h5>
                                    </div>
                                    <div class="card-body">
                                        <ul class="nav nav-tabs" id="distributionTabs" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" id="weekly-dist-tab" data-toggle="tab" href="#weekly-dist" role="tab">This Week</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="monthly-dist-tab" data-toggle="tab" href="#monthly-dist" role="tab">This Month</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content" id="distributionTabsContent">
                                            <div class="tab-pane fade show active" id="weekly-dist" role="tabpanel">
                                                <div class="chart-container">
                                                    <canvas id="weeklyDistributionChart"></canvas>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="monthly-dist" role="tabpanel">
                                                <div class="chart-container">
                                                    <canvas id="monthlyDistributionChart"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Custom Date Range Analysis</h5>
                                    </div>
                                    <div class="card-body">
                                        <form action="${pageContext.request.contextPath}/statistics" method="post" class="row g-3">
                                            <input type="hidden" name="action" value="custom-date-range">
                                            <div class="col-md-4">
                                                <label for="startDate" class="form-label">Start Date</label>
                                                <input type="date" class="form-control" id="startDate" name="startDate" required>
                                            </div>
                                            <div class="col-md-4">
                                                <label for="endDate" class="form-label">End Date</label>
                                                <input type="date" class="form-control" id="endDate" name="endDate" required>
                                            </div>
                                            <div class="col-md-4 d-flex align-items-end">
                                                <button type="submit" class="btn btn-primary">Analyze</button>
                                            </div>
                                        </form>
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
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: 'Top Products This Week',
                            font: {
                                size: 16
                            }
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
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: 'Top Products This Month',
                            font: {
                                size: 16
                            }
                        }
                    }
                }
            });
            
            // Weekly Distribution Chart
            const weeklyDistributionCtx = document.getElementById('weeklyDistributionChart').getContext('2d');
            const weeklyDistributionChart = new Chart(weeklyDistributionCtx, {
                type: 'pie',
                data: {
                    labels: [
                        <c:forEach var="product" items="${topWeeklyProducts}" varStatus="status">
                            '${product.productName}'${!status.last ? ',' : ''}
                        </c:forEach>
                    ],
                    datasets: [{
                        data: [
                            <c:forEach var="product" items="${topWeeklyProducts}" varStatus="status">
                                ${product.salesCount}${!status.last ? ',' : ''}
                            </c:forEach>
                        ],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.6)',
                            'rgba(54, 162, 235, 0.6)',
                            'rgba(255, 206, 86, 0.6)',
                            'rgba(75, 192, 192, 0.6)',
                            'rgba(153, 102, 255, 0.6)',
                            'rgba(255, 159, 64, 0.6)',
                            'rgba(199, 199, 199, 0.6)',
                            'rgba(83, 102, 255, 0.6)',
                            'rgba(40, 159, 64, 0.6)',
                            'rgba(210, 199, 199, 0.6)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)',
                            'rgba(199, 199, 199, 1)',
                            'rgba(83, 102, 255, 1)',
                            'rgba(40, 159, 64, 1)',
                            'rgba(210, 199, 199, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Weekly Sales Distribution',
                            font: {
                                size: 16
                            }
                        },
                        legend: {
                            position: 'right'
                        }
                    }
                }
            });
            
            // Monthly Distribution Chart
            const monthlyDistributionCtx = document.getElementById('monthlyDistributionChart').getContext('2d');
            const monthlyDistributionChart = new Chart(monthlyDistributionCtx, {
                type: 'pie',
                data: {
                    labels: [
                        <c:forEach var="product" items="${topMonthlyProducts}" varStatus="status">
                            '${product.productName}'${!status.last ? ',' : ''}
                        </c:forEach>
                    ],
                    datasets: [{
                        data: [
                            <c:forEach var="product" items="${topMonthlyProducts}" varStatus="status">
                                ${product.salesCount}${!status.last ? ',' : ''}
                            </c:forEach>
                        ],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.6)',
                            'rgba(54, 162, 235, 0.6)',
                            'rgba(255, 206, 86, 0.6)',
                            'rgba(75, 192, 192, 0.6)',
                            'rgba(153, 102, 255, 0.6)',
                            'rgba(255, 159, 64, 0.6)',
                            'rgba(199, 199, 199, 0.6)',
                            'rgba(83, 102, 255, 0.6)',
                            'rgba(40, 159, 64, 0.6)',
                            'rgba(210, 199, 199, 0.6)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)',
                            'rgba(199, 199, 199, 1)',
                            'rgba(83, 102, 255, 1)',
                            'rgba(40, 159, 64, 1)',
                            'rgba(210, 199, 199, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Monthly Sales Distribution',
                            font: {
                                size: 16
                            }
                        },
                        legend: {
                            position: 'right'
                        }
                    }
                }
            });
        </script>
    </body>
</html> 