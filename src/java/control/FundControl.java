/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.CashDAO;
import dao.CustomerDAO;
import dao.InvoiceDAO;
import dao.UserDAO;
import entity.Cash;
import entity.Customer;
import entity.Orders;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "FundControl", urlPatterns = {"/fund"})
public class FundControl extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
         CashDAO dao = new CashDAO();
        List<User> employees = userDAO.getEmployee();
        request.setAttribute("employees", employees);
        CustomerDAO customerDAO = new CustomerDAO();
        List<Customer> customers = customerDAO.getAllCustomers();
        request.setAttribute("customers", customers);
        
        doPost(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null) {
            request.getRequestDispatcher("/login").forward(request, response);
        } else {
            response.setCharacterEncoding("UTF-8");

            // Lấy các tham số tìm kiếm
            String cashId = request.getParameter("cashId") != null ? request.getParameter("cashId").trim() : "";
            String time = request.getParameter("time") != null ? request.getParameter("time").trim() : "";
            String typeName = request.getParameter("typeName") != null ? request.getParameter("typeName").trim() : "";
            String amount = request.getParameter("amount") != null ? request.getParameter("amount").trim() : "";
            String customerName = request.getParameter("customerName") != null ? request.getParameter("customerName").trim() : "";
            String employeeName = request.getParameter("employeeName") != null ? request.getParameter("employeeName").trim() : "";
            String note = request.getParameter("note") != null ? request.getParameter("note").trim() : "";
           
            // Phân trang
            int recordsPerPage = 10;
            int page = 1; // Đặt trang mặc định là 1
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                    if (page < 1) page = 1; // Đảm bảo không có trang < 1
                } catch (NumberFormatException e) {
                    page = 1; // Nếu có lỗi, đặt mặc định trang 1
                }
            }

            CashDAO dao = new CashDAO();
            // Lấy danh sách hóa đơn
            ArrayList<Cash> listCash = dao.searchCashsWithPagination(
                cashId, time, typeName, amount, customerName, employeeName, note,
                page, recordsPerPage);
            if (listCash == null) {
                listCash = new ArrayList<>();
            }
           
            // Kiểm tra số lượng đơn hàng
            int totalCashs = dao.getTotalCashsCountAfterSearch(
                cashId, time, typeName, amount, customerName, employeeName, note,
                page, recordsPerPage);
            // Tính tổng số trang
            int totalPages = (int) Math.ceil((double) totalCashs / recordsPerPage);
            if (totalPages < 1) {
                totalPages = 1; // Đảm bảo rằng ít nhất có 1 trang
            }

            // Kiểm tra phải không vượt quá số trang
            if (page > totalPages) {
                page = totalPages; // Nếu số trang yêu cầu vượt quá thì chuyển về trang cuối
            }
            
            // Tính toán startPage và endPage cho hiển thị phân trang
            int maxPagesToShow = 5; // Số trang tối đa hiển thị
            int startPage = Math.max(1, page - (maxPagesToShow / 2));
            int endPage = Math.min(totalPages, startPage + maxPagesToShow - 1);
            
            // Điều chỉnh startPage nếu endPage đã đạt giới hạn
            if (endPage == totalPages) {
                startPage = Math.max(1, endPage - maxPagesToShow + 1);
            }
             // Lấy danh sách không phân trang (toàn bộ dữ liệu)
           
            List<Cash> listCash_total = dao.getAllCashRecords();
             List<Cash> listAllCash = dao.getAllCashs();
          request.setAttribute("listCash_total", listCash_total);
            //System.out.println("control.FundControl.doPost()" + listCash_total);
            // Thiết lập thuộc tính cho JSP
            request.setAttribute("listCash", listCash);
            //request.setAttribute("listCash", listAllCash);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);
            
            // Truyền lại các tham số tìm kiếm
            request.setAttribute("cashId", cashId);
            request.setAttribute("time", time);
            request.setAttribute("typeName", typeName);
            request.setAttribute("amount", amount);
            request.setAttribute("customerName", customerName);
            request.setAttribute("employeeName", employeeName);
            request.setAttribute("note", note);
            
            request.getRequestDispatcher("/view/page/fund.jsp" ).forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
