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

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
    </head>

    <body>

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
                                        <h2>Manage Account</h2>
                                    </div>
                                    <div class="card-body">
                                        <button class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target="#addAccountModal">+
                                            Add Account</button>
                                        <table class="table table-bordered table-striped">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th>Account</th>
                                                    <th>Email</th>
                                                    <th>Address</th>
                                                    <th>Phone</th>
                                                    <th>Role</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="account" items="${accounts}">
                                                <tr>
                                                    <td>${account.name}</td>
                                                    <td>${account.email}</td>
                                                    <td>${account.address}</td>
                                                    <td>${account.phone}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${account.roletype == '1'}">Admin</c:when>
                                                            <c:when test="${account.roletype == '2'}">Owner</c:when>
                                                            <c:when test="${account.roletype == '3'}">Staff</c:when>
                                                            <c:otherwise>Unknown</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${account.isactive == '1'}">
                                                                <span class="badge bg-success">Active</span>
                                                            </c:when>
                                                            <c:when test="${account.isactive == '0'}">
                                                                <span class="badge bg-danger">Inactive</span>
                                                            </c:when>
                                                            <c:otherwise>Unknown</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-warning btn-sm edit-btn"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#editAccountModal"
                                                                data-id="${account.id}"
                                                                data-name="${account.name}"
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
                        <h5 class="modal-title">Add Account</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Account</label>
                                <input type="text" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Role</label>
                                <select class="form-control">
                                    <option>Admin</option>
                                    <option>Owner</option>
                                    <option>Staff</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Add</button>
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
                        <h5 class="modal-title" id="editAccountModalLabel">Edit Account</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="updateaccount" method="POST">
                            <input type="hidden" id="edit-id" name="id" /> 

                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-control" id="edit-name" name="name" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" id="edit-email" name="email" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Phone</label>
                                <input type="text" class="form-control" id="edit-phone" name="phone" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Address</label>
                                <input type="text" class="form-control" id="edit-address" name="address" >
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Role</label>
                                <select class="form-control" id="edit-roletype" name="roletype">
                                    <option value="1">Admin</option>
                                    <option value="2">Owner</option>
                                    <option value="3">Staff</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label" id="status-group">Status</label>
                                <select class="form-control" id="edit-isactive" name="isactive">
                                    <option value="1">Active</option>
                                    <option value="0">Inactive</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-warning w-100">Save Changes</button>
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
                        document.getElementById("edit-email").value = this.getAttribute("data-email");
                        document.getElementById("edit-phone").value = this.getAttribute("data-phone");
                        document.getElementById("edit-address").value = this.getAttribute("data-address");

                        let roletype = this.getAttribute("data-roletype");
                        document.getElementById("edit-roletype").value = roletype;

                        let isactive = this.getAttribute("data-isactive");
                        document.getElementById("edit-isactive").value = isactive;

                        // Ẩn Status nếu là Admin (roletype == 1)
                        let statusGroup = document.getElementById("status-group");
                        if (roletype === "1") {
                            statusGroup.style.display = "none";
                        } else {
                            statusGroup.style.display = "block";
                        }
                    });
                });

                // Kiểm tra khi submit form chỉnh sửa
                document.querySelector("#editAccountModal form").addEventListener("submit", function (event) {
                    let nameField = document.getElementById("edit-name");
                    if (nameField.value.trim() === "") {
                        event.preventDefault(); // Ngăn form gửi đi
                        alert("User name not allow blank!"); // Hiển thị popup cảnh báo
                        nameField.focus(); // Đưa con trỏ vào ô nhập
                    }
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

