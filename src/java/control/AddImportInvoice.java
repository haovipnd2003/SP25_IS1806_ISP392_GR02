package control;

import dao.InvoiceDAO;
import dao.ProductDAO;
import entity.Customer;
import entity.OrderItems;
import entity.Product;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddImportInvoice", urlPatterns = {"/addImportInvoice"})
public class AddImportInvoice extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        try {
            // Nhận dữ liệu từ request
            String[] productIds = request.getParameterValues("productID");
            String[] dropdowns = request.getParameterValues("dropdown");
            String[] quantities = request.getParameterValues("quantity");
            String[] totalMasses = request.getParameterValues("totalMass");
            String[] discounts = request.getParameterValues("discount");

            // Ghi log dữ liệu đầu vào
            out.write("Received Data:\n");
            out.write("Products Count: " + (productIds != null ? productIds.length : "null") + "\n");
            out.flush();

            if (productIds != null) {
                for (int i = 0; i < productIds.length; i++) {
                    out.write("ProductID: " + productIds[i] + 
                              ", Dropdown: " + dropdowns[i] +
                              ", Quantity: " + quantities[i] +
                              ", TotalMass: " + totalMasses[i] +
                              ", Discount: " + discounts[i] + "\n");
                }
                out.flush();
            }

            // Lấy dữ liệu từ session
            String grandMoney = (String) session.getAttribute("totalGrand");
            String customerPay = (String) session.getAttribute("customerPay");
            Customer customer = (Customer) session.getAttribute("customerInfo");

            if (customer == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("Error: Customer information is missing. Please select a customer.\n");
                out.flush();
                return;
            }

            String customerId = customer.getId();
            String realTime = getRealTime();
            User user = (User) session.getAttribute("acc");

            out.write("Grand Money: " + grandMoney + "\n");
            out.write("Customer Pay: " + customerPay + "\n");
            out.write("Customer ID: " + customerId + "\n");
            out.flush();

            // Tạo hóa đơn
            InvoiceDAO invoiceDAO = new InvoiceDAO();
            invoiceDAO.addImportInvoice(customerId, user.getId(), grandMoney, customerPay, 1, realTime, user.getName());

            // Lấy orderID mới tạo
            String orderID = invoiceDAO.getLatestOrderId();
            out.write("Order Created - Order ID: " + orderID + "\n");
            out.flush();

            long totalPrice = 0;
            List<OrderItems> orderDetails = new ArrayList<>();
            ProductDAO proDAO = new ProductDAO();

            if (productIds != null) {
                for (int i = 0; i < productIds.length; i++) {
                    Product proFromID = proDAO.getProductById2(productIds[i]);

                    if (proFromID == null) {
                        out.write("Warning: Product not found with ID: " + productIds[i] + "\n");
                        out.flush();
                        continue;
                    }

                    String productName = proFromID.getName();
                    double price1kg = proFromID.getPrice();
                    String describe = proFromID.getDescribe();

                    double dropdown = Double.parseDouble(dropdowns[i]);
                    double quantity = Double.parseDouble(quantities[i]);
                    double totalMass = Double.parseDouble(totalMasses[i]);
                    double discount = Double.parseDouble(discounts[i]);

                    totalPrice = (long) ((price1kg - discount) * quantity * dropdown);

                    OrderItems orderItem = new OrderItems(null, orderID, productIds[i], productName,
                            String.valueOf(price1kg), describe, String.valueOf(quantity),
                            String.valueOf(dropdown), String.valueOf(discount), String.valueOf(totalPrice));

                    orderDetails.add(orderItem);

                    invoiceDAO.addOrderItems(orderID, productIds[i], productName, String.valueOf(price1kg),
                            describe, String.valueOf(quantity), String.valueOf(dropdown),
                            String.valueOf(discount), String.valueOf(totalPrice));

                    out.write("Added Order Item - Product ID: " + productIds[i] + ", Total Price: " + totalPrice 
                            + "price1kg: "+price1kg+  "discount: "+discount+"quantity: "+quantity+ "dropdown: "+dropdown+"\n");
                    out.flush();
                    
                    //Cập nhật tồn kho
                    ProductDAO proDao = new ProductDAO();
                    Product pro = proDao.getProductById2(productIds[i]);
                    double stock = pro.getQuantity() + quantity;
                    invoiceDAO.updateStock(productIds[i], String.valueOf(stock));
                }
            } else {
                out.write("No products received.\n");
                out.flush();
            }

            out.write("Processing completed successfully.\n");
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("Error: " + e.getMessage() + "\n");
            out.flush();
        }
    }

    private String getRealTime() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return now.format(formatter);
    }
}
