/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.CustomerDAO;
import dao.ProductDAO;
import entity.Customer;
import entity.Product;
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
@WebServlet(name = "SearchProductServlet", urlPatterns = {"/searchProduct"})
public class SearchProductServlet extends HttpServlet {

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
            out.println("<title>Servlet SearchProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchProductServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        String key = request.getParameter("key");
        ProductDAO dao = new ProductDAO();
        ArrayList<Product> list = new ArrayList<>();
        if(!key.isEmpty()){
           list = dao.searchProductByNameNDescribe(key, key);

        }

        PrintWriter out = response.getWriter();

        for (Product product : list) {
            String shortDescribe = product.getDescribe();
            if (shortDescribe.length() > 30) {
                shortDescribe = shortDescribe.substring(0, 50) + "...";
            }

            out.println("<tr><td>"
                    + product.getName() + " - Tồn:"
                    + product.getQuantity() + " - "
                    + shortDescribe + "</td>\n"
                    + "<td>"
                    + "<input type='hidden' id='pName_" + product.getId() + "' value='" + product.getName() + "' />"
                    + "<input type='hidden' id='pQuantity_" + product.getId() + "' value='" + product.getQuantity() + "' />"
                    + "<input type='hidden' id='pDescribe_" + product.getId() + "' value='" + product.getDescribe() + "' />"
                    + "<input type='hidden' id='pPrice_" + product.getId()+ "' value='" + product.getPrice()+ "' />"
                    + "<button onclick=\"choosePro('" + product.getId() + "')\">Choose</button>"
                    + "</td>\n"
                    + "</tr>");
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
