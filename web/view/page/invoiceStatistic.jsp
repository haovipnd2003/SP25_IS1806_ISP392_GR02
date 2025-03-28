<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Quản lý hóa đơn</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

        <style>
            /* Reduced base font size */
            html, body {
                font-size: 14px; /* Reduced from 16px to 14px */
            }

            /* Modern Card Styling */
            .card {
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                border: none;
                margin-bottom: 24px;
            }

            .card-header {
                background-color: #fff;
                border-bottom: 1px solid #f1f1f1;
                padding: 18px 22px; /* Slightly reduced padding */
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .card-header h2 {
                margin: 0;
                font-size: 1.6rem; /* Reduced from 1.8rem */
                font-weight: 600;
                color: #333;
            }

            .card-body {
                padding: 20px; /* Reduced from 24px */
            }

            /* Table Styling */
            .table {
                width: 100%;
                margin-bottom: 0;
                font-size: 0.95rem; /* Reduced from 1.05rem */
            }

            /* More specific selector for thead background */
            .table thead {
                background-color: #95c9f0bd !important;
            }

            .table thead tr {
                background-color: #95c9f0bd !important;
            }

            .table thead th {
                background-color: #95c9f0bd !important;
                font-weight: 600;
                color: #2c5282;
                border-top: none;
                padding: 14px 10px; /* Reduced from 16px 12px */
                white-space: nowrap;
            }

            .table td {
                padding: 12px 10px; /* Reduced from 16px 12px */
                vertical-align: middle;
            }

            .table-hover tbody tr:hover {
                background-color: #f8f9fa;
                transition: background-color 0.2s ease;
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #fcfcfc;
            }

            /* Filter Inputs */
            .filter-input {
                margin-top: 6px; /* Reduced from 8px */
                font-size: 13px; /* Reduced from 14px */
            }

            .form-control-sm {
                border-radius: 4px;
                border: 1px solid #e2e8f0;
                padding: 5px 8px; /* Reduced from 6px 10px */
                font-size: 12px; /* Reduced from 14px */
                background-color: #f9fafc;
            }

            .form-control-sm:focus {
                background-color: #fff;
                border-color: #4299e1;
                box-shadow: 0 0 0 2px rgba(66, 153, 225, 0.2);
            }

            /* Range inputs on same row */
            .range-inputs {
                display: flex;
                gap: 6px; /* Reduced from 8px */
            }

            .range-inputs input {
                flex: 1;
            }

            /* Action Buttons */
            .btn-action {
                padding: 5px 8px; /* Reduced from 6px 10px */
                border-radius: 4px;
                transition: all 0.2s;
                font-size: 13px; /* Reduced from 14px */
            }

            .btn-info {
                background-color: #4299e1;
                border-color: #4299e1;
            }

            .btn-info:hover {
                background-color: #3182ce;
                border-color: #3182ce;
            }

            /* Total Row */
            .total-row {
                font-weight: 600;
                background-color: #f8fafc !important;
                border-top: 2px solid #e2e8f0;
                font-size: 1rem; /* Reduced from 1.1rem */
            }

            .total-row td {
                color: #2d3748;
            }

            /* Pagination */
            .pagination-container {
                display: flex;
                justify-content: center;
                margin-top: 20px; /* Reduced from 24px */
            }

            .pagination {
                display: flex;
                padding-left: 0;
                list-style: none;
                border-radius: 0.25rem;
                font-size: 0.95rem; /* Reduced from 1.05rem */
            }

            .page-item:first-child .page-link {
                border-top-left-radius: 4px;
                border-bottom-left-radius: 4px;
            }

            .page-item:last-child .page-link {
                border-top-right-radius: 4px;
                border-bottom-right-radius: 4px;
            }

            .page-link {
                position: relative;
                display: block;
                padding: 0.45rem 0.7rem; /* Reduced from 0.5rem 0.75rem */
                margin-left: -1px;
                line-height: 1.25;
                color: #4299e1;
                background-color: #fff;
                border: 1px solid #e2e8f0;
                transition: all 0.2s;
            }

            .page-link:hover {
                z-index: 2;
                color: #2b6cb0;
                text-decoration: none;
                background-color: #f7fafc;
                border-color: #e2e8f0;
            }

            .page-item.active .page-link {
                z-index: 3;
                color: #fff;
                background-color: #4299e1;
                border-color: #4299e1;
            }

            .page-item.disabled .page-link {
                color: #a0aec0;
                pointer-events: none;
                cursor: not-allowed;
                background-color: #fff;
                border-color: #e2e8f0;
            }

            /* Money formatting */
            .money {
                font-family: 'Roboto Mono', monospace;
                text-align: right;
            }

            /* Section titles */
            h4 {
                font-size: 1.25rem; /* Reduced from 1.4rem */
                font-weight: 600;
                color: #2d3748;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .card-header {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .table-responsive {
                    border: 0;
                }

                .range-inputs {
                    flex-direction: column;
                }
            }

            .btn-search {
                background-color: #4299e1; /* Changed to requested blue color */
                color: white;
                border: none;
                border-radius: 4px; /* Added slight rounding */
                width: 40px;
                height: 40px;
                display: flex;
                justify-content: center;
                align-items: center;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn-search:hover {
                background-color: #3182ce; /* Darker blue on hover */
            }

            /*POP-UP*/
            /* Modal styling */
            .modal-content {
                border-radius: 8px;
                border: none;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .modal-header {
                border-bottom: 1px solid #f1f1f1;
                background-color: #f8fafc;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
                padding: 15px 20px;
            }

            .modal-title {
                font-weight: 600;
                color: #2c5282;
                font-size: 1.25rem;
            }

            .modal-body {
                padding: 20px;
            }

            .modal-footer {
                border-top: 1px solid #f1f1f1;
                padding: 15px 20px;
            }

            .invoice-info {
                background-color: #f8fafc;
                padding: 15px;
                border-radius: 6px;
                margin-bottom: 20px;
            }

            .invoice-info p {
                margin-bottom: 8px;
            }

            /* Make sure the modal appears on top of everything */
            .modal {
                z-index: 1050;
            }

            /* Center the modal vertically */
            @media (min-width: 576px) {
                .modal-dialog {
                    margin: 1.75rem auto;
                }
            }

            /* Make modal larger on bigger screens */
            @media (min-width: 992px) {
                .modal-lg {
                    max-width: 800px;
                }
            }

            /* Animation for modal */
            .modal.fade .modal-dialog {
                transition: transform 0.3s ease-out;
                transform: translate(0, -25px);
            }

            .modal.show .modal-dialog {
                transform: translate(0, 0);
            }

            /* Print button styling */
            #printInvoiceBtn {
                background-color: #4299e1;
                border-color: #4299e1;
            }

            #printInvoiceBtn:hover {
                background-color: #3182ce;
                border-color: #3182ce;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <div class="main-wrapper">
                <jsp:include page="/view/common/nav_bar.jsp"></jsp:include>
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>

                    <div class="main-content" style="min-height: 600px;">
                        <section class="section">
                            <div class="section-body">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h2>Quản lý hóa đơn</h2>
                                            </div>
                                            <div class="card-body">
                                                <form action="${pageContext.request.contextPath}/invoiceStatistic" method="post">
                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    <h4 class="mb-0">Danh sách hóa đơn</h4>
                                                </div>
                                                <div class="table-responsive">
                                                    <table class="table table-striped table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>
                                                                    Mã hóa đơn
                                                                    <div class="filter-input">
                                                                        <input type="text" name="invoiceId" class="form-control form-control-sm" placeholder="Tìm kiếm mã..." value="${invoiceId}">
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Thời gian
                                                                    <div class="filter-input">
                                                                        <input type="datetime-local" name="createdAt" class="form-control form-control-sm" value="${createdAt}">
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Khách hàng
                                                                    <div class="filter-input">
                                                                        <input type="text" name="customerName" class="form-control form-control-sm" placeholder="Tìm kiếm khách hàng..."value="${customerName}">
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Người tạo
                                                                    <div class="filter-input">
                                                                        <input type="text" name="userName" class="form-control form-control-sm" placeholder="Tìm kiếm người tạo..."value="${userName}">
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Tổng tiền
                                                                    <div class="filter-input">
                                                                        <div class="range-inputs">
                                                                            <input type="text" name="totalAmountMin" class="form-control form-control-sm money-format" placeholder="Từ..." oninput="formatCurrency(this)"value="${totalAmountMin}">
                                                                            <input type="text" name="totalAmountMax" class="form-control form-control-sm money-format" placeholder="Đến..." oninput="formatCurrency(this)"value="${totalAmountMax}">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Khách trả
                                                                    <div class="filter-input">
                                                                        <div class="range-inputs">
                                                                            <input type="text" name="customerPayMin" class="form-control form-control-sm money-format" placeholder="Từ..." oninput="formatCurrency(this)"value="${customerPayMin}">
                                                                            <input type="text" name="customerPayMax" class="form-control form-control-sm money-format" placeholder="Đến..." oninput="formatCurrency(this)"value="${customerPayMax}">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    <button type="submit" class="btn-search">
                                                                        <i class="fas fa-search"></i>
                                                                    </button>
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:choose>
                                                                <c:when test="${not empty listOrders}">
                                                                    <c:forEach var="orders" items="${requestScope.listOrders}">
                                                                        <tr>
                                                                            <td><c:out value="${orders.getId()}"></c:out></td>
                                                                            <td><c:out value="${orders.getCreatedAt()}"></c:out></td>
                                                                            <td><c:out value="${orders.getCusName()}"></c:out></td>
                                                                            <td><c:out value="${orders.getUserName()}"></c:out></td>
                                                                            <td class="money"><c:out value="${orders.getTotalAmount()}"></c:out> ₫</td>
                                                                            <td class="money"><c:out value="${orders.getCustomerPay()}"></c:out> ₫</td>
                                                                                <td>
                                                                                    <button class="btn btn-sm btn-info btn-action" title="Xem chi tiết">
                                                                                        <i class="fas fa-eye"></i>
                                                                                    </button>
                                                                                </td>
                                                                            </tr>
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <tr>
                                                                        <td colspan="7" class="text-center">Không có hóa đơn nào phù hợp với tìm kiếm.</td>
                                                                    </tr>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </form>

                                            <!-- Pagination -->
                                            <c:if test="${not empty listOrders && listOrders.size() > 0}">
                                                <div class="pagination-container">
                                                    <c:if test="${totalPages >= 1}">


                                                        <ul class="pagination">
                                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                                <a class="page-link" href="invoiceStatistic?page=1&invoiceId=${param.invoiceId}&createdAt=${param.createdAt}&customerName=${param.customerName}&userName=${param.userName}" aria-label="First">
                                                                    &laquo;&laquo;
                                                                </a>
                                                            </li>
                                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                                <a class="page-link" href="invoiceStatistic?page=${currentPage - 1}&invoiceId=${param.invoiceId}&createdAt=${param.createdAt}&customerName=${param.customerName}&userName=${param.userName}" aria-label="Previous">
                                                                    &laquo;
                                                                </a>
                                                            </li>

                                                            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                                    <a class="page-link" href="invoiceStatistic?page=${i}&invoiceId=${param.invoiceId}&createdAt=${param.createdAt}&customerName=${param.customerName}&userName=${param.userName}">${i}</a>
                                                                </li>
                                                            </c:forEach>

                                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                                <a class="page-link" href="invoiceStatistic?page=${currentPage + 1}&invoiceId=${param.invoiceId}&createdAt=${param.createdAt}&customerName=${param.customerName}&userName=${param.userName}" aria-label="Next">
                                                                    &raquo;
                                                                </a>
                                                            </li>
                                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                                <a class="page-link" href="invoiceStatistic?page=${totalPages}&invoiceId=${param.invoiceId}&createdAt=${param.createdAt}&customerName=${param.customerName}&userName=${param.userName}" aria-label="Last">
                                                                    &raquo;&raquo;
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </c:if>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>

        <!-- Add this modal HTML structure at the end of your body tag, before the closing </body> -->
        <!-- Add this modal HTML structure at the end of your body tag, before the closing </body> -->
        <div class="modal fade" id="invoiceDetailModal" tabindex="-1" role="dialog" aria-labelledby="invoiceDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="invoiceDetailModalLabel">Chi tiết hóa đơn</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <table border="1">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Name</th>
                                    <th>Product Packaging</th>
                                    <th>Quantity</th>
                                    <th>Total Mass</th>
                                    <th>Price of 1 Kg</th>
                                    <th>Discount(đ)</th>
                                    <th>Amount Money</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Content will be loaded here -->

                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>

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
    </body>
</html>

<script>
    // Hàm định dạng số tiền khi nhập
    function formatCurrency(input) {
        var cursorPos = input.selectionStart;

        var value = input.value.replace(/[^\d]/g, '');

        var originalLength = input.value.length;

        if (value) {
            // Định dạng số với dấu phân cách hàng nghìn
            value = parseInt(value, 10).toLocaleString('vi-VN');
            input.value = value;
        } else {
            input.value = '';
        }

        var newLength = input.value.length;
        cursorPos = cursorPos + (newLength - originalLength);
        input.setSelectionRange(cursorPos, cursorPos);
    }

    // Hàm chuyển đổi giá trị đã định dạng về số nguyên khi submit form
    function parseFormattedNumber(value) {
        if (!value)
            return '';
        return value.replace(/[^\d]/g, '');
    }

    $(document).ready(function () {
        // Format các trường tiền tệ khi trang tải
        $('.money-format').each(function () {
            formatCurrency(this);
        });

        // Gắn sự kiện input vào tất cả ô nhập
        $(".filter-input input").on("keypress", function (event) {
            // Kiểm tra nếu phím Enter được nhấn (mã phím 13)
            if (event.which === 13) {
                event.preventDefault(); // Ngăn chặn hành vi mặc định của phím Enter
                $("form").submit(); // Gửi form
            }
        });


        // Xử lý trước khi submit form
        $("form").on("submit", function () {
            // Chuyển đổi các giá trị đã định dạng về số nguyên
            $('.money-format').each(function () {
                var rawValue = parseFormattedNumber($(this).val());
                $(this).val(rawValue);
            });
            return true; // Cho phép form submit
        });
    });

    // Định dạng các số tiền hiển thị trong bảng
    $(document).ready(function () {
        $('.money').each(function () {
            var text = $(this).text();
            var value = text.replace(/[^\d]/g, '');
            if (value) {
                $(this).text(parseInt(value, 10).toLocaleString('vi-VN') + ' ₫');
            }
        });
    });



    //Ham 500ms sau khi nguoi dùng nhập sẽ gửi tới servlet
    let typingTimer; // Timer identifier
// Thêm sự kiện input cho tất cả các ô nhập
    $(".filter-input input").on("input", function () {
        clearTimeout(typingTimer); // Xóa timer cũ nếu có

        const form = $(this).closest('form'); // Lấy form cha

        // Thiết lập timer mới
        typingTimer = setTimeout(function () {
            form.submit(); // Gửi form sau 300ms
        }, 300);
    });


//POP-UP
    $(document).ready(function () {
    $('.btn-info.btn-action').on('click', function (e) {
        e.preventDefault();

        var row = $(this).closest('tr');
        var invoiceId = row.find('td:eq(0)').text().trim();

        // Hiển thị modal trước khi dữ liệu được tải
        $('#invoiceDetailModal').modal('show');

        // Xóa dữ liệu cũ trong bảng chi tiết
        $('#invoiceDetailModal tbody').html('<tr><td colspan="8" class="text-center">Đang tải dữ liệu...</td></tr>');

        // Gửi AJAX request đến servlet để lấy dữ liệu hóa đơn
        $.ajax({
            url: '${pageContext.request.contextPath}/invoiceStatisticDetail',
            type: 'POST',
            data: { invoiceId: invoiceId },
            success: function (response) {
                $('#invoiceDetailModal tbody').html(response); // Chèn HTML nhận từ servlet
            },
            error: function () {
                $('#invoiceDetailModal tbody').html('<tr><td colspan="8" class="text-center text-danger">Lỗi tải dữ liệu.</td></tr>');
            }
        });
    });
});

</script>
