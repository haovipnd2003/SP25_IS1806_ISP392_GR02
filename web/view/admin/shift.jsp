<%-- 
    Document   : shift
    Created on : Mar 4, 2025, 5:31:27 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Manage Shift</title>

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
        <jsp:include page="/view/common/nav_bar.jsp"></jsp:include>
        <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>

            <div class="main-content" style="min-height: 600px;">
                <section class="section">
                    <div class="section-body">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h2>Manage Shift</h2>
                                    </div>
                                    <div class="card-body">
                                        <button class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target="#addShiftModal">+
                                            Add Shift</button>
                                        <form action="searchShift" method="post">
                                            <div class="mb-3">
                                                <input type="text" value="${keywordS}" name="keyword" id="search-input" class="form-control" placeholder="Search by shift">
                                        </div>
                                    </form>

                                    <table class="table table-bordered table-striped">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>No</th>
                                                <th>Shift</th>
                                                <th>Time</th>   
                                                <th>Total time</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="shift" items="${shiftList}" varStatus="loop">
                                                <tr>
                                                    <td>${loop.index + 1}</td>
                                                    <td>${shift.name}</td>
                                                    <td>${shift.start_time} - ${shift.end_time}</td>
                                                    <td>${shift.total_time} hours</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${shift.isactive == 1}">
                                                                <span class="badge bg-success">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">Inactive</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-warning btn-sm edit-btn" data-bs-toggle="modal" data-bs-target="#editShiftModal" 
                                                                data-id="${shift.id}" data-name="${shift.name}" data-start="${shift.start_time}" 
                                                                data-end="${shift.end_time}" data-total="${shift.total_time}" data-active="${shift.isactive}">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-danger btn-sm delete-btn" data-id="${shift.id}">
                                                            <i class="fas fa-trash-alt"></i>
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

        <!-- Add Shift Modal -->
        <div class="modal fade" id="addShiftModal" tabindex="-1" aria-labelledby="addShiftModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addShiftModalLabel">Add Shift</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="addshift" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="shiftName" class="form-label">Shift Name</label>
                                <input type="text" class="form-control" id="shiftName" name="name">
                            </div>
                            <div class="mb-3">
                                <label for="startTime" class="form-label" >Start Time</label>
                                <input type="time" class="form-control" id="startTime" name="start_time" >
                            </div>
                            <div class="mb-3">
                                <label for="endTime" class="form-label">End Time</label>
                                <input type="time" class="form-control" id="endTime" name="end_time" >
                            </div>
                            <div class="mb-3">
                                <label for="totalTime" class="form-label">Total Time</label>
                                <p id="totalTimeDisplay">0 hours</p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Shift Modal -->
        <div class="modal fade" id="editShiftModal" tabindex="-1" aria-labelledby="editShiftModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editShiftModalLabel">Edit Shift</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="editShift" method="post">
                        <div class="modal-body">
                            <input type="hidden" id="editShiftId" name="id">
                            <div class="mb-3">
                                <label for="editShiftName" class="form-label">Shift Name</label>
                                <input type="text" class="form-control" id="editShiftName" name="name">
                            </div>
                            <div class="mb-3">
                                <label for="editStartTime" class="form-label">Start Time</label>
                                <input type="time" class="form-control" id="editStartTime" name="start_time">
                            </div>
                            <div class="mb-3">
                                <label for="editEndTime" class="form-label">End Time</label>
                                <input type="time" class="form-control" id="editEndTime" name="end_time">
                            </div>
                            <div class="mb-3">
                                <label for="editTotalTime" class="form-label">Total Time</label>
                                <p id="editTotalTimeDisplay">0 hours</p>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Status</label>
                                <select class="form-control" id="editShiftStatus" name="isactive">
                                    <option value="1">Active</option>
                                    <option value="0">Inactive</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function calculateTotalTime() {
                let startTimeInput = document.getElementById('startTime');
                let endTimeInput = document.getElementById('endTime');

                let startTime = startTimeInput.value || "07:00";
                let endTime = endTimeInput.value || "11:00";

                let start = new Date('1970-01-01T' + startTime + 'Z');
                let end = new Date('1970-01-01T' + endTime + 'Z');
                let diff = (end - start) / 3600000;
                if (diff < 0)
                    diff += 24;

                document.getElementById('totalTimeDisplay').textContent = diff.toFixed(2) + ' hours';
            }

            document.getElementById('addShiftModal').addEventListener('shown.bs.modal', function () {
                let startTimeInput = document.getElementById('startTime');
                let endTimeInput = document.getElementById('endTime');

                startTimeInput.value = "07:00";
                endTimeInput.value = "11:00";
                calculateTotalTime();
            });

            document.getElementById('startTime').addEventListener('input', function () {
                if (this.value === "")
                    this.value = "07:00";
                calculateTotalTime();
            });

            document.getElementById('endTime').addEventListener('input', function () {
                if (this.value === "")
                    this.value = "11:00";
                calculateTotalTime();
            });
            document.querySelector("form[action='addshift']").addEventListener("submit", function (e) {
                let shiftName = document.getElementById("shiftName").value.trim();
                if (shiftName === "") {
                    toastr.error("Please enter shift name.");
                    e.preventDefault(); // Ngăn form gửi đi
                    return;
                }

            });
        </script>
        <script>
            // Khi bấm vào icon Edit, điền dữ liệu vào form Edit Shift
            document.querySelectorAll('.edit-btn').forEach(button => {
                button.addEventListener('click', function () {
                    document.getElementById('editShiftId').value = this.dataset.id;
                    document.getElementById('editShiftName').value = this.dataset.name;
                    document.getElementById('editStartTime').value = this.dataset.start;
                    document.getElementById('editEndTime').value = this.dataset.end;
                    document.getElementById('editShiftStatus').value = this.dataset.active;

                    // Tính toán thời gian tổng
                    calculateEditTotalTime();
                });
            });

