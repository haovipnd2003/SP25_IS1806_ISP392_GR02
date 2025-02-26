/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.CustomerDAO;
import dao.DAO;
import entity.Customer;
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
import java.util.List;

/**
 *
 * @author Viet Duc
 */
@WebServlet(name = "CustomerSevlet", urlPatterns = {"/customer"})
public class CustomerSevlet extends HttpServlet {

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
            out.println("<title>Servlet CustomerSevlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerSevlet at " + request.getContextPath() + "</h1>");
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
    CustomerDAO dao = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null) {
            request.getRequestDispatcher("/login").forward(request, response);
        } else {
            String action = request.getParameter("action");
            if (action == null) {
                action = "view";
            }
            if (action.equals("view")) {
                //
                int page = 1;
                int recordsPerPage = 5;
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                //
//                ArrayList<Customer> listCus = dao.getAllCustomers();
//
                ArrayList<Customer> listCus = dao.getPaginatedCustomers(page, recordsPerPage);
                int totalCustomers = dao.getTotalCustomers();
                int totalPages = (int) Math.ceil(totalCustomers * 1.0 / recordsPerPage);
//
                request.setAttribute("listCus", listCus);
                //
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                //

                String succMess = (String) session.getAttribute("succMess");
                if (succMess != null) {
                    request.setAttribute("succMess", succMess);
                    session.removeAttribute("succMess");
                }

                request.getRequestDispatcher("view/page/customer.jsp").forward(request, response);
                return;
            }
            switch (action) {
                case "update":
                    Customer updatedCustomer = dao.getCustomerById(id);
                    PrintWriter out = response.getWriter();
                    out.print(updatedCustomer);
                    break;
                case "add":
                    request.getRequestDispatcher("view/page/addCustomer.jsp").forward(request, response);
                    break;
                default:
                    throw new AssertionError();
            }
        }
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
        String action = request.getParameter("action");
        if (action == null) {
            action = "add";
        }
        switch (action) {
            case "add":
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                Customer newCustomer = new Customer(id, name, phone, email, address);
                boolean addSuccess = dao.addCustomer(newCustomer);

                HttpSession session = request.getSession();
                session.setAttribute("succMess", "Add " + name + " successfully");
                ArrayList<Customer> newlistCus = dao.getAllCustomers();
                request.setAttribute("listCus", newlistCus);
                response.sendRedirect("customer?action=view");
                break;

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
