<%-- 
    Document   : sale
    Created on : 16 thg 2, 2025, 00:34:41
    Author     : binh2
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/invoiceInterface.css">
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
                                        <h2>Invoice</h2>
                                    </div>
                                    <div class="invoice-form">
                                        <div class="invoice-date">
                                            <label>Date created: </label>
                                            <span id="invoiceDate"></span>
                                        </div>
                                        <!-- Phần thông tin khách hàng -->
                                        <div class="section">
                                            <div class="section-title">Customer Information</div>
                                            <div class="search-group">
                                                <label>Search Customer: </label>
                                                <input type="text" name="search" placeholder="Name or Phone Number">
                                                <button onclick="search()">Search</button>
                                            </div>
                                            <table id="content">
                                                <tbody>
                                                    <!-- Nội dung tìm kiếm -->
                                                </tbody>
                                            </table>
                                            <div class="customer-info">
                                                <input type="text" name="CustomerName" placeholder="Customer Name" class="underline-input">
                                                <input type="text" name="CustomerPhone" placeholder="Phone Number" class="underline-input">
                                                <input type="text" name="CustomerAddress" placeholder="Address" class="underline-input">
                                                <button type="button" onclick="confirmSelection()">Confirm</button>
                                            </div>
                                        </div>

                                        <!-- Phần thông tin sản phẩm và danh sách mua hàng -->
                                        <div class="section">
                                            <div class="section-title">Product Infomation</div>
                                            <div class="search-group">
                                                <label>Search Product: </label>
                                                <input type="text" name="searchPro" placeholder="Name or Describe">
                                                <button onclick="searchPro()">Search</button>
                                            </div>
                                            <table id="contentPro">
                                                <tbody>
