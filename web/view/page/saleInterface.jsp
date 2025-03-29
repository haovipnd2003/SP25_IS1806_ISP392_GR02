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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Invoice2.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <style>
.popup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    padding: 20px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
    display: none;
    z-index: 1000;
    border-radius: 12px;
    width: auto;
    height: auto;
    text-align: center;
}
/* Nút đóng (X) ở góc trên bên phải */
.close-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    background: none;
    border: none;
    font-size: 20px;
    cursor: pointer;
    color: red;
}

#close-popup:hover {
    color: #ff0000;
}

/* Các nút */
 .popup button {
    width: 100%;
    margin: 10px 0;
    padding: 10px;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
}

/* Màu sắc nút */
#cash-payment {
    background-color: #28a745;
    color: white;
}

#bank-payment {
    background-color: #007bff;
    color: white;
}

#close-btn {
    background-color: #dc3545;
    color: white;
}

/* Hiệu ứng hover */
.popup button:hover {
    opacity: 0.8;
}

.qr-code-container {
    text-align: center;  /* Căn giữa nội dung */
    margin-top: 10px;    /* Khoảng cách với phần trên */
}
.qr-code-container img {
    margin-top: 5px;  /* Khoảng cách giữa tiêu đề và ảnh */
}

.popup-content {
    background: white;
    padding: 20px;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.popup-content p {
    margin-bottom: 15px;
}

.btn-confirm {
    background-color: green;
    color: white;
    padding: 10px 20px;
    border: none;
    cursor: pointer;
    margin-right: 10px;
    border-radius: 5px;
}

.btn-cancel {
    background-color: red;
    color: white;
    padding: 10px 20px;
    border: none;
    cursor: pointer;
    border-radius: 5px;
}
    </style>
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
                <div class="search-container">
                    <div class="search-box">
                        <input oninput="search(this)" type="text" name="search" placeholder="Tìm khách hàng...">
                    </div>
                    <div class="add-customer-btn" onclick="openAddCustomerPopup()">+</div>
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
                        <span>00.0 vnđ</span>
                    </div>
                    <div class="total-row final">
                        <span>Khách cần trả</span>
                        <span><input type="text" name="khachTra" value="" /></span>
                    </div>
                    <div class="total-row" id="debtRow" style="display: none;">
                        <span style="font-size: 14px; color: #ff6666; font-weight: bold;">Nợ còn lại:</span>
                        <span id="debtAmount" style="font-size: 14px; color: #ff6666; font-weight: bold;">0 VND</span>
                    </div>
                </div>

                <div class="payment-methods">
                    <button class="payment-method selected" onclick="selectPaymentMethod(this)">Trả tất</button>
                    <button class="payment-method" onclick="selectPaymentMethod(this)">Trả một phần</button>
                    <button class="payment-method" onclick="selectPaymentMethod(this)">Nợ</button>
                </div>


                <button class="pay-button">THANH TOÁN</button>
        <div id="payment-popup" class="popup">
    <button id="close-popup">❌ Đóng</button>
    <div class="popup-content">
        <h3><b>Chọn phương thức thanh toán</b></h3>
        <button id="cash-payment">💵 Thanh toán tiền mặt</button>
        <button id="bank-payment">🏦 Thanh toán chuyển khoản (ATM)</button>
      
    </div>
</div>
<div id="confirmPopup" class="popup">
    <div class="popup-content">
        <p>Bạn có muốn xác nhận đơn đã thanh toán không?</p>
        <button id="confirmBtn" class="btn-confirm">Xác nhận</button>
        <button id="cancelBtn" class="btn-cancel">Hủy</button>
    </div>
</div>

            </div>
        </div>


        <!--        Nut Back to Home-->
        <a id="unique-home-button" href="view/page/dashboard.jsp" style="display: flex;align-items: center;justify-content: center;background-color: #2563eb;color: white;border: none;border-radius: 4px;padding: 8px 15px;
           cursor: pointer;font-size: 14px;text-decoration: none;position: fixed;bottom: 20px;right: 20px;z-index: 9999;box-shadow: 0 2px 4px rgba(0,0,0,0.2);">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 8px; width: 16px; height: 16px;">
            <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
            <polyline points="9 22 9 12 15 12 15 22"></polyline>
            </svg>
            Home
        </a>






        <!-- THÊM VÀO: Popup thêm khách hàng -->
        <div id="addCustomerPopup" class="popup">
            <div class="popup-content">
                <span class="close-popup" onclick="closeAddCustomerPopup()">&times;</span>
                <h3>Thêm Khách Hàng Mới</h3>
                <form id="addCustomerForm">
                    <div class="form-group">
                        <br>
                        <label for="customerName">Tên Khách Hàng:</label>
                        <input type="text" id="customerName" name="customerName" required>
                    </div>
                    <div class="form-group">
                        <label for="customerPhone">Số Điện Thoại:</label>
                        <input type="text" id="customerPhone" name="customerPhone">
                    </div>
                    <div class="form-actions">
                        <button type="button" onclick="saveCustomer()">Lưu</button>
                        <button type="button" onclick="closeAddCustomerPopup()">Hủy</button>
                    </div>
                </form>
            </div>
        </div>


        <!-- Order Confirmation Popup -->
        <div id="orderConfirmationPopup" class="popup">
            <div class="popup-content" style="width: 600px; max-height: 80vh; overflow-y: auto;">
                <span class="close-popup" onclick="closeOrderConfirmationPopup()">&times;</span>
                <h3>Xác Nhận Đơn Hàng</h3>

                <div class="confirmation-section">
                    <h4>Thông Tin Khách Hàng</h4>
                    <div id="customerSummary">
                        <p><strong>Tên:</strong> <span id="confirmCustomerName">---</span></p>
                        <p><strong>SĐT:</strong> <span id="confirmCustomerPhone">---</span></p>
                        <p><strong>Địa chỉ:</strong> <span id="confirmCustomerAddress">---</span></p>
                    </div>
                </div>

                <div class="confirmation-section">
                    <h4>Danh Sách Sản Phẩm</h4>
                    <table class="confirm-table">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Đóng Gói</th>
                                <th>Số Lượng</th>
                                <th>Tổng KL</th>
                                <th>Đơn Giá</th>
                                <th>Giảm Giá</th>
                                <th>Thành Tiền</th>
                            </tr>
                        </thead>
                        <tbody id="confirmProductList">
                            <!-- Products will be loaded here -->
                        </tbody>
                    </table>
                </div>

                <div class="confirmation-section">
                    <h4>Thanh Toán</h4>
              
                        <div class="qr-code-container" id="qrCodeContainer" style="display: none;">   
                             <h4>Quét Mã QR Để Thanh Toán</h4>
                             
                            <img src="img/QR_Code_payment.jpg" alt="QR Code" width="200">
                        </div>
                    <div id="paymentSummary">
                        <p><strong>Tổng tiền hàng:</strong> <span id="confirmTotalAmount">0 VNĐ</span></p>
                        <p><strong>Phương thức thanh toán:</strong> <span id="confirmPaymentMethod">Trả tất</span></p>
                        <p><strong>Số tiền thanh toán:</strong> <span id="confirmPaidAmount">0 VNĐ</span></p>
                        <p id="confirmDebtRow" style="color: #ff6666;"><strong>Nợ còn lại:</strong> <span id="confirmDebtAmount">0 VNĐ</span></p>
                    </div>
                </div>

                <div class="confirmation-actions">
                    <button type="button" class="confirm-button" onclick="getTableData()">Xác Nhận Thanh Toán</button>
                    <button type="button" class="cancel-button" onclick="closeOrderConfirmationPopup()">Hủy</button>
                </div>
            </div>
        </div>
  
    </body>
</html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
//-------------------------------------------------SEARCH AND CHOOSE MODULE--------------------------------------------------------------------------------------------------------------
                        var customerSearchTimeout;
                        function search(param) {
                            var searchValue = param.value;

                            // Xóa timeout cũ nếu có
                            clearTimeout(customerSearchTimeout);

                            // Tạo timeout mới - chỉ gửi request sau khi người dùng ngừng gõ 500ms
                            customerSearchTimeout = setTimeout(function () {
                                $.ajax({
                                    url: "/RiceManagement/searchCustomer",
                                    type: "get",
                                    data: {key: searchValue},
                                    success: function (data) {
                                        var row = document.getElementById("content");
                                        row.innerHTML = data;
                                    }
                                });
                            }, 300); // Đợi 500ms
                        }





                        var searchTimeout; // Biến để lưu timeout
                        function searchPro(param) {
                            var searchValue = param.value;

                            // Xóa timeout cũ nếu có
                            clearTimeout(searchTimeout);

                            // Tạo timeout mới - chỉ gửi request sau khi người dùng ngừng gõ 500ms
                            searchTimeout = setTimeout(function () {
                                $.ajax({
                                    url: "/RiceManagement/searchProduct",
                                    type: "get",
                                    data: {key: searchValue},
                                    success: function (data) {
                                        var row = document.getElementById("contentPro");
                                        row.innerHTML = data;
                                    }
                                });
                            }, 300);
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
                            document.querySelector('.search-container .search-box input[name="search"]').value = '';


                            // Gửi dữ liệu lên Servlet bằng jQuery AJAX
                            $.ajax({
                                url: "/RiceManagement/setCustomerSession",
                                type: "POST",
                                data: {name: name, phone: phone},
                                success: function (response) {
                                    console.log("Product added to session: " + response);
                                },
                                error: function (xhr, status, error) {
                                    console.log("Error: " + error);
                                }
                            });
                        }


                        var currentId = 1;

                        //Choose Product Information
                        function choosePro(productId) {
                            var productID = document.getElementById('pID_' + productId).value;
                            var name = document.getElementById('pName_' + productId).value;
                            var price = parseFloat(document.getElementById('pPrice_' + productId).value);
                            var priceFormat = formatMoney(price);
                            var tableBody = document.getElementById('productTableBody');
                            var newRow = document.createElement('tr');
                            var stockQuantity = parseInt(document.getElementById('pStock_' + productId).value); // Lấy tồn kho
                            if (name) {
                                newRow.innerHTML = '<td>' + currentId + '</td>' +
                                        '<td>' + name + '</td>' +
                                        '<td>' + createDropdown() + '</td>' +
                                        '<td><input type="text" class="quantity-input underline-input" oninput="validateQuantity(this); calculateTotal(this);"  onchange=" sendQuantityToServer(this);"/></td>' +
                                        '<td>Total mass in here</td>' +
                                        '<td><span>' + priceFormat + '</span></td>' +
                                        '<td><input type="text" class="discount-input underline-input" oninput="validateDiscount(this); calculateTotal(this);" onchange="sendDiscountToServer(this);"/></td>' +
                                        '<td><span class="total-amount">0.00</span></td>' +
                                        '<td><button class="tab-button" onclick="removeProduct(this)">Remove</button></td>' +
                                        '<td><input type="hidden" name="" value="' + productID + '" /></td>' +
                                        '<td><input type="hidden" class="stock-quantity" value="' + stockQuantity + '" /></td>';
                                tableBody.appendChild(newRow);
                                currentId++;
                                var row = document.getElementById("contentPro");
                                row.innerHTML = '';
                                document.querySelector('.header .search-box input[name="searchPro"]').value = '';


                                // Tính toán total mass ban đầu với giá trị mặc định (nếu cần)
                                const select = newRow.querySelector('select');
                                if (select) {
                                    handleSelectChange(select);
                                }

                            } else {
                                console.log("Error: Name not found or is empty.");
                            }
                        }

                        function validateQuantity(inputElement) {
                            let value = inputElement.value.replace(/\D/g, ''); // Chỉ giữ lại số

                            // Nếu chuỗi nhập vào rỗng, giữ nguyên để cho phép nhập số lớn
                            if (value === "") {
                                inputElement.value = "";
                                return;
                            }

                            let quantity = parseInt(value, 10);
                            let row = inputElement.closest('tr');
                            let stockQuantity = parseInt(row.querySelector('.stock-quantity').value) || 0;

                            if (stockQuantity === 0) {
                                quantity = 0;
                                inputElement.value = quantity;
                                inputElement.disabled = true;
                                alert("Sản phẩm này đã hết hàng!");
                                return;
                            }

                            if (quantity < 1) {
                                quantity = 1;
                                alert("Số lượng không thể nhỏ hơn 1!");
                            } else if (quantity > stockQuantity) {
                                quantity = stockQuantity;
                                alert("Số lượng không thể vượt quá tồn kho (" + stockQuantity + ")!");
                            }

                            inputElement.value = quantity;
                        }



                        function validateDiscount(inputElement) {
                            let value = inputElement.value.replace(/\D/g, ''); // Chỉ giữ lại số
                            let discount = parseInt(value) || 0; // Nếu không nhập gì, mặc định là 0

                            let row = inputElement.closest('tr');
                            let priceText = row.querySelector('td:nth-child(6) span').textContent.replace(/[,.]/g, '');
                            let price = parseFloat(priceText) || 0;

                            if (discount > price) {
                                discount = price;
                                alert("Giảm giá không thể lớn hơn giá sản phẩm!");
                            }

                            inputElement.value = discount;
                        }
//------------------------------------------CHECK VALUE IN SERVER---------------------------------------------------------------------------------------------------

                        function sendQuantityToServer(inputElement) {
                            let quantity = parseFloat(inputElement.value) || 0;
                            let row = inputElement.closest("tr");
                            let productName = row.children[1].innerText;

                            $.ajax({
                                url: "/RiceManagement/quantityCheckSever",
                                type: "POST",
                                data: {
                                    productName: productName,
                                    quantity: quantity
                                },
                                success: function (response) {
                                    if (response.trim() === "INVALID") {
                                        alert("Số lượng không thể nhỏ hơn 0!");
                                        inputElement.value = 0; // Nếu Servlet trả về lỗi, đặt lại quantity = 0
                                    }
                                },
                                error: function () {
                                    alert("Có lỗi xảy ra khi gửi dữ liệu!");
                                }
                            });
                        }



                        function sendDiscountToServer(inputElement) {
                            let discount = parseFloat(inputElement.value) || 0;
                            let row = inputElement.closest("tr");
                            let productName = row.children[1].innerText;

                            $.ajax({
                                url: "/RiceManagement/discountCheckSever",
                                type: "POST",
                                data: {
                                    productName: productName,
                                    discount: discount
                                },
                                success: function (response) {
                                    if (response.trim() === "INVALID") {
                                        alert("Discount không hợp lệ!");
                                        inputElement.value = 0;
                                    }
                                },
                                error: function () {
                                    alert("Có lỗi xảy ra khi gửi dữ liệu!");
                                }
                            });
                        }

//---------------------------------------CALCULATE IN SERVER-------------------------------------------------------------------------------------------------------------------------

                        function calculateTotal(element) {
                            var row = element.closest('tr');
                            var price = parseFloat(row.querySelector('td:nth-child(6) span').textContent) || 0;
                            var quantity = parseFloat(row.querySelector('.quantity-input').value) || 0;
                            var discount = parseFloat(row.querySelector('.discount-input').value) || 0;
                            var dropdown = row.querySelector('select');

                            // Đảm bảo giá trị packaging hợp lệ
                            var packagingValue = 1;
                            if (dropdown && dropdown.value) {
                                packagingValue = parseFloat(dropdown.value);
                                if (isNaN(packagingValue))
                                    packagingValue = 1;
                            }

                            var productName = row.children[1].innerText;

                            console.log("Sending to server:", {productName, price, quantity, packagingValue, discount});

                            $.ajax({
                                url: "/RiceManagement/calculateTotalServlet",
                                type: "POST",
                                data: {
                                    productName: productName,
                                    price: price,
                                    quantity: quantity,
                                    packaging: packagingValue,
                                    discount: discount
                                },
                                success: function (response) {
                                    console.log("Response from server:", response);

                                    // Kiểm tra nếu response không hợp lệ
                                    if (!response || isNaN(parseFloat(response))) {
                                        row.querySelector('.total-amount').textContent = "0.00";
                                    } else {
                                        row.querySelector('.total-amount').textContent = formatMoney(response);
                                    }

                                    calculateGrandTotal();
                                },
                                error: function () {
                                    alert("Có lỗi xảy ra khi tính toán tổng tiền!");
                                }
                            });
                        }





                        // Hàm tính tổng tiền hàng và gửi request đến servlet
                        function calculateGrandTotal() {
                            var rows = document.getElementById('productTableBody').getElementsByTagName('tr');
                            var totalAmounts = [];

                            // Thu thập tất cả các giá trị tổng tiền từ bảng
                            for (let row of rows) {
                                var totalText = row.querySelector('.total-amount').textContent;
                                totalAmounts.push(totalText);
                            }
                            console.log("totalArray123: " + totalAmounts);
                            // Gửi request đến servlet để tính toán
                            $.ajax({
                                url: "/RiceManagement/grandTotalServlet",
                                type: "POST",
                                data: {
                                    "totalAmounts[]": totalAmounts
                                },
                                success: function (response) {
                                    console.log("Kết quả tổng tiền từ server:", response);

                                    // Kiểm tra nếu response hợp lệ
                                    if (!response || isNaN(parseFloat(response.replace(/[,.]/g, '')))) {
                                        console.error("Kết quả không hợp lệ từ server");
                                        return;
                                    }

                                    // Định dạng hiển thị
                                    var formattedResponse = response;
                                    formattedResponse = formatMoney(formattedResponse);

                                    // Cập nhật giá trị Tổng tiền hàng
                                    var totalElement = document.querySelector('.totals .total-row:first-child span:last-child');
                                    if (totalElement) {
                                        totalElement.textContent = formattedResponse + ' vnđ';
                                        console.log("Đã cập nhật tổng tiền hàng:", formattedResponse);
                                    } else {
                                        console.error("Không tìm thấy phần tử tổng tiền hàng");
                                    }

                                    // Cập nhật giá trị Khách cần trả
                                    var customerPayElement = document.querySelector('.totals .final input[name="khachTra"]');
                                    if (customerPayElement) {
                                        customerPayElement.value = formattedResponse;
                                        console.log("Đã cập nhật ô khách cần trả:", formattedResponse);
                                    } else {
                                        console.error("Không tìm thấy ô input khách cần trả");
                                    }
                                },
                                error: function (xhr, status, error) {
                                    alert("Có lỗi xảy ra khi tính tổng tiền hàng!");
                                }
                            });
                        }





                        function calculateTotalMass(row) {
                            if (!row)
                                return;

                            const packagingSelect = row.querySelector('select');
                            const quantityInput = row.querySelector('.quantity-input');
                            const totalMassCell = row.querySelector('td:nth-child(5)'); // Cột "Total Mass"

                            if (!packagingSelect || !quantityInput || !totalMassCell) {
                                console.error("Lỗi: Không tìm thấy phần tử cần thiết trong hàng.");
                                return;
                            }

                            let packagingValue = packagingSelect.value; // Lấy giá trị từ select
                            let quantity = parseFloat(quantityInput.value) || 0; // Lấy số lượng

                            let totalMass = 0;

                            if (packagingValue === "kg") {
                                totalMass = quantity; // Nếu là kg, tổng khối lượng bằng số lượng
                            } else {
                                let bagSize = parseFloat(packagingValue) || 1; // Nếu là bao, nhân với số lượng
                                totalMass = bagSize * quantity;
                            }

                            // Cập nhật giá trị hiển thị
                            totalMassCell.textContent = totalMass.toFixed(2) + " kg";
                        }

// Đảm bảo tính tổng khối lượng khi số lượng hoặc packaging thay đổi
                        document.addEventListener("input", function (event) {
                            if (event.target.classList.contains("quantity-input")) {
                                const row = event.target.closest("tr");
                                calculateTotalMass(row);
                            }
                        });

// Đảm bảo tính tổng khối lượng khi thay đổi packaging
                        document.addEventListener("change", function (event) {
                            if (event.target.tagName.toLowerCase() === "select") {
                                const row = event.target.closest("tr");
                                calculateTotalMass(row);
                            }
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




//-------------------------------------------THANH TOAN-------------------------------------------------------------------------------------------------------------------------------

                        document.addEventListener("DOMContentLoaded", function () {
                            // Đảm bảo trang đã tải xong
                            setTimeout(function () {
                                // Tìm và thiết lập input khách trả
                                const inputKhachTra = document.querySelector('input[name="khachTra"]');
                                if (inputKhachTra) {
                                    inputKhachTra.setAttribute('disabled', 'true'); // Ban đầu không thể sửa
                                }

                                // Tìm nút "Trả tất"
                                const traAllButton = Array.from(document.querySelectorAll('.payment-method'))
                                        .find(button => button.textContent.trim() === "Trả tất");

                                // Kiểm tra xem nút có tồn tại không
                                if (traAllButton) {
                                    console.log("Đã tìm thấy nút 'Trả tất', đang chọn mặc định...");
                                    traAllButton.classList.add('selected'); // Thêm class selected trực tiếp
                                    selectPaymentMethod(traAllButton); // Gọi hàm xử lý
                                } else {
                                    console.error("Không tìm thấy nút 'Trả tất'");

                                    // Debug: Hiển thị tất cả các nút để xem có gì
                                    const allButtons = document.querySelectorAll('.payment-method');
                                    console.log("Tất cả các nút payment-method:", allButtons.length);
                                    allButtons.forEach(btn => console.log("Nút:", btn.textContent.trim()));
                                }
                            }, 100); // Delay nhỏ để đảm bảo DOM đã được tải hoàn toàn
                        });


// Bỏ dấu chấm khi gửi đi xử lý số học
                        function removeDots(value) {
                            return value.replace(/\./g, '');
                        }



                        function selectPaymentMethod(button) {
                            const buttons = document.querySelectorAll('.payment-method');
                            buttons.forEach(btn => btn.classList.remove('selected'));
                            button.classList.add('selected');

                            const inputKhachTra = document.querySelector('input[name="khachTra"]');
                            const totalAmountElement = document.querySelector('.total-row span:nth-child(2)');
                            let totalAmount = removeDots(totalAmountElement.textContent); // Chỉ lấy số (bỏ dấu chấm)
                            totalAmount = parseFloat(totalAmount) || 0; // Chuyển thành số

                            if (button.textContent.trim() === "Trả tất") {
                                inputKhachTra.value = formatMoney(totalAmount);
                                inputKhachTra.setAttribute('disabled', 'true');
                                updateDebt(0); // Khách không nợ gì
                                debtRow.style.display = "none"; // Ẩn phần nợ




                            } else if (button.textContent.trim() === "Nợ") {
                                inputKhachTra.value = 0;
                                inputKhachTra.setAttribute('disabled', 'true');
                                updateDebt(totalAmount); // Khách nợ toàn bộ số tiền
                                debtRow.style.display = "block"; // Hiển thị phần nợ

                                $.ajax({
                                    url: "/RiceManagement/checkPaymentServlet",
                                    type: "POST",
                                    data: {amountPaid: 0, totalAmount: totalAmount},
                                    success: function (response) {
                                        console.log("Server response:", response);
                                        // Đã gửi 0 làm amountPaid
                                    },
                                    error: function () {
                                        alert("Lỗi khi gửi dữ liệu đến server!");
                                    }
                                });
                            } else { // Trả một phần
                                inputKhachTra.value = formatMoney(totalAmount);
                                ; // Cho phép nhập tay
                                inputKhachTra.removeAttribute('disabled');
                                updateDebt(0);
                                debtRow.style.display = "block"; // Hiển thị phần nợ

                                inputKhachTra.addEventListener("input", function (e) {
                                    let value = removeDots(e.target.value);
                                    if (isNaN(value) || value === "")
                                        value = "0";
                                    e.target.value = formatMoney(value);
                                });

                                inputKhachTra.addEventListener("change", function () {
                                    let amountPaid = removeDots(inputKhachTra.value);
                                    amountPaid = parseFloat(amountPaid) || 0;

                                    if (amountPaid < 0 || amountPaid > totalAmount) {
                                        alert("Số tiền nhập không hợp lệ! Vui lòng nhập từ 0 đến " + formatMoney(totalAmount) + " VND.");
                                        inputKhachTra.value = "";
                                        updateDebt(totalAmount); // Giữ nguyên số nợ
                                        return;
                                    }

                                    // Gửi AJAX đến Servlet kiểm tra số tiền hợp lệ
                                    $.ajax({
                                        url: "/RiceManagement/checkPaymentServlet",
                                        type: "POST",
                                        data: {amountPaid: amountPaid, totalAmount: totalAmount},
                                        success: function (response) {
                                            console.log("Server response:", response);
                                            updateDebt(totalAmount - amountPaid);
                                        },
                                        error: function () {
                                            alert("Lỗi khi gửi dữ liệu đến server!");
                                        }
                                    });
                                });
                            }
                        }

// Cập nhật số tiền khách còn nợ
                        function updateDebt(amountOwed) {
                            const debtElement = document.getElementById("debtAmount");
                            if (debtElement) {
                                debtElement.textContent = formatMoney(amountOwed) + " VND";
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



// Handle select change for product packaging
                        function handleSelectChange(select) {
                            // Lấy row chứa select element
                            const row = select.closest('tr');
                            // Tính toán total mass và hiển thị
                            calculateTotalMass(row);
                            // Tính toán tổng tiền
                            calculateTotal(select);
                        }



//-----------------------------------------POP UP ADD CUSTOMER----------------------------------------------------------------------------------------------------------------------
                        /* THÊM VÀO: Các hàm xử lý popup thêm khách hàng */
                        // Mở popup thêm khách hàng
                        function openAddCustomerPopup() {
                            document.getElementById('addCustomerPopup').style.display = 'block';
                            // Xóa dữ liệu form cũ
                            document.getElementById('customerName').value = '';
                            document.getElementById('customerPhone').value = '';
                        }

                        // Đóng popup thêm khách hàng
                        function closeAddCustomerPopup() {
                            document.getElementById('addCustomerPopup').style.display = 'none';
                        }

                        // Lưu thông tin khách hàng mới
                        function saveCustomer() {
                            const name = document.getElementById('customerName').value;
                            const phone = document.getElementById('customerPhone').value;

                            if (!name) {
                                alert('Vui lòng nhập tên khách hàng!');
                                return;
                            }

                            // Gửi dữ liệu đến server
                            $.ajax({
                                url: "/RiceManagement/addCusInvoice",
                                type: "post",
                                data: {
                                    name: name,
                                    phone: phone
                                },
                                success: function (response) {
                                    // Cập nhật thông tin khách hàng trong giao diện
                                    document.querySelector('.customer-info h2').textContent = name;
                                    document.querySelector('.customer-info .customer-note:nth-child(2)').textContent = 'SDT: ' + phone;

                                    // Đóng popup
                                    closeAddCustomerPopup();

                                    alert('Đã thêm khách hàng thành công!');
                                },
                                error: function (error) {
                                    alert('Lỗi khi thêm khách hàng: ' + error.responseText);
                                }
                            });
                        }

                        // Đóng popup khi click ra ngoài
                        window.onclick = function (event) {
                            const popup = document.getElementById('addCustomerPopup');
                            if (event.target === popup) {
                                closeAddCustomerPopup();
                            }
                        };

//-------------------------------------------POP UP CONFIRM INVOICE----------------------------------------------------------------------------------------------------------------------------------------
// Add this to your existing script section
$(document).ready(function () {
    $(".pay-button").click(function () {
        $("#payment-popup").fadeIn();
    });

    // Đóng popup khi bấm ❌ hoặc nút Đóng
    $("#close-popup, #close-btn").click(function () {
        $("#payment-popup").fadeOut();
    });
    // Xử lý khi chọn phương thức "Thanh toán tiền mặt"
    $("#cash-payment").click(function () {
        $("#qrCodeContainer").fadeOut();
        openOrderConfirmationPopup(); // Gọi hàm khi chọn thanh toán tiền mặt
         $("#payment-popup").fadeOut();
    });
$("#bank-payment").click(function () {
        $("#qrCodeContainer").fadeIn(); // Hiển thị ảnh QR
        openOrderConfirmationPopup();   // Mở popup xác nhận đơn hàng
        $("#payment-popup").fadeOut();  // Ẩn popup thanh toán
    });
});




// Function to open order confirmation popup
                        function openOrderConfirmationPopup() {
                            // Check if there are products in the table
                            const productRows = document.getElementById('productTableBody').getElementsByTagName('tr');
                            if (productRows.length === 0) {
                                alert('Vui lòng thêm sản phẩm vào đơn hàng!');
                                return;
                            }

                            // Check if customer is selected
                            const customerName = document.querySelector('.customer-info h2').textContent;
                            if (!customerName || customerName === 'Name customer') {
                                alert('Vui lòng chọn khách hàng!');
                                return;
                            }

                            // Populate customer information
                            document.getElementById('confirmCustomerName').textContent = customerName;
                            document.getElementById('confirmCustomerPhone').textContent = document.querySelector('.customer-info p:nth-child(2)').textContent.replace('SDT: ', '');
                            document.getElementById('confirmCustomerAddress').textContent = document.querySelector('.customer-info p:nth-child(3)').textContent.replace('Address: ', '');

                            // Recalculate and populate product list
                            populateProductList();

                            // Calculate and populate payment information
                            PaymentInfo();

                            // Show the popup
                            document.getElementById('orderConfirmationPopup').style.display = 'block';
                        }

                      

// Function to populate product list in confirmation popup
                        // Modified populateProductList function
                        function populateProductList() {
                            console.log("populateProductList function called");

                            const productTableBody = document.getElementById('productTableBody');
                            const confirmProductList = document.getElementById('confirmProductList');

                            if (!confirmProductList) {
                                console.error("confirmProductList element not found");
                                return;
                            }

                            // Clear existing data
                            confirmProductList.innerHTML = '';

                            // Loop through all product rows and add to confirmation
                            const rows = productTableBody.getElementsByTagName('tr');

                            for (let i = 0; i < rows.length; i++) {
                                const row = rows[i];

                                try {
                                    const productId = row.cells[0].textContent;
                                    const productName = row.cells[1].textContent;

                                    // Get packaging info
                                    const packagingSelect = row.querySelector('select');
                                    let packaging = "kg";
                                    if (packagingSelect && packagingSelect.options.length > 0) {
                                        const selectedIndex = packagingSelect.selectedIndex;
                                        if (selectedIndex >= 0) {
                                            packaging = packagingSelect.options[selectedIndex].text;
                                        }
                                    }

                                    const quantityInput = row.querySelector('.quantity-input');
                                    const quantity = quantityInput ? quantityInput.value || '0' : '0';

                                    const totalMass = row.cells[4].textContent;

                                    const priceElement = row.cells[5].querySelector('span');
                                    const price = priceElement ? priceElement.textContent : '0';

                                    const discountInput = row.querySelector('.discount-input');
                                    const discount = discountInput ? discountInput.value || '0' : '0';

                                    const totalElement = row.querySelector('.total-amount');
                                    const amount = totalElement ? totalElement.textContent : '0';

                                    // Create new row as a DOM element rather than setting innerHTML
                                    const newRow = document.createElement('tr');

                                    // Add each cell
                                    const cells = [productId, productName, packaging, quantity, totalMass, price, discount + '%', amount];
                                    cells.forEach(text => {
                                        const td = document.createElement('td');
                                        td.textContent = text;
                                        newRow.appendChild(td);
                                    });

                                    // Append the row
                                    confirmProductList.appendChild(newRow);
                                } catch (error) {
                                    console.error("Error processing row", i, error);
                                }
                            }
                        }

                        function PaymentInfo() {
                            // Get total amount directly from the DOM
                            const totalAmountElement = document.querySelector('.totals .total-row:first-child span:last-child');
                            let totalAmountText = totalAmountElement.textContent;

                            // Clean up the text (remove "vnđ" if present and trim)
                            totalAmountText = totalAmountText.replace('vnđ', '').trim();

                            // Update total amount in confirmation
                            document.getElementById('confirmTotalAmount').textContent = totalAmountText;

                            // Get payment method
                            const selectedPaymentMethod = document.querySelector('.payment-method.selected').textContent;
                            document.getElementById('confirmPaymentMethod').textContent = selectedPaymentMethod;

                            // Get paid amount
                            const paidAmount = document.querySelector('input[name="khachTra"]').value;
                            document.getElementById('confirmPaidAmount').textContent = paidAmount + ' vnđ';

                            // Calculate and show debt if applicable
                            const totalAmount = parseFloat(totalAmountText.replace(/[,.]/g, '')) || 0;
                            let debtAmount = 0;

                            if (selectedPaymentMethod === 'Nợ') {
                                debtAmount = totalAmount;
                                document.getElementById('confirmDebtRow').style.display = 'block';
                            } else if (selectedPaymentMethod === 'Trả một phần') {
                                const paid = parseFloat(paidAmount.replace(/[,.]/g, '')) || 0;
                                debtAmount = totalAmount - paid;
                                document.getElementById('confirmDebtRow').style.display = 'block';
                            } else {
                                document.getElementById('confirmDebtRow').style.display = 'none';
                            }

                            document.getElementById('confirmDebtAmount').textContent = formatMoney(debtAmount) + ' vnđ';
                        }

// Kiểm tra nếu đây là nút trả tất mặc định
                        function isTraTatSelected() {
                            const traAllButton = document.querySelector('.payment-method.selected');
                            return traAllButton && traAllButton.textContent.trim() === "Trả tất";
                        }

                function getTableData() {
                   closeOrderConfirmationPopup();
    // Hiển thị popup xác nhận
    document.getElementById("confirmPopup").style.display = "flex";

    // Xử lý khi bấm nút "Xác nhận"
    document.getElementById("confirmBtn").onclick = function () {
        document.getElementById("confirmPopup").style.display = "none"; // Ẩn popup và tiếp tục xử lý thanh toán

        // Tra tat Session
        if (isTraTatSelected()) {
            const totalAmountElement = document.querySelector('.total-row span:nth-child(2)');
            let totalAmount = removeDots(totalAmountElement.textContent);
            totalAmount = parseFloat(totalAmount) || 0;

            console.log("Đây là nút Trả tất mặc định, gửi AJAX với totalAmount:", totalAmount);

            $.ajax({
                url: "/RiceManagement/checkPaymentServlet",
                type: "POST",
                data: { amountPaid: totalAmount, totalAmount: totalAmount },
                success: function (response) {
                    console.log("Server response for default Trả tất:", response);
                },
                error: function (xhr, status, error) {
                    console.error("AJAX Error:", error);
                    alert("Lỗi khi gửi dữ liệu đến server!");
                }
            });
        } else {
            console.log("Không phải nút Trả tất mặc định, bỏ qua việc gửi AJAX");
        }

        let rows = document.getElementById("productTableBody").getElementsByTagName("tr");
        let formData = new URLSearchParams();

        for (let i = 0; i < rows.length; i++) {
            let cols = rows[i].getElementsByTagName("td");
            if (cols.length < 10) continue;

            const customerName = document.querySelector('.customer-info h2').textContent;
            if (!customerName || customerName === 'Name customer') {
                alert('Vui lòng chọn khách hàng!');
                return;
            }

            let productID = cols[9]?.querySelector("input")?.value || "";
            let dropdown = cols[2]?.querySelector("select")?.value || "";
            let quantity = cols[3]?.querySelector("input")?.value || "0";
            let totalMass = cols[4]?.innerText.trim().replace(" kg", "") || "0";
            let discount = cols[6]?.querySelector("input")?.value || "0";

            formData.append("productID", productID);
            formData.append("dropdown", dropdown);
            formData.append("quantity", quantity);
            formData.append("totalMass", totalMass);
            formData.append("discount", discount);
        }

        console.log([...formData]);

        $.ajax({
            url: "/RiceManagement/addPrepareInvoice",
            type: "POST",
            data: formData.toString(),
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (response) {
                console.log("Dữ liệu đã được gửi thành công:", response);

                closeOrderConfirmationPopup();
                showNotification('Đơn hàng đã được thanh toán thành công!');

                setTimeout(() => {
                    document.getElementById('productTableBody').innerHTML = '';
                    document.querySelector('.customer-info h2').textContent = 'Name customer';
                    document.querySelector('.customer-info p:nth-child(2)').textContent = 'SDT: ';
                    document.querySelector('.customer-info p:nth-child(3)').textContent = 'Address: ';
                    document.querySelector('.totals .total-row:first-child span:last-child').textContent = '00.0 vnđ';
                    document.querySelector('input[name="khachTra"]').value = '';
                    document.querySelector(".header .search-box input").value = '';
                    document.querySelector(".search-container .search-box input").value = '';
                    document.querySelector("#debtAmount").textContent = '';
                    currentId = 1;
                }, 500);
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi gửi dữ liệu:", error);
                console.error("Response:", xhr.responseText);
            }
        });
    };

    // Xử lý khi bấm nút "Hủy"
    document.getElementById("cancelBtn").onclick = function () {
        document.getElementById("confirmPopup").style.display = "none"; // Ẩn popup, không làm gì
    };
}







// Function to show a notification
                        function showNotification(message) {
                            // Create notification element if it doesn't exist
                            if (!document.getElementById('notification')) {
                                const notification = document.createElement('div');
                                notification.id = 'notification';
                                notification.className = 'notification';
                                document.body.appendChild(notification);
                            }

                            const notificationElement = document.getElementById('notification');
                            notificationElement.textContent = message;
                            notificationElement.classList.add('show');

                            // Hide notification after 3 seconds
                            setTimeout(() => {
                                notificationElement.classList.remove('show');
                            }, 3000);
                        }

                        // Function to close order confirmation popup
                        function closeOrderConfirmationPopup() {
                            $("#qrCodeContainer").fadeOut();
                            document.getElementById('orderConfirmationPopup').style.display = 'none';
                            console.log("Popup display style:", document.getElementById('orderConfirmationPopup').style.display);
                        }

</script>
