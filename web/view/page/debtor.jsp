<%-- 
    Document   : debtor
    Created on : Feb 19, 2025, 8:45:42 AM
    Author     : vietanhdang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Quản lý phiếu nợ</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
        <style>
            button {
                cursor: pointer;
            }
            /* The Modal (background) */
            .modal {
                display: none; /* Hidden by default */
                position: fixed;
                z-index: 1;
                padding-top: 100px;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.4);
            }

            /* Modal Content */
            .modal-content {
                max-width: 800px;
                background-color: #fefefe;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
            }
            
            .modal-content .row {
                width: 70%;
                margin: 5px 0;
                justify-content: space-between;
            }
            
            .modal-content .row input {
                width: 60%;
            }
            
            .modal-content .row #type-cbx {
                width: 60%;
                height: 28px;
            }
            
            .display-flex-center {
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .display-flex-al-center {
                display: flex;
                align-items: center;
            }
            
            .justify-space-between {
                justify-content: space-between;
            }

            /* The Close Button */
            .close {
                color: #aaaaaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }
            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            } 
            
            .table-list-content {
                width: 100%;
                margin: 15px 0;
            }
            
            input#negative {
                width: 18px;
                height: 18px;
                filter: hue-rotate(142deg);
                margin-right: 15px;
            }
            
            input#positive {
                width: 18px;
                height: 18px;
                filter: hue-rotate(276deg);
            }
             /* Table styles for clear columns and rows */
            .table {
                width: 100%;
                border-collapse: collapse; /* Ensure borders collapse for clean lines */
            }

            .table-grey {
                background-color: #f5f5f5; /* Light gray header background */
                font-weight: bold; /* Bold header text */
            }

            .table th {
                background-color: #007bff; /* Blue background for header */
                color: white; /* White text for header */
                border: 1px solid #dee2e6; /* Light gray borders for cells */
                padding: 12px; /* Increased padding for better spacing */
                text-align: left; /* Align text to the left for consistency */
                vertical-align: middle; /* Center text vertically */
                font-weight: bold; /* Bold header text */
            }

            .table td {
                border: 1px solid #dee2e6; /* Light gray borders for cells */
                padding: 12px; /* Increased padding for better spacing */
                text-align: left; /* Align text to the left for consistency */
                vertical-align: middle; /* Center text vertically */
            }

            .table th {
                background-color: #f5f5f5; /* Match header background */
                color: #333; /* Darker text for headers */
            }

            .table tr {
                border-bottom: 1px solid #dee2e6; /* Light gray line between rows */
            }

            .table tr:last-child {
                border-bottom: none; /* Remove bottom border for the last row */
            }
.pagination-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.pagination {
    display: flex;
    list-style: none;
    padding: 0;
}

.page-item {
    margin: 0 5px;
}

.page-link {
    display: block;
    padding: 8px 12px;
    text-decoration: none;
    color: #007bff;
    border: 1px solid #ddd;
    border-radius: 5px;
    transition: all 0.3s;
}

.page-link:hover {
    background-color: #007bff;
    color: white;
}

.page-item.active .page-link {
    background-color: #007bff;
    color: white;
    border-color: #007bff;
}


        </style>
    </head>

    <body>
        <div id="app">
            <div class="main-wrapper">
                <div class="navbar-bg"></div>
                
                <jsp:include page="/view/common/nav_bar.jsp"></jsp:include>
                <!--MAIN-SIDEBAR-JSP-INCLUDE-->
                <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
                <!--MAIN-SIDEBAR-JSP-INCLUDE-->
                <!--MAIN CONTENT-->
                <div class="main-content" style="min-height: 600px;">
                    <section class="section">
                        <div class="section-body">
                            <div class="row">
                                <div class="col-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h2>Quản lý khách hàng</h2>
                                        </div>
                                        <div class="card-body">
                                            <!-- Trigger/Open The Modal -->
                                            <div class="display-flex-al-center justify-space-between">
                                                <form action="${pageContext.request.contextPath}/debtor.do" method="get">
                    <input id="search-field" type="text" name="keyword" value="${keyword}" style="    font-size: 18px;">
                                                    <button class="btn btn-info" type="submit">Tìm kiếm</button>
                                                </form>
                                                <button class="btn btn-warning" id="addBtn" onclick="openModal('debtor', null, 'khách hàng')">Thêm khách hàng</button>
                                            </div>
                                        
                                             <div class="table-responsive">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                    <th>ID</th> 
                                                    <th>Tên</th> 
                                                    <th>Điện thoại</th> 
                                                    <th>Email</th> 
                                                    <th>Địa chỉ</th>
                                                    <th>Tổng nợ</th>
                                                    <th>Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:choose>
                                                                <c:when test="${empty debtorList || debtorList.size() == 0}">
                                                                    <!-- No customers found, table body remains empty -->
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:forEach items="${debtorList}" var="lc">
                                                                        <tr>
                                                                            <td>${lc.id}</td>
                                                                            <td>${lc.name}</td>
                                                                            <td>${lc.phone}</td>
                                                                            <td>${lc.email}</td>
                                                                            <td>${lc.address}</td>
                                                                             <td>${lc.getTotalDebtString()}</td>
                                                                            <td>
                                                                                <div class="action-buttons">
                                                                                 <button class="btn btn-primary" 
                                                                                        onclick="openUpdateDebtorModal('${lc.id}', '${lc.name}', '${lc.phone}', '${lc.email}', '${lc.address}', '${lc.totalDebt}')">
                                                                                    Cập nhật
                                                                                </button>
 
                                                                                <button class="btn btn-warning"  onclick="openModal('debenture', '${lc.id}', 'phiếu nợ')">
                                                                                      Thêm phiếu nợ
                                                                                 </button>
                                                                                     <a  href="debenture.do?debtorId=${lc.id}"><button class="btn btn-info" >Chi tiết</button></a> 
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </tbody>
                                                    </table>
                                                </div>
