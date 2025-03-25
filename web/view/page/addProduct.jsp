<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
    <head>
        <title>Add Product</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .main-content {
                margin-left: 250px;
                padding: 2rem;
                transition: margin-left 0.3s ease;
            }
            .card {
                border: none;
                border-radius: 0.75rem;
                box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.1);
                margin-bottom: 2rem;
            }
            .card-header {
                padding: 1.5rem;
                border-radius: 0.75rem 0.75rem 0 0;
                border-bottom: none;
            }
            .card-body {
                padding: 2rem;
            }
            .form-group {
                margin-bottom: 1.75rem;
            }
            .form-label {
                font-weight: 600;
                margin-bottom: 0.5rem;
                color: #495057;
            }
            .form-control, .form-select {
                padding: 0.75rem 1rem;
                border-radius: 0.5rem;
                border: 1px solid #ced4da;
                transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            }
            .form-control:focus, .form-select:focus {
                border-color: #80bdff;
                box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
            }
            .btn-primary {
                padding: 0.75rem 2rem;
                font-size: 1rem;
                font-weight: 600;
                border-radius: 0.5rem;
                background-color: #0d6efd;
                border-color: #0d6efd;
                transition: all 0.2s ease;
            }
            .btn-primary:hover {
                background-color: #0b5ed7;
                border-color: #0a58ca;
                transform: translateY(-2px);
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }
            .text-danger {
                font-size: 0.875rem;
                margin-top: 0.25rem;
            }
            .zone-checkbox-container {
                max-height: 150px;
                overflow-y: auto;
                border: 1px solid #ced4da;
                border-radius: 0.5rem;
                padding: 0.75rem;
                margin-bottom: 0.5rem;
            }
            .form-check {
                margin-bottom: 0.5rem;
            }
            .form-text {
                font-size: 0.875rem;
            }
            #sidebarToggle {
                margin-bottom: 1.5rem;
                border-radius: 0.5rem;
                padding: 0.5rem 1rem;
            }
            .section-title {
                margin-bottom: 1.5rem;
                color: #212529;
                font-weight: 700;
            }
        </style>
    </head>
    <body>
        <div id="app">
            <div class="main-wrapper">
                <!-- Sidebar -->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>

                <!-- Main Content -->
                <div class="main-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <button id="sidebarToggle" class="btn btn-light">
                            <i class="fas fa-bars"></i>
                        </button>
                        <h2 class="section-title mb-0">Product Management</h2>
                    </div>

                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h3 class="card-title mb-0">Add New Product</h3>
                        </div>
                        <div class="card-body">
                            <form action="products" method="post" onsubmit="return validateForm()">
                                <input type="hidden" name="action" value="insert">

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="name" class="form-label">Product Name <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control ${not empty nameError ? 'is-invalid' : ''}" 
                                                   id="name" name="name" value="${not empty param.name ? param.name : productName}" required>
                                            <c:if test="${not empty nameError}">
                                                <div class="invalid-feedback">${nameError}</div>
                                            </c:if>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="price" class="form-label">Price (VNĐ) <span class="text-danger">*</span></label>
                                            <input type="number" class="form-control ${not empty priceError ? 'is-invalid' : ''}" 
                                                   id="price" name="price" step="1000" min="0" value="${not empty param.price ? param.price : productPrice}" required>
                                            <c:if test="${not empty priceError}">
                                                <div class="invalid-feedback">${priceError}</div>
                                            </c:if>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="quantity" class="form-label">Quantity <span class="text-danger">*</span></label>
                                            <input type="number" class="form-control ${not empty quantityError ? 'is-invalid' : ''}" 
                                                   id="quantity" name="quantity" step="1" min="1" value="${not empty param.quantity ? param.quantity : productQuantity}" required>
                                            <c:if test="${not empty quantityError}">
                                                <div class="invalid-feedback">${quantityError}</div>
                                            </c:if>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="describe" class="form-label">Description</label>
                                            <textarea class="form-control" id="describe" name="describe" 
                                                      rows="4" placeholder="Enter product description">${not empty param.describe ? param.describe : productDescribe}</textarea>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="packaging" class="form-label">Packaging Options</label>
                                            <input type="text" class="form-control" id="packaging" name="packaging" 
                                                   placeholder="e.g., 10kg, 50kg, 100kg" value="${not empty param.packaging ? param.packaging : productPackaging}">
                                            <small class="form-text text-muted">Enter packaging sizes separated by commas</small>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="image" class="form-label">Image URL</label>
                                            <input type="text" class="form-control" id="image" name="image" 
                                                   placeholder="Enter image URL or leave blank for default" value="${param.image}">
                                            <small class="form-text text-muted">Optional: URL to product image</small>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label class="form-label">Zones <span class="text-danger">*</span></label>
                                            <c:if test="${not empty zoneError}">
                                                <div class="text-danger mb-2">${zoneError}</div>
                                            </c:if>
                                            
                                            <div class="d-flex flex-wrap mb-2" id="selectedZonesContainer">
                                                <!-- Các zone đã chọn sẽ hiển thị ở đây dưới dạng badge -->
                                            </div>
                                            
                                            <button type="button" class="btn btn-outline-primary" id="selectZonesBtn">
                                                <i class="fas fa-map-marker-alt me-1"></i> Chọn Zones
                                            </button>
                                            
                                            <!-- Input ẩn để lưu các zone ID đã chọn -->
                                            <div id="zoneIdsContainer">
                                                <!-- Các input hidden chứa zone ID sẽ được thêm vào đây -->
                                            </div>
                                            
                                            <small class="form-text text-muted">Click vào nút để chọn các zone cho sản phẩm.</small>
                                        </div>
                                        
                                        <!-- jQuery added before modal -->
                                        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                                        
                                        <!-- Modal chọn Zone -->
                                        <div class="modal fade" id="zonesModal" tabindex="-1" aria-labelledby="zonesModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-lg">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="zonesModalLabel">Chọn Zones</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="mb-3">
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="zoneSearchInput" placeholder="Tìm kiếm zone...">
                                                                <button class="btn btn-outline-secondary" type="button" id="searchZoneBtn">
                                                                    <i class="fas fa-search"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="mb-3">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox" id="selectAllZones">
                                                                <label class="form-check-label fw-bold" for="selectAllZones">
                                                                    Chọn tất cả zones
                                                                </label>
                                                            </div>
                                                        </div>
                                                        
                                                        <div id="zonesList" class="border rounded p-3" style="max-height: 300px; overflow-y: auto;">
                                                            <div class="text-center py-4">
                                                                <div class="spinner-border text-primary" role="status">
                                                                    <span class="visually-hidden">Loading...</span>
                                                                </div>
                                                                <p class="mt-2">Đang tải danh sách zones...</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="button" class="btn btn-primary" id="applyZoneSelection">Áp dụng</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="isActive" class="form-label">Status <span class="text-danger">*</span></label>
                                            <select class="form-select" id="isActive" name="isActive" required>
                                                <option value="true" ${param.isActive == 'true' ? 'selected' : ''}>Active</option>
                                                <option value="false" ${param.isActive == 'false' ? 'selected' : ''}>Inactive</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-center mt-4">
                                    <a href="products" class="btn btn-secondary me-2">Cancel</a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-plus-circle me-2"></i>Add Product
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Get existing product names from server
            const existingProductNames = [
            <c:forEach var="product" items="${productList}" varStatus="loop">
            "${fn:escapeXml(product.name)}"${!loop.last ? ',' : ''}
            </c:forEach>
            ];

            // Lưu trữ zones đã chọn
            let selectedZones = [];
            
            // Lưu trữ tất cả zones được hiển thị trong modal
            let availableZones = [];
            
            $(document).ready(function() {
                console.log("DOM ready");
                
                // Xử lý sự kiện click cho nút sidebarToggle
                $("#sidebarToggle").on("click", function() {
                    console.log("Sidebar toggle clicked");
                    $(".main-content").toggleClass("expanded");
                    $(".main-sidebar").toggleClass("collapsed");
                });
                
                // Xử lý sự kiện click cho nút chọn zone
                $("#selectZonesBtn").on("click", function() {
                    console.log("Select zones button clicked");
                    loadAvailableZones();
                    $("#zonesModal").modal("show");
                });
                
                // Các xử lý sự kiện khác
                $('#searchZoneBtn').on("click", function() {
                    loadAvailableZones($('#zoneSearchInput').val());
                });
                
                $('#zoneSearchInput').on("keypress", function(e) {
                    if (e.which === 13) {
                        loadAvailableZones($('#zoneSearchInput').val());
                        return false;
                    }
                });
                
                $('#selectAllZones').on("change", function() {
                    const isChecked = $(this).is(':checked');
                    $('.zone-checkbox').prop('checked', isChecked);
                    
                    if (isChecked) {
                        availableZones.forEach(zone => {
                            if (!selectedZones.some(sz => sz.id === zone.id)) {
                                selectedZones.push(zone);
                            }
                        });
                    } else {
                        selectedZones = selectedZones.filter(zone => 
                            !availableZones.some(az => az.id === zone.id)
                        );
                    }
                });
                
                $('#applyZoneSelection').on("click", function() {
                    updateSelectedZonesDisplay();
                    $('#zonesModal').modal('hide');
                });
                
                // Kiểm tra zones đã chọn khi form được tải
                checkSelectedZones();
            });
            
            // Tải danh sách zone khả dụng
            function loadAvailableZones(keyword = '') {
                $('#zonesList').html(
                    '<div class="text-center py-4">' +
                    '<div class="spinner-border text-primary" role="status">' +
                    '<span class="visually-hidden">Loading...</span>' +
                    '</div>' +
                    '<p class="mt-2">Đang tải danh sách zones...</p>' +
                    '</div>'
                );
                
                const productId = $('input[name="id"]').val() || 0;
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/products',
                    method: 'GET',
                    data: {
                        action: 'getAvailableZones',
                        productId: productId,
                        keyword: keyword
                    },
                    dataType: 'json',
                    success: function(data) {
                        availableZones = data;
                        
                        if (data.length === 0) {
                            $('#zonesList').html(
                                '<div class="alert alert-info mb-0">' +
                                'Không tìm thấy zone nào' + (keyword ? ' với từ khóa "' + keyword + '"' : '') +
                                '</div>'
                            );
                            return;
                        }
                        
                        let html = '';
                        
                        data.forEach(zone => {
                            const isChecked = selectedZones.some(sz => sz.id === zone.id);
                            
                            html += 
                                '<div class="form-check mb-2">' +
                                '<input class="form-check-input zone-checkbox" type="checkbox" ' +
                                'id="zone' + zone.id + '" value="' + zone.id + '" ' + (isChecked ? 'checked' : '') +
                                ' onchange="handleZoneCheckboxChange(this, ' + zone.id + ', \'' + 
                                zone.name.replace(/'/g, "\\'") + '\', \'' + 
                                (zone.description ? zone.description.replace(/'/g, "\\'") : '') + '\')">' +
                                '<label class="form-check-label" for="zone' + zone.id + '">' +
                                '<strong>' + zone.name + '</strong>' +
                                (zone.description ? '<br><small class="text-muted">' + zone.description + '</small>' : '') +
                                '</label>' +
                                '</div>';
                        });
                        
                        $('#zonesList').html(html);
                        
                        // Cập nhật trạng thái của checkbox "Chọn tất cả"
                        const allChecked = data.every(zone => selectedZones.some(sz => sz.id === zone.id));
                        $('#selectAllZones').prop('checked', allChecked && data.length > 0);
                    },
                    error: function(xhr, status, error) {
                        $('#zonesList').html(
                            '<div class="alert alert-danger mb-0">' +
                            'Lỗi khi tải danh sách zones: ' + error +
                            '</div>'
                        );
                        console.error('Error loading available zones:', error);
                    }
                });
            }
            
            // Xử lý khi người dùng chọn/bỏ chọn một zone
            function handleZoneCheckboxChange(checkbox, zoneId, zoneName, zoneDescription) {
                if (checkbox.checked) {
                    // Tạo đối tượng zone từ các tham số
                    const zone = {
                        id: zoneId,
                        name: zoneName,
                        description: zoneDescription
                    };
                    
                    // Thêm zone vào danh sách đã chọn nếu chưa có
                    if (!selectedZones.some(sz => sz.id === zoneId)) {
                        selectedZones.push(zone);
                    }
                } else {
                    // Xóa zone khỏi danh sách đã chọn
                    selectedZones = selectedZones.filter(sz => sz.id !== zoneId);
                }
            }
            
            // Cập nhật hiển thị các zone đã chọn
            function updateSelectedZonesDisplay() {
                const container = $('#selectedZonesContainer');
                container.empty();
                
                $('#zoneIdsContainer').empty();
                
                // Thêm các badge và input hidden mới
                selectedZones.forEach(zone => {
                    container.append(
                        '<span class="badge bg-primary me-2 mb-2">' +
                        zone.name +
                        '<i class="fas fa-times ms-1" ' +
                        'onclick="removeZone(' + zone.id + ')" ' +
                        'style="cursor: pointer;"></i>' +
                        '</span>'
                    );
                    
                    // Thêm input hidden
                    $('#zoneIdsContainer').append(
                        '<input type="hidden" name="zoneIds" value="' + zone.id + '">'
                    );
                });
                
                // Hiển thị thông báo nếu không có zone nào được chọn
                if (selectedZones.length === 0) {
                    container.append(
                        '<span class="text-muted">Chưa có zone nào được chọn</span>'
                    );
                }
            }
            
            // Xóa zone khỏi danh sách đã chọn
            function removeZone(zoneId) {
                selectedZones = selectedZones.filter(z => z.id !== zoneId);
                updateSelectedZonesDisplay();
            }
            
            // Kiểm tra zones đã chọn khi form được tải
            function checkSelectedZones() {
                // Nếu là form chỉnh sửa, lấy danh sách zone đã chọn
                const productId = $('input[name="id"]').val();
                if (productId) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/products',
                        method: 'GET',
                        data: {
                            action: 'getProductZones',
                            productId: productId
                        },
                        dataType: 'json',
                        success: function(data) {
                            selectedZones = data;
                            updateSelectedZonesDisplay();
                        },
                        error: function(xhr, status, error) {
                            console.error('Error loading product zones:', error);
                        }
                    });
                }
            }
            
            // Validate form trước khi submit
            function validateForm() {
                // Kiểm tra xem đã chọn zone nào chưa
                if (selectedZones.length === 0) {
                    alert('Vui lòng chọn ít nhất một zone cho sản phẩm');
                    return false;
                }
                
                return true;
            }
        </script>
        
        <!-- Toast notification script -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var toastMessage = "${sessionScope.toastMessage}";
                var toastType = "${sessionScope.toastType}";
                if (toastMessage) {
                    iziToast.show({
                        title: toastType === 'success' ? 'Success' : 'Error',
                        message: toastMessage,
                        position: 'topRight',
                        color: toastType === 'success' ? 'green' : 'red',
                        timeout: 5000
                    });
                    
                    // Clear toast messages from session immediately after showing
                    <% 
                        session.removeAttribute("toastMessage");
                        session.removeAttribute("toastType");
                    %>
                }
            });
        </script>
        
        <!-- Required Scripts -->
        <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/popper.js"></script>
        <script src="${pageContext.request.contextPath}/modules/tooltip.js"></script>
        <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/nicescroll/jquery.nicescroll.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/scroll-up-bar/dist/scroll-up-bar.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sa-functions.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/js/iziToast.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
        <script src="${pageContext.request.contextPath}/js/custom.js"></script>
        <script src="${pageContext.request.contextPath}/js/demo.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>