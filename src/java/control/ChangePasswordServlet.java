/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.LoginDAO;
import dao.UserDAO;
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
 * @author binh2
 */
@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/changePassword"})
public class ChangePasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet ChangePasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordServlet at " + request.getContextPath() + "</h1>");
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
        response.sendRedirect("view/page/updatePassword.jsp");
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
        String oldPass = request.getParameter("old_pass");
        String newPass = request.getParameter("new_pass");
        String confPass = request.getParameter("confirm_pass");

        if (oldPass.isEmpty()) {
            request.setAttribute("error", "Old Password is empty");
            request.getRequestDispatcher("view/page/updatePassword.jsp").forward(request, response);
        }

        String encode_oldPass = hashpassword.toSHA1(oldPass);
        LoginDAO dao = new LoginDAO();
        if (dao.loginByNameNPass(name, encode_oldPass) == null) {
            request.setAttribute("error", "Wrong Old Password");
            request.getRequestDispatcher("view/page/updatePassword.jsp").forward(request, response);
        } else if (!validPass(newPass)) {
            request.setAttribute("error", "New Password at least 6 characters");
            request.getRequestDispatcher("view/page/updatePassword.jsp").forward(request, response);
        } else if (!newPass.equals(confPass)) {
            request.setAttribute("error", "Confirm password is not match");
            request.getRequestDispatcher("view/page/updatePassword.jsp").forward(request, response);
        } else {
            String encode_newPass = hashpassword.toSHA1(newPass);
            UserDAO udao = new UserDAO();
            udao.updatePassword(encode_newPass, name);
            request.setAttribute("mess", "Change password successfully");
            request.getRequestDispatcher("view/page/updatePassword.jsp").forward(request, response);
        }

    }

    public boolean validPass(String pass) {
        String check = ".{6,}";
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