// Tính toán tổng thời gian trong modal Edit
            function calculateEditTotalTime() {
                let startTime = document.getElementById('editStartTime').value;
                let endTime = document.getElementById('editEndTime').value;

                let start = new Date('1970-01-01T' + startTime + 'Z');
                let end = new Date('1970-01-01T' + endTime + 'Z');
                let diff = (end - start) / 3600000;
                if (diff < 0)
                    diff += 24;

                document.getElementById('editTotalTimeDisplay').textContent = diff.toFixed(2) + ' hours';
            }

// Lắng nghe sự thay đổi của thời gian trong modal Edit
            document.getElementById('editStartTime').addEventListener('input', calculateEditTotalTime);
            document.getElementById('editEndTime').addEventListener('input', calculateEditTotalTime);

        </script>
        <script>
            document.querySelectorAll('.delete-btn').forEach(button => {
                button.addEventListener('click', function () {
                    let shiftId = this.dataset.id;
                    if (confirm("Are you sure you want to delete this shift?")) {
                        window.location.href = "deleteShift?id=" + shiftId;
                    }
                });
            });

        </script>
        <script>
//            // Validation for Edit Shift Form
//            document.querySelector("form[action='editShift']").addEventListener("submit", function (e) {
//                let shiftName = document.getElementById("editShiftName").value.trim();
//
//                // Validate shift name
//                if (shiftName === "") {
//                    toastr.error("Please enter shift name.");
//                    e.preventDefault(); // Prevent form submission
//                    return;
//                }
//
//            });
            document.querySelector("form[action='editShift']").addEventListener("submit", function (e) {
                let shiftName = document.getElementById("editShiftName").value.trim();
                let startTime = document.getElementById("editStartTime").value;
                let endTime = document.getElementById("editEndTime").value;

                // Validate shift name
                if (shiftName === "") {
                    toastr.error("Please enter shift name.");
                    e.preventDefault();
                    return;
                }

                // Validate start and end times
                if (!startTime) {
                    toastr.error("Please enter a start time.");
                    e.preventDefault();
                    return;
                }

                if (!endTime) {
                    toastr.error("Please enter an end time.");
                    e.preventDefault();
                    return;
                }
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
