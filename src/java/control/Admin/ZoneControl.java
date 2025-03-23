package control.Admin;

import dao.ZoneDAO;
import entity.Zone;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.User;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "Zones", urlPatterns = {"/zoneControl"})
public class ZoneControl extends HttpServlet {

    private ZoneDAO zoneDAO;

    @Override
    public void init() throws ServletException {
        zoneDAO = new ZoneDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "add":
                    handleAddZone(request, response);
                    break;
                case "edit":
                    handleEditZone(request, response);
                    break;
                case "search":
                    handleSearch(request, response);
                    break;
                case "filter":
                    handleFilter(request, response);
                    break;
                case "details":
                    handleZoneDetails(request, response);
                    break;
                default:
                    handleDefault(request, response);
                    break;
            }
        } else {
            handleDefault(request, response);
        }
    }

    private void handleAddZone(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Zone> zoneList = zoneDAO.getAllZones(1, Integer.MAX_VALUE);
        request.setAttribute("zoneList", zoneList);
        request.getRequestDispatcher("view/admin/addZone.jsp").forward(request, response);
    }

    private void handleEditZone(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Zone zone = zoneDAO.getZoneById(id);
        
        // Thêm danh sách zone để kiểm tra trùng tên
        List<Zone> zoneList = zoneDAO.getAllZones(1, Integer.MAX_VALUE);
        
        request.setAttribute("zone", zone);
        request.setAttribute("zoneList", zoneList);
        request.getRequestDispatcher("view/admin/updateZone.jsp").forward(request, response);
    }

    private void handleDefault(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Add pagination support
        int page = 1;
        int pageSize = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        
        List<Zone> zoneList = zoneDAO.getAllZones(page, pageSize);
        
        // Thêm số lượng sản phẩm cho mỗi zone
        for (Zone zone : zoneList) {
            int productCount = zoneDAO.countProductsInZone(zone.getId());
            zone.setProductCount(productCount);
        }
        
        int totalZones = zoneDAO.getTotalZones();
        int totalPages = (int) Math.ceil((double) totalZones / pageSize);

        User user = (User) request.getSession().getAttribute("acc");
        if (user != null) {
            request.setAttribute("roletype", user.getRoletype().toString());
        } else {
            request.setAttribute("roletype", null);
        }

        request.setAttribute("zoneList", zoneList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalZones", totalZones);
        request.getRequestDispatcher("view/admin/zones.jsp").forward(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        // Add pagination support
        int page = 1;
        int pageSize = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        
        List<Zone> zoneList = zoneDAO.searchZones(keyword, page, pageSize);
        
        // Thêm số lượng sản phẩm cho mỗi zone
        for (Zone zone : zoneList) {
            int productCount = zoneDAO.countProductsInZone(zone.getId());
            zone.setProductCount(productCount);
        }
        
        int totalZones = zoneDAO.getTotalSearchResults(keyword);
        int totalPages = (int) Math.ceil((double) totalZones / pageSize);

        User user = (User) request.getSession().getAttribute("acc");
        if (user != null) {
            request.setAttribute("roletype", user.getRoletype().toString());
        } else {
            request.setAttribute("roletype", null);
        }

        request.setAttribute("zoneList", zoneList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("view/admin/zones.jsp").forward(request, response);
    }

    private void handleFilter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String isActive = request.getParameter("isActive");
        
        // Add pagination support
        int page = 1;
        int pageSize = 10;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        
        List<Zone> zoneList = zoneDAO.filterZonesByActive(isActive, page, pageSize);
        
        // Thêm số lượng sản phẩm cho mỗi zone
        for (Zone zone : zoneList) {
            int productCount = zoneDAO.countProductsInZone(zone.getId());
            zone.setProductCount(productCount);
        }
        
        int totalZones = zoneDAO.getTotalFilterResults(isActive);
        int totalPages = (int) Math.ceil((double) totalZones / pageSize);

        User user = (User) request.getSession().getAttribute("acc");
        if (user != null) {
            request.setAttribute("roletype", user.getRoletype().toString());
        } else {
            request.setAttribute("roletype", null);
        }

        request.setAttribute("zoneList", zoneList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("view/admin/zones.jsp").forward(request, response);
    }

    private void handleZoneDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        
        // Lấy thông tin zone
        Zone zone = zoneDAO.getZoneById(id);
        if (zone == null) {
            request.getSession().setAttribute("toastMessage", "Không tìm thấy zone!");
            request.getSession().setAttribute("toastType", "error");
            response.sendRedirect("zoneControl");
            return;
        }
        
        // Đếm số lượng sản phẩm trong zone
        int productCount = zoneDAO.countProductsInZone(id);
        zone.setProductCount(productCount);
        
        // Lấy danh sách sản phẩm trong zone
        List<entity.Product> products = zoneDAO.getProductsInZone(id);
        
        User user = (User) request.getSession().getAttribute("acc");
        if (user != null) {
            request.setAttribute("roletype", user.getRoletype().toString());
        } else {
            request.setAttribute("roletype", null);
        }
        
        request.setAttribute("zone", zone);
        request.setAttribute("products", products);
        request.getRequestDispatcher("view/admin/zone-details.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "insert":
                    insertZone(request, response);
                    break;
                case "update":
                    updateZone(request, response);
                    break;
                case "delete":
                    deleteZone(request, response);
                    break;
            }
        }
    }

    private void insertZone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String name = request.getParameter("name").trim();
            String isActiveParam = request.getParameter("isActive");
            
            Map<String, String> errors = new HashMap<>();
            
            // Validate required fields
            if (name.isEmpty()) {
                errors.put("nameError", "Zone name is required");
            }
            if (isActiveParam == null) {
                errors.put("statusError", "Status is required");
            }
            
            // Check duplicate name
            if (zoneDAO.getZoneByName(name) != null) {
                errors.put("nameError", "Zone name already exists");
            }
            
            if (!errors.isEmpty()) {
                errors.forEach(request.getSession()::setAttribute);
                response.sendRedirect("zoneControl?action=add");
                return;
            }
            
            boolean isActive = Boolean.parseBoolean(isActiveParam);
            Zone zone = new Zone();
            zone.setName(name);
            zone.setIsActive(isActive);
            
            zoneDAO.insert(zone);
            request.getSession().setAttribute("toastMessage", "Zone added successfully!");
            request.getSession().setAttribute("toastType", "success");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("toastMessage", "Error adding zone: " + e.getMessage());
            request.getSession().setAttribute("toastType", "error");
        }
        response.sendRedirect("zoneControl");
    }

    private void updateZone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String id = request.getParameter("id");
            String name = request.getParameter("name").trim();
            String isActiveParam = request.getParameter("isActive");
            
            Map<String, String> errors = new HashMap<>();
            
            // Validate required fields
            if (name.isEmpty()) {
                errors.put("nameError", "Zone name is required");
            }
            if (isActiveParam == null) {
                errors.put("statusError", "Status is required");
            }
            
            // Check duplicate name
            Zone existingZone = zoneDAO.getZoneByName(name);
            if (existingZone != null && !existingZone.getId().equals(id)) {
                errors.put("nameError", "Zone name already exists");
            }
            
            if (!errors.isEmpty()) {
                errors.forEach(request.getSession()::setAttribute);
                response.sendRedirect("zoneControl?action=edit&id=" + id);
                return;
            }
            
            // Kiểm tra id có tồn tại không
            Zone currentZone = zoneDAO.getZoneById(id);
            if (currentZone == null) {
                request.getSession().setAttribute("toastMessage", "Zone not found!");
                request.getSession().setAttribute("toastType", "error");
                response.sendRedirect("zoneControl");
                return;
            }
            
            // Kiểm tra xem tên zone mới có trùng với zone khác không
            if (existingZone != null && !existingZone.getId().equals(id)) {
                request.getSession().setAttribute("toastMessage", "Zone name already exists!");
                request.getSession().setAttribute("toastType", "error");
                response.sendRedirect("zoneControl?action=edit&id=" + id);
                return;
            }
            
            // Nếu đang chuyển từ active sang inactive, kiểm tra xem có sản phẩm không
            if (currentZone.isIsActive() && !isActiveParam.equals("true")) {
                boolean hasProducts = zoneDAO.isZoneUsedByProducts(id);
                if (hasProducts && request.getParameter("confirmed") == null) {
                    // Nếu có sản phẩm và chưa xác nhận, chuyển về trang cập nhật với thông báo
                    request.getSession().setAttribute("confirmMessage", "This zone contains products. Are you sure you want to deactivate it?");
                    request.getSession().setAttribute("zoneId", id);
                    request.getSession().setAttribute("zoneName", name);
                    response.sendRedirect("zoneControl?action=edit&id=" + id);
                    return;
                }
            }

            Zone zone = new Zone();
            zone.setId(id);
            zone.setName(name);
            zone.setIsActive(Boolean.parseBoolean(isActiveParam));
            
            // Thêm debug log
            System.out.println("Updating zone: ID=" + id + ", Name=" + name + ", isActive=" + isActiveParam);
            
            boolean updated = zoneDAO.update(zone);
            if (updated) {
                request.getSession().setAttribute("toastMessage", "Zone updated successfully!");
                request.getSession().setAttribute("toastType", "success");
            } else {
                request.getSession().setAttribute("toastMessage", "Failed to update zone!");
                request.getSession().setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("toastMessage", "Error updating zone: " + e.getMessage());
            request.getSession().setAttribute("toastType", "error");
        }
        response.sendRedirect("zoneControl");
    }

    private void deleteZone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");

        // Kiểm tra xem zone có đang được sử dụng bởi sản phẩm nào không
        if (zoneDAO.isZoneUsedByProducts(id)) {
            request.getSession().setAttribute("toastMessage", "Cannot delete zone because it is being used by products!");
            request.getSession().setAttribute("toastType", "error");
        } else {
            zoneDAO.delete(id);
            request.getSession().setAttribute("toastMessage", "Zone deleted successfully!");
            request.getSession().setAttribute("toastType", "success");
        }
        response.sendRedirect("zoneControl");
    }
}
