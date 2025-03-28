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
                double totalMassValue  = Double.parseDouble(item.getQuantityInput()) * Double.parseDouble(item.getPackaging());
                String price1kg = formatMoney(Double.parseDouble(item.getPrice1kg()));
                String discount = formatMoney(Double.parseDouble(item.getDiscount()));
                String money = formatMoney(Double.parseDouble(item.getAmountMoney()));

                // Chuyển đổi quy cách từ "50.0" thành "50kg"
                String packaging = item.getPackaging();
                if (packaging.endsWith(".0")) {
                    packaging = packaging.substring(0, packaging.length() - 2) + " kg";
                } else {
                    packaging += "kg";
                }

                // Chuyển đổi số lượng từ "11.0" thành "11"
                String quantityInput = item.getQuantityInput();
                if (quantityInput.endsWith(".0")) {
                    quantityInput = quantityInput.substring(0, quantityInput.length() - 2);
                }

                // Chuyển đổi tổng khối lượng từ "55.0" thành "55kg"
                String totalMass = (totalMassValue % 1 == 0) ? ((int) totalMassValue + " kg") : (totalMassValue + " kg");
                
                out.println("<tr>");
                out.println("<td>" + index++ + "</td>");
                out.println("<td>" + item.getProductName() + "</td>");
                out.println("<td>" + packaging + "</td>");
                out.println("<td>" + quantityInput + "</td>");
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
