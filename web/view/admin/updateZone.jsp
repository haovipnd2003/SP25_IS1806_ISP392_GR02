<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
    <head>
        <title>Cập Nhật Khu Vực</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .main-content {
                margin-left: 250px;
                padding: 2rem;
            }
            .card {
                border: none;
                border-radius: 0.5rem;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }
            .card-header {
                padding: 1.5rem;
                border-radius: 0.5rem 0.5rem 0 0;
            }
            .card-body {
                padding: 2rem;
            }
            .form-group {
                margin-bottom: 1.5rem;
            }
            .form-control {
                padding: 0.75rem 1rem;
                border-radius: 0.5rem;
            }
            .btn-primary {
                padding: 0.75rem 1rem;
                font-size: 1rem;
                border-radius: 0.5rem;
            }
            .alert {
                margin-bottom: 1.5rem;
                padding: 1rem;
                border-radius: 0.5rem;
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
                        <button id="sidebarToggle" class="btn btn-secondary mb-4">
                            <i class="fas fa-bars"></i>
                        </button>

                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header bg-primary text-white">
                                        <h1 class="card-title text-center">Cập Nhật Khu Vực</h1>
                                    </div>
                                    <div class="card-body">
                                        <!-- Confirmation Alert -->
                                        <c:if test="${not empty sessionScope.confirmMessage}">
                                            <div class="alert alert-warning" role="alert">
                                                <h4 class="alert-heading">Cảnh Báo!</h4>
                                                <p>${sessionScope.confirmMessage}</p>
                                                <hr>
                                                <div class="d-flex justify-content-end">
                                                    <form action="zoneControl" method="post">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="id" value="${sessionScope.zoneId}">
                                                        <input type="hidden" name="name" value="${sessionScope.zoneName}">
                                                        <input type="hidden" name="isActive" value="false">
                                                        <input type="hidden" name="confirmed" value="true">
                                                        <button type="submit" class="btn btn-danger me-2">Đồng Ý, Vô Hiệu Hóa</button>
                                                        <a href="zoneControl" class="btn btn-secondary">Hủy</a>
                                                    </form>
                                                </div>
                                            </div>
                                            <% 
                                                session.removeAttribute("confirmMessage");
                                                session.removeAttribute("zoneId");
                                                session.removeAttribute("zoneName");
                                            %>
                                        </c:if>
                                        
                                        <form action="zoneControl" method="post" onsubmit="return validateForm()">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${zone.id}">

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label for="name" class="form-label">Tên Khu Vực:</label>
                                                        <input type="text" class="form-control ${not empty nameError ? 'is-invalid' : ''}" 
                                                               id="name" name="name" value="${not empty zoneName ? zoneName : zone.name}" required>
                                                        <c:if test="${not empty nameError}">
                                                            <div class="invalid-feedback">${nameError}</div>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mt-3">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label for="description" class="form-label">Mô Tả:</label>
                                                        <textarea class="form-control" id="description" name="description" rows="4">${not empty zoneDescription ? zoneDescription : zone.description}</textarea>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mt-3">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label class="form-label">Trạng Thái:</label>
                                                        <c:if test="${not empty statusError}">
                                                            <div class="text-danger d-block mb-2">${statusError}</div>
                                                        </c:if>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="isActive" id="active" value="true" 
                                                                   ${not empty zoneIsActive ? (zoneIsActive == 'true' ? 'checked' : '') : (zone.isActive ? 'checked' : '')}>
                                                            <label class="form-check-label" for="active">
                                                                Hoạt Động
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="isActive" id="inactive" value="false" 
                                                                   ${not empty zoneIsActive ? (zoneIsActive == 'false' ? 'checked' : '') : (!zone.isActive ? 'checked' : '')}>
                                                            <label class="form-check-label" for="inactive">
                                                                Không Hoạt Động
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mt-4">
                                                <div class="col-md-12 text-center">
                                                    <button type="submit" class="btn btn-primary">Cập Nhật Khu Vực</button>
                                                    <a href="zoneControl" class="btn btn-secondary">Hủy</a>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Danh sách tên zone đã tồn tại (trừ zone hiện tại)
            const currentZoneId = ${zone.id};
            const currentZoneName = "${zone.name}";
            const existingZoneNames = [
            <c:forEach var="z" items="${zoneList}" varStatus="status">
                <c:if test="${z.id != zone.id}">
            "${z.name}"${!status.last ? ',' : ''}
                </c:if>
            </c:forEach>
            ];

            function validateForm() {
                let isValid = true;
                const zoneName = document.getElementById('name').value.trim();
                const activeRadio = document.getElementById('active');
                const inactiveRadio = document.getElementById('inactive');
                
                // Clear ALL previous error messages
                document.querySelectorAll('.validation-error, .invalid-feedback').forEach(el => el.remove());
                document.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));
                
                // Validate zone name
                if (zoneName === '') {
                    displayError('name', 'Tên khu vực là bắt buộc');
                    isValid = false;
                } else if (zoneName !== currentZoneName && existingZoneNames.includes(zoneName)) {
                    displayError('name', 'Tên khu vực đã tồn tại!');
                    isValid = false;
                }
                
                // Validate status
                if (!activeRadio.checked && !inactiveRadio.checked) {
                    const statusContainer = document.querySelector('.form-group:has(#active)');
                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'text-danger validation-error mb-2';
                    errorDiv.textContent = 'Vui lòng chọn trạng thái';
                    statusContainer.insertBefore(errorDiv, statusContainer.firstChild.nextSibling);
                    isValid = false;
                }
                
                if (!isValid) {
                    // Prevent form submission if validation fails
                    iziToast.error({
                        title: 'Lỗi',
                        message: 'Vui lòng sửa các lỗi trong biểu mẫu',
                        position: 'topRight',
                        timeout: 5000
                    });
                    return false;
                }
                
                return true;
            }
            
            function displayError(fieldId, message) {
                const field = document.getElementById(fieldId);
                field.classList.add('is-invalid');
                
                const errorDiv = document.createElement('div');
                errorDiv.className = 'invalid-feedback validation-error';
                errorDiv.textContent = message;
                
                field.parentNode.appendChild(errorDiv);
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
                        title: toastType === 'success' ? 'Thành Công' : 'Lỗi',
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

        <!-- Bootstrap JS (optional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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