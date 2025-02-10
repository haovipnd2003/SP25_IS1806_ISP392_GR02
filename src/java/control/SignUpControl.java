/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.UserDAO;
import entity.User;
import helper.BusinessHelper;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;

/**
 *
 * @author dung.nvan
 */
@WebServlet(name = "SignUpControl", urlPatterns = {"/sign-up"})
public class SignUpControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processGetRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SignUpControl</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUpControl at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processPostRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("user");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repass");
        
        if (!BusinessHelper.isValidFieldSignUp(username, email, password, repassword)) {
            this.HandleBusinessError(request, response, "Please fill out the form.");
        }
        
        if (!BusinessHelper.validateEmail(email)) {
            this.HandleBusinessError(request, response, "Invalid email address.");
        }
        
        if (!BusinessHelper.validatePassword(password, repassword)) {
            this.HandleBusinessError(request, response, "Password must be equal.");
        }
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.GetUserByUsernameOrEmail(username, email);
        if (user != null) {
            this.HandleBusinessError(request, response, "Username or Email already exist!");
        }
        
        // to do: handle verify email
        String randomCode = this.getRandomCode();
        boolean isSended = BusinessHelper.sendEmail(email, randomCode);
        if (isSended) {
            HttpSession session = request.getSession();
            session.setAttribute("authCode", randomCode);
            session.setAttribute("currentUserSignUp", new User(username, password, email));
            response.sendRedirect("verifySignUp.jsp");
        }
    }
    
    private void HandleBusinessError(HttpServletRequest request, HttpServletResponse response, String message)
        throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("Signup.jsp").forward(request, response);
    }
    
    private String getRandomCode() {
        Random r = new Random();
        int number = r.nextInt(999999);
        return String.format("%06d", number);
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
        processGetRequest(request, response);
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
        processPostRequest(request, response);
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
