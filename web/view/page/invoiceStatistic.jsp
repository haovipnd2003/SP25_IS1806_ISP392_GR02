<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Hóa đơn bán</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/invoiceStatistic.css">
       
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
                                    <th>Tên</th>
                                    <th>Quy Cách</th>
                                    <th>Số Lượng</th>
                                    <th>Tổng Khối Lượng</th>
                                    <th>Giá 1 Cân</th>
                                    <th>Giảm Giá(đ)</th>
                                    <th>Giá Thành</th>
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
    // Wait for the document to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Get the close button in the modal
    const closeButton = document.querySelector('#invoiceDetailModal .close');
    
    // Add click event listener to the close button
    if (closeButton) {
        closeButton.addEventListener('click', function() {
            // Use Bootstrap's modal method to hide the modal
            $('#invoiceDetailModal').modal('hide');
        });
    }
    
    // Alternative: You can also close the modal when clicking outside of it
    // This is usually enabled by default in Bootstrap, but we can ensure it works
    $('#invoiceDetailModal').on('click', function(event) {
        if (event.target === this) {
            $(this).modal('hide');
        }
    });
    
    // You can also add keyboard support to close with the Escape key
    $(document).on('keydown', function(event) {
        if (event.key === 'Escape' && $('#invoiceDetailModal').hasClass('show')) {
            $('#invoiceDetailModal').modal('hide');
        }
    });
});
    
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
