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
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Kiểm tra quyền truy cập
        String roleType = user.getRoletype();
        
        switch (action) {
            case "list":
                if ("1".equals(roleType)) { // Admin
                    handleListAudits(request, response);
                } else if ("2".equals(roleType)) { // Staff
                    handleShowAuditForm(request, response);
                } else {
                    response.sendRedirect("home");
                }
                break;
            case "form":
                if ("2".equals(roleType)) { // Staff
                    handleShowAuditForm(request, response);
                } else {
                    response.sendRedirect("stock-audit");
                }
                break;
            case "details":
                if ("1".equals(roleType)) { // Admin
                    handleShowAuditDetails(request, response);
                } else {
                    response.sendRedirect("stock-audit");
                }
                break;
            case "history":
                if ("1".equals(roleType)) { // Admin
                    handleShowAuditHistory(request, response);
                } else {
                    response.sendRedirect("stock-audit");
                }
                break;
            default:
                if ("1".equals(roleType)) { // Admin
                    handleListAudits(request, response);
                } else if ("2".equals(roleType)) { // Staff
                    handleShowAuditForm(request, response);
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
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Kiểm tra quyền truy cập
        String roleType = user.getRoletype();
        
        switch (action) {
            case "submit-audit":
                if ("2".equals(roleType)) { // Staff
                    handleSubmitAudit(request, response);
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

    private void handleShowAuditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách zone
        ZoneDAO zoneDAO = new ZoneDAO();
        List<Zone> zones = zoneDAO.getActiveZones();
        request.setAttribute("zones", zones);
        
        // Nếu đã chọn zone, hiển thị danh sách sản phẩm trong zone đó
        String zoneId = request.getParameter("zoneId");
        if (zoneId != null && !zoneId.isEmpty()) {
            List<Product> products = zoneDAO.getProductsInZone(zoneId);
            request.setAttribute("products", products);
            request.setAttribute("selectedZoneId", zoneId);
            
            // Lấy thông tin zone đã chọn
            Zone selectedZone = zoneDAO.getZoneById(zoneId);
            request.setAttribute("selectedZone", selectedZone);
        }
        
        request.getRequestDispatcher("view/staff/stock-audit-form.jsp").forward(request, response);
    }

    private void handleSubmitAudit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        String zoneId = request.getParameter("zoneId");
        String[] productIds = request.getParameterValues("productId");
        String[] expectedQuantities = request.getParameterValues("expectedQuantity");
        String[] actualQuantities = request.getParameterValues("actualQuantity");
        String[] notes = request.getParameterValues("note");
        
        if (zoneId == null || productIds == null || expectedQuantities == null || actualQuantities == null) {
            setToastMessage(request, "Dữ liệu kiểm kho không hợp lệ", "error");
            response.sendRedirect("stock-audit?action=form");
            return;
        }
        
        StockAuditDAO auditDAO = new StockAuditDAO();
        Date auditDate = Date.valueOf(LocalDate.now());
        boolean success = true;
        
        for (int i = 0; i < productIds.length; i++) {
            String productId = productIds[i];
            double expectedQuantity = Double.parseDouble(expectedQuantities[i]);
            double actualQuantity = Double.parseDouble(actualQuantities[i]);
            double difference = actualQuantity - expectedQuantity;
            String note = (notes != null && i < notes.length) ? notes[i] : "";
            
            StockAudit audit = new StockAudit();
            audit.setAuditDate(auditDate);
            audit.setZoneId(zoneId);
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
            Zone zone = zoneDAO.getZoneById(zoneId);
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