/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ManageAccount", urlPatterns = {"/manageaccount"})
public class ManageAccount extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO dao = new DAO();

        // Lấy tham số từ request
        String pageParam = request.getParameter("page");
        String keyword = request.getParameter("keyword");

        boolean isSearching = (keyword != null && !keyword.trim().isEmpty());

        // Số tài khoản trên mỗi trang
        int recordsPerPage = 5;
        int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
        int totalAccounts = isSearching ? dao.countSearchAccounts(keyword) : dao.countAccounts();
        int totalPages = (int) Math.ceil((double) totalAccounts / recordsPerPage);

        // Lấy danh sách tài khoản theo phân trang
        List<User> accounts;
        if (isSearching) {
            accounts = dao.searchUsersPaginated(keyword, (currentPage - 1) * recordsPerPage, recordsPerPage);
        } else {
            accounts = dao.getAccountsByPage((currentPage - 1) * recordsPerPage, recordsPerPage);
        }

        // Gửi dữ liệu về JSP
        request.setAttribute("accounts", accounts);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("isSearching", isSearching);
        request.setAttribute("keywordS", keyword);

        request.getRequestDispatcher("/view/admin/manageAccount.jsp").forward(request, response);
    }

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
        processRequest(request, response);
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
        processRequest(request, response);
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