<!--                                                    Content-->
                                                </tbody>
                                            </table>

                                            <div class="product-section">
                                                <table class="product-table">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Name</th>
                                                            <th>Product Packaging</th>
                                                            <th>Quantity</th>
                                                            <th>Price of 1 Kg</th>
                                                            <th>Discount</th>
                                                            <th>Amount Money</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="productTableBody">
                                                        <!-- Product COntent -->
                                                    </tbody>
                                                </table>

                                                <div class="total-section">
                                                    <div>
                                                        <label>Number of Porters:</label>
                                                        <input type="number" name="porter" value="0" min="0" oninput="validity.valid||(value='');">
                                                    </div>
                                                    <div style="font-size: 18px; margin-top: 10px;">
                                                        <strong>Total Money: </strong>
                                                        <span id="grandTotal">0.00</span>
                                                    </div>
                                                </div>

                                                <div class="payment-method">
                                                    <strong>Payment method: </strong>
                                                    <label>
                                                        <input type="radio" name="payment" value="debt"> Debt
                                                    </label>
                                                    <label>
                                                        <input type="radio" name="payment" value="direct"> Direct
                                                    </label>
                                                </div>

                                                <a href="#" class="create-invoice-btn">Create Invoice</a>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>

                                                   //Search Customer Infomation
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


                                                    //Choose Customer Information
                                                    function choose(customerId) {
                                                        // Get data
                                                        var name = document.getElementById('cName_' + customerId).value;
                                                        var phone = document.getElementById('cPhone_' + customerId).value;
                                                        var address = document.getElementById('cAddress_' + customerId).value;

                                                        // Set data to input 
                                                        document.querySelector('input[name="CustomerName"]').value = name;
                                                        document.querySelector('input[name="CustomerPhone"]').value = phone;
                                                        document.querySelector('input[name="CustomerAddress"]').value = address;
                                                    }


                                                    //Confirm Customer Information
                                                    function confirmSelection() {
                                                        // Get data
                                                        var customerNameInput = document.querySelector('input[name="CustomerName"]');
                                                        var customerPhoneInput = document.querySelector('input[name="CustomerPhone"]');
                                                        var customerAddressInput = document.querySelector('input[name="CustomerAddress"]');

                                                        // change readonly
                                                        customerNameInput.readOnly = true;
                                                        customerPhoneInput.readOnly = true;
                                                        customerAddressInput.readOnly = true;

                                                        // Delete result rows
                                                        document.getElementById("content").innerHTML = '';
                                                    }

                                                    //Search Product Information
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

                                                    var currentId = 1;
                                                    
                                                    //Choose Product Information
                                                    function choosePro(productId) {
                                                        var name = document.getElementById('pName_' + productId).value;
                                                        var price = parseFloat(document.getElementById('pPrice_' + productId).value);

                                                        var tableBody = document.getElementById('productTableBody');
                                                        var newRow = document.createElement('tr');

                                                        if (name) {
                                                            newRow.innerHTML = '<td>' + currentId + '</td>' +
                                                                    '<td>' + name + '</td>' +
                                                                    '<td>' + createDropdown() + '</td>' +
                                                                    '<td><input type="text" class="quantity-input underline-input" oninput="checkQuantityMin(this); calculateTotal(this);" /></td>' +
                                                                    '<td><span>' + price.toFixed(2) + '</span></td>' +
                                                                    '<td><input type="text" class="discount-input underline-input" oninput="checkDiscount(this); calculateTotal(this);" /></td>' +
                                                                    '<td><span class="total-amount">0.00</span></td>' +
                                                                    '<td><button onclick="removeProduct(this)">Remove</button></td>';

                                                            tableBody.appendChild(newRow);
                                                            currentId++;
                                                        } else {
                                                            console.log("Error: Name not found or is empty.");
                                                        }
                                                    }

                                                    //Create Product Packaging
                                                    function createDropdown() {
                                                        return `<select onchange="handleSelectChange(this)">
                                                     <option value="">Chọn quy cách</option>
                                                        <option value="kg">kg</option>
                                                        <option value="10">Bao 10kg</option>
                                                         <option value="25">Bao 25kg</option>
                                                        <option value="50">Bao 50kg</option>
                                                            <option value="70">Bao 70kg</option>
                                                                </select>`;
                                                    }

                                                    //Check quantity and product money when staff change data
                                                    function handleSelectChange(select) {
                                                        checkQuantity(select);
                                                        calculateTotal(select);
                                                    }

                                                    //Check Product packaging Options
                                                    function checkQuantity(select) {
                                                        var inputField = select.parentElement.nextElementSibling.querySelector('.quantity-input');
                                                        if (select.value === 'kg' || ['10', '25', '50', '70'].includes(select.value)) {
                                                            inputField.style.display = 'block';
                                                        } else {
                                                            inputField.style.display = 'none';
                                                            inputField.value = '';
                                                            calculateTotal(select);
                                                        }
                                                    }
                                                    

                                                    //Calculate Product Money
                                                    function calculateTotal(element) {
                                                        var row = element.closest('tr');
                                                        var price = parseFloat(row.querySelector('td:nth-child(5) span').textContent);
                                                        var quantity = parseFloat(row.querySelector('.quantity-input').value) || 0;
                                                        var dropdown = row.querySelector('select');
                                                        var discount = parseFloat(row.querySelector('.discount-input').value) || 0;

                                                        var totalAmount = 0;

                                                        if (dropdown.value === 'kg') {
                                                            totalAmount = price * quantity;
                                                        } else if (dropdown.value) {
                                                            totalAmount = price * quantity * parseFloat(dropdown.value);
                                                        }

                                                        if (discount > 0) {
                                                            totalAmount -= (totalAmount * (discount / 100));
                                                        }

                                                        // Format money
                                                        row.querySelector('.total-amount').textContent = formatMoney(totalAmount);
                                                        calculateGrandTotal();
                                                    }


                                                    //Calculate Total After Plus All Money
                                                    function calculateGrandTotal() {
                                                        var rows = document.getElementById('productTableBody').getElementsByTagName('tr');
                                                        var grandTotal = 0;

                                                        for (let row of rows) { //repeat row and change string to number
                                                            var totalText = row.querySelector('.total-amount').textContent;
                                                            var totalAmount = parseFloat(totalText.replace(/\./g, '')) || 0;
                                                            grandTotal += totalAmount;
                                                        }

                                                        // Format Money
                                                        document.getElementById('grandTotal').textContent = formatMoney(grandTotal);
                                                    }

                                                    //Remove Product
                                                    function removeProduct(button) {
                                                        var row = button.parentNode.parentNode;
                                                        row.parentNode.removeChild(row);
                                                        updateId();
                                                        calculateGrandTotal();
                                                    }

                                                    //Update ID when removing product
                                                    function updateId() {
                                                        var rows = document.getElementById('productTableBody').getElementsByTagName('tr');
                                                        let newId = 1;

                                                        for (let i = 0; i < rows.length; i++) {
                                                            rows[i].children[0].textContent = newId;
                                                            newId++;
                                                        }

                                                        currentId = newId;
                                                    }

                                                    //Validate discount must >= 0 and <=10
                                                    function checkDiscount(input) {
                                                        var discountValue = parseFloat(input.value);
                                                        if (discountValue > 10 || discountValue < 0) {
                                                            alert("Chiết khấu vượt quá 10% và nhỏ hơn 0%");
                                                            input.value = '';
                                                            calculateTotal(input);
                                                        }
                                                    }

                                                    //Validate quantity must >=0
                                                    function checkQuantityMin(input) {
                                                        var quantityValue = parseFloat(input.value);
                                                        if (quantityValue < 0) {
                                                            alert("Số lượng không được nhỏ hơn 0");
                                                            input.value = '';
                                                            calculateTotal(input);
                                                        }
                                                    }

                                                    // Function to get server time
                                                    function getServerTime() {
                                                        $.ajax({
                                                            url: "/RiceManagement/getServerTime",
                                                            type: "get",
                                                            success: function (data) {
                                                                document.getElementById("invoiceDate").innerHTML = data;
                                                            }
                                                        });
                                                    }

                                                    // Call the function when page loads
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        getServerTime();
                                                        // Update time every minute
                                                        setInterval(getServerTime, 60000);
                                                    });

                                                    //Format money (1.000.000)
                                                    function formatMoney(number) {
                                                        // Change number to text
                                                        let numStr = Math.floor(number).toString();
                                                        // Change to array and revert
                                                        let reversed = numStr.split('').reverse();
                                                        // add digit after three nd number
                                                        let withDots = reversed.reduce((acc, digit, index) => {
                                                            if (index > 0 && index % 3 === 0) {
                                                                return acc + '.' + digit;
                                                            }
                                                            return acc + digit;
                                                        }, '');

                                                        // revert number
                                                        return withDots.split('').reverse().join('');
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

