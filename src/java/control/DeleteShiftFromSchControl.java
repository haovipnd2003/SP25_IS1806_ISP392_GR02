/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.ScheduleDAO;
import entity.Schedule;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DeleteShiftFromSchControl", urlPatterns = {"/deleteshift"})
public class DeleteShiftFromSchControl extends HttpServlet {

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
//        response.setContentType("application/json;charset=UTF-8");
//        PrintWriter out = response.getWriter();
//
//        try {
//            // Get parameters from the request
//            String userId = request.getParameter("userId");
//            String date = request.getParameter("date");
//            String shiftName = request.getParameter("shiftName");
//            String week = request.getParameter("week");
//
//            // Create ScheduleDAO instance
//            ScheduleDAO scheduleDAO = new ScheduleDAO();
//
//            // Get the date range for the current week
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//            Date currentDate = new Date();
//            String currentWeek = week != null ? week : sdf.format(currentDate);
//
//            // Get schedules for the specified week
//            List<Schedule> schedules = scheduleDAO.getScheduleByWeek(currentWeek, currentWeek);
//
//            // Find the schedule ID for the specified user, date, and shift
//            String targetScheduleId = null;
//            for (Schedule schedule : schedules) {
//                if (schedule.getUser_id().equals(userId)
//                        && schedule.getDate().equals(date)
//                        && schedule.getShiftname().equals(shiftName)) {
//                    targetScheduleId = schedule.getId();
//                    break;
//                }
//            }
//
//            boolean success = false;
//            if (targetScheduleId != null) {
//                // Delete the shift from the schedule
//                success = scheduleDAO.deleteShiftFromSchedule(targetScheduleId);
//            }
//
//            if (success) {
//                out.println("{\"success\": true, \"message\": \"Shift deleted successfully\"}");
//            } else {
//                out.println("{\"success\": false, \"message\": \"Failed to delete shift\"}");
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            out.println("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
//        }
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get parameters from the request
            String userId = request.getParameter("userId");
            String date = request.getParameter("date");
            String shiftName = request.getParameter("shiftName");
            String week = request.getParameter("week");

            System.out.println("Delete request received: userId=" + userId + ", date=" + date + ", shiftName=" + shiftName);

            // Create ScheduleDAO instance
            ScheduleDAO scheduleDAO = new ScheduleDAO();

            // Calculate start and end dates for the week
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate;
            if (week != null && !week.isEmpty()) {
                startDate = sdf.parse(week);
            } else {
                startDate = new Date();
            }

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
            String weekStart = sdf.format(calendar.getTime());

            calendar.add(Calendar.DAY_OF_WEEK, 6);
            String weekEnd = sdf.format(calendar.getTime());

            System.out.println("Week range: " + weekStart + " to " + weekEnd);

            // Get all schedules for the week
            List<Schedule> schedules = scheduleDAO.getScheduleByWeek(weekStart, weekEnd);

            // Find the schedule ID that matches our criteria
            String targetScheduleId = null;
            for (Schedule schedule : schedules) {
                if (schedule.getUser_id().equals(userId)
                        && schedule.getDate().equals(date)
                        && schedule.getShiftname().equals(shiftName)) {
                    targetScheduleId = schedule.getId();
                    System.out.println("Found matching schedule ID: " + targetScheduleId);
                    break;
                }
            }

            boolean success = false;
            if (targetScheduleId != null) {
                // Delete the shift from the schedule
                success = scheduleDAO.deleteShiftFromSchedule(targetScheduleId);
                System.out.println("Delete result: " + success);
            } else {
                System.out.println("No matching schedule found");
            }

            if (success) {
                out.println("{\"success\": true, \"message\": \"Shift deleted successfully\"}");
            } else {
                out.println("{\"success\": false, \"message\": \"Failed to delete shift. Schedule not found.\"}");
            }

        } catch (Exception e) {
            System.out.println("Error in DeleteShiftFromSchControl: " + e.getMessage());
            e.printStackTrace();
            out.println("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
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
