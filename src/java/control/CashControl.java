/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.CashDAO;
import dao.CustomerDAO;
import dao.UserDAO;
import entity.Cash;
import entity.Customer;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 *
 * @author anhdv
 */
@WebServlet(name = "CashControl", urlPatterns = {"/cash"})
public class CashControl extends HttpServlet {

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
    try {
        String typeId = request.getParameter("type");
        Long cash_manage_id = 1L;
        String amountStr = request.getParameter("amount");
        Long empId = Long.valueOf(request.getParameter("empId"));
        Long cusId = Long.valueOf(request.getParameter("cusId"));
        String note = request.getParameter("note");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime localDateTime = LocalDateTime.parse(request.getParameter("time"), formatter);
        Date time = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());

        // Lấy typeName từ Cash.mapType
        int typeIdInt = Integer.parseInt(typeId);
        String typeName = Cash.mapType(typeIdInt);

        // Chuyển đổi amount thành số thực
        double amount = Double.parseDouble(amountStr);

        // Nếu loại là "Chi trả NCC", chuyển amount thành số âm
        if ("Chi trả NCC".equals(typeName)) {
            amount = -Math.abs(amount);
        }

        CashDAO cashDAO = new CashDAO();
        User user = new UserDAO().getUserById(empId.intValue());
        Customer customer = new CustomerDAO().getCustomerById(cusId.toString());

        // Chèn dữ liệu vào database
        cashDAO.insertCash(new Cash(
            time, 
            typeIdInt, 
            typeName, 
            amount,  // Amount có thể bị âm nếu là "Chi trả NCC"
            empId, 
            user.getName(), 
            cusId, 
            customer.getName(), 
            note,
            cash_manage_id
        ));

        // Chuyển hướng về trang /fund
        response.sendRedirect(request.getContextPath() + "/fund");
    } catch (Exception ex) {
        request.getRequestDispatcher(ex.getMessage()).forward(request, response);
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
