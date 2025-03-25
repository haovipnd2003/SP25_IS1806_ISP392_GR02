<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kiểm Kho Sản Phẩm: ${product.name}</title>

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
            
            .product-info {
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            
            .product-name {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 5px;
            }
            
            .product-id {
                font-size: 16px;
                color: #666;
                margin-bottom: 10px;
            }
            
            .total-quantity {
                font-size: 18px;
                color: #007bff;
                font-weight: bold;
                margin-bottom: 10px;
            }
            
            .audit-form {
                margin-top: 20px;
            }
            
            .quantity-input {
                width: 100px;
            }
            
            .note-input {
                width: 200px;
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
            
            .zone-badge {
                display: inline-block;
                background-color: #e9ecef;
                padding: 5px 10px;
                border-radius: 15px;
                margin-right: 5px;
                margin-bottom: 5px;
                font-size: 14px;
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
                            <h1>Kiểm Kho Sản Phẩm</h1>
                            <a href="stock-audit?action=form" class="btn btn-primary">
                                <i class="fas fa-arrow-left"></i> Quay Lại
                            </a>
                        </div>

                        <div class="section-body">
                            <div class="product-info">
                                <div class="product-name">${product.name}</div>
                                <div class="product-id">Mã sản phẩm: ${product.id}</div>
                                <div class="total-quantity">Tổng số lượng: ${product.quantity}</div>
                                <div class="mt-2">
                                    <strong>Khu vực hiện có:</strong>
                                    <div class="mt-1">
                                        <c:forEach var="zone" items="${zones}">
                                            <span class="zone-badge">${zone.name}</span>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card">
                                <div class="card-header">
                                    <h4>Kiểm Kho Sản Phẩm</h4>
                                </div>
                                <div class="card-body">
                                    <form action="stock-audit" method="post" id="auditForm" class="audit-form">
                                        <input type="hidden" name="action" value="submit-audit">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th width="30%">Sản Phẩm</th>
                                                        <th width="20%">Số Lượng Hệ Thống</th>
                                                        <th width="20%">Số Lượng Thực Tế</th>
                                                        <th width="15%">Chênh Lệch</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>${product.name}</td>
                                                        <td>
                                                            ${product.quantity}
                                                            <input type="hidden" name="expectedQuantity" value="${product.quantity}" class="expected-quantity">
                                                        </td>
                                                        <td>
                                                            <input type="number" name="actualQuantity" class="form-control actual-quantity" step="0.01" min="0" required>
                                                        </td>
                                                        <td>
                                                            <span class="difference">0.00</span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        
                                        <div class="form-group mt-4">
                                            <label for="note">Ghi Chú:</label>
                                            <textarea name="note" id="note" class="form-control" rows="3" placeholder="Nhập ghi chú kiểm kho (nếu có)"></textarea>
                                        </div>
                                        
                                        <div class="form-group mt-4 text-center">
                                            <button type="submit" class="btn btn-primary btn-lg">
                                                <i class="fas fa-save"></i> Lưu Kiểm Kho
                                            </button>
                                        </div>
                                    </form>
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
            
            // Calculate difference when actual quantity changes
            document.querySelectorAll('.actual-quantity').forEach(function(input) {
                input.addEventListener('input', function() {
                    const row = this.closest('tr');
                    const expectedQuantity = parseFloat(row.querySelector('.expected-quantity').value);
                    const actualQuantity = parseFloat(this.value) || 0;
                    const difference = actualQuantity - expectedQuantity;
                    const differenceElement = row.querySelector('.difference');
                    
                    differenceElement.textContent = difference.toFixed(2);
                    
                    // Add color based on difference
                    differenceElement.className = 'difference';
                    if (difference > 0) {
                        differenceElement.classList.add('difference-positive');
                    } else if (difference < 0) {
                        differenceElement.classList.add('difference-negative');
                    } else {
                        differenceElement.classList.add('difference-zero');
                    }
                });
            });
            
            // Form validation
            document.getElementById('auditForm').addEventListener('submit', function(event) {
                const actualQuantities = document.querySelectorAll('.actual-quantity');
                let valid = true;
                
                actualQuantities.forEach(function(input) {
                    if (input.value === '' || isNaN(parseFloat(input.value))) {
                        valid = false;
                    }
                });
                
                if (!valid) {
                    event.preventDefault();
                    iziToast.error({
                        title: 'Lỗi',
                        message: 'Vui lòng nhập số lượng thực tế',
                        position: 'topRight',
                        timeout: 5000
                    });
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