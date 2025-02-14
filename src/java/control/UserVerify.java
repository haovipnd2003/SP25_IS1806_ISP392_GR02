/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 *
 * @author acer
 */
@WebServlet(name = "UserVerify", urlPatterns = {"/UserVerify"})
public class UserVerify extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     private static final int OTP_EXPIRY_TIME = 60; // 5 minutes

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String resend = request.getParameter("resend");
        String resend_register = request.getParameter("resend_register");
        HttpSession session = request.getSession();

        if (resend != null) {
            User user = (User) session.getAttribute("authcode");
            String email = user.getEmail();

            SendEmail sm = new SendEmail();
            String code = sm.getRandom();
            user.setCode(code);

            session.setAttribute("authcode", user);
            session.setAttribute("otpExpiryTime", System.currentTimeMillis() + OTP_EXPIRY_TIME * 1000);
            session.setAttribute("message", "A new OTP is being sent to " + email + ". Please check your inbox.");
            session.removeAttribute("otpAttempts");

            executorService.submit(() -> {
                boolean test = sm.sendEmail(user);
                if (test) {
                    session.setAttribute("message", "A new OTP has been sent to " + email + ". Please check your inbox.");
                } else {
                    session.setAttribute("message", "Failed to send the new OTP. Please try again.");
                }
            });
            request.getRequestDispatcher("view/page/enterOtp.jsp").forward(request, response);
        } else if (resend_register != null) {
            User user = (User) session.getAttribute("authcode");
            String email = user.getEmail();

            SendEmail sm = new SendEmail();
            String code = sm.getRandom();
            user.setCode(code);

            session.setAttribute("authcode", user);
            session.setAttribute("otpExpiryTime", System.currentTimeMillis() + OTP_EXPIRY_TIME * 1000);
            session.setAttribute("message", "A new OTP is being sent to " + email + ". Please check your inbox.");
            session.removeAttribute("otpAttempts");

            executorService.submit(() -> {
                boolean test = sm.sendEmail(user);
                if (test) {
                    session.setAttribute("message", "A new OTP has been sent to " + email + ". Please check your inbox.");
                } else {
                    session.setAttribute("message", "Failed to send the new OTP. Please try again.");
                }
            });
            request.getRequestDispatcher("view/page/enterOtp_Reg.jsp").forward(request, response);
        } else {
            String email = request.getParameter("email");
            SendEmail sm = new SendEmail();
            String code = sm.getRandom();
            User user = new User(email, code);
            DAO d = new DAO();
            request.setAttribute("email", email);
            session.setAttribute("authcode", user);
            session.setAttribute("otpExpiryTime", System.currentTimeMillis() + OTP_EXPIRY_TIME * 1000);
            if (d.isAccountExists(email)) {
                session.setAttribute("message", "An OTP is being sent to " + email + ". Please check your inbox.");

                executorService.submit(() -> {
                    boolean test = sm.sendEmail(user);
                    if (test) {
                        session.setAttribute("message", "An email has been sent to " + email + ". Please check your inbox.");
                    } else {
                        session.setAttribute("message", "Failed to send email. Please try again.");
                    }
                });
                request.getRequestDispatcher("view/page/enterOtp.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Email is invalid");
                request.getRequestDispatcher("view/page/forgotPassword.jsp").forward(request, response);
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
    private static final ExecutorService executorService = Executors.newFixedThreadPool(10);

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
    public void destroy() {
        executorService.shutdown();
        super.destroy();
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
