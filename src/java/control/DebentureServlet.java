/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DebentureDAO;
import dao.DebtDAO;
import entity.Debenture;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 *
 * @author vietanhdang
 */
public class DebentureServlet extends HttpServlet {

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
        String debtorIdParam = request.getParameter("debtorId");
        if (debtorIdParam == null || debtorIdParam.isBlank() || debtorIdParam.isEmpty()) {
            request.getRequestDispatcher(debtorIdParam).forward(request, response);
        }
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("acc");
        if (u == null) {
            request.getRequestDispatcher("/login").forward(request, response);
        } 
        else {
            int page = 1; 
            int recordsPerPage = 5; 
            int debtorId = Integer.parseInt(debtorIdParam);
            if (request.getParameter("page") != null) 
                page = Integer.parseInt( 
                    request.getParameter("page")); 
            DebentureDAO dao = new DebentureDAO(); 
            List<Debenture> list = dao.viewAllDebenturesByDebtorId(
                debtorId,
                (page - 1) * recordsPerPage, 
                recordsPerPage); 
            int noOfRecords = dao.getNoOfRecords(); 
            int noOfPages = (int)Math.ceil(noOfRecords * 1.0
                                           / recordsPerPage); 
            request.setAttribute("debentureList", list); 
            request.setAttribute("noOfPages", noOfPages); 
            request.setAttribute("currentPage", page); 
            request.getRequestDispatcher("/view/page/debenture.jsp").forward(request, response);
        }
        request.getRequestDispatcher("/view/page/debt.jsp").forward(request, response);
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
            String amountStr = request.getParameter("amount");
            if (amountStr == null || amountStr.isBlank() || amountStr.isEmpty()) {
                request.getRequestDispatcher("/view/page/debenture.jsp").forward(request, response);
            }
            String debtorId = request.getParameter("debtor");
            String note = request.getParameter("note");
            double amount = Double.parseDouble(amountStr.replaceAll("[^\\d.]", ""));
            if (request.getParameter("type").equals("0")) {
                amount = 0 - amount;
            }
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
            Date created = new Date();
            String dateRequest = request.getParameter("created");
            if (dateRequest != null && !dateRequest.isBlank() && !dateRequest.isEmpty()) {
                created = df.parse(request.getParameter("created"));
            }
            Debenture debenture = new Debenture(note, amount, Integer.parseInt(debtorId), created);
            DebentureDAO debentureDAO = new DebentureDAO();
            boolean insertSuccess = debentureDAO.insertDebenture(debenture);
            if (insertSuccess) {
                DebtDAO debtDAO = new DebtDAO();
                debtDAO.updateTotalDebtById(debenture.getDebtorId(), debenture.getAmount());
            }
            request.getRequestDispatcher("/view/page/debenture.jsp").forward(request, response);
        }
        catch (Exception ex) {
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
