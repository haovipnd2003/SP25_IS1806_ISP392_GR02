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
        <style>
            .schedule-table {
                width: 100%;
                text-align: center;
            }
            .schedule-header {
                background-color: #f8f9fa;
                font-weight: bold;
            }
            .shift-cell {
                background-color: #e7f1ff;
                border-radius: 5px;
                padding: 3px;
                margin: 2px;
                display: inline-block;
            }
            .shifts-container {
                display: flex;
                flex-wrap: wrap;
                gap: 3px;
                justify-content: center;
            }
            .shift-container {
                position: relative;
                text-align: center;
            }
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
            .today {
                background-color: #d4edda !important; /* Màu xanh nhạt */
                font-weight: bold;
            }
            .no-shift {
                color: #bbb; /* Làm mờ chữ */
                font-style: italic;
            }

        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h3>Lịch làm việc</h3>
            <div class="d-flex justify-content-between mb-3">
                <input type="text" id="searchEmployee" class="form-control w-25" placeholder="Tìm kiếm nhân viên">
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
                        <th>Nhân viên</th>
                            <c:forEach var="i" begin="0" end="6">
                            <th>${days[i]} <br> ${dates[i]}</th>
                            </c:forEach>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="employee" items="${employees}">
                        <tr class="employee-row">
                            <td>${employee.fullname}  </td>

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
                                                        <div class="shift-cell">${shift}</div>
                                                    </c:forEach>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="no-shift" style="${currentDate eq todayDate ? 'opacity: 0.5;' : ''}">Không có ca</div>
                                            </c:otherwise>
                                        </c:choose>
                                        <button class="btn btn-sm btn-light add-shift-btn" 
                                                onclick="showAddShiftModal('${employee.id}', '${currentDate}')">+ Thêm ca</button>
                                    </div>
                                </td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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
                            <div class="mb-3">
                                <label class="form-label">Chọn ca làm việc</label>
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
                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </form>
                    </div>
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
        </script>
    </body>
</html>