
package control;

import dao.InvoiceDAO;
import entity.OrderItems;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.text.NumberFormat;
import java.util.Locale;

/**
 *
 * @author binh2
 */
@WebServlet(name = "InvoiceStatisticDetail", urlPatterns = {"/invoiceStatisticDetail"})
public class InvoiceStatisticDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }


//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        PrintWriter out = response.getWriter();
//        InvoiceDAO dao = new InvoiceDAO();
//        ArrayList<OrderItems> Olist = new ArrayList<>();
//        
//        String invoiceId = request.getParameter("invoiceId");
//
//        Olist = dao.getOrderItemsByOrderID(invoiceId);
//        
//            // Xây dựng HTML để gửi về AJAX
//    StringBuilder htmlResponse = new StringBuilder();
//    int index = 1; // Số thứ tự
//
//    for (OrderItems item : Olist) {
//        double totalMass = Double.parseDouble(item.getQuantityInput())*Double.parseDouble(item.getPackaging());
//        htmlResponse.append("<tr>");
//        htmlResponse.append("<td>").append(index++).append("</td>"); // Số thứ tự
//        htmlResponse.append("<td>").append(item.getProductName()).append("</td>"); // Tên sản phẩm
//        htmlResponse.append("<td>").append(item.getPackaging()).append("</td>"); // Quy cách đóng gói
//        htmlResponse.append("<td>").append(item.getQuantityInput()).append("</td>"); // Số lượng
//        htmlResponse.append("<td>").append(totalMass).append("</td>"); // Khối lượng tổng
//        htmlResponse.append("<td>").append(item.getPrice1kg()).append("</td>"); // Giá 1 Kg
//        htmlResponse.append("<td>").append(item.getDiscount()).append("</td>"); // Giảm giá
//        htmlResponse.append("<td>").append(item.getAmountMoney()).append("</td>"); // Thành tiền
//        htmlResponse.append("</tr>");
//    }
//
//    out.print(htmlResponse.toString()); // Trả về HTML để hiển thị trong bảng
//        
//    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html");
    response.setCharacterEncoding("UTF-8");
    
    String invoiceId = request.getParameter("invoiceId");
    InvoiceDAO dao = new InvoiceDAO();
    ArrayList<OrderItems> Olist = dao.getOrderItemsByOrderID(invoiceId);
    
    PrintWriter out = response.getWriter();
    
    if (Olist.isEmpty()) {
        out.println("<tr><td colspan='8' class='text-center'>Không có dữ liệu.</td></tr>");
    } else {
        int index = 1;
        for (OrderItems item : Olist) {
            double totalMass = Double.parseDouble(item.getQuantityInput())*Double.parseDouble(item.getPackaging());
            String price1kg = formatMoney(Double.parseDouble(item.getPrice1kg())*1000);
            String discount = formatMoney(Double.parseDouble(item.getDiscount()));
            String money = formatMoney(Double.parseDouble( item.getAmountMoney())*1000);
            out.println("<tr>");
            out.println("<td>" + index++ + "</td>");
            out.println("<td>" + item.getProductName() + "</td>");
            out.println("<td>" + item.getPackaging() + "</td>");
            out.println("<td>" + item.getQuantityInput() + "</td>");
            out.println("<td>" + totalMass + " kg</td>");
            out.println("<td>" + price1kg + " ₫</td>");
            out.println("<td>" + discount + " ₫</td>");
            out.println("<td>" + money + " ₫</td>");
            out.println("</tr>");
        }
    }
    
    out.flush();
}




    
    private String formatMoney(double amount) {
        // Tạo NumberFormat cho tiền tệ
        NumberFormat numberFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
        numberFormat.setGroupingUsed(true); // Sử dụng phân cách hàng nghìn
        
        // Định dạng tiền tệ và thêm ký hiệu ₫
        return numberFormat.format(amount);
    }




    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
