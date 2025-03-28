<%-- 
    Document   : manageAccount
    Created on : 16 thg 2, 2025, 00:34:41
    Author     : Admin
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">

        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Manage Accounts</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>
        <!-- jQuery first, then Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
    </head>

    <body>
        <style>
            /* Blue color scheme (#2563eb) styling */
            .card-header {
                background-color: #3b82f6  !important;
                color: white !important;
            }

            .btn-primary {
                background-color: #2563eb !important;
                border-color: #2563eb !important;
            }

            .btn-primary:hover {
                background-color: #1d4ed8 !important;
                border-color: #1d4ed8 !important;
            }

            .btn-warning {
                background-color: #3b82f6 !important;
                border-color: #3b82f6 !important;
                color: white !important;
            }

            .btn-warning:hover {
                background-color: #2563eb !important;
                border-color: #2563eb !important;
            }

            thead.table-dark th {
                background-color: #3b82f6 !important; /* Màu xanh nhạt hơn */
                color: white !important; /* Màu chữ trắng */
            }

            .form-control:focus {
                border-color: #3b82f6 !important;
                box-shadow: 0 0 0 0.25rem rgba(37, 99, 235, 0.25) !important;
            }

            .badge.bg-primary {
                background-color: #2563eb !important;
            }

            .badge.bg-info {
                background-color: #3b82f6 !important;
            }

            .modal-header {
                background-color: #2563eb !important;
                color: white !important;
            }

            .toast-success {
                background-color: #2563eb !important;
            }

            /* Simple enhancements that don't change layout */
            .card {
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                border: none;
            }

            .table {
                border-collapse: separate;
                border-spacing: 0;
            }

            .badge {
                font-weight: 500;
                padding: 5px 10px;
                border-radius: 20px;
            }
        </style>
        <jsp:include page="/view/common/nav_bar.jsp"></jsp:include>
            <!--MAIN-SIDEBAR-JSP-INCLUDE-->
        <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
            <!--MAIN-SIDEBAR-JSP-INCLUDE-->

            <!--                MAIN CONTENT-->
            <div class="main-content" style="min-height: 600px;">
                <section class="section">


                    <div class="section-body">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h2>Quản Lý Tài Khoản</h2>
                                    </div>
                                    <div class="card-body">
                                        <button class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target="#addAccountModal">+
                                            Thêm tài khoản</button>
                                        <form action="searchaccount" method="post">
                                            <div class="mb-3">
                                                <input type="text" value="${keywordS}" name="keyword" id="search-input" class="form-control" placeholder="tìm kiếm theo tên, email, địa chỉ, số điện thoại, or role...">
                                        </div>

                                    </form>



                                    <table class="table table-bordered table-striped">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Tài khoản</th>
                                                <th>Tên</th>
                                                <th>Email</th>
                                                <th>Địa chỉ</th>
                                                <th>SĐT</th>
                                                <th>Chức vụ</th>
                                                <th>Trạng thái</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="account" items="${accounts}">
                                                <tr>
                                                    <td>${account.name}</td>
                                                    <td>${account.fullname}</td>
                                                    <td>${account.email}</td>
                                                    <td>${account.address}</td>
                                                    <td>${account.phone}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${account.roletype == '2'}">Chủ cửa hàng</c:when>
                                                            <c:when test="${account.roletype == '3'}">Nhân Viên</c:when>
                                                            <c:otherwise>Unknown</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${account.isactive == '1'}">
                                                                <span class="badge bg-success">Hoạt động</span>
                                                            </c:when>
                                                            <c:when test="${account.isactive == '0'}">
                                                                <span class="badge bg-danger">Không hoạt động</span>
                                                            </c:when>
                                                            <c:otherwise>Không biết</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-warning btn-sm edit-btn"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#editAccountModal"
                                                                data-id="${account.id}"
                                                                data-name="${account.name}"
                                                                data-fullname="${account.fullname}"
                                                                data-email="${account.email}"
                                                                data-phone="${account.phone}"
                                                                data-address="${account.address}"
                                                                data-roletype="${account.roletype}"
                                                                data-isactive="${account.isactive}">
                                                            <i class="fa-solid fa-pen"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <!-- Modal Add Account -->
        <div class="modal fade" id="addAccountModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm tài khoản</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="addaccount" method="POST" >
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tên đăng nhập</label>
                                <input type="text" class="form-control" name="name" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mật khẩu</label>
                                <input type="password" class="form-control" name="password" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tên</label>
                                <input type="text" class="form-control" name="fullname" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">SĐT</label>
                                <input type="text" class="form-control" name="phone">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Địa chỉ</label>
                                <input type="text" class="form-control" name="address">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Chức vụ</label>
                                <select class="form-control" name="roletype" >
                                    <option value="2">Chủ cửa hàng</option>
                                    <option value="3" selected>Nhân viên</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Thêm</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Edit Account -->
        <div class="modal fade" id="editAccountModal" tabindex="-1" aria-labelledby="editAccountModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editAccountModalLabel">Chỉnh sửa tài khoản</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="updateaccount" method="POST">
                            <input type="hidden" id="edit-id" name="id" /> 

                            <div class="mb-3">
                                <label class="form-label">Tên đăng nhập</label>
                                <input type="text" class="form-control" id="edit-name" name="name" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tên</label>
                                <input type="text" class="form-control" id="edit-fullname" name="fullname" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" id="edit-email" name="email" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">SĐT</label>
                                <input type="text" class="form-control" id="edit-phone" name="phone" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Địa chỉ</label>
                                <input type="text" class="form-control" id="edit-address" name="address" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Chức vụ</label>
                                <select class="form-control" id="edit-roletype" name="roletype">
                                    <option value="2">Chủ cửa hàng</option>
                                    <option value="3">Nhân viên</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label" id="status-group">Trạng thái</label>
                                <select class="form-control" id="edit-isactive" name="isactive">
                                    <option value="1">Hoạt động</option>
                                    <option value="0">Không hoạt động</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-warning w-100">Lưu thay đổi</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let editButtons = document.querySelectorAll(".edit-btn");

                editButtons.forEach(button => {
                    button.addEventListener("click", function () {
                        document.getElementById("edit-id").value = this.getAttribute("data-id");
                        document.getElementById("edit-name").value = this.getAttribute("data-name");
                        document.getElementById("edit-fullname").value = this.getAttribute("data-fullname");
                        document.getElementById("edit-email").value = this.getAttribute("data-email");
                        document.getElementById("edit-phone").value = this.getAttribute("data-phone");
                        document.getElementById("edit-address").value = this.getAttribute("data-address");

                        let roletype = this.getAttribute("data-roletype");
                        document.getElementById("edit-roletype").value = roletype;

                        let isactive = this.getAttribute("data-isactive");
                        document.getElementById("edit-isactive").value = isactive;

                        // Ẩn Status nếu là Admin (roletype == 1)
                        let statusGroup = document.getElementById("status-group");
                        if (roletype === "2") {
                            statusGroup.style.display = "none";
                        } else {
                            statusGroup.style.display = "block";
                        }
                    });
                });

                // Kiểm tra khi submit form chỉnh sửa
                document.querySelector("#editAccountModal form").addEventListener("submit", function (event) {
                    let nameField = document.getElementById("edit-name");
                    let nameField2 = document.getElementById("edit-fullname");
                    if (nameField.value.trim() === "") {
                        event.preventDefault(); // Ngăn form gửi đi
                        alert("Tên tài khoản không được để trống!"); // Hiển thị popup cảnh báo
                        nameField.focus(); // Đưa con trỏ vào ô nhập
                    }
                    if (nameField2.value.trim() === "") {
                        event.preventDefault(); // Ngăn form gửi đi
                        alert("Tên không được để trống!"); // Hiển thị popup cảnh báo
                        nameField2.focus(); // Đưa con trỏ vào ô nhập
                    }
                });
            });
        </script>  
        <script>
            $(document).ready(function () {
                $("form[action='addaccount']").submit(function (event) {
                    event.preventDefault(); // Ngăn form gửi đi mặc định

                    $.ajax({
                        type: "POST",
                        url: "addaccount",
                        data: $(this).serialize(),
                        dataType: "json",
                        success: function (response) {
                            if (response.status === "success") {
                                toastr.success(response.message, "Success", {
                                    positionClass: "toast-top-right",
                                    timeOut: 2000,
                                    showMethod: "fadeIn",
                                    hideMethod: "fadeOut"
                                });
                                setTimeout(() => location.reload(), 1000); // Reload trang sau 2s
                            } else {
                                toastr.error(response.message, "Error", {
                                    positionClass: "toast-top-right",
                                    timeOut: 2000,
                                    showMethod: "fadeIn",
                                    hideMethod: "fadeOut"
                                });
                            }
                        },
                        error: function () {
                            toastr.error("Something went wrong!", "Error", {
                                positionClass: "toast-top-right",
                                timeOut: 2000
                            });
                        }
                    });
                });
            });
        </script>


        <script src="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
        <script src="${pageContext.request.contextPath}/js/custom.js"></script>
        <script src="${pageContext.request.contextPath}/js/demo.js"></script>


        <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/popper.js"></script>
        <script src="${pageContext.request.contextPath}/modules/tooltip.js"></script>
        <script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/nicescroll/jquery.nicescroll.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/scroll-up-bar/dist/scroll-up-bar.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sa-functions.js"></script>

    </body>
</html>

