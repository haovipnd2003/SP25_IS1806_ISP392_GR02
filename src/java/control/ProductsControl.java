package control;

import dao.ProductDAO;
import entity.Product;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.User; // Add this import statement
import dao.ZoneDAO;
import entity.Zone;

@WebServlet(name = "Products", urlPatterns = {"/products"})
public class ProductsControl extends HttpServlet {

    private ProductDAO productDAO;
    private ZoneDAO zoneDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        zoneDAO = new ZoneDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "add":
                    handleAddProduct(request, response);
                    break;
                case "edit":
                    handleEditProduct(request, response);
                    break;
                case "search":  
                    handleSearch(request, response);
                    break;
                case "filter":
                    handleFilter(request, response);
                    break;
                default:
                    handleDefault(request, response);
                    break;
            }
        } else {
            handleDefault(request, response);
        }
    }

    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> productList = productDAO.getAllProducts(1, Integer.MAX_VALUE);
        List<Zone> activeZones = zoneDAO.getActiveZones();
        request.setAttribute("productList", productList);
        request.setAttribute("activeZones", activeZones);
        request.getRequestDispatcher("view/page/addProduct.jsp").forward(request, response);
    }

    private void handleEditProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Product product = productDAO.getProductById(id);
        List<Zone> activeZones = zoneDAO.getActiveZones();
        
        request.setAttribute("product", product);
        request.setAttribute("activeZones", activeZones);
        request.getRequestDispatcher("view/page/updateProduct.jsp").forward(request, response);
    }

    private void handleDefault(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("acc");
        if (user != null) {
            request.setAttribute("roletype", user.getRoletype().toString()); 
        } else {
            request.setAttribute("roletype", null);
        }

        int page = 1;
        int pageSize = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        List<Product> productList = productDAO.getAllProducts(page, pageSize);
        int totalProducts = productDAO.getTotalProducts();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        List<Zone> zones = zoneDAO.getActiveZones();

        request.setAttribute("productList", productList);
        request.setAttribute("zones", zones);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("view/page/products.jsp").forward(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Product> productList = productDAO.searchProducts(keyword);
        List<Zone> zones = zoneDAO.getActiveZones();
        
        // Thêm thông tin người dùng
        User user = (User) request.getSession().getAttribute("acc");
        if (user != null) {
            request.setAttribute("roletype", user.getRoletype().toString()); 
        } else {
            request.setAttribute("roletype", null);
        }
        
        request.setAttribute("productList", productList);
        request.setAttribute("zones", zones);
        request.getRequestDispatcher("view/page/products.jsp").forward(request, response);
    }

    private void handleFilter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Boolean isActive = null;
        String zoneId = null;

        // Lấy tham số lọc với kiểm tra null và giá trị mặc định
        String isActiveParam = request.getParameter("isActive");
        if (isActiveParam != null && !isActiveParam.equals("default")) {
            isActive = Boolean.parseBoolean(isActiveParam);
        }

        String zoneIdParam = request.getParameter("zoneId");
        if (zoneIdParam != null && !zoneIdParam.equals("default")) {
            zoneId = zoneIdParam;
        }

        // Gọi DAO để lọc
        List<Product> productList = productDAO.filterProductsByActiveAndZone(isActive, zoneId);
        List<Zone> zones = zoneDAO.getActiveZones();

        // Set các attribute cho JSP
        request.setAttribute("productList", productList);
        request.setAttribute("zones", zones);
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
        try {
            String name = request.getParameter("name");
            String describe = request.getParameter("describe");
            double price = Double.parseDouble(request.getParameter("price"));
            double quantity = Double.parseDouble(request.getParameter("quantity"));
            String[] zoneIds = request.getParameterValues("zoneIds");
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
            String image = request.getParameter("image");

            Product product = new Product();
            product.setName(name);
            product.setDescribe(describe);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setZoneIds(zoneIds);
            product.setActive(isActive);
            product.setImage(image);
            productDAO.insert(product);
            request.getSession().setAttribute("toastMessage", "Product added successfully!");
            request.getSession().setAttribute("toastType", "success");
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("toastMessage", "Failed to add product!");
            request.getSession().setAttribute("toastType", "error");
        }
        response.sendRedirect("products");
    }

    private void updateProducts(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String describe = request.getParameter("describe");
            double price = Double.parseDouble(request.getParameter("price"));
            double quantity = Double.parseDouble(request.getParameter("quantity"));
            String[] zoneIds = request.getParameterValues("zoneIds");
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
            String image = request.getParameter("image");

            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setDescribe(describe);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setZoneIds(zoneIds);
            product.setActive(isActive);
            product.setImage(image);
            productDAO.update(product);
            request.getSession().setAttribute("toastMessage", "Product updated successfully!");
            request.getSession().setAttribute("toastType", "success");
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("toastMessage", "Failed to update product!");
            request.getSession().setAttribute("toastType", "error");
        }
        response.sendRedirect("products");
    }

    private void deleteProducts(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        productDAO.delete(id);
        if (request.getSession().getAttribute("toastMessage") == null) {
            request.getSession().setAttribute("toastMessage", "Product deleted successfully!");
            request.getSession().setAttribute("toastType", "success");
        }
        response.sendRedirect("products");
    }
}
