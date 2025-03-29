<%-- 
    Document   : fund
    Created on : Mar 23, 2025, 11:36:13 AM
    Author     : anhdv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>
<%@page import="entity.CashManager" %>
<%@page import="entity.Cash" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý quỹ</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.6/css/selectize.bootstrap3.min.css" integrity="sha256-ze/OEYGcFbPRmvCnrSeKbRTtjG4vGLHXgOqsyLFTRjg=" crossorigin="anonymous" />
        <link href="css/fund.css" rel="stylesheet" type="text/css"/>
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
                                                <h2>Danh sách phiếu thu chi</h2>
                                                
                                                
                                            </div>
                                            <div class="card-body">
                                                <form action="${pageContext.request.contextPath}/fund" method="post">
                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    
<%
     List<Cash> listCash = (List<Cash>) request.getAttribute("listCash_total");
    double totalThu = 0, totalChi = 0, totalQuydauky = 0, totalQuy = 0;
    if (listCash != null) {
       
        for (Cash cash : listCash) {
            double amount = cash.getAmount();
            if (amount > 0) {
                totalThu += amount;
            } else {
                totalChi += Math.abs(amount);
            }
           // out.println("Cash ID: " + cash.getId() + ", Amount: " + cash.getAmount() + "<br>");
        }
    }

    totalQuy = totalQuydauky + totalThu - totalChi;

