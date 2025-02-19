<%-- 
    Document   : sale
    Created on : 16 thg 2, 2025, 00:34:41
    Author     : binh2
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" name="viewport">
        <title>Components &rsaquo; Toastr &mdash; Stisla</title>

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
                                                <h2>Sale</h2>
                                            </div>
                                            <div class="card-body">
                                                
                                                
                                        <!----------------------CUSTOMER----------------------------->
                                                <table border="0">
                                                    <tbody>
                                                        <tr>
                                                            <td>Search Customer:</td>
                                                            <td><t></t><input type="text" name="search" value="" placeholder="name or phone"/></td>
                                                    <td><button onclick="search()">Search</button></td>
                                                    </tr>
                                                    </tbody>
                                                </table>

<!--                                                RECOMMEND ROW-->
                                                <table border="1" id="content">
                                                    <tbody>
                                                        <!--Content here-->

                                                    </tbody>
                                                </table>

                                                <!--Form CUSTOMER INFO-->
                                                <form action="##"> 
                                                    <table border="1">
                                                        <thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>Customer Name:<input type="text" name="CustomerName" value="" /></td>
                                                                <td>Phone:<input type="text" name="CustomerPhone" value="" /></td>
                                                                <td>Address:<input type="text" name="CustomerAddress" value="" /></td>
                                                                <td><button type="button" onclick="confirmSelection()">Confirm</button></td>
                                                            </tr>
                                                        </tbody>
                                                        </thead>
                                                    </table>
                                                </form>
                                                
                                                <!----------------------PRODUCT----------------------------->
                                                <table border="0">
                                                    <tbody>
                                                        <tr>
                                                            <td>Search Product:</td>
                                                            <td><t></t><input type="text" name="searchPro" value="" placeholder="name or describe"/></td>
                                                    <td><button onclick="searchPro()">Search</button></td>
                                                    </tr>
                                                    </tbody>
                                                </table>

                                                 <!--RECOMMEND ROW-->
                                                <table border="1" id="contentPro">
                                                    <tbody>
                                                        <!--Content here-->
                                                    </tbody>
                                                </table>
                                                
                                                 <!--Form PRODUCT INFO-->
                                                 <h4>Danh sách mua hàng</h4>
                                                 <table border="1">
                                                     <thead>
                                                         <tr>
                                                             <th>ID</th>
                                                             <th>NAME</th>
                                                             <th>Quy Cách</th>
                                                             <th>Số Lượng</th>
                                                             <th>Đơn Giá</th>
                                                             <th>Chiết Khấu</th>
                                                             <th>Thành tiền</th>
                                                             <th>Action</th>
                                                         </tr>
                                                     </thead>
                                                     <tbody>
                                                         <tr>
                                                             <td></td>
                                                             <td></td>
                                                             <td></td>
                                                             <td></td>
                                                             <td></td>
                                                             <td></td>
                                                             <td></td>
                                                             <td></td>
                                                         </tr>
                                                     </tbody>
                                                 </table>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>




                </div>
            </div>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <script>
                                                                    function search() {
                                                                        var searchValue = document.querySelector('input[name="search"]').value;
                                                                        $.ajax({
                                                                            url: "/RiceManagement/searchCustomer",
                                                                            type: "get",
                                                                            data: {key: searchValue},
                                                                            success: function (data) {
                                                                                var row = document.getElementById("content");
                                                                                row.innerHTML = '';
                                                                                row.innerHTML += data;
                                                                            }
                                                                        });
                                                                    }


                                                                    function choose(customerId) {
                                                                        // Lấy giá trị từ các thẻ input hidden
                                                                        var name = document.getElementById('cName_' + customerId).value;
                                                                        var phone = document.getElementById('cPhone_' + customerId).value;
                                                                        var address = document.getElementById('cAddress_' + customerId).value;

                                                                        // Điền giá trị vào các trường input trong form
                                                                        document.querySelector('input[name="CustomerName"]').value = name;
                                                                        document.querySelector('input[name="CustomerPhone"]').value = phone;
                                                                        document.querySelector('input[name="CustomerAddress"]').value = address;
                                                                    }


                                                                    function confirmSelection() {
                                                                        // Lấy các trường input
                                                                        var customerNameInput = document.querySelector('input[name="CustomerName"]');
                                                                        var customerPhoneInput = document.querySelector('input[name="CustomerPhone"]');
                                                                        var customerAddressInput = document.querySelector('input[name="CustomerAddress"]');

                                                                        // Đặt thuộc tính readonly cho các trường input
                                                                        customerNameInput.readOnly = true;
                                                                        customerPhoneInput.readOnly = true;
                                                                        customerAddressInput.readOnly = true;

                                                                        // Xóa nội dung bảng kết quả tìm kiếm
                                                                        document.getElementById("content").innerHTML = ''; // Xóa tất cả các dòng trong bảng kết quả
                                                                    }
                                                                    
                                                                    
                                                                    function searchPro() {
                                                                        var searchValue = document.querySelector('input[name="searchPro"]').value;
                                                                        $.ajax({
                                                                            url: "/RiceManagement/searchProduct",
                                                                            type: "get",
                                                                            data: {key: searchValue},
                                                                            success: function (data) {
                                                                                var row = document.getElementById("contentPro");
                                                                                row.innerHTML = '';
                                                                                row.innerHTML += data;
                                                                            }
                                                                        });
                                                                    }
                                                                    
                                                                    
                                                                    
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

