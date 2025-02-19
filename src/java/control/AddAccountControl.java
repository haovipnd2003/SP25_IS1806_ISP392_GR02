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
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Admin
 */
@WebServlet(name="AddAccountControl", urlPatterns={"/addaccount"})
public class AddAccountControl extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<h1>Servlet AddAccountControl at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        DAO dao = new DAO();
        String name = request.getParameter("user");
        String email = request.getParameter("email");
        String pass1 = request.getParameter("password");
        String pass2 = request.getParameter("repass");
        HttpSession session = request.getSession();

        request.setAttribute("user", name);
        request.setAttribute("email", email);
        request.setAttribute("password", pass1);
        request.setAttribute("confirmpassword", pass2);

        // Kiểm tra username không chứa khoảng trắng
        if (name.contains(" ")) {
            request.setAttribute("err", "Username không được chứa khoảng trắng!");
            request.getRequestDispatcher("view/page/addaccount.jsp").forward(request, response);
            return;
        }

        // Kiểm tra định dạng email
        if (!isValidEmail(email)) {
            request.setAttribute("err", "Email không hợp lệ!");
            request.getRequestDispatcher("view/page/addaccount.jsp").forward(request, response);
            return;
        }

        // Kiểm tra các trường không được bỏ trống
        if (name.isEmpty() || email.isEmpty() || pass1.isEmpty() || pass2.isEmpty()) {
            request.setAttribute("err", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("view/page/addaccount.jsp").forward(request, response);
            return;
        }

        // Kiểm tra độ dài mật khẩu
        if (!validPass(pass1)) {
            request.setAttribute("err", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("view/page/addaccount.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu nhập lại có khớp không
        if (!pass1.equals(pass2)) {
            request.setAttribute("err", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("view/page/addaccount.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xem email hoặc username đã tồn tại chưa
        ArrayList<User> list = dao.getAccount();
        for (User u : list) {
            if (email.equals(u.getEmail())) {
                request.setAttribute("err", "Email đã tồn tại!");
                request.getRequestDispatcher("view/page/addaccount.jsp").forward(request, response);
                return;
            }
            if (name.equals(u.getName())) {
                request.setAttribute("err", "Username đã tồn tại!");
                request.getRequestDispatcher("view/page/addaccount.jsp").forward(request, response);
                return;
            }
        }

        // Mã hóa mật khẩu trước khi lưu vào database
        pass1 = hashpassword.toSHA1(pass1);
        User newUser = new User(name, pass1, email, "3");

        // Lưu vào database
        dao.addUser(newUser);

        session.setAttribute("success", "Tài khoản đã được tạo thành công!");
        response.sendRedirect("view/page/success.jsp");
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

 

