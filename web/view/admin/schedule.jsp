<%-- 
    Document   : schedule
    Created on : Mar 6, 2025, 9:23:56 PM
    Author     : Admin
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
    <head>
        <title>Lịch làm việc</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>
        <!-- jQuery first, then Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
        <style>

            .add-shift-btn {
                display: none;
                margin-top: 5px;
            }
            .shift-container:hover .add-shift-btn {
                display: inline-block;
            }
            .add-shift-modal {
                display: none;
                position: absolute;
                background-color: white;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 10px;
                z-index: 1000;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                width: 150px;
                text-align: left;
            }

            /* Table improvements */
            .schedule-table {
                border-collapse: separate;
                border-spacing: 0;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
            }

            .schedule-table th, .schedule-table td {
                border: 1px solid #e9ecef;
                padding: 12px 8px;
                vertical-align: middle;
            }

            .schedule-header {
                background-color: #f1f5f9;
                color: #334155;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.85rem;
                letter-spacing: 0.5px;
            }

            .schedule-header th {
                padding: 15px 10px;
            }

            /* Shift styling */
            .shift-cell {
                background-color: #e0f2fe;
                border: 1px solid #bae6fd;
                color: #0369a1;
                border-radius: 6px;
                padding: 5px 8px;
                margin: 3px;
                font-weight: 500;
                font-size: 0.9rem;
                box-shadow: 0 1px 2px rgba(0,0,0,0.05);
                transition: all 0.2s ease;
            }

            .shift-cell:hover {
                background-color: #bae6fd;
                transform: translateY(-1px);
            }

            .shifts-container {
                display: flex;
                flex-wrap: wrap;
                gap: 5px;
                justify-content: center;
                padding: 3px;
            }

            /* Today highlighting */
            .today, .today-header {
                background-color: #dcfce7 !important;
                position: relative;
            }

            .today-header::after {
                content: "Hôm nay";
                position: absolute;
                top: 0;
                right: 0;
                background-color: #22c55e;
                color: white;
                font-size: 0.65rem;
                padding: 2px 5px;
                border-radius: 0 0 0 5px;
            }

            /* No shift styling */
            .no-shift {
                color: #94a3b8;
                font-style: italic;
                padding: 5px;
                font-size: 0.85rem;
            }

            /* Button styling */
            .add-shift-btn {
                background-color: #f8fafc;
                border: 1px dashed #cbd5e1;
                color: #64748b;
                border-radius: 4px;
                padding: 3px 8px;
                font-size: 0.8rem;
                transition: all 0.2s ease;
                margin-top: 8px;
            }

            .add-shift-btn:hover {
                background-color: #f1f5f9;
                color: #334155;
                border-color: #94a3b8;
            }

            .delete-shift-btn {
                background-color: transparent;
                border: none;
                color: #ef4444;
                font-size: 0.75rem;
                padding: 0 3px;
                margin-left: 3px;
                opacity: 0.6;
                transition: opacity 0.2s;
            }

            .delete-shift-btn:hover {
                opacity: 1;
                background-color: transparent;
            }

            /* Navigation controls */
            .btn-light {
                background-color: white;
                border: 1px solid #e2e8f0;
                color: #475569;
                box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            }

            .btn-light:hover {
                background-color: #f8fafc;
                color: #334155;
            }

            .btn-outline-primary {
                border-color: #3b82f6;
                color: #3b82f6;
            }

            .btn-outline-primary:hover {
                background-color: #3b82f6;
                color: white;
            }

            /* Search input */
            #searchEmployee {
                border-radius: 6px;
                border: 1px solid #e2e8f0;
                padding: 8px 12px;
                box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            }

            #searchEmployee:focus {
                border-color: #3b82f6;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25);
            }

            /* Modal styling */
            .modal-content {
                border-radius: 10px;
                border: none;
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            }

            .modal-header {
                background-color: #f8fafc;
                border-bottom: 1px solid #f1f5f9;
                border-radius: 10px 10px 0 0;
                padding: 15px 20px;
            }

            .modal-title {
                color: #334155;
                font-weight: 600;
            }

            .modal-body {
                padding: 20px;
            }

            .form-label {
                color: #475569;
                font-weight: 500;
            }

            .form-check-label {
                color: #334155;
            }

            .add-new-shift-btn {
                background-color: #dbeafe;
                color: #2563eb;
                width: 24px;
                height: 24px;
                border-radius: 50%;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-size: 16px;
                transition: all 0.2s ease;
            }

            .add-new-shift-btn:hover {
                background-color: #bfdbfe;
                transform: scale(1.1);
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }

                .schedule-table th, .schedule-table td {
                    padding: 8px 5px;
                    font-size: 0.9rem;
                }

                .shift-cell {
                    font-size: 0.8rem;
                    padding: 3px 5px;
                }
            }
        </style>

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
                                    <!-- Nội dung schedule.jsp -->
                                    <div class="container mt-4">
                                        <h3>Lịch làm việc</h3>
                                        <div class="d-flex justify-content-between mb-3">
                                            <!--<input type="text" id="searchEmployee" class="form-control w-25" placeholder="Tìm kiếm nhân viên">-->
                                        <c:if test="${not isStaffView}">
                                            <input type="text" id="searchEmployee" class="form-control w-25" placeholder="Tìm kiếm nhân viên">
                                        </c:if>
                                        <c:if test="${isStaffView}">
                                            <div></div> <!-- Empty div for flex spacing when search is hidden -->
                                        </c:if>
                                        <div>
                                            <button class="btn btn-light" onclick="navigateWeek(-1)">&lt;</button>
                                            <span class="mx-2">Tuần ${weekOfMonth} - Th.${monthYear}</span>
                                            <button class="btn btn-light" onclick="navigateWeek(1)">&gt;</button>
                                            <button class="btn btn-outline-primary ms-2" onclick="goToCurrentWeek()">Tuần này</button>
                                        </div>
                                    </div>
                                    <table class="table table-bordered schedule-table">
                                        <thead>
                                            <tr class="schedule-header">
                                                <c:if test="${not isStaffView}">
                                                    <th>Nhân viên</th>
                                                    </c:if>
                                                    <c:forEach var="i" begin="0" end="6">
                                                    <!--<th>${days[i]} <br> ${dates[i]}</th>-->
                                                    <fmt:parseDate value="${startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" />
                                                    <jsp:useBean id="headerDateCalculator" class="java.util.Date" />
                                                    <c:set target="${headerDateCalculator}" property="time" value="${parsedStartDate.time + (i * 86400000)}" />
                                                    <fmt:formatDate value="${headerDateCalculator}" pattern="yyyy-MM-dd" var="headerCurrentDate" />
                                                    <th class="${headerCurrentDate eq todayDate ? 'today-header' : ''}">${days[i]} <br> ${dates[i]}</th>
                                                    </c:forEach>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="employee" items="${employees}">
                                                <tr class="employee-row">
                                                    <c:if test="${not isStaffView}">
                                                        <td>${employee.fullname}  </td>
                                                    </c:if>

                                                    <c:forEach var="i" begin="0" end="6">
                                                        <fmt:parseDate value="${startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" />
                                                        <jsp:useBean id="dateCalculator" class="java.util.Date" />
                                                        <c:set target="${dateCalculator}" property="time" value="${parsedStartDate.time + (i * 86400000)}" />
                                                        <fmt:formatDate value="${dateCalculator}" pattern="yyyy-MM-dd" var="currentDate" />

                                                        <td>
                                                            <div class="shift-container">
                                                                <c:choose>
                                                                    <c:when test="${not empty scheduleMap[employee.id][currentDate]}">
                                                                        <div class="shifts-container">
                                                                            <c:set var="shiftsForDay" value="${scheduleMap[employee.id][currentDate]}" />
                                                                            <c:forEach var="shift" items="${shiftsForDay}">
                                                                                <div class="shift-cell" title="${shift} (${shiftTimeMap[shift]})">${shift}
                                                                                    <c:if test="${not isStaffView}">
                                                                                        <button class="btn btn-sm btn-danger delete-shift-btn"
                                                                                                onclick="deleteShift('${employee.id}', '${currentDate}', '${shift}')">
                                                                                            x
                                                                                        </button>
                                                                                    </c:if>
                                                                                </div>
                                                                            </c:forEach>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="no-shift" style="${currentDate eq todayDate ? 'opacity: 0.5;' : ''}">Không có ca</div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <!--                                        <button class="btn btn-sm btn-light add-shift-btn" 
                                                                                                                onclick="showAddShiftModal('${employee.id}', '${currentDate}')">+ Thêm ca</button>-->
                                                                <c:if test="${not isStaffView}">
                                                                    <button class="btn btn-sm btn-light add-shift-btn" 
                                                                            onclick="showAddShiftModal('${employee.id}', '${currentDate}')">+ Thêm ca</button>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                    </c:forEach>
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


        <!--Add Shift Modal--> 
        <div class="modal fade" id="addShiftModal" tabindex="-1" aria-labelledby="addShiftModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addShiftModalLabel">Thêm ca làm việc</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="addShiftForm" action="addshiftfs" method="post">
                            <input type="hidden" name="action" value="addshiftfs">
                            <input type="hidden" id="userId" name="userId">
                            <input type="hidden" id="date" name="date">
                            <input type="hidden" name="week" value="${startDate}">
                            <div class="mb-3">
                                <label class="form-label d-inline-flex align-items-center">
                                    Chọn ca làm việc
                                    <span class="add-new-shift-btn ms-2" title="Thêm ca làm việc mới" onclick="showCreateShiftModal()">+</span>
                                </label>

                                <div>
                                    <c:forEach var="shift" items="${shifts}">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="shift_${shift.id}" name="shiftIds" value="${shift.id}">
                                            <label class="form-check-label" for="shift_${shift.id}">
                                                ${shift.name} (${shift.start_time} - ${shift.end_time})
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary" onclick="return validateShiftForm()">Thêm</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Create New Shift Modal -->
        <div class="modal fade" id="createShiftModal" tabindex="-1" aria-labelledby="createShiftModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createShiftModalLabel">Thêm ca làm việc mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="addnewshift" method="post">
                        <div class="modal-body">             
                            <div class="mb-3">
                                <label for="shiftName" class="form-label">Tên ca làm việc</label>
                                <input type="text" class="form-control" id="shiftName" name="name">
                            </div>
                            <div class="mb-3">
                                <label for="startTime" class="form-label">Giờ bắt đầu</label>
                                <input type="time" class="form-control" id="startTime" name="start_time" onchange="calculateTotalTime()">
                            </div>
                            <div class="mb-3">
                                <label for="endTime" class="form-label">Giờ kết thúc</label>
                                <input type="time" class="form-control" id="endTime" name="end_time" onchange="calculateTotalTime()">
                            </div>
                            <div class="mb-3">
                                <label for="totalTime" class="form-label">Tổng thời gian</label>
                                <p id="totalTimeDisplay">0 giờ</p>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" id="saveNewShiftBtn" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                    // Filter employees by name
                                    document.getElementById('searchEmployee').addEventListener('input', function () {
                                        const searchTerm = this.value.toLowerCase();
                                        const rows = document.querySelectorAll('.employee-row');

                                        rows.forEach(row => {
                                            const employeeName = row.querySelector('td:first-child').textContent.toLowerCase();
                                            if (employeeName.includes(searchTerm)) {
                                                row.style.display = '';
                                            } else {
                                                row.style.display = 'none';
                                            }
                                        });
                                    });

                                    // Navigate between weeks
                                    function navigateWeek(direction) {
                                        const currentUrl = new URL(window.location);

                                        // Get current date parameter or use today
                                        let currentDate = currentUrl.searchParams.get('week') || new Date().toISOString().split('T')[0];
                                        let date = new Date(currentDate);

                                        // Add or subtract 7 days
                                        date.setDate(date.getDate() + (direction * 7));

                                        // Format date as YYYY-MM-DD
                                        const newDate = date.toISOString().split('T')[0];

                                        // Update URL and reload
                                        currentUrl.searchParams.set('week', newDate);
                                        window.location.href = currentUrl.toString();
                                    }

                                    // Go to current week
                                    function goToCurrentWeek() {
                                        const currentUrl = new URL(window.location);
                                        currentUrl.searchParams.delete('week');
                                        window.location.href = currentUrl.toString();
                                    }

                                    // Show add shift modal
                                    function showAddShiftModal(userId, date) {
                                        console.log("Opening modal for userId:", userId, "date:", date);

                                        // Clear any previously selected shifts
                                        const checkboxes = document.querySelectorAll('input[name="shiftIds"]');
                                        checkboxes.forEach(checkbox => {
                                            checkbox.checked = false;
                                        });

                                        // Set the userId and date in the form
                                        document.getElementById('userId').value = userId;
                                        document.getElementById('date').value = date;

                                        // For debugging
                                        console.log("Form userId:", document.getElementById('userId').value);
                                        console.log("Form date:", document.getElementById('date').value);

                                        // Show the modal
                                        const modal = new bootstrap.Modal(document.getElementById('addShiftModal'));
                                        modal.show();
                                    }
                                    // Show create shift modal and hide add shift modal
                                    function showCreateShiftModal() {
                                        const addShiftModal = bootstrap.Modal.getInstance(document.getElementById('addShiftModal'));
                                        addShiftModal.hide();

                                        // Store reference to the previous modal
                                        sessionStorage.setItem('previousModal', 'addShiftModal');

                                        // Clear form fields
                                        document.getElementById('shiftName').value = '';
                                        document.getElementById('startTime').value = '';
                                        document.getElementById('endTime').value = '';
                                        document.getElementById('totalTimeDisplay').textContent = '0 giờ';

                                        setTimeout(() => {
                                            const modal = new bootstrap.Modal(document.getElementById('createShiftModal'));
                                            modal.show();
                                        }, 500);
                                    }

                                    // Handle closing createShiftModal and returning to addShiftModal
                                    document.getElementById('createShiftModal').addEventListener('hidden.bs.modal', function () {
                                        const previousModalId = sessionStorage.getItem('previousModal');
                                        if (previousModalId === 'addShiftModal') {
                                            const modal = new bootstrap.Modal(document.getElementById('addShiftModal'));
                                            modal.show();
                                            sessionStorage.removeItem('previousModal'); // Remove reference after reopening
                                        }
                                    });

                                    // Add this to your existing JavaScript section
                                    function validateShiftForm() {
                                        // Check if at least one shift is selected
                                        if ($('input[name="shiftIds"]:checked').length === 0) {
                                            toastr.error('Vui lòng chọn ít nhất một ca làm việc');
                                            return false;
                                        }
                                        return true;
                                    }
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                function getExistingShiftNames() {
                    let shiftNames = [];

                    // Lấy tất cả các ca làm việc từ danh sách checkbox trong modal "Thêm ca làm việc"
                    document.querySelectorAll("input[name='shiftIds']").forEach(checkbox => {
                        let label = document.querySelector("label[for='" + checkbox.id + "']");
                        if (label) {
                            let shiftName = label.textContent.trim().split('(')[0].trim(); // Lấy tên ca làm việc, bỏ thời gian trong ngoặc
                            shiftNames.push(shiftName.toLowerCase());
                        }
                    });

                    return shiftNames;
                }

                // Fix form submission event listener
                document.querySelector("form[action='addnewshift']").addEventListener("submit", function (e) {
                    let shiftName = document.getElementById("shiftName").value.trim();
                    let startTime = document.getElementById("startTime").value;
                    let endTime = document.getElementById("endTime").value;
                    if (shiftName === "") {
                        toastr.error("Please enter shift name.");
                        e.preventDefault(); // Ngăn form gửi đi
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
                    // Check if name already exists
                    const existingNames = getExistingShiftNames();
                    if (existingNames.includes(shiftName.toLowerCase())) {
                        toastr.error("Shift name already exists. Please use a different name.");
                        e.preventDefault();
                        return;
                    }
                    sessionStorage.setItem('previousModal', 'addShiftModal');
                });

                // Improved total time calculation
                function calculateTotalTime() {
                    let startTimeInput = document.getElementById('startTime');
                    let endTimeInput = document.getElementById('endTime');

                    if (!startTimeInput.value || !endTimeInput.value) {
                        document.getElementById('totalTimeDisplay').textContent = '0 giờ';
                        return;
                    }

                    let start = new Date('1970-01-01T' + startTimeInput.value);
                    let end = new Date('1970-01-01T' + endTimeInput.value);

                    let diff = (end - start) / (1000 * 60 * 60); // Convert to hours

                    // Handle overnight shifts
                    if (diff < 0) {
                        diff += 24;
                    }

                    // Format with 2 decimal places and use Vietnamese text
                    document.getElementById('totalTimeDisplay').textContent = diff.toFixed(2) + ' giờ';
                }

                // Add event listeners for time inputs
                document.getElementById('startTime').addEventListener('change', calculateTotalTime);
                document.getElementById('endTime').addEventListener('change', calculateTotalTime);

                // Initialize with default values when modal is shown
                document.getElementById('createShiftModal').addEventListener('shown.bs.modal', function () {
                    // Set default values if empty
                    let startTimeInput = document.getElementById('startTime');
                    let endTimeInput = document.getElementById('endTime');

                    if (!startTimeInput.value)
                        startTimeInput.value = "07:00";
                    if (!endTimeInput.value)
                        endTimeInput.value = "11:00";

                    calculateTotalTime();
                });

                // Make calculateTotalTime function available globally
                window.calculateTotalTime = calculateTotalTime;
            });
        </script>

        <script>
            // Function to delete a shift
            function deleteShift(userId, date, shiftName) {
                if (confirm("Bạn có chắc chắn muốn xóa ca làm này?")) {
                    console.log("Deleting shift: userId=" + userId + ", date=" + date + ", shiftName=" + shiftName);
                    $.ajax({
                        url: 'deleteshift',
                        type: 'POST',
                        data: {
                            userId: userId,
                            date: date,
                            shiftName: shiftName,
                            week: '${startDate}' // Pass current week for reference
                        },
                        dataType: 'json',
                        success: function (response) {
                            if (response.success) {
                                toastr.success('Xóa ca làm thành công');
                                // Reload the page to refresh the schedule
                                setTimeout(function () {
                                    window.location.href = 'schedule?week=${startDate}';
                                }, 1000);
                            } else {
                                toastr.error('Xóa ca làm thất bại: ' + response.message);
                            }
                        },
                        error: function () {
                            toastr.error('Có lỗi xảy ra khi xóa ca làm');
                        }
                    });
                }
            }
        </script>
        <!-- Add this at the end of your JSP body -->
        <c:if test="${not empty sessionScope.toastMessage}">
            <script>
                $(document).ready(function () {
                    const toastType = "${sessionScope.toastType}";
                    const toastMessage = "${sessionScope.toastMessage}";

                    if (toastType === "success") {
                        toastr.success(toastMessage);
                    } else if (toastType === "error") {
                        toastr.error(toastMessage);
                    } else {
                        toastr.info(toastMessage);
                    }
                });
            </script>
            <% 
            // Remove the message attributes to avoid showing them again on refresh
            session.removeAttribute("toastMessage");
            session.removeAttribute("toastType");
            %>
        </c:if>
        <script src="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
        <script src="${pageContext.request.contextPath}/js/custom.js"></script>
        <!--<script src="${pageContext.request.contextPath}/js/demo.js"></script>-->


        <script src="${pageContext.request.contextPath}/modules/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/popper.js"></script>
        <script src="${pageContext.request.contextPath}/modules/tooltip.js"></script>
        <!--<script src="${pageContext.request.contextPath}/modules/bootstrap/js/bootstrap.min.js"></script>-->
        <script src="${pageContext.request.contextPath}/modules/nicescroll/jquery.nicescroll.min.js"></script>
        <script src="${pageContext.request.contextPath}/modules/scroll-up-bar/dist/scroll-up-bar.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sa-functions.js"></script>
    </body>
</html>