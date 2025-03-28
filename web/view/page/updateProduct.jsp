<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Cập Nhật Sản Phẩm</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
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
                        <div class="container mt-5">
                            <h2>Cập Nhật Sản Phẩm</h2>
                            <form action="products" method="post" onsubmit="return validateForm()">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${product.id}">
                                <input type="hidden" name="zoneId" value="${param.zoneId}" />

                            <div class="form-group">
                                <label for="name">Tên Sản Phẩm:</label>
                                <input type="text" class="form-control" id="name" name="name" value="${fn:escapeXml(not empty param.name ? param.name : product.name)}">
                                <c:if test="${not empty nameError}">
                                    <small class="text-danger">${nameError}</small>
                                </c:if>
                            </div>

                            <div class="form-group">
                                <label for="describe">Mô Tả:</label>
                                <textarea class="form-control" id="describe" name="describe" rows="3">${fn:escapeXml(product.describe)}</textarea>
                            </div>

                            <div class="form-group">
                                <label for="packaging">Tùy Chọn Đóng Gói:</label>
                                <input type="text" class="form-control" id="packaging" name="packaging" 
                                       value="${product.packaging}" placeholder="Ví dụ: 10kg, 50kg, 100kg">
                                <small class="form-text text-muted">Nhập kích thước đóng gói, phân cách bằng dấu phẩy</small>
                            </div>

                            <div class="form-group">
                                <label for="price">Giá:</label>
                                <input type="number" class="form-control" id="price" name="price" 
                                       value="${not empty param.price ? param.price : product.price}" step="0.01">
                                <c:if test="${not empty priceError}">
                                    <small class="text-danger">${priceError}</small>
                                </c:if>
                            </div>

                            <div class="form-group">
                                <label for="quantity">Số Lượng:</label>
                                <input type="number" class="form-control" id="quantity" name="quantity" 
                                       value="${not empty param.quantity ? param.quantity : product.quantity}" step="1" min="1">
                                <c:if test="${not empty quantityError}">
                                    <small class="text-danger">${quantityError}</small>
                                </c:if>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Khu Vực <span class="text-danger">*</span></label>
                                <c:if test="${not empty zoneError}">
                                    <div class="text-danger mb-2">${zoneError}</div>
                                </c:if>
                                
                                <div class="d-flex flex-wrap mb-2" id="selectedZonesContainer">
                                    <!-- Các zone đã chọn sẽ hiển thị ở đây dưới dạng badge -->
                                </div>
                                
                                <button type="button" class="btn btn-outline-primary" id="selectZonesBtn">
                                    <i class="fas fa-map-marker-alt me-1"></i> Chọn Khu Vực
                                </button>
                                
                                <!-- Input ẩn để lưu các zone ID đã chọn -->
                                <div id="zoneIdsContainer">
                                    <!-- Các input hidden chứa zone ID sẽ được thêm vào đây -->
                                </div>
                                
                                <small class="form-text text-muted">Nhấp vào nút để chọn các khu vực cho sản phẩm.</small>
                            </div>
                            
                            <!-- jQuery added before modal -->
                            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                            
                            <!-- Modal chọn Zone -->
                            <div class="modal fade" id="zonesModal" tabindex="-1" aria-labelledby="zonesModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="zonesModalLabel">Chọn Khu Vực</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <div class="input-group">
                                                    <input type="text" class="form-control" id="zoneSearchInput" placeholder="Tìm kiếm khu vực...">
                                                    <button class="btn btn-outline-secondary" type="button" id="searchZoneBtn">
                                                        <i class="fas fa-search"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            
                                            <div class="mb-3">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" id="selectAllZones">
                                                    <label class="form-check-label fw-bold" for="selectAllZones">
                                                        Chọn tất cả khu vực
                                                    </label>
                                                </div>
                                            </div>
                                            
                                            <div id="zonesList" class="border rounded p-3" style="max-height: 300px; overflow-y: auto;">
                                                <div class="text-center py-4">
                                                    <div class="spinner-border text-primary" role="status">
                                                        <span class="visually-hidden">Loading...</span>
                                                    </div>
                                                    <p class="mt-2">Đang tải danh sách khu vực...</p>
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
                                <label for="isActive">Trạng Thái:</label>
                                <select class="form-control" id="isActive" name="isActive" required>
                                    <option value="true" ${product.active ? 'selected' : ''}>Hoạt Động</option>
                                    <option value="false" ${!product.active ? 'selected' : ''}>Không Hoạt Động</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="image">URL Hình Ảnh:</label>
                                <input type="text" class="form-control" id="image" name="image" value="${product.image}" placeholder="Nhập URL hình ảnh">
                            </div>

                            <button type="submit" class="btn btn-primary">Cập Nhật Sản Phẩm</button>
                            <a href="products" class="btn btn-secondary">Quay Lại Danh Sách</a>
                            <a href="zoneControl?action=details&id=${param.zoneId}" class="btn btn-info">Quay Lại Chi Tiết Khu Vực</a>
                        </form>
                    </div>
                </div>
            </div>

            <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.bundle.min.js"></script>
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
            <script>
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
                    // Lấy danh sách zone đã chọn từ product
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
        </div>
    </body>
</html>