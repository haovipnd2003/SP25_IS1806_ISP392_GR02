<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sản Phẩm Xu Hướng</title>

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

            .trend-up {
                color: #28a745;
            }

            .trend-down {
                color: #dc3545;
            }

            .trend-card {
                background-color: #fff;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
                border-left: 4px solid #007bff;
            }

            .trend-card:hover {
                transform: translateY(-5px);
            }

            .trend-card .product-name {
                font-weight: 600;
                font-size: 18px;
                margin-bottom: 10px;
            }

            .trend-card .sales-count {
                font-size: 16px;
                color: #6c757d;
            }

            .trend-card .growth {
                font-weight: 600;
                font-size: 16px;
                margin-top: 10px;
            }

            .trend-card .growth-positive {
                color: #28a745;
            }

            .trend-card .growth-negative {
                color: #dc3545;
            }
        </style>
    </head>
    <body>
        <div id="app">
            <div class="main-wrapper">
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
                <div class="main-content">
                    <section class="section">
                        <h1 class="section-header">
                            <div>Sản Phẩm Xu Hướng</div>
                            <button id="sidebarToggle" class="btn btn-primary d-md-none">
                                <i class="fa fa-bars"></i>
                            </button>
                        </h1>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h5>Sản Phẩm Xu Hướng Tuần Này</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="alert alert-info">
                                            <i class="fa fa-info-circle"></i> Phân tích này hiển thị các sản phẩm có sự tăng trưởng đáng kể về doanh số (đo bằng ${unit}) so với tuần trước. Sử dụng thông tin này để xác định xu hướng mới nổi và điều chỉnh hàng tồn kho của bạn phù hợp.
                                        </div>

                                        <div class="chart-container">
                                            <canvas id="trendingChart"></canvas>
                                        </div>

                                        <div class="row">
                                            <c:forEach var="product" items="${trendingProducts}">
                                                <div class="col-md-6">
                                                    <div class="trend-card">
                                                        <div class="product-name">${product.productName}</div>
                                                        <div class="sales-count">
                                                            <i class="fa fa-shopping-cart"></i> ${product.salesCount} ${unit} đã bán tuần này
                                                        </div>
                                                        <div class="growth ${product.totalRevenue >= 0 ? 'growth-positive' : 'growth-negative'}">
                                                            <c:if test="${product.totalRevenue >= 0}">
                                                                <i class="fa fa-arrow-up"></i>
                                                            </c:if>
                                                            <c:if test="${product.totalRevenue < 0}">
                                                                <i class="fa fa-arrow-down"></i>
                                                            </c:if>
                                                            <fmt:formatNumber value="${Math.abs(product.totalRevenue)}" type="number" maxFractionDigits="1"/>% 
                                                            <c:if test="${product.totalRevenue >= 0}">tăng trưởng</c:if>
                                                            <c:if test="${product.totalRevenue < 0}">giảm</c:if>
                                                                so với tuần trước
                                                            </div>
                                                        </div>
                                                    </div>
                                            </c:forEach>
                                            <c:if test="${empty trendingProducts}">
                                                <div class="col-md-12">
                                                    <div class="text-center p-5">
                                                        <i class="fa fa-chart-line fa-3x text-muted mb-3"></i>
                                                        <p>Chưa có dữ liệu xu hướng. Điều này có thể là do chưa có đủ đơn hàng để thiết lập xu hướng.</p>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>

                                        <div class="table-responsive mt-4">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Sản Phẩm</th>
                                                        <th>Số Lượng (${unit})</th>
                                                        <th>Tỷ Lệ Tăng Trưởng</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="product" items="${trendingProducts}" varStatus="status">
                                                        <tr>
                                                            <td>${status.index + 1}</td>
                                                            <td>${product.productName}</td>
                                                            <td>${product.salesCount}</td>
                                                            <td class="${product.totalRevenue >= 0 ? 'trend-up' : 'trend-down'}">
                                                                <c:if test="${product.totalRevenue >= 0}">
                                                                    <i class="fa fa-arrow-up"></i>
                                                                </c:if>
                                                                <c:if test="${product.totalRevenue < 0}">
                                                                    <i class="fa fa-arrow-down"></i>
                                                                </c:if>
                                                                <fmt:formatNumber value="${Math.abs(product.totalRevenue)}" type="number" maxFractionDigits="1"/>%
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty trendingProducts}">
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
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h5>Đề Xuất Hàng Tồn Kho</h5>
                            </div>
                            <div class="card-body">
                                <div class="alert alert-success">
                                    <h6><i class="fa fa-lightbulb"></i> Dựa trên sản phẩm xu hướng, chúng tôi đề xuất:</h6>
                                    <ul>
                                        <c:if test="${not empty trendingProducts}">
                                            <c:forEach var="product" items="${trendingProducts}" begin="0" end="2">
                                                <c:if test="${product.totalRevenue > 20}">
                                                    <li>Tăng hàng tồn kho cho <strong>${product.productName}</strong> (tăng trưởng ${product.totalRevenue}%) - Doanh số hiện tại: ${product.salesCount} ${unit}</li>
                                                    </c:if>
                                                </c:forEach>
                                                <c:forEach var="product" items="${trendingProducts}">
                                                    <c:if test="${product.totalRevenue < -20}">
                                                    <li>Cân nhắc giảm hàng tồn kho cho <strong>${product.productName}</strong> (giảm ${Math.abs(product.totalRevenue)}%) - Doanh số hiện tại: ${product.salesCount} ${unit}</li>
                                                    </c:if>
                                                </c:forEach>
                                            <li>Theo dõi các xu hướng này hàng tuần để điều chỉnh mức hàng tồn kho</li>
                                            </c:if>
                                            <c:if test="${empty trendingProducts}">
                                            <li>Bắt đầu theo dõi doanh số bán hàng một cách nhất quán để xây dựng dữ liệu xu hướng</li>
                                            <li>Duy trì mức hàng tồn kho cân đối trên các danh mục sản phẩm</li>
                                            <li>Xem xét các yếu tố theo mùa khi lập kế hoạch hàng tồn kho</li>
                                            </c:if>
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
        // Trending Chart
        const trendingCtx = document.getElementById('trendingChart').getContext('2d');
        const trendingChart = new Chart(trendingCtx, {
        type: 'bar',
                data: {
                labels: [
        <c:forEach var="product" items="${trendingProducts}" varStatus="status">
                '${product.productName}'${!status.last ? ',' : ''}
        </c:forEach>
                ],
                        datasets: [{
                        label: 'Tỷ Lệ Tăng Trưởng (%)',
                                data: [
        <c:forEach var="product" items="${trendingProducts}" varStatus="status">
            ${product.totalRevenue}${!status.last ? ',' : ''}
        </c:forEach>
                                ],
                                backgroundColor: [
        <c:forEach var="product" items="${trendingProducts}" varStatus="status">
                                '${product.totalRevenue >= 0 ? "rgba(40, 167, 69, 0.6)" : "rgba(220, 53, 69, 0.6)"}'${!status.last ? ',' : ''}
        </c:forEach>
                                ],
                                borderColor: [
        <c:forEach var="product" items="${trendingProducts}" varStatus="status">
                                '${product.totalRevenue >= 0 ? "rgba(40, 167, 69, 1)" : "rgba(220, 53, 69, 1)"}'${!status.last ? ',' : ''}
        </c:forEach>
                                ],
                                borderWidth: 1
                        }]
                },
                options: {
                responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                        y: {
                        beginAtZero: true,
                                title: {
                                display: true,
                                        text: 'Tỷ Lệ Tăng Trưởng (%)'
                                }
                        },
                                x: {
                                title: {
                                display: true,
                                        text: 'Sản Phẩm'
                                }
                                }
                        },
                        plugins: {
                        title: {
                        display: true,
                                text: 'Tỷ Lệ Tăng Trưởng Hàng Tuần Theo Sản Phẩm',
                                font: {
                                size: 16
                                }
                        }
                        }
                }
        });
    </script>
</body>
</html> 