<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.Revenue" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    List<Revenue> revenueByDate = (List<Revenue>) request.getAttribute("revenueByDate");
    List<Revenue> revenueByWeek = (List<Revenue>) request.getAttribute("revenueByWeek");
    List<Revenue> revenueByMonth = (List<Revenue>) request.getAttribute("revenueByMonth");

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    String currentDate = dateFormat.format(new Date());

    SimpleDateFormat monthFormat = new SimpleDateFormat("MMMM");
    String currentMonth = monthFormat.format(new Date());

    NumberFormat numberFormat = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
    numberFormat.setMinimumFractionDigits(1);
    numberFormat.setMaximumFractionDigits(1);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Revenue Statistics</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <style>
            .stats-tab {
                cursor: pointer;
                padding: 10px 20px;
                margin-right: 5px;
                background-color: #f1f1f1;
                border-radius: 5px 5px 0 0;
                border: 1px solid #ddd;
                border-bottom: none;
            }
            .stats-tab.active {
                background-color: #3498db;
                color: white;
                font-weight: bold;
            }
            .stats-content {
                display: none;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 0 5px 5px 5px;
                margin-bottom: 20px;
            }
            .stats-content.active {
                display: block;
            }
            .revenue-summary {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .summary-item {
                text-align: center;
                background-color: #f9f9f9;
                border-radius: 5px;
                padding: 15px;
                width: 30%;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            .summary-item .icon {
                font-size: 24px;
                margin-bottom: 10px;
            }
            .summary-item .value {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 5px;
            }
            .summary-item .label {
                color: #666;
            }
            .chart-container {
                margin-top: 20px;
                border-radius: 5px;
                background-color: white;
                padding: 15px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
        </style>
    </head>
    <body>
        <div id="app">
            <div class="main-wrapper">
                <jsp:include page="/view/common/nav_bar.jsp"></jsp:include>
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                <div class="main-content" style="min-height: 600px;">
                    <section class="section">
                        <div class="section-body">
                            <div class="row">
                                <div class="col-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h2><a href="revenuestatistics" style="text-decoration: none; color: inherit;">Revenue Statistics</a></h2>
                                        </div>
                                        <div class="card-body">
                                            <!-- Navigation Tabs -->
                                            <div class="d-flex mb-3">
                                                <div id="tabDay" class="stats-tab active" onclick="switchTab('day')">Theo ngày</div>
                                                <div id="tabWeek" class="stats-tab" onclick="switchTab('week')">Theo tuần</div>
                                                <div id="tabMonth" class="stats-tab" onclick="switchTab('month')">Theo tháng</div>
                                            </div>

                                            <!-- Daily Statistics -->
                                            <div id="contentDay" class="stats-content active">
                                                <div class="revenue-summary">
                                                    <div class="summary-item">
                                                        <div class="icon text-primary"><i class="fas fa-calendar-day"></i></div>
                                                        <div class="value"><%= currentDate %></div>
                                                        <div class="label">Ngày hiện tại</div>
                                                    </div>
                                                    <div class="summary-item">
                                                        <div class="icon text-success">VND</div>
                                                        <div class="value">
                                                            <%= numberFormat.format(request.getAttribute("todayRevenue") != null ? (Double)request.getAttribute("todayRevenue") : 0) %>
                                                        </div>
                                                        <div class="label">Doanh Thu hôm nay</div>
                                                    </div>
                                                    <div class="summary-item">
                                                        <div class="icon text-warning"><i class="fas fa-chart-line"></i></div>
                                                        <div class="value"><%= String.format("%.2f", request.getAttribute("dailyGrowth") != null ? (Double)request.getAttribute("dailyGrowth") : 0) %>%</div>
                                                        <div class="label">So với ngày trước</div>
                                                    </div>
                                                </div>
                                                <div class="chart-container">
                                                    <canvas id="chartByDate"></canvas>
                                                </div>
                                            </div>

                                            <!-- Weekly Statistics -->
                                            <div id="contentWeek" class="stats-content">
                                                <div class="revenue-summary">
                                                    <div class="summary-item">
                                                        <div class="icon text-primary"><i class="fas fa-calendar-week"></i></div>
                                                        <div class="value">
                                                            <% java.util.Calendar calWeek = java.util.Calendar.getInstance(); %>
                                                            <%= calWeek.get(java.util.Calendar.WEEK_OF_YEAR) %>
                                                        </div>
                                                        <div class="label">Tuần hiện tại</div>
                                                    </div>
                                                    <div class="summary-item">
                                                        <div class="icon text-success">VND</div>
                                                        <div class="value">
                                                            <% if (revenueByWeek != null && !revenueByWeek.isEmpty()) { %>
                                                                <%= numberFormat.format(revenueByWeek.get(revenueByWeek.size() - 1).getRevenue()) %>
                                                            <% } else { %>
                                                                <%= numberFormat.format(0) %>
                                                            <% } %>
                                                        </div>
                                                        <div class="label">Doanh Thu tuần này</div>
                                                    </div>
                                                    <div class="summary-item">
                                                        <div class="icon text-warning"><i class="fas fa-chart-line"></i></div>
                                                        <div class="value"><%= String.format("%.2f", request.getAttribute("weeklyGrowth") != null ? (Double)request.getAttribute("weeklyGrowth") : 0) %>%</div>
                                                        <div class="label">So với tuần trước</div>
                                                    </div>
                                                </div>
                                                <div class="chart-container">
                                                    <canvas id="chartByWeek"></canvas>
                                                </div>
                                            </div>

                                            <!-- Monthly Statistics -->
                                            <div id="contentMonth" class="stats-content">
                                                <div class="revenue-summary">
                                                    <div class="summary-item">
                                                        <div class="icon text-primary"><i class="fas fa-calendar-alt"></i></div>
                                                        <div class="value">
                                                            <% java.util.Calendar calMonth = java.util.Calendar.getInstance(); %>
                                                            <%= new SimpleDateFormat("MM/yyyy").format(calMonth.getTime()) %>
                                                        </div>
                                                        <div class="label">Tháng hiện tại</div>
                                                    </div>
                                                    <div class="summary-item">
                                                        <div class="icon text-success">VND</div>
                                                        <div class="value">
                                                            <% if (revenueByMonth != null && !revenueByMonth.isEmpty()) { %>
                                                                <%= numberFormat.format(revenueByMonth.get(revenueByMonth.size() - 1).getRevenue()) %>
                                                            <% } else { %>
                                                                <%= numberFormat.format(0) %>
                                                            <% } %>
                                                        </div>
                                                        <div class="label">Doanh Thu tháng này</div>
                                                    </div>
                                                    <div class="summary-item">
                                                        <div class="icon text-warning"><i class="fas fa-chart-line"></i></div>
                                                        <div class="value"><%= String.format("%.2f", request.getAttribute("monthlyGrowth") != null ? (Double)request.getAttribute("monthlyGrowth") : 0) %>%</div>
                                                        <div class="label">So với tháng trước</div>
                                                    </div>
                                                </div>
                                                <div class="chart-container">
                                                    <canvas id="chartByMonth"></canvas>
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
        </div>
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
        <script>
            <c:if test="${not empty succMess}">
                toastr.success('${succMess}');
            </c:if>
            <% session.removeAttribute("succMess"); %>
        </script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            // Doanh thu theo ngày
            const labelsByDate = [
                <% for (Revenue r : revenueByDate) { %>
                    "<%= r.getDate() %>",
                <% } %>
            ];
            const dataByDate = [
                <% for (Revenue r : revenueByDate) { %>
                    <%= r.getRevenue() %>,
                <% } %>
            ];

            // Doanh thu theo tuần
            const labelsByWeek = [
                <% for (Revenue r : revenueByWeek) { %>
                    "Tuần <%= r.getDate() %>",
                <% } %>
            ];
            const dataByWeek = [
                <% for (Revenue r : revenueByWeek) { %>
                    <%= r.getRevenue() %>,
                <% } %>
            ];

            // Doanh thu theo tháng
            const labelsByMonth = [
                <% for (Revenue r : revenueByMonth) { %>
                    "T <%= r.getDate() %>",
                <% } %>
            ];
            const dataByMonth = [
                <% for (Revenue r : revenueByMonth) { %>
                    <%= r.getRevenue() %>,
                <% } %>
            ];

            // Hàm vẽ biểu đồ cột
            function drawChart(canvasId, labels, data, labelText) {
                console.log("Drawing chart with labels:", labels);
                console.log("Drawing chart with data:", data);
                return new Chart(document.getElementById(canvasId), {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: labelText,
                            data: data,
                            backgroundColor: 'rgba(54, 162, 235, 0.5)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            title: {
                                display: true,
                                text: labelText,
                                font: { size: 16 }
                            },
                            legend: { display: false },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return context.raw !== undefined 
                                            ? context.raw.toLocaleString('vi-VN') 
                                            : 'Không có dữ liệu';
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: { color: 'rgba(0, 0, 0, 0.05)' },
                                ticks: {
                                    callback: function(value) {
                                        return value.toLocaleString('vi-VN');
                                    }
                                }
                            },
                            x: {
                                grid: { display: false },
                                ticks: { autoSkip: false }
                            }
                        }
                    }
                });
            }

            // Tab switching function
            function switchTab(tab) {
                document.querySelectorAll('.stats-content').forEach(item => item.classList.remove('active'));
                document.querySelectorAll('.stats-tab').forEach(item => item.classList.remove('active'));
                document.getElementById('tab' + tab.charAt(0).toUpperCase() + tab.slice(1)).classList.add('active');
                document.getElementById('content' + tab.charAt(0).toUpperCase() + tab.slice(1)).classList.add('active');
            }

            // Vẽ biểu đồ khi DOM loaded
            document.addEventListener('DOMContentLoaded', function() {
                drawChart("chartByDate", labelsByDate, dataByDate, "Doanh thu theo ngày");
                drawChart("chartByWeek", labelsByWeek, dataByWeek, "Doanh thu theo tuần");
                drawChart("chartByMonth", labelsByMonth, dataByMonth, "Doanh thu theo tháng");
            });
        </script>
    </body>
</html>