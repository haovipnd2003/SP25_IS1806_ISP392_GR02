/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;

/**
 *
 * @author binh2
 */
@WebServlet(name = "GrandTotalServlet", urlPatterns = {"/grandTotalServlet"})
public class GrandTotalServlet extends HttpServlet {

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
            out.println("<title>Servlet GrandTotalServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GrandTotalServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        try {
            String[] totalAmounts = request.getParameterValues("totalAmounts[]");
            long grandTotal = 0;

            if (totalAmounts != null && totalAmounts.length > 0) {
                for (String amount : totalAmounts) {
                    if (amount != null && !amount.trim().isEmpty()) {
                        String cleanAmount = amount.replace(".", "").replaceAll("[^0-9]", "");
                        try {
                            long value = Long.parseLong(cleanAmount); // Ép kiểu trực tiếp sang long
                            grandTotal += value;
                        } catch (NumberFormatException e) {
                            System.out.println("Bỏ qua giá trị không hợp lệ: " + amount);
                        }
                    }
                }
            }

            
            System.out.println("Tổng tiền hàng: " + grandTotal);
            response.getWriter().write(String.valueOf(grandTotal));

            
            HttpSession session = request.getSession();
             session.setAttribute("totalGrand", String.valueOf(grandTotal));
        } catch (Exception e) {
            System.out.println("Lỗi khi tính tổng tiền hàng: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("0");
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
