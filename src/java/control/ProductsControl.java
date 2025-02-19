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
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "add":
                    handleAddProduct(request, response);
                    break;
                case "edit":
                    handleEditProduct(request, response);
                    break;
                case "search":  // Thêm case xử lý tìm kiếm
                    handleSearch(request, response);
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
        request.getRequestDispatcher("view/page/addProduct.jsp").forward(request, response);
    }

    private void handleEditProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy id từ request và lấy thông tin sản phẩm từ database
        String id = request.getParameter("id");
        Products product = productsDAO.getProductById(id);

        // Đặt sản phẩm vào request attribute để hiển thị trong form cập nhật
        request.setAttribute("product", product);
        request.getRequestDispatcher("view/page/updateProduct.jsp").forward(request, response);
    }

    private void handleDefault(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int pageSize = 10; // Số lượng sản phẩm mỗi trang

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        List<Products> productList = productsDAO.getAllProducts(page, pageSize);
        int totalProducts = productsDAO.getTotalProducts();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        request.setAttribute("productList", productList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("view/page/products.jsp").forward(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Products> productList = productsDAO.searchProducts(keyword);
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
        response.sendRedirect("products");
    }

    private void updateProducts(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve product data from the form
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String describe = request.getParameter("describe");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String zoneId = request.getParameter("zoneId");
        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

        // Create a Products object with the updated data
        Products product = new Products(id, name, describe, price, quantity, zoneId, isActive);

        // Update the product in the database
        productsDAO.update(product);

        // Redirect back to the products list page
        response.sendRedirect("products");
    }

    private void deleteProducts(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        productsDAO.delete(id);
        response.sendRedirect("products");
    }
}
