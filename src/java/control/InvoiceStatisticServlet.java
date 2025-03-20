/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.InvoiceDAO;
import entity.Orders;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author binh2
 */
@WebServlet(name = "InvoiceStatisticServlet", urlPatterns = {"/invoiceStatistic"})
public class InvoiceStatisticServlet extends HttpServlet {

@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            String invoiceId = request.getParameter("invoiceId") != null ? request.getParameter("invoiceId").trim() : "";
            String createdAt = request.getParameter("createdAt") != null ? request.getParameter("createdAt").trim() : "";
            String customerName = request.getParameter("customerName") != null ? request.getParameter("customerName").trim() : "";
            String userName = request.getParameter("userName") != null ? request.getParameter("userName").trim() : "";
            
            // Lấy các tham số lọc số tiền
            String totalAmountMin = request.getParameter("totalAmountMin");
            String totalAmountMax = request.getParameter("totalAmountMax");
            String customerPayMin = request.getParameter("customerPayMin");
            String customerPayMax = request.getParameter("customerPayMax");

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

            InvoiceDAO dao = new InvoiceDAO();
            
            // Chuyển đổi các giá trị số tiền từ String sang Double nếu có
            Double totalAmountMinDouble = null;
            Double totalAmountMaxDouble = null;
            Double customerPayMinDouble = null;
            Double customerPayMaxDouble = null;
            
            try {
                if (totalAmountMin != null && !totalAmountMin.isEmpty()) {
                    totalAmountMinDouble = Double.parseDouble(totalAmountMin);
                }
                if (totalAmountMax != null && !totalAmountMax.isEmpty()) {
                    totalAmountMaxDouble = Double.parseDouble(totalAmountMax);
                }
                if (customerPayMin != null && !customerPayMin.isEmpty()) {
                    customerPayMinDouble = Double.parseDouble(customerPayMin);
                }
                if (customerPayMax != null && !customerPayMax.isEmpty()) {
                    customerPayMaxDouble = Double.parseDouble(customerPayMax);
                }
            } catch (NumberFormatException e) {
                // Xử lý lỗi nếu có
                System.out.println("Error parsing number: " + e.getMessage());
            }
            
            // Lấy danh sách hóa đơn
            ArrayList<Orders> listOrders = dao.searchInvoicesWithPagination(
                invoiceId, createdAt, customerName, userName, 
                totalAmountMinDouble, totalAmountMaxDouble, 
                customerPayMinDouble, customerPayMaxDouble, 
                page, recordsPerPage);
                
            if (listOrders == null) {
                listOrders = new ArrayList<>();
            }

            // Kiểm tra số lượng đơn hàng
            int totalOrders = dao.getTotalOrdersCountAfterSearch(
                invoiceId, createdAt, customerName, userName,
                totalAmountMin, totalAmountMax, customerPayMin, customerPayMax);
            
            // Tính tổng số trang
            int totalPages = (int) Math.ceil((double) totalOrders / recordsPerPage);
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

            // Thiết lập thuộc tính cho JSP
            request.setAttribute("listOrders", listOrders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);
            
            // Truyền lại các tham số tìm kiếm
            request.setAttribute("invoiceId", invoiceId);
            request.setAttribute("createdAt", createdAt);
            request.setAttribute("customerName", customerName);
            request.setAttribute("userName", userName);
            request.setAttribute("totalAmountMin", totalAmountMin);
            request.setAttribute("totalAmountMax", totalAmountMax);
            request.setAttribute("customerPayMin", customerPayMin);
            request.setAttribute("customerPayMax", customerPayMax);
            
            request.getRequestDispatcher("/view/page/invoiceStatistic.jsp").forward(request, response);
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
