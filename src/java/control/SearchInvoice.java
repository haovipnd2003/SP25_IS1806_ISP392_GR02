/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.InvoiceDAO;
import entity.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author binh2
 */
@WebServlet(name = "SearchInvoice", urlPatterns = {"/searchInvoice"})
public class SearchInvoice extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchInvoice</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchInvoice at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        PrintWriter out = response.getWriter();
        response.setCharacterEncoding("UTF-8");

        
        String invoiceId = request.getParameter("invoiceId") != null ? request.getParameter("invoiceId").trim() : "";
        String createdAt = request.getParameter("createdAt") != null ? request.getParameter("createdAt").trim() : "";
        String customerName = request.getParameter("customerName") != null ? request.getParameter("customerName").trim() : "";
        String userName = request.getParameter("userName") != null ? request.getParameter("userName").trim() : "";

        String totalAmountMinStr = request.getParameter("totalAmountMin");
        Double totalAmountMin = (totalAmountMinStr != null && !totalAmountMinStr.trim().isEmpty())
                ? Double.parseDouble(totalAmountMinStr.trim())
                : null;

        String totalAmountMaxStr = request.getParameter("totalAmountMax");
        Double totalAmountMax = (totalAmountMaxStr != null && !totalAmountMaxStr.trim().isEmpty())
                ? Double.parseDouble(totalAmountMaxStr.trim())
                : null;

        String customerPayMinStr = request.getParameter("customerPayMin");
        Double customerPayMin = (customerPayMinStr != null && !customerPayMinStr.trim().isEmpty())
                ? Double.parseDouble(customerPayMinStr.trim())
                : null;

        String customerPayMaxStr = request.getParameter("customerPayMax");
        Double customerPayMax = (customerPayMaxStr != null && !customerPayMaxStr.trim().isEmpty())
                ? Double.parseDouble(customerPayMaxStr.trim())
                : null;
        
 
invoiceId = invoiceId.replace("'", "''");



        out.print("invoiceId: " + invoiceId + "\n");
out.print("createdAt: " + createdAt + "\n");
out.print("customerName: " + customerName + "\n");
out.print("userName: " + userName + "\n");
out.print("totalAmountMin: " + totalAmountMin + "\n");
out.print("totalAmountMax: " + totalAmountMax + "\n");
out.print("customerPayMin: " + customerPayMin + "\n");
out.print("customerPayMax: " + customerPayMax + "\n");


        //Phan trang
        int page = 1;
        int recordsPerPage = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        InvoiceDAO dao = new InvoiceDAO();
        ArrayList<Orders> listOrders = dao.searchInvoicesWithPagination(invoiceId, createdAt, customerName,
                userName, totalAmountMin, totalAmountMax, customerPayMin, customerPayMax, page, recordsPerPage);
        int totalOrders = dao.getTotalOrdersCountAfterSearch(invoiceId, createdAt, customerName,
                userName, totalAmountMinStr, totalAmountMaxStr, customerPayMinStr, customerPayMaxStr);
        int totalPages = (int) Math.ceil(totalOrders * 1.0 / recordsPerPage);
        
        out.print("listOrders: " + listOrders + "\n");
        out.print("totalOrders: " + totalOrders + "\n");
        out.print("totalPages: " + totalPages + "\n");

        request.setAttribute("listOrders", listOrders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Calculate totals for all orders
        long totalAmount = dao.getTotalAmountAfterSearch(invoiceId, createdAt, customerName,
                userName, totalAmountMinStr, totalAmountMaxStr, customerPayMinStr, customerPayMaxStr);
        long totalCustomerPay = dao.getTotalCustomerPayAfterSearch(invoiceId, createdAt, customerName,
                userName, totalAmountMinStr, totalAmountMaxStr, customerPayMinStr, customerPayMaxStr);
        long totalBalance = totalAmount - totalCustomerPay;

        request.setAttribute("totalAmount", dao.formatMoney(String.valueOf(totalAmount)));
        request.setAttribute("totalCustomerPay", dao.formatMoney(String.valueOf(totalCustomerPay)));
        request.setAttribute("totalBalance", dao.formatMoney(String.valueOf(totalBalance)));

        request.getRequestDispatcher("/view/page/invoiceStatistic.jsp").forward(request, response);
        return;
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