%>

                                
            <!-- Card Tổng tiền -->
            <div class="row col-md-12 mb-4">
                <div class="col-md-3">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <h5 class="card-title">Quỹ đầu kỳ</h5>
                            <p class="card-text"><%= String.format("%,.0f", totalQuydauky) %> VNĐ</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <h5 class="card-title">Tổng Tiền Thu</h5>
                            <p class="card-text"><%= String.format("%,.0f", totalThu) %> VNĐ</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-danger">
                        <div class="card-body">
                            <h5 class="card-title">Tổng Tiền Chi</h5>
                            <p class="card-text"><%= String.format("%,.0f", totalChi) %> VNĐ</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <h5 class="card-title">Tổng Quỹ</h5>
                            <p class="card-text"><%= String.format("%,.0f", totalQuy) %> VNĐ</p>
                        </div>
                    </div>
                </div>
            </div>

                                                </div>
                                               <div class="d-flex mb-2 justify-content-lg-end">
                                                        <button type="button" class="btn mr-3 btn-ctrl btn-open-modal">
                                                            Lập phiếu thu
                                                        </button>
                                                        <button type="button" class="btn btn-ctrl btn-open-modal">
                                                            Lập phiếu chi
                                                        </button>
                                                    </div>
                                                <div class="table-responsive">
                                                    <table class="table table-striped table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>
                                                                    Mã phiếu
                                                                    <div class="filter-input">
                                                                        <input type="text" name="cashId" class="form-control form-control-sm" placeholder="Tìm kiếm mã..." value="${cashId}">
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Thời gian
                                                                    <div class="filter-input">
                                                                        <input type="datetime-local" name="time" class="form-control form-control-sm" value="${time}">
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Loại thu chi
                                                                    <div class="filter-input">
                                                                        <input type="text" name="typeName" class="form-control form-control-sm" placeholder="Tìm kiếm loại..."value="${typeName}">
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Giá trị
                                                                    <div class="filter-input">
                                                                        <input type="text" name="amount" class="form-control form-control-sm" placeholder="Tìm kiếm giá trị..."value="${amount}">
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Người nộp/nhận
                                                                    <div class="filter-input">
                                                                        <input type="text" name="employeeName" class="form-control form-control-sm" placeholder="Tìm kiếm người nộp/nhận..."value="${employeeName}">
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Tên khách hàng
                                                                    <div class="filter-input">
                                                                        <div class="range-inputs">
                                                                            <input type="text" name="customerName" class="form-control form-control-sm" placeholder="Tìm kiếm khách hàng..."value="${customerName}">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th>
                                                                    Ghi chú
                                                                    <div class="filter-input">
                                                                        <div class="range-inputs">
                                                                            <input type="text" name="note" class="form-control form-control-sm" placeholder="Tìm kiếm ghi chú..."value="${note}">
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
                                                                <c:when test="${not empty listCash}">
                                                                    <c:forEach var="cash" items="${requestScope.listCash}">
                                                                        <tr>
                                                                            <td><c:out value="${cash.getId()}"></c:out></td>
                                                                            <td><c:out value="${cash.getTime()}"></c:out></td>
                                                                            <td><c:out value="${cash.getTypeName()}"></c:out></td>
                                                                            <td class="money"><c:out value="${cash.getAmount()}"></c:out> ₫</td>
                                                                            <td><c:out value="${cash.getEmployeeName()}"></c:out></td>
                                                                            <td><c:out value="${cash.getCustomerName()}"></c:out></td>
                                                                            <td><c:out value="${cash.getNote()}"></c:out></td>
                                                                            </tr>
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <tr>
                                                                        <td colspan="7" class="text-center">Không có phiếu thu chi nào phù hợp với tìm kiếm.</td>
                                                                    </tr>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </form>

                                            <!-- Pagination -->
                                            <c:if test="${not empty listCash && listCash.size() > 0}">
                                                <div class="pagination-container">
                                                    <c:if test="${totalPages >= 1}">
                                                        <ul class="pagination">
                                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                                <a class="page-link" href="fund?page=1&id=${param.id}&customerName=${param.customerName}&employeeName=${param.employeeName}" aria-label="First">
                                                                    &laquo;&laquo;
                                                                </a>
                                                            </li>
                                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                                <a class="page-link" href="fund?page=${currentPage - 1}&id=${param.id}&customerName=${param.customerName}&employeeName=${param.employeeName}" aria-label="Previous">
                                                                    &laquo;
                                                                </a>
                                                            </li>

                                                            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                                    <a class="page-link" href="fund?page=${i}&id=${param.id}&customerName=${param.customerName}&employeeName=${param.employeeName}">${i}</a>
                                                                </li>
                                                            </c:forEach>

                                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                                <a class="page-link" href="fund?page=${currentPage + 1}&id=${param.id}&customerName=${param.customerName}&employeeName=${param.employeeName}" aria-label="Next">
                                                                    &raquo;
                                                                </a>
                                                            </li>
                                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                                <a class="page-link" href="fund?page=${totalPages}&id=${param.id}&customerName=${param.customerName}&employeeName=${param.employeeName}" aria-label="Last">
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
        <div class="modal fade" id="fundModal" tabindex="-1" role="dialog" aria-labelledby="fundModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="fundModalLabel"></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form class="form-signin" action="${pageContext.request.contextPath}/cash" method="post">
                        <div class="modal-body">
                            <div class="d-flex justify-content-between">
                                <div class="w-50 mr-5">
                                    <div class="d-flex justify-content-between">
                                        <label class="w-30">Thời gian</label>
                                        <div class="w-70" >
                                            <input type="datetime-local" style="width: 200px" name="time" class="form-control form-control-sm" value="${createdAt}">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2">
                                        <label id="fundTypeTitle"></label>
                                        <div class="w-70" >
                                            <select style="width: 200px" name="type" id="select-type" placeholder="Pick a type...">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2">
                                        <label>Giá trị</label>
                                        <div class="w-70" >
                                            <input type="text" name="amount" style="width: 200px" class="form-control form-control-sm">
                                        </div>
                                    </div>
                                </div>
                                <div class="w-50">
                                    <div class="d-flex justify-content-between">
                                        <label>Nhân viên thu/chi</label>
                                        <div class="w-70" >
                                            <select style="width: 200px" id="select-emp" name="empId" placeholder="Pick a employee...">
                                                <option value=""></option>
                                                <c:forEach var="emp" items="${employees}"> 
                                                    <option value="${emp.id}">${emp.name}</option>
                                                </c:forEach> 
                                            </select>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2">
                                        <label>Tên khách hàng</label>
                                        <div class="w-70">
                                            <select style="width: 200px" id="select-cus" name="cusId" placeholder="Pick a customer...">
                                                <option value=""></option>
                                                <c:forEach var="customer" items="${customers}"> 
                                                    <option value="${customer.id}">${customer.name}</option>
                                                </c:forEach> 
                                            </select>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2">
                                        <label>Ghi chú</label>
                                        <div class="w-70" >
                                            <input type="text" name="note" style="width: 200px" class="form-control form-control-sm">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-ctrl">Lưu</button>
                        </div>
                    </form>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.6/js/standalone/selectize.min.js" integrity="sha256-+C0A5Ilqmu4QcSPxrlGpaZxJ04VjsRjKu+G82kl5UJk=" crossorigin="anonymous"></script>
        <script>
            //POP-UP
            $(document).ready(function () {
                let optionsIn = [
                    {value: '0', text: 'Thu tiền khách trả'},
                    {value: '1', text: 'Khác'}
                ];
                let optionsOut = [
                    {value: '2', text: 'Chi trả NCC'},
                    {value: '3', text: 'Khác'}
                ];
                $('select').selectize({
                    sortField: 'text'
                });
                $('button.close').on('click', function (e) {
                    $('#fundModal').modal('toggle');
                });
                $('.btn.btn-open-modal').on('click', function (e) {
                    e.preventDefault();
                    
                    let type = 'chi';
                    let selectize = $('#select-type')[0].selectize;
                    selectize.clearOptions();
                    console.log(selectize);
                    if ($(this).index() === 0) {
                        type = 'thu';
                        selectize.addOption(optionsIn);
                    } else {
                        selectize.addOption(optionsOut);
                    }
                    $('#fundModalLabel').text('Lập phiếu ' + type);
                    $('#fundTypeTitle').text('Loại ' + type);
                    
                    $('#fundModal').modal('toggle');
                });
            });
           
        </script>
    </body>
</html>
