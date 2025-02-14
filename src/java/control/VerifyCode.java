/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.User;
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
 * @author acer
 */
@WebServlet(name = "VerifyCode", urlPatterns = {"/VerifyCode"})
public class VerifyCode extends HttpServlet {

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
            out.println("<title>Servlet VerifyCode</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyCode at " + request.getContextPath() + "</h1>");
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
    private static final int MAX_ATTEMPTS = 3;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String submit = request.getParameter("submit");
        //enter otp for reset password
        if (submit != null) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("authcode");
            long otpExpiryTime = (long) session.getAttribute("otpExpiryTime");
            long currentTime = System.currentTimeMillis();
            Integer attempts = (Integer) session.getAttribute("otpAttempts");
            if (attempts == null) {
                attempts = 0;
            }

            String code = request.getParameter("otp");
            request.setAttribute("code", code);

            if (currentTime > otpExpiryTime) {
                request.setAttribute("error", "OTP has expired. Please request a new one.");
                request.getRequestDispatcher("view/page/enterOtp.jsp").forward(request, response);
                return;
            }

            if (attempts >= MAX_ATTEMPTS) {
                request.setAttribute("error", "Maximum number of attempts reached. Please request a new OTP.");
                request.getRequestDispatcher("view/page/enterOtp.jsp").forward(request, response);
                return;
            }

            if (code.equals(user.getCode())) {
                session.removeAttribute("otpAttempts"); //stop session saving attempts
                request.setAttribute("email", user.getEmail());
                request.getRequestDispatcher("view/page/newPassword.jsp").forward(request, response);
            } else {
                attempts++;
                session.setAttribute("otpAttempts", attempts);
                request.setAttribute("error", "Wrong OTP. Attempt " + attempts + " of " + MAX_ATTEMPTS);
                request.getRequestDispatcher("view/page/enterOtp.jsp").forward(request, response);
            }
        } else {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("authcode");
            long otpExpiryTime = (long) session.getAttribute("otpExpiryTime");
            long currentTime = System.currentTimeMillis();
            Integer attempts = (Integer) session.getAttribute("otpAttempts");
            if (attempts == null) {
                attempts = 0;
            }

            String code = request.getParameter("otp");
            request.setAttribute("code", code);

            if (currentTime > otpExpiryTime) {
                request.setAttribute("error", "OTP has expired. Please request a new one.");
                request.getRequestDispatcher("view/page/enterOtp_Reg.jsp").forward(request, response);
                return;
            }

            if (attempts >= MAX_ATTEMPTS) {
                request.setAttribute("error", "Maximum number of attempts reached. Please request a new OTP.");
                request.getRequestDispatcher("view/page/enterOtp_Reg.jsp").forward(request, response);
                return;
            }

            if (code.equals(user.getCode())) {
                User newUser = (User) session.getAttribute("newUser");
                DAO dao = new DAO();
                dao.addUser(newUser);
                session.removeAttribute("newUser");
                session.removeAttribute("otpAttempts"); //stop session saving attempts
                session.setAttribute("successMessage", "Account created successfully!");
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                attempts++;
                session.setAttribute("otpAttempts", attempts);
                request.setAttribute("error", "Wrong OTP. Attempt " + attempts + " of " + MAX_ATTEMPTS);
                request.getRequestDispatcher("view/page/enterOtp_Reg.jsp").forward(request, response);
            }
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
