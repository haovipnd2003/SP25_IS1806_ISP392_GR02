/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ResetPassword", urlPatterns = {"/ResetPassword"})
public class ResetPassword extends HttpServlet {

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
            out.println("<title>Servlet ResetPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPassword at " + request.getContextPath() + "</h1>");
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
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newpassword");
        String confirmpassword = request.getParameter("confirm-password");
        String hashpass = hashpassword.toSHA1(newPassword);
        DAO d = new DAO();
        if (isValidPassword(newPassword)) {
            if (newPassword.equals(confirmpassword)) {
                d.update(email, hashpass);
                request.setAttribute("mess2", "Password updated successfully. You can now login.");
                request.getRequestDispatcher("view/page/login.jsp").forward(request, response);
            } else {
                request.setAttribute("newpassword", newPassword);
                request.setAttribute("confirmpassword", confirmpassword);
                request.setAttribute("mess1", "Passwords don't match.");
                request.getRequestDispatcher("view/page/newPassword.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("newpassword", newPassword);
            request.setAttribute("confirmpassword", confirmpassword);
            request.getRequestDispatcher("view/page/newPassword.jsp").forward(request, response);
        }
    }

    public boolean isValidPassword(String pass) {
        String check = "^(?=.*[A-Z])(?=.*\\d)(?=.*[-!@#$%^&*()_+|~=`{}\\[\\]:\";'<>?,./]).{6,}$";
        Pattern pattern = Pattern.compile(check);
        Matcher matcher = pattern.matcher(pass);
        return matcher.matches();
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