<div class="pagination-container">
    <ul class="pagination">
       <c:if test="${currentPage == 1}">
            <li class="page-item">
                <a class="page-link disabled" href="debtor.do?keyword=${keyword}&page=1" style="border: none;color: #ccc; pointer-events: none; background-color: #f8f9fa; border-color: #ddd; cursor: not-allowed;"><<</a>
            </li>
            <li class="page-item">
                <a class="page-link disabled" href="debtor.do?keyword=${keyword}&page=${currentPage - 1}" style="border: none;color: #ccc; pointer-events: none; background-color: #f8f9fa; border-color: #ddd; cursor: not-allowed;">Trang trước</a>
            </li>
        </c:if>
        <c:if test="${currentPage > 1}">
            <li class="page-item">
                <a class="page-link" href="debtor.do?keyword=${keyword}&page=1"><<</a>
            </li>
            <li class="page-item">
                <a class="page-link" href="debtor.do?keyword=${keyword}&page=${currentPage - 1}">Trang trước</a>
            </li>
        </c:if>

        <c:forEach begin="1" end="${noOfPages}" var="i">
            <li class="page-item ${currentPage eq i ? 'active' : ''}">
                <a class="page-link" href="debtor.do?keyword=${keyword}&page=${i}">${i}</a>
            </li>
        </c:forEach>

        <c:if test="${currentPage lt noOfPages}">
            <li class="page-item">
                <a class="page-link" href="debtor.do?keyword=${keyword}&page=${currentPage + 1}">Tiếp</a>
            </li>
            <li class="page-item">
                <a class="page-link" href="debtor.do?keyword=${keyword}&page=${noOfPages}">>></a>
            </li>
        </c:if>
    </ul>
</div>


                                         
                                            <!-- Modal Debtor (Add/Update) -->
                                            <div id="debtor" class="modal">
                                                <div class="modal-content">
                                                    <div class="display-flex-al-center justify-space-between">
                                                        <h3></h3>
                                                        <div class="close" onclick="closeModal('debtor')">&times;</div>
                                                    </div>
                                                    <form id="debtorForm" class="form-signin" action="${pageContext.request.contextPath}/debtor.do" method="post">
                                                        <input id="id" style="display: none;" name="id" type="text"/>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Tên đầy đủ</h6>
                                                            <input id="name" name="name" type="text"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Địa chỉ</h6>
                                                            <input id="address" name="address" type="text"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Điện thoại</h6>
                                                            <input id="phone" name="phone" type="text"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Email</h6>
                                                            <input id="email" name="email" type="text"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Tổng nợ</h6>
                                                            <input id="debt" name="debt" type="text" readonly/>
                                                        </div>
                                                        <button style="width: 80px; margin-top: 5px;" type="submit">Thêm</button>
                                                    </form>
                                                </div>
                                            </div>

                                            <!-- Modal Debenture -->
                                            <div id="debenture" class="modal">
                                                <div class="modal-content">
                                                    <div class="display-flex-al-center justify-space-between">
                                                        <h3></h3>
                                                        <div class="close" onclick="closeModal('debenture')">&times;</div>
                                                    </div>
                                                    <!-- Đặt id="debentureForm" để bắt sự kiện submit -->
                                                    <form id="debentureForm" class="form-signin" action="${pageContext.request.contextPath}/debenture.do" method="post">
                                                        <input id="debtor" style="display: none;" name="debtor" type="text"/>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Ghi chú</h6>
                                                            <input name="note" type="text"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Loại phiếu</h6>
                                                            <select name="type" id="type-cbx">
                                                                <option value="0">Khách hàng vay nợ</option>
                                                                <option value="1">Khách hàng thanh toán</option>
                                                                <option value="0">Nợ</option>
                                                                <option value="1">Trả tiền khách hàng</option>
                                                            </select>
