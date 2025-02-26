<%-- 
    Document   : saleInterface
    Created on : 23 thg 2, 2025, 15:12:12
    Author     : binh2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>POS System</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            }

            body {
                background-color: #f8f9fa;
            }

            .container {
                display: flex;
                min-height: 100vh;
            }

            .main-content {
                flex: 1;
                padding: 20px;
                background: white;
                border-right: 1px solid #e5e7eb;
            }

            .header {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
                align-items: center;
            }

            .search-box {
                flex: 1;
                position: relative;
            }

            .search-box input {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #e5e7eb;
                border-radius: 4px;
                padding-left: 35px;
            }

            .search-box::before {
                content: "🔍";
                position: absolute;
                left: 12px;
                top: 50%;
                transform: translateY(-50%);
                color: #6b7280;
            }

            .tab-button {
                padding: 8px 16px;
                border: 1px solid #e5e7eb;
                background: white;
                border-radius: 4px;
                cursor: pointer;
            }

            .product-table {
                width: 100%;
                border-collapse: collapse;
            }

            .product-table th,
            .product-table td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #e5e7eb;
            }

            .product-table th {
                background: #f9fafb;
                font-weight: 500;
                color: #374151;
            }

            .product-table td {
                color: #1f2937;
            }

            .amount {
                text-align: right;
            }

            .sidebar {
                width: 400px;
                padding: 20px;
                background: white;
            }

            .customer-info {
                margin-bottom: 30px;
            }

            .customer-info h2 {
                font-size: 1.25rem;
                margin-bottom: 10px;
            }

            .customer-note {
                color: #6b7280;
                font-size: 0.875rem;
            }

            .totals {
                margin-bottom: 30px;
            }

            .total-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                padding: 5px 0;
            }

            .total-row.final {
                font-weight: 500;
                font-size: 1.1em;
            }

            .payment-methods {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 10px;
                margin-bottom: 20px;
            }

            .payment-method {
                padding: 15px;
                text-align: center;
                border: 1px solid #e5e7eb;
                border-radius: 4px;
                cursor: pointer;
            }

            .payment-method.selected {
                border-color: #2563eb;
                color: #2563eb;
            }

            .quick-amounts {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 8px;
                margin-bottom: 20px;
            }

            .amount-button {
                padding: 12px;
                border: 1px solid #e5e7eb;
                background: white;
                border-radius: 4px;
                cursor: pointer;
            }

            .pay-button {
                width: 100%;
                padding: 16px;
                background: #2563eb;
                color: white;
                border: none;
                border-radius: 4px;
                font-weight: 500;
                cursor: pointer;
            }

            .pay-button:hover {
                background: #1d4ed8;
            }
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="main-content">
                <div class="header">
                    <div class="search-box">
                        <input oninput="searchPro(this)" type="text" name="searchPro" placeholder="Tìm hàng hóa...">
                    </div>
                </div>

                <!--Table Search-->
                <div>
                    <table class="product-table" id="contentPro">
                        <tbody>
                            <!-- Nội dung tìm kiếm -->

                        </tbody>
                    </table>    
                </div>



                <div class="product-section">
                    <table class="product-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Product Packaging</th>
                                <th>Quantity</th>
                                <th>Total Mass</th>
                                <th>Price of 1 Kg</th>
                                <th>Discount (%)</th>
                                <th>Amount Money</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="productTableBody">
                            <!-- Product COntent -->
                        </tbody>
                    </table>
                </div>

            </div>


            <div class="sidebar">
                <!--SEARCH CUSTOMER-->
                <div>
                    <div class="search-box">
                        <input oninput="search(this)" type="text" name="search" placeholder="Tìm khách hàng...">
                    </div>
                </div>
                <br>
                <!--Table Search-->
                <div>
                    <table class="product-table" id="content">
                        <tbody>
                            <!-- Nội dung tìm kiếm -->

                        </tbody>
                    </table>    
                </div>


                <div class="customer-info">
                    <h2>Name customer</h2>
                    <p class="customer-note">SDT: </p>
                    <p class="customer-note">Address: </p>
                </div>

                <div class="totals">
                    <div class="total-row">
                        <span>Tổng tiền hàng</span>
                        <span>00.0</span>
                    </div>
                    <div class="total-row final">
                        <span>Khách cần trả</span>
                        <span><input type="text" name="khachTra" value="" /></span>
                    </div>
                </div>

                <div class="payment-methods">
                    <button class="payment-method selected" onclick="selectPaymentMethod(this)">Trả tất</button>
                    <button class="payment-method" onclick="selectPaymentMethod(this)">Trả một phần</button>
                    <button class="payment-method" onclick="selectPaymentMethod(this)">Nợ</button>
                </div>


                <button class="pay-button">THANH TOÁN</button>
            </div>
        </div>
    </body>
</html>

