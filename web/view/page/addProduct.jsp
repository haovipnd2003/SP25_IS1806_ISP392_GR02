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
                                                   id="name" name="name" value="${param.name}" required>
                                            <c:if test="${not empty nameError}">
                                                <div class="invalid-feedback">${nameError}</div>
                                            </c:if>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="price" class="form-label">Price (VNĐ) <span class="text-danger">*</span></label>
                                            <input type="number" class="form-control ${not empty priceError ? 'is-invalid' : ''}" 
                                                   id="price" name="price" step="1000" min="0" value="${param.price}" required>
                                            <c:if test="${not empty priceError}">
                                                <div class="invalid-feedback">${priceError}</div>
                                            </c:if>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="quantity" class="form-label">Quantity <span class="text-danger">*</span></label>
                                            <input type="number" class="form-control ${not empty quantityError ? 'is-invalid' : ''}" 
                                                   id="quantity" name="quantity" step="1" min="1" value="${param.quantity}" required>
                                            <c:if test="${not empty quantityError}">
                                                <div class="invalid-feedback">${quantityError}</div>
                                            </c:if>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="describe" class="form-label">Description</label>
                                            <textarea class="form-control" id="describe" name="describe" 
                                                      rows="4" placeholder="Enter product description">${param.describe}</textarea>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="packaging" class="form-label">Packaging Options</label>
                                            <input type="text" class="form-control" id="packaging" name="packaging" 
                                                   placeholder="e.g., 10kg, 50kg, 100kg" value="${param.packaging}">
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
                                            <div class="zone-checkbox-container">
                                                <c:forEach var="zone" items="${activeZones}">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" name="zoneIds" 
                                                               id="zone${zone.id}" value="${zone.id}" ${fn:contains(param.zoneIds, zone.id) ? 'checked' : ''}>
                                                        <label class="form-check-label" for="zone${zone.id}">
                                                            ${zone.name}
                                                        </label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <small class="form-text text-muted">Select all zones where this product should be available</small>
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

            function validateForm() {
                const productName = document.getElementById('name').value.trim();
                const zoneCheckboxes = document.querySelectorAll('input[name="zoneIds"]:checked');

                if (existingProductNames.includes(productName)) {
                    iziToast.error({
                        title: 'Error',
                        message: 'Product name already exists!',
                        position: 'topCenter'
                    });
                    return false;
                }
                
                if (zoneCheckboxes.length === 0) {
                    iziToast.error({
                        title: 'Error',
                        message: 'Please select at least one zone!',
                        position: 'topCenter'
                    });
                    return false;
                }
                
                return true;
            }
            
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
    </body>
</html>