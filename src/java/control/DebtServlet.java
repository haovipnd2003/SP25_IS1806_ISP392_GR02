/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DebtDAO;
import entity.Debtor;
import entity.User;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author vietanhdang
 */
public class DebtServlet extends HttpServlet {

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
            out.println("<title>Servlet DebtServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DebtServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("acc");
        if (u == null) {
            request.getRequestDispatcher("/login").forward(request, response);
        } 
        else {
            int page = 1; 
            int recordsPerPage = 5; 
            if (request.getParameter("page") != null) 
                page = Integer.parseInt( 
                    request.getParameter("page")); 
            DebtDAO dao = new DebtDAO(); 
            List<Debtor> list = dao.viewAllDebtors( 
                (page - 1) * recordsPerPage, 
                recordsPerPage); 
            int noOfRecords = dao.getNoOfRecords(); 
            int noOfPages = (int)Math.ceil(noOfRecords * 1.0
                                           / recordsPerPage); 
            request.setAttribute("debtorList", list); 
            request.setAttribute("noOfPages", noOfPages); 
            request.setAttribute("currentPage", page); 
            request.getRequestDispatcher("/view/page/debt.jsp").forward(request, response);
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
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        double totalDebt = Double.parseDouble(request.getParameter("debt"));
        Debtor debtor = new Debtor(name, phone, email, address, totalDebt);
        DebtDAO debtDAO = new DebtDAO();
        boolean success = debtDAO.insertDebtor(debtor);
        request.getRequestDispatcher("/view/page/debt.jsp").forward(request, response);
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
