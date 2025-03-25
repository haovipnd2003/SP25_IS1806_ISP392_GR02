package control.Admin;

import dao.ProductDAO;
import dao.StockAuditDAO;
import dao.ZoneDAO;
import entity.Product;
import entity.StockAudit;
import entity.User;
import entity.Zone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "StockAuditController", urlPatterns = {"/stock-audit"})
public class StockAuditController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        String roleType = String.valueOf(user.getRoletype());
        
        switch (action) {
            case "list":
                if ("2".equals(roleType)) { // Admin
                    handleListAudits(request, response);
                } else if ("3".equals(roleType)) { // Staff
                    handleShowProductList(request, response);
                } else {
                    response.sendRedirect("home");
                }
                break;
            case "form":
                if ("3".equals(roleType)) { // Staff
                    handleShowProductList(request, response);
                } else {
                    response.sendRedirect("stock-audit");
                }
                break;
            case "audit-product":
                if ("3".equals(roleType)) { // Staff
                    handleShowProductAuditForm(request, response);
                } else {
                    response.sendRedirect("stock-audit");
                }
                break;
            case "details":
                if ("2".equals(roleType)) { // Admin
                    handleShowAuditDetails(request, response);
                } else {
                    response.sendRedirect("stock-audit");
                }
                break;
            case "history":
                if ("2".equals(roleType)) { // Admin
                    handleShowAuditHistory(request, response);
                } else {
                    response.sendRedirect("stock-audit");
                }
                break;
            default:
                if ("2".equals(roleType)) { // Admin
                    handleListAudits(request, response);
                } else if ("3".equals(roleType)) { // Staff
                    handleShowProductList(request, response);
                } else {
                    response.sendRedirect("home");
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        String roleType = String.valueOf(user.getRoletype());
        
        switch (action) {
            case "submit-audit":
                if ("3".equals(roleType)) { // Staff
                    handleSubmitProductAudit(request, response);
                } else {
                    response.sendRedirect("stock-audit");
                }
                break;
            default:
                response.sendRedirect("stock-audit");
                break;
        }
    }

    private void handleListAudits(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số phân trang
        int page = 1;
        int pageSize = 10;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        StockAuditDAO auditDAO = new StockAuditDAO();
        
        // Lấy danh sách các ngày kiểm kho
        List<Date> auditDates = auditDAO.getDistinctAuditDates();
        request.setAttribute("auditDates", auditDates);
        
        // Lấy danh sách kiểm kho theo trang
        List<StockAudit> audits = auditDAO.getAllAudits(page, pageSize);
        int totalAudits = auditDAO.getTotalAudits();
        int totalPages = (int) Math.ceil((double) totalAudits / pageSize);
        
        request.setAttribute("audits", audits);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalAudits", totalAudits);
        
        request.getRequestDispatcher("view/admin/stock-audit-list.jsp").forward(request, response);
    }

    private void handleShowProductList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số tìm kiếm
        String keyword = request.getParameter("keyword");
        
        // Lấy tham số phân trang
        int page = 1;
        int pageSize = 10; // Hoặc số lượng phù hợp với giao diện của bạn
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Lấy danh sách sản phẩm
        ProductDAO productDAO = new ProductDAO();
        List<Product> products;
        
        if (keyword != null && !keyword.isEmpty()) {
            products = productDAO.searchProducts(keyword);
        } else {
            products = productDAO.getAllProducts(page, pageSize);
        }
        
        // Lấy thông tin kiểm kho gần nhất cho mỗi sản phẩm
        StockAuditDAO auditDAO = new StockAuditDAO();
        Map<String, Date> lastAuditDates = new HashMap<>();
        
        for (Product product : products) {
            Date lastAuditDate = auditDAO.getLastAuditDateForProduct(product.getId());
            lastAuditDates.put(product.getId(), lastAuditDate);
        }
        
        request.setAttribute("products", products);
        request.setAttribute("lastAuditDates", lastAuditDates);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        
        // Tính tổng số trang nếu cần phân trang
        if (keyword == null || keyword.isEmpty()) {
            int totalProducts = productDAO.getTotalProducts();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            request.setAttribute("totalPages", totalPages);
        }
        
        request.getRequestDispatcher("view/staff/stock-audit-product-list.jsp").forward(request, response);
    }
    
    private void handleShowProductAuditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        
        if (productId == null || productId.isEmpty()) {
            setToastMessage(request, "Sản phẩm không hợp lệ", "error");
            response.sendRedirect("stock-audit?action=form");
            return;
        }
        
        // Lấy thông tin sản phẩm
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);
        
        if (product == null) {
            setToastMessage(request, "Không tìm thấy sản phẩm", "error");
            response.sendRedirect("stock-audit?action=form");
            return;
        }
        
        // Lấy danh sách zone chứa sản phẩm này
        ZoneDAO zoneDAO = new ZoneDAO();
        List<Zone> zones = zoneDAO.getZonesContainingProduct(productId);
        
        // Tạo map để lưu số lượng sản phẩm trong mỗi zone
        Map<Integer, Double> quantityByZone = new HashMap<>();
        double totalQuantity = 0;
        
        for (Zone zone : zones) {
            double quantity = zoneDAO.getProductQuantityInZone(productId, zone.getId());
            quantityByZone.put(zone.getId(), quantity);
            totalQuantity += quantity;
        }
        
        request.setAttribute("product", product);
        request.setAttribute("zones", zones);
        request.setAttribute("quantityByZone", quantityByZone);
        request.setAttribute("totalQuantity", totalQuantity);
        
        request.getRequestDispatcher("view/staff/stock-audit-product-form.jsp").forward(request, response);
    }
    
    private void handleSubmitProductAudit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");
        
        String productId = request.getParameter("productId");
        String expectedQuantityStr = request.getParameter("expectedQuantity");
        String actualQuantityStr = request.getParameter("actualQuantity");
        String note = request.getParameter("note");
        
        if (productId == null || expectedQuantityStr == null || actualQuantityStr == null) {
            setToastMessage(request, "Dữ liệu kiểm kho không hợp lệ", "error");
            response.sendRedirect("stock-audit?action=form");
            return;
        }
        
        try {
            double expectedQuantity = Double.parseDouble(expectedQuantityStr);
            double actualQuantity = Double.parseDouble(actualQuantityStr);
            double difference = actualQuantity - expectedQuantity;
            
            StockAuditDAO auditDAO = new StockAuditDAO();
            Date auditDate = Date.valueOf(LocalDate.now());
            
            // Lấy danh sách zone chứa sản phẩm này
            ZoneDAO zoneDAO = new ZoneDAO();
            List<Zone> zones = zoneDAO.getZonesContainingProduct(productId);
            
            if (zones.isEmpty()) {
                // Nếu không có zone nào chứa sản phẩm, tạo một bản ghi kiểm kho với zoneId = null
                StockAudit audit = new StockAudit();
                audit.setAuditDate(auditDate);
                audit.setZoneId(null);
                audit.setStaffId(user.getId());
                audit.setProductId(productId);
                audit.setExpectedQuantity(expectedQuantity);
                audit.setActualQuantity(actualQuantity);
                audit.setDifference(difference);
                audit.setNote(note);
                
                int result = auditDAO.insert(audit);
                if (result != -1) {
                    setToastMessage(request, "Kiểm kho thành công", "success");
                } else {
                    setToastMessage(request, "Có lỗi xảy ra khi lưu dữ liệu kiểm kho", "error");
                }
            } else {
                // Nếu có zone chứa sản phẩm, tạo một bản ghi kiểm kho cho mỗi zone
                boolean success = true;
                for (Zone zone : zones) {
                    StockAudit audit = new StockAudit();
                    audit.setAuditDate(auditDate);
                    audit.setZoneId(String.valueOf(zone.getId()));
                    audit.setStaffId(user.getId());
                    audit.setProductId(productId);
                    audit.setExpectedQuantity(expectedQuantity);
                    audit.setActualQuantity(actualQuantity);
                    audit.setDifference(difference);
                    audit.setNote(note);
                    
                    int result = auditDAO.insert(audit);
                    if (result == -1) {
                        success = false;
                    }
                }
                
                if (success) {
                    setToastMessage(request, "Kiểm kho thành công", "success");
                } else {
                    setToastMessage(request, "Có lỗi xảy ra khi lưu dữ liệu kiểm kho", "error");
                }
            }
        } catch (NumberFormatException e) {
            setToastMessage(request, "Dữ liệu số lượng không hợp lệ", "error");
        }
        
        response.sendRedirect("stock-audit?action=form");
    }

    private void handleShowAuditDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String dateStr = request.getParameter("date");
        if (dateStr == null || dateStr.isEmpty()) {
            response.sendRedirect("stock-audit");
            return;
        }
        
        Date auditDate = Date.valueOf(dateStr);
        StockAuditDAO auditDAO = new StockAuditDAO();
        
        // Lấy dữ liệu kiểm kho theo ngày, nhóm theo zone
        Map<String, List<StockAudit>> auditsByZone = auditDAO.getAuditsByDateGroupedByZone(auditDate);
        
        // Lấy thông tin zone
        ZoneDAO zoneDAO = new ZoneDAO();
        Map<String, Zone> zoneMap = new HashMap<>();
        for (String zoneId : auditsByZone.keySet()) {
            Zone zone = zoneDAO.getZoneById(Integer.parseInt(zoneId));
            if (zone != null) {
                zoneMap.put(zoneId, zone);
            }
        }
        
        request.setAttribute("auditDate", auditDate);
        request.setAttribute("auditsByZone", auditsByZone);
        request.setAttribute("zoneMap", zoneMap);
        
        request.getRequestDispatcher("view/admin/stock-audit-details.jsp").forward(request, response);
    }

    private void handleShowAuditHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số phân trang
        int page = 1;
        int pageSize = 10;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Lấy tham số lọc theo zone
        String zoneId = request.getParameter("zoneId");
        
        StockAuditDAO auditDAO = new StockAuditDAO();
        List<StockAudit> audits;
        int totalAudits;
        
        if (zoneId != null && !zoneId.isEmpty()) {
            // Lọc theo zone
            audits = auditDAO.getAuditsByZone(zoneId, page, pageSize);
            totalAudits = auditDAO.getTotalAuditsByZone(zoneId);
        } else {
            // Lấy tất cả
            audits = auditDAO.getAllAudits(page, pageSize);
            totalAudits = auditDAO.getTotalAudits();
        }
        
        int totalPages = (int) Math.ceil((double) totalAudits / pageSize);
        
        // Lấy danh sách zone để hiển thị filter
        ZoneDAO zoneDAO = new ZoneDAO();
        List<Zone> zones = zoneDAO.getActiveZones();
        
        request.setAttribute("audits", audits);
        request.setAttribute("zones", zones);
        request.setAttribute("selectedZoneId", zoneId);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalAudits", totalAudits);
        
        request.getRequestDispatcher("view/admin/stock-audit-history.jsp").forward(request, response);
    }

    private void setToastMessage(HttpServletRequest request, String message, String type) {
        request.getSession().setAttribute("toastMessage", message);
        request.getSession().setAttribute("toastType", type);
    }
} 