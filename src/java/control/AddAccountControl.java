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
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddAccountControl", urlPatterns = {"/addaccount"})
public class AddAccountControl extends HttpServlet {

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
            out.println("<title>Servlet AddAccountControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAccountControl at " + request.getContextPath() + "</h1>");
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
        DAO dao = new DAO();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String pass = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String roletype = request.getParameter("roletype");

        if (name.isEmpty() || pass.isEmpty()) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Username and password cannot be blank!\"}");
            return;
        }

        if (!isValidEmail(email)) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Invalid email format!\"}");
            return;
        }

        if (name.contains(" ")) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Username cannot contain spaces!\"}");
            return;
        }

        if (!validPass(pass)) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Password must be at least 6 characters long!\"}");
            return;
        }

        ArrayList<User> list = dao.getAccount();
        for (User u : list) {
            if (email.equals(u.getEmail())) {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Email already exists!\"}");
                return;
            }
            if (name.equals(u.getName())) {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Username already exists!\"}");
                return;
            }
        }

        pass = hashpassword.toSHA1(pass);
        User newUser = new User(name, pass, email, phone, address, roletype);
        dao.addUser(newUser);

        response.getWriter().write("{\"status\":\"success\", \"message\":\"Account has been created successfully!\"}");
    }

    // Kiểm tra mật khẩu có ít nhất 6 ký tự
    public boolean validPass(String pass) {
        return pass.length() >= 6;
    }

    // Kiểm tra định dạng email
    public boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

}