<script>
    function search(param) {
        var searchValue = param.value;
        $.ajax({
            url: "/RiceManagement/searchCustomer",
            type: "get",
            data: {key: searchValue},
            success: function (data) {
                var row = document.getElementById("content");
                row.innerHTML = data;
            }
        });
    }
    function searchPro(param) {
        var searchValue = param.value;
        $.ajax({
            url: "/RiceManagement/searchProduct",
            type: "get",
            data: {key: searchValue},
            success: function (data) {
                var row = document.getElementById("contentPro");
                row.innerHTML = data;
            }
        });
    }


    //Choose Customer Information
    function choose(customerId) {
        // Get data
        var name = document.getElementById('cName_' + customerId).value;
        var phone = document.getElementById('cPhone_' + customerId).value;
        var address = document.getElementById('cAddress_' + customerId).value;

        // Set data to customer info div
        document.querySelector('.customer-info h2').textContent = name;
        document.querySelector('.customer-info p:nth-child(2)').textContent = 'Phone: ' + phone;
        document.querySelector('.customer-info p:nth-child(3)').textContent = 'Address: ' + address;
        var row = document.getElementById("content");
        row.innerHTML = '';
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
        } else {
            // Khi số lượng thay đổi, cập nhật total mass
            const row = input.closest('tr');
            calculateTotalMass(row);
        }
        calculateTotal(input);

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
                    '<td><input type="text" class="quantity-input underline-input" oninput="checkQuantityMin(this); calculateTotal(this); " /></td>' +
                    '<td>Total mass in here</td>' +
                    '<td><span>' + price.toFixed(2) + '</span></td>' +
                    '<td><input type="text" class="discount-input underline-input" oninput="checkDiscount(this); calculateTotal(this);" /></td>' +
                    '<td><span class="total-amount">0.00</span></td>' +
                    '<td><button onclick="removeProduct(this)">Remove</button></td>';

            tableBody.appendChild(newRow);
            currentId++;

            // Tính toán total mass ban đầu với giá trị mặc định (nếu cần)
            const select = newRow.querySelector('select');
            if (select) {
                handleSelectChange(select);
            }
        } else {
            console.log("Error: Name not found or is empty.");
        }
    }


    //Create Product Packaging
    function createDropdown() {
        return `<select onchange="handleSelectChange(this);">
                                                        <option value="kg">kg</option>
                                                        <option value="10">Bao 10kg</option>
                                                         <option value="25">Bao 25kg</option>
                                                        <option value="50"  selected   >Bao 50kg</option>
                                                            <option value="70">Bao 70kg</option>
                                                                </select>`;
    }

    //Check quantity and product money when staff change data
    function handleSelectChange(select) {

        checkQuantity(select);
        const row = select.closest('tr');
        calculateTotalMass(row);
        calculateTotal(select);
    }


    //Check Product packaging Options
    function checkQuantity(select) {
        const row = select.closest('tr');
        var inputField = select.parentElement.nextElementSibling.querySelector('.quantity-input');
        if (select.value === 'kg' || ['10', '25', '50', '70'].includes(select.value)) {
            inputField.style.display = 'block';
        } else {
            inputField.style.display = 'none';
            inputField.value = '';
            calculateTotal(select);
            calculateTotalMass(row);
        }
    }


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





    //Calculate Product Money
    function calculateTotal(element) {
        var row = element.closest('tr');
        var price = parseFloat(row.querySelector('td:nth-child(6) span').textContent);
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


    // Hàm cập nhật tổng tiền hàng & khách cần trả
    function calculateGrandTotal() {
        var rows = document.getElementById('productTableBody').getElementsByTagName('tr');
        var grandTotal = 0;

        for (let row of rows) {
            var totalText = row.querySelector('.total-amount').textContent;
            var totalAmount = parseFloat(totalText.replace(/\./g, '')) || 0;
            grandTotal += totalAmount;
        }

        // Format tiền tệ (VD: 13,819,000)
        var formattedTotal = formatMoney(grandTotal);

        // Cập nhật giá trị trong thẻ <span> của Tổng tiền hàng
        document.querySelector('.totals .total-row:first-child span:last-child').textContent = formattedTotal + '$';

        // Cập nhật giá trị trong ô input "khách cần trả"
        document.querySelector('.totals .final input[name="khachTra"]').value = formattedTotal + '$';
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


// Calculate total mass based on product packaging and quantity
    function calculateTotalMass(row) {
        const packagingSelect = row.querySelector('select');
        const quantityInput = row.querySelector('.quantity-input');
        const totalMassCell = row.querySelector('td:nth-child(5)'); // Thẻ td chứa "Total mass in here"

        if (!packagingSelect || !quantityInput || !totalMassCell) {
            console.error("Required elements not found in the row:", {
                packagingSelect: !!packagingSelect,
                quantityInput: !!quantityInput,
                totalMassCell: !!totalMassCell
            });
            return 0;
        }

        const packagingValue = packagingSelect.value;
        const quantity = parseFloat(quantityInput.value) || 0;
        let totalMass = 0;

        // Calculate total mass based on packaging type
        if (packagingValue === "kg") {
            // If packaging is kg, total mass equals quantity
            totalMass = quantity;
        } else {
            // If packaging is by bag, multiply bag size by quantity
            const bagSize = parseFloat(packagingValue);
            totalMass = bagSize * quantity;
        }



        // Display the total mass in the cell - ĐÂY LÀ DÒNG QUAN TRỌNG
        totalMassCell.textContent = totalMass + " kg";

        return totalMass;
    }
    
        function selectPaymentMethod(button) {
        // Xóa lớp 'selected' khỏi tất cả các nút
        const buttons = document.querySelectorAll('.payment-method');
        buttons.forEach(btn => btn.classList.remove('selected'));
        
        // Thêm lớp 'selected' vào nút được chọn
        button.classList.add('selected');
    }
    

</script>
