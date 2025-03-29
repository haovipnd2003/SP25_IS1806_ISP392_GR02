<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <!--<title>Components &rsaquo; Toastr &mdash; Stisla</title>-->

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <style>
            .btn-search {
                background-color: #28a745;
                border-color: #28a745;
                color: white;
            }
            .btn-ban {
                background-color: #dc3545; 
                border-color: #dc3545;
                color: white;             
                margin-left: 5px;         
            }
            .action-buttons {
                display: flex;
                flex-direction: row;
                gap: 5px;
            }
        
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 5px;
            }

            .pagination-btn {
                display: inline-block;
                padding: 8px 14px; 
                margin: 0 2px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: #fff;
                color: #333;
                text-decoration: none;
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.3s, color 0.3s;
                white-space: nowrap; 
            }

            .pagination-btn.active {
                background-color: #007bff; 
                color: white;
                border-color: #007bff;
                cursor: default;
            }

            .pagination-btn:disabled,
            .pagination-btn.disabled {
                background-color: transparent; 
                color: #999; 
                border: none;
                cursor: not-allowed;
                pointer-events: none; 
            }

            .pagination-btn:hover:not(.disabled):not(.active) {
                background-color: #e9ecef;
                border-color: #adb5bd;
            }
          
            .no-customers-message {
                text-align: center;
                color: #dc3545; 
                margin-top: 20px;
                font-size: 16px;
            }
        
            .table {
                width: 100%;
                border-collapse: collapse;
            }

            .table-grey {
                background-color: #f5f5f5; 
                font-weight: bold;
            }

            .table th {
                background-color: #007bff; 
                color: white; 
                border: 1px solid #dee2e6; 
                padding: 12px; 
                text-align: left;
                vertical-align: middle; 
                font-weight: bold; 
            }

            .table td {
                border: 1px solid #dee2e6; 
                padding: 12px;
                text-align: left;
                vertical-align: middle; 
            }

            .table th {
                background-color: #f5f5f5; /* Match header background */
                color: #333; /* Darker text for headers */
            }

            .table tr {
                border-bottom: 1px solid #dee2e6; 
            }

            .table tr:last-child {
                border-bottom: none; 
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
                                                <h2><a href="customer" style="text-decoration: none; color: inherit;">Khách hàng</a></h2>
                                            </div>
                                            <div class="card-body">
                                                <form action="customer" method="get" class="mb-4">
                                                    <input type="hidden" name="action" value="add">
                                                    <button type="submit" class="btn btn-primary">
                                                        + Thêm Khách hàng</button>
                                                </form>
                                            <%--<c:set value="${srCus}" var="sr"></c:set>--%>
                                            <form action="searchcustomer" method="post" class="mb-4">
                                                <div class="form-row">
                                                    <div class="col">
                                                        <input type="text" class="form-control" name="id" placeholder="ID" value="${requestScope.id}">
                                                    </div>
                                                    <div class="col">
                                                        <input type="text" class="form-control" name="name" placeholder="Tên" value="${requestScope.name}">
                                                    </div>
                                                    <div class="col">
                                                        <input type="text" class="form-control" name="phone" placeholder="SĐT" value="${requestScope.phone}">
                                                    </div>
                                                    <div class="col">
                                                        <input type="email" class="form-control" name="email" placeholder="Email" value="${requestScope.email}" >
                                                    </div>
                                                    <div class="col">
                                                        <input type="text" class="form-control" name="address" placeholder="Địa chỉ" value="${requestScope.address}">
                                                    </div>
                                                    <div class="col">
                                                        <button type="submit" class="btn btn-search">
                                                            <i class="fas fa-search"></i> Tìm kiếm
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                            <!-- Check for no customers message -->
                                            <c:if test="${not empty noCustomersMessage}">
                                                <div class="no-customers-message">${noCustomersMessage}</div>
                                            </c:if>

                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Tên</th>
                                                            <th>Điện Thoại</th>
                                                            <th>Email</th>
                                                            <th>Địa chỉ</th>
                                                            <th>Hành động</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:choose>
                                                            <c:when test="${empty listCus || listCus.size() == 0}">
                                                                <tr>
                                                                    <td colspan="6" class="text-center text-danger">
                                                                        Không tìm thấy khách hàng
                                                                    </td>
                                                                </tr>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:forEach items="${listCus}" var="lc">
                                                                    <tr>
                                                                        <td>${lc.id}</td>
                                                                        <td>${lc.name}</td>
                                                                        <td>${lc.phone}</td>
                                                                        <td>${lc.email}</td>
                                                                        <td>${lc.address}</td>
                                                                        <td>
                                                                            <div class="action-buttons">
                                                                                <form action="updatecustomer" method="get" style="display: inline;">
                                                                                    <input type="hidden" name="action" value="update">
                                                                                    <input type="hidden" name="id" value="${lc.id}">
                                                                                    <button type="submit" class="btn btn-primary">Update</button>
                                                                                </form>  
                                                                                <form action="bancustomer" method="get" style="display: inline;" onsubmit="return confirm('Are you sure you want to ban this customer?');">
                                                                                    <input type="hidden" name="action" value="ban">
                                                                                    <input type="hidden" name="banId" value="${lc.id}">
                                                                                    <button type="submit" class="btn btn-ban">Ban</button>
                                                                                </form>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <!-- Pagination (only show if there are customers) -->
                                            <c:if test="${not empty listCus && listCus.size() > 0}">
                                                <div class="pagination" style="margin-top: 20px; text-align: center;">
                                                    <c:if test="${totalPages > 1}">
                                                        <a href="customer?action=view&page=1" class="pagination-btn ${currentPage == 1 ? 'disabled' : ''}"><<</a>
                                                        <a href="customer?action=view&page=${currentPage - 1}" class="pagination-btn ${currentPage == 1 ? 'disabled' : ''}">Previous</a>

                                                        <c:set var="startPage" value="${currentPage - 2}"/>
                                                        <c:set var="endPage" value="${currentPage + 2}"/>

                                                        <c:if test="${startPage < 1}">
                                                            <c:set var="startPage" value="1"/>
                                                            <c:set var="endPage" value="${endPage + (1 - startPage)}"/>
                                                        </c:if>
                                                        <c:if test="${endPage > totalPages}">
                                                            <c:set var="endPage" value="${totalPages}"/>
                                                            <c:set var="startPage" value="${startPage - (endPage - totalPages)}"/>
                                                            <c:if test="${startPage < 1}">
                                                                <c:set var="startPage" value="1"/>
                                                            </c:if>
                                                        </c:if>

                                                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                            <c:choose>
                                                                <c:when test="${currentPage == i}">
                                                                    <span class="pagination-btn active">${i}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="customer?action=view&page=${i}" class="pagination-btn">${i}</a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>

                                                        <a href="customer?action=view&page=${currentPage + 1}" class="pagination-btn ${currentPage == totalPages ? 'disabled' : ''}">Next</a>
                                                        <a href="customer?action=view&page=${totalPages}" class="pagination-btn ${currentPage == totalPages ? 'disabled' : ''}">>></a>
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
                <script>
                    <c:if test="${not empty succMess}">
                                                                                    toastr.success('${succMess}');

                    </c:if>
                    <% session.removeAttribute("succMess"); %>

                </script>
            </div>
        </div>
    </body>
</html>