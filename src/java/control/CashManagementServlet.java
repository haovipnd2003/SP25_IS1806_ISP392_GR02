package control;

import dao.CashDAO;
import dao.Cash_managerDAO;
import entity.Cash;
import entity.CashManager;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 * Servlet quản lý danh sách CashManager.
 */
@WebServlet(name = "CashManagementServlet", urlPatterns = {"/CashManagement"})
public class CashManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập encoding để tránh lỗi font tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Khởi tạo DAO để lấy dữ liệu
        Cash_managerDAO cashManagerDAO = new Cash_managerDAO();
        CashDAO cashDAO = new CashDAO(); // Thêm DAO đúng cho bảng Cash

        // Lấy danh sách CashManager từ database
        List<CashManager> cashManagers = cashManagerDAO.getAllCashManagers();
        if (cashManagers == null) {
            cashManagers = new ArrayList<>(); // Khởi tạo danh sách rỗng đúng cách
        }

        // Lấy danh sách Cash từ bảng cash
        List<Cash> listCash_total = cashDAO.getAllCashRecords(); // Gọi từ CashDAO thay vì Cash_managerDAO
        if (listCash_total == null) {
            listCash_total = new ArrayList<>();
        }

        // Đẩy dữ liệu vào request
        request.setAttribute("cashManagers", cashManagers);
        request.setAttribute("listCash_total", listCash_total);

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("/view/page/CashManager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
