<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>
<%@page import="entity.CashManager" %>
<%@page import="entity.Cash" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý CashManager</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/modules/fontawesome/web-fonts-with-css/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//modules/toastr/build/toastr.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/demo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}//css/style.css">
         
        <style>
            /* Đảm bảo menu sidebar không đè lên nội dung chính */
.d-flex {
    display: flex;
}

/* Định kích thước sidebar */
.sidebar {
    width: 250px; /* Điều chỉnh độ rộng của sidebar */
    position: fixed;
    top: 0;
    left: 0;
    height: 100%;
    background-color: #f8f9fa;
    padding-top: 20px;
    transition: all 0.3s;
}

/* Dịch nội dung chính sang phải để không bị che */
.content-wrapper {
    margin-left: 250px; /* Phù hợp với độ rộng của sidebar */
    width: calc(100% - 250px);
    transition: all 0.3s;
}

/* Nếu sidebar có thể thu nhỏ, cập nhật lớp này */
.sidebar.collapsed {
    width: 60px;
}

.sidebar.collapsed + .content-wrapper {
    margin-left: 60px;
    width: calc(100% - 60px);
}

        </style>
</head>
<body>

    <!-- Include Navbar -->
    <jsp:include page="/view/common/nav_bar.jsp"></jsp:include>
       <!-- Include Sidebar -->
        <jsp:include page="/view/common/main-sidebar.jsp"></jsp:include>
    <div class="d-flex mt-3">
 

        <!-- Nội dung chính -->
        <div class="container mt-5 content-wrapper">
            <h2 class="text-center mb-4 mt-5">Quản lý quỹ tiền</h2>

        <% 
            List<CashManager> cashManagers = (List<CashManager>) request.getAttribute("cashManagers");
            if (cashManagers == null) {
                cashManagers = new java.util.ArrayList<>();
            }
            
            double totalQuythu = 0, totalQuychi = 0, totalQuydauky = 0, totalQuy = 0, totaMabsQuychi =0;
            for (CashManager cm : cashManagers) {
                totalQuythu += cm.getTotalQuythu();
                totalQuychi += cm.getTotalQuychi();
                totalQuydauky += cm.getTotalQuydauky();
            }
            totaMabsQuychi = Math.abs(totalQuychi);
            totalQuy = totalQuydauky + totalQuythu + totalQuychi;
        %>
        
        <!-- Thống kê tổng quỹ -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-primary text-white">
                    <div class="card-body">
                        <h5 class="card-title">Quỹ đầu kỳ</h5>
                        <p class="card-text"><%= String.format("%,.0f", totalQuydauky) %> VNĐ</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white">
                    <div class="card-body">
                        <h5 class="card-title">Tổng Thu</h5>
                        <p class="card-text"><%= String.format("%,.0f", totalQuythu) %> VNĐ</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-danger text-white">
                    <div class="card-body">
                        <h5 class="card-title">Tổng Chi</h5>
                        <p class="card-text"><%= String.format("%,.0f", totaMabsQuychi) %> VNĐ</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-primary text-white">
                    <div class="card-body">
                        <h5 class="card-title">Tổng Quỹ</h5>
                        <p class="card-text"><%= String.format("%,.0f", totalQuy) %> VNĐ</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bảng danh sách -->
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>                  
                    <th>Nhân Viên</th>
                    <th>Ngày chốt sổ</th>
                    <th>Chi Tiết</th>
                </tr>
            </thead>
            <tbody>
                <% if (!cashManagers.isEmpty()) { %>
                    <% for (CashManager cm : cashManagers) { %>
                        <tr>
                          
                            <td><%= cm.getEmployeeName() %></td>
                            <td><%= cm.getTime() != null ? cm.getTime() : "Không có dữ liệu" %></td>
                            <td><%= cm.getDetails() != null ? cm.getDetails() : "Không có dữ liệu" %></td>
                      
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="8" class="text-center text-danger">Không có dữ liệu</td>
                    </tr>
                <% } %>
            </tbody>
        </table>

       <button id="btnChotSo" class="btn btn-primary">Chốt sổ</button>
        </div>
    </div>

</body>
<script>
document.getElementById("btnChotSo").addEventListener("click", function() {
    fetch("UpdateCashManagementServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "" // Không cần gửi dữ liệu, mọi giá trị đều mặc định trong servlet
    })
    .then(response => response.json())
    .then(data => {
        alert(data.message);
        if (data.status === "success") {
            location.reload(); // Reload lại trang sau khi cập nhật thành công
        }
    })
    .catch(error => alert("Lỗi khi chốt sổ!"));
});
</script>

</html>
