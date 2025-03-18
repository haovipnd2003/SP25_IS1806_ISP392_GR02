package control;

import dao.DAO;
import dao.ScheduleDAO;
import entity.Schedule;
import entity.Shift;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ScheduleStaffControl", urlPatterns = {"/schedule"})
public class ScheduleStaffControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            // Get current user from session
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("acc");

            // Check if user is logged in
            if (currentUser == null) {
                response.sendRedirect("login");
                return;
            }

            String roleType = currentUser.getRoletype();
            // Get current date
            Calendar calendar = Calendar.getInstance();
            // Format today's date for comparison
            SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");
            String todayDate = dbFormat.format(new Date());

            // Set today's date as attribute
            request.setAttribute("todayDate", todayDate);
            // Check if a specific week is requested
            String weekParam = request.getParameter("week");
            if (weekParam != null && !weekParam.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date date = sdf.parse(weekParam);
                    calendar.setTime(date);
                } catch (Exception e) {
                    // Invalid date format, use current date
                }
            }

            // Set to the first day of the week (Monday)
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            // Format dates for display and database query
            SimpleDateFormat displayFormat = new SimpleDateFormat("d/M");
            SimpleDateFormat monthYearFormat = new SimpleDateFormat("M yyyy");
//            SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");

            // Get first and last day of the week for database query
            String startDate = dbFormat.format(calendar.getTime());

            // Move to the last day of the week (Sunday)
            calendar.add(Calendar.DAY_OF_WEEK, 6);
            String endDate = dbFormat.format(calendar.getTime());

            // Get week number and month
            Calendar tempCalendar = Calendar.getInstance();
            tempCalendar.setTime(calendar.getTime());
            int weekOfMonth = tempCalendar.get(Calendar.WEEK_OF_MONTH);
            String monthYear = monthYearFormat.format(calendar.getTime());

            // Prepare data for weekly display
            String[] days = new String[7];
            String[] dates = new String[7];
            // Reset calendar to the first day of the week
            calendar.add(Calendar.DAY_OF_WEEK, -6);

            // Get day names and dates for the week
            String[] dayNames = {"Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "Chủ nhật"};
            for (int i = 0; i < 7; i++) {
                days[i] = dayNames[i];
                dates[i] = displayFormat.format(calendar.getTime());
                calendar.add(Calendar.DAY_OF_WEEK, 1);
            }
            //            // Get employees, shifts, and schedules from DAO
            //            ScheduleDAO scheduleDAO = new ScheduleDAO();
            //            List<User> employees = scheduleDAO.getEmployees();
            //            List<Shift> shifts = scheduleDAO.getShifts();
            //            List<Schedule> schedules = scheduleDAO.getScheduleByWeek(startDate, endDate);

            ScheduleDAO scheduleDAO = new ScheduleDAO();
            List<User> employees;
            List<Shift> shifts = scheduleDAO.getShifts();
            List<Schedule> schedules;

            // Filter employees and schedules based on user role
            boolean isStaffRole = "3".equals(roleType);
            if (isStaffRole) { // Staff role
                // Staff can only see their own schedule
                employees = new ArrayList<>();
                employees.add(currentUser);
                schedules = scheduleDAO.getScheduleByUserAndWeek(currentUser.getId(), startDate, endDate);

                // Set a flag to indicate that this is a staff view (for read-only access)
                request.setAttribute("isStaffView", true);
            } else {
                // Admin or manager can see all schedules
                employees = scheduleDAO.getEmployees();
                schedules = scheduleDAO.getScheduleByWeek(startDate, endDate);
                request.setAttribute("isStaffView", false);
            }
            // Create a set of active shift names for filtering
            Map<String, Boolean> activeShifts = new HashMap<>();
            for (Shift shift : shifts) {
                activeShifts.put(shift.getName(), true);
            }

            // Organize schedules by user and date for easy access in JSP
            // Thay đổi cấu trúc lưu trữ để lưu nhiều ca làm việc trong một ngày
            Map<String, Map<String, List<String>>> scheduleMap = new HashMap<>();

            for (Schedule schedule : schedules) {
                String userId = schedule.getUser_id();
                String date = schedule.getDate();
                String shiftName = schedule.getShiftname();
                // Skip this schedule entry if the shift is inactive
                if (!activeShifts.containsKey(shiftName)) {
                    continue; // Skip inactive shifts
                }

                if (!scheduleMap.containsKey(userId)) {
                    scheduleMap.put(userId, new HashMap<>());
                }

                Map<String, List<String>> userSchedule = scheduleMap.get(userId);

                if (!userSchedule.containsKey(date)) {
                    userSchedule.put(date, new ArrayList<>());
                }

                List<String> shiftsForDay = userSchedule.get(date);
                shiftsForDay.add(shiftName);
            }
            // Tạo map lưu trữ thời gian của các ca làm việc
            Map<String, String> shiftTimeMap = new HashMap<>();
            for (Shift shift : shifts) {
                shiftTimeMap.put(shift.getName(), shift.getStart_time() + " - " + shift.getEnd_time());
            }
            // Set attribute cho JSP
            request.setAttribute("shiftTimeMap", shiftTimeMap);
            request.setAttribute("userRole", roleType);
            request.setAttribute("currentUser", currentUser);
            System.out.println("Schedule Map: " + scheduleMap);
            System.out.println("Employees: " + employees);
            System.out.println("Shifts: " + shifts);
            System.out.println("Schedules: " + schedules);

            // Set attributes for JSP
            request.setAttribute("employees", employees);
            request.setAttribute("shifts", shifts);
            request.setAttribute("scheduleMap", scheduleMap);
            request.setAttribute("days", days);
            request.setAttribute("dates", dates);
            request.setAttribute("weekOfMonth", weekOfMonth);
            request.setAttribute("monthYear", monthYear);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            // Forward to JSP page
//            request.getRequestDispatcher("view/admin/schedule.jsp").forward(request, response);
            // Forward to JSP page
            if ("3".equals(roleType)) {
                request.getRequestDispatcher("view/admin/schedule.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("view/admin/schedule.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
