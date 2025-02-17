/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.LoginDAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginControl", urlPatterns = {"/login"})
public class LoginControl extends HttpServlet {

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

        HttpSession session = request.getSession();
        // Add these headers to prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        String username = request.getParameter("name");
        String password = request.getParameter("password");
        request.setAttribute("name", username);
        request.setAttribute("password", password);

        password = hashpassword.toSHA1(password);
        LoginDAO dao = new LoginDAO();
        User a = dao.login(username);
        if ( a == null || !a.getPassword().equals(password)) {
            request.setAttribute("mess", "Wrong User or Password");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {

            session.setAttribute("acc", a);
            // Kiểm tra xem có URL trả về không
            String returnUrl = (String) session.getAttribute("returnUrl");
            if (returnUrl != null && returnUrl.equals("order")) {
                session.removeAttribute("returnUrl");
                String script = "<script>"
                        + "alert('Logged in successfully. You will be redirected to the payment page.');"
                        + "window.location='print';"
                        + "</script>";
                response.getWriter().println(script);
            } else {
                String script = "<script>"
                        + "alert('Logged in successfully.');"
                        + "window.location='view/page/dashboard.jsp';"
                        + "</script>";
                response.getWriter().println(script);
            }
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
        session.removeAttribute("mess1");

        // Add these headers to prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies
        // Check if the user is already logged in
        User acc = (User) session.getAttribute("acc");

        if (acc != null) {
            response.sendRedirect("home");
            return;
        }
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("success", successMessage);
            session.removeAttribute("successMessage");
        }
        request.getRequestDispatcher("view/page/login.jsp").forward(request, response);
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