<!--                                                            <div class="display-flex-al-center" style="width: 60%;">
                                                                <input id="negative" type="radio" name="type" value="0" checked>
                                                                <input id="positive" type="radio" name="type" value="1">
                                                            </div>-->
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Số tiền</h6>
                                                            <input name="amount" type="text"/>
                                                        </div>
                                                        <div class="row display-flex-al-center">
                                                            <h6>Ngày tạo</h6>
                                                            <input name="created" type="date"/>
                                                        </div>
                                                        <button style="width: 80px; margin-top: 5px;" type="submit">Lưu</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                     </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>

        <!-- jQuery từ Google (không trùng lặp) -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
        <script>
            // Lấy giá trị search từ URL nếu có
            let url_string = window.location.href; 
            let url = new URL(url_string);
            let keyword = url.searchParams.get("keyword");
            if (keyword) {
                $("#search-field").val(keyword);
            }

            function closeModal(name) {
                $("#" + name + ".modal").hide();
            }

            function openModal(name, debtorIdToAddDebenture, nameVi) {
                $("#"+ name +".modal h3").html('Thêm ' + nameVi);
                $("#"+ name +".modal button[type='submit']").html('Thêm');
                
                // Reset các ô nhập cho modal Debtor
                $("#debtor.modal input#id").val("");
                $("#debtor.modal input#name").val("");
                $("#debtor.modal input#phone").val("");
                $("#debtor.modal input#email").val("");
                $("#debtor.modal input#address").val("");
                $("#debtor.modal input#debt").val("0").prop("readonly", true);
                
                $("#"+ name +".modal").css('display', 'block');
                
                if (debtorIdToAddDebenture) {
                    $("#debenture.modal input#debtor").val(debtorIdToAddDebenture);
                }
            }

            function openUpdateDebtorModal(id, name, phone, email, address, totalDebt) {
                $("#debtor.modal h3").html('Cập nhật khách hàng');
                $("#debtor.modal button[type='submit']").html('Sửa');
                
                $("#debtor.modal input#id").val(id);
                $("#debtor.modal input#name").val(name);
                $("#debtor.modal input#phone").val(phone);
                $("#debtor.modal input#email").val(email);
                $("#debtor.modal input#address").val(address);
                $("#debtor.modal input#debt").val(totalDebt).prop("readonly", true);
                
                $("#debtor.modal").css('display', 'block');
            }

            // Bắt sự kiện submit của form Debtor (Add/Update)
            $(document).ready(function(){
                $("#debtorForm").on("submit", function(e) {
                    var name = $("#debtor.modal input#name").val().trim();
                    var phone = $("#debtor.modal input#phone").val().trim();
                    var email = $("#debtor.modal input#email").val().trim();
                    var address = $("#debtor.modal input#address").val().trim();

                    if(name === "" || phone === "" || email === "" || address === "") {
                        alert("Please fill information complete!");
                        e.preventDefault();
                        return;
                    }

                    e.preventDefault();
                    $.ajax({
                        url: $(this).attr("action"),
                        type: "POST",
                        data: $(this).serialize(),
                        success: function(response) {
                            alert("Save successfully!");
                            window.location.href = "${pageContext.request.contextPath}/debtor.do";
                        },
                        error: function(xhr, status, error) {
                            alert("Có lỗi xảy ra: " + error);
                        }
                    });
                });

                // Bắt sự kiện submit của form Debenture
                $("#debentureForm").on("submit", function(e) {
                    // Ví dụ kiểm tra trường Amount, có thể bổ sung kiểm tra các trường khác nếu cần
                    var amount = $("input[name='amount']").val().trim();
                    if(amount === ""){
                        alert("Please fill in the amount!");
                        e.preventDefault();
                        return;
                    }
                    e.preventDefault();
                    $.ajax({
                        url: $(this).attr("action"),
                        type: "POST",
                        data: $(this).serialize(),
                        success: function(response) {
                            alert("Save successfully!");
                            window.location.href = "${pageContext.request.contextPath}/debtor.do";
                        },
                        error: function(xhr, status, error) {
                            alert("Có lỗi xảy ra: " + error);
                        }
                    });
                });
            });
        </script>

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
        <script src="${pageContext.request.contextPath}/js/demo.js"></script>
    </body>
</html>
