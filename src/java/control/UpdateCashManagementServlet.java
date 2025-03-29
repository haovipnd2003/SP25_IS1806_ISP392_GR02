/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.Cash_managerDAO;
import entity.CashManager;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "UpdateCashManagementServlet", urlPatterns = {"/UpdateCashManagementServlet"})
public class UpdateCashManagementServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Dữ liệu mặc định
            String employeeName = "Admin";
            int id = 1;
            String details = "Đã chốt sổ"; // Giá trị mặc định
            // Tạo đối tượng CashManager
            CashManager cm = new CashManager();
            cm.setEmployeeName(employeeName);
            cm.setDetails(details);
            cm.setId(id);

            // Gọi DAO để cập nhật
            Cash_managerDAO dao = new Cash_managerDAO();
            boolean success = dao.updateCashManager(cm);

            // Trả về kết quả dưới dạng JSON
            if (success) {
                response.getWriter().write("{\"status\": \"success\", \"message\": \"Chốt sổ thành công!\"}");
            } else {
                response.getWriter().write("{\"status\": \"error\", \"message\": \"Lỗi khi chốt sổ!\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Lỗi hệ thống!\"}");
            e.printStackTrace();
        }
    }
}

