package control;

import dao.ProductsDAO;
import entity.Products;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Products", urlPatterns = {"/products"})
public class ProductsControl extends HttpServlet {

    private ProductsDAO productsDAO;

    @Override
    public void init() throws ServletException {
        productsDAO = new ProductsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Products> productList = productsDAO.getAllProducts();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("view/page/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action != null) {
            switch (action) {
                case "insert":
                    insertProducts(request, response);
                    break;
                case "update":
                    updateProducts(request, response);
                    break;
                case "delete":
                    deleteProducts(request, response);
                    break;
            }
        }
    }

    private void insertProducts(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String describe = request.getParameter("describe");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String zoneId = request.getParameter("zoneId");
        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
        
        Products products = new Products(id, name, describe, price, quantity, zoneId, isActive);
        productsDAO.insert(products);
        response.sendRedirect("/products");
    }

    private void updateProducts(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String describe = request.getParameter("describe");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String zoneId = request.getParameter("zoneId");
        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
        
        Products product = new Products(id, name, describe, price, quantity, zoneId, isActive);
        productsDAO.update(product);
        response.sendRedirect("/products");
    }

    private void deleteProducts(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        productsDAO.delete(id);
        response.sendRedirect("/products");
    }
}