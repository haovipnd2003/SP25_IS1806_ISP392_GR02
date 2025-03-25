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
import entity.Product;
import java.sql.Timestamp;
import java.util.Date;
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
         User user = (User) request.getSession().getAttribute("acc");
        int roleType = 0; // Default to lowest role
        if (user != null) {
            // Convert the String roletype to int
            try {
                roleType = Integer.parseInt(user.getRoletype());
            } catch (NumberFormatException e) {
                // If conversion fails, keep default value
                System.out.println("Error parsing roletype: " + e.getMessage());
            }
        }
        request.setAttribute("roletype", roleType);

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
         User user = (User) request.getSession().getAttribute("acc");
        int roleType = 0; // Default to lowest role
        if (user != null) {
            // Convert the String roletype to int
            try {
                roleType = Integer.parseInt(user.getRoletype());
            } catch (NumberFormatException e) {
                // If conversion fails, keep default value
                System.out.println("Error parsing roletype: " + e.getMessage());
            }
        }
        request.setAttribute("roletype", roleType);
        List<Zone> zoneList = zoneDAO.getAllZones(1, Integer.MAX_VALUE);
        request.setAttribute("zoneList", zoneList);
        request.getRequestDispatcher("view/admin/addZone.jsp").forward(request, response);
    }

    private void handleEditZone(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Zone zone = zoneDAO.getZoneById(id);
        
        // Thêm danh sách zone để kiểm tra trùng tên
        List<Zone> zoneList = zoneDAO.getAllZones(1, Integer.MAX_VALUE);
        
        request.setAttribute("zone", zone);
        request.setAttribute("zoneList", zoneList);
        request.getRequestDispatcher("view/admin/updateZone.jsp").forward(request, response);
    }

    private void handleZoneDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Zone zone = zoneDAO.getZoneById(id);
        List<Product> productList = zoneDAO.getProductsInZone(id);
        
        request.setAttribute("zone", zone);
        request.setAttribute("products", productList);
        request.getRequestDispatcher("view/admin/zone-details.jsp").forward(request, response);
    }

    private void handleDefault(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pageParam = request.getParameter("page");
        int page = 1;
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                // Ignore and use default
            }
        }
        
        // Get user role type from session
//        User user = (User) request.getSession().getAttribute("acc");
//        int roleType = 0; // Default to lowest role
//        if (user != null) {
//            // Convert the String roletype to int
//            try {
//                roleType = Integer.parseInt(user.getRoletype());
//            } catch (NumberFormatException e) {
//                // If conversion fails, keep default value
//                System.out.println("Error parsing roletype: " + e.getMessage());
//            }
//        }
//        request.setAttribute("roletype", roleType);
        
        int pageSize = 10;
        List<Zone> zoneList = zoneDAO.getAllZones(page, pageSize);
        int totalZones = zoneDAO.getTotalZones();
        int totalPages = (int) Math.ceil((double) totalZones / pageSize);
        
        // Thêm số lượng sản phẩm cho mỗi zone
        for (Zone zone : zoneList) {
            int productCount = zoneDAO.countProductsInZone(zone.getId());
            zone.setProductCount(productCount);
        }
        
        request.setAttribute("zoneList", zoneList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("view/admin/zones.jsp").forward(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String pageParam = request.getParameter("page");
        int page = 1;
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                // Ignore and use default
            }
        }
        
        int pageSize = 10;
        List<Zone> zoneList = zoneDAO.searchZones(keyword, page, pageSize);
        int totalResults = zoneDAO.getTotalSearchResults(keyword);
        int totalPages = (int) Math.ceil((double) totalResults / pageSize);
        
        // Thêm số lượng sản phẩm cho mỗi zone
        for (Zone zone : zoneList) {
            int productCount = zoneDAO.countProductsInZone(zone.getId());
            zone.setProductCount(productCount);
        }
        
        request.setAttribute("zoneList", zoneList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("searchMode", true);
        request.getRequestDispatcher("view/admin/zones.jsp").forward(request, response);
    }

    private void handleFilter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String isActive = request.getParameter("isActive");
        String pageParam = request.getParameter("page");
        int page = 1;
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                // Ignore and use default
            }
        }
        
        int pageSize = 10;
        List<Zone> zoneList = zoneDAO.filterZones(isActive, page, pageSize);
        int totalResults = zoneDAO.getTotalFilterResults(isActive);
        int totalPages = (int) Math.ceil((double) totalResults / pageSize);
        
        // Thêm số lượng sản phẩm cho mỗi zone
        for (Zone zone : zoneList) {
            int productCount = zoneDAO.countProductsInZone(zone.getId());
            zone.setProductCount(productCount);
        }
        
        request.setAttribute("zoneList", zoneList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("isActive", isActive);
        request.setAttribute("filterMode", true);
        request.getRequestDispatcher("view/admin/zones.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
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
            default:
                response.sendRedirect("zoneControl");
                break;
        }
    }

    private void insertZone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String name = request.getParameter("name").trim();
            String description = request.getParameter("description");
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
            zone.setDescription(description);
            
            // Set creation info
            User user = (User) request.getSession().getAttribute("acc");
            if (user != null) {
                zone.setCreateBy(user.getName());
            }
            zone.setCreatedAt(new Timestamp(new Date().getTime()));
            
            boolean inserted = zoneDAO.insert(zone);
            if (inserted) {
                request.getSession().setAttribute("toastMessage", "Zone added successfully!");
                request.getSession().setAttribute("toastType", "success");
            } else {
                request.getSession().setAttribute("toastMessage", "Failed to add zone!");
                request.getSession().setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("toastMessage", "Error adding zone: " + e.getMessage());
            request.getSession().setAttribute("toastType", "error");
        }
        response.sendRedirect("zoneControl");
    }

    private void updateZone(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name").trim();
            String description = request.getParameter("description");
            String isActiveParam = request.getParameter("isActive");
            
            Map<String, String> errors = new HashMap<>();
            
            // Validate required fields
            if (name.isEmpty()) {
                errors.put("nameError", "Zone name is required");
            }
            if (isActiveParam == null) {
                errors.put("statusError", "Status is required");
            }
            
            Zone existingZone = zoneDAO.getZoneByName(name);
            if (existingZone != null && existingZone.getId() != id) {
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
            zone.setDescription(description);
            
            // Set update info
            User user = (User) request.getSession().getAttribute("acc");
            if (user != null) {
                // We could set an updateBy field here if needed
            }
            
            // Thêm debug log
            System.out.println("Updating zone: ID=" + id + ", Name=" + name + ", isActive=" + isActiveParam + ", Description=" + description);
            
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
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // Kiểm tra xem zone có đang được sử dụng bởi sản phẩm nào không
            if (zoneDAO.isZoneUsedByProducts(id)) {
                request.getSession().setAttribute("toastMessage", "Cannot delete zone because it is being used by products!");
                request.getSession().setAttribute("toastType", "error");
            } else {
                // Get current user for deleteBy field
                User user = (User) request.getSession().getAttribute("acc");
                if (user != null) {
                    // We could set the deleteBy field here if we modified the delete method
                }
                
                zoneDAO.delete(id);
                request.getSession().setAttribute("toastMessage", "Zone deleted successfully!");
                request.getSession().setAttribute("toastType", "success");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("toastMessage", "Error deleting zone: " + e.getMessage());
            request.getSession().setAttribute("toastType", "error");
        }
        response.sendRedirect("zoneControl");
    }
}
