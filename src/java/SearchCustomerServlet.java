/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.CustomerDAO;
import entity.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Viet Duc
 */
@WebServlet(name = "SearchCustomerServlet", urlPatterns = {"/searchcustomer"})
public class SearchCustomerServlet extends HttpServlet {

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
            out.println("<title>Servlet SearchCustomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchCustomerServlet at " + request.getContextPath() + "</h1>");
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
        String id = request.getParameter("id") != null ? request.getParameter("id").trim() : "";
        String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
        String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
        String address = request.getParameter("address") != null ? request.getParameter("address").trim() : "";

        CustomerDAO dao = new CustomerDAO();
        ArrayList<Customer> listCus = dao.searchCustomers(id,name, phone, email, address);

        request.setAttribute("listCus", listCus);
        request.setAttribute("id", id);
        request.setAttribute("name", name);
        request.setAttribute("phone", phone);
        request.setAttribute("email", email);
        request.setAttribute("address", address);

        if (listCus == null || listCus.isEmpty()) {
            request.setAttribute("noCustomersMessage", "No matching customers");
        }

        request.getRequestDispatcher("view/page/customer.jsp").forward(request, response);
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
