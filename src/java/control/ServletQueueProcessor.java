/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class for handling servlet requests in a queue to process them sequentially.
 */
public class ServletQueueProcessor {
    // Sử dụng mẫu thiết kế Singleton đảm bảo chỉ có một thể hiện duy nhất của ServletQueueProcessor trong toàn bộ ứng dụng
    private static ServletQueueProcessor instance;
    
    // Logger for this class
    private static final Logger LOGGER = Logger.getLogger(ServletQueueProcessor.class.getName());
    
    // Một hàng đợi chặn được sử dụng để lưu trữ các yêu cầu servlet.
    private final BlockingQueue<ServletRequestTask> requestQueue;
    
    // Bộ thực thi luồng được cấu hình để chỉ có một luồng duy nhất, đảm bảo xử lý tuần tự.
    private final ThreadPoolExecutor executor;
    
    // Flag to control the processing loop
    private boolean isRunning = true;
    
    /**
     * Private constructor for singleton pattern
     */
    private ServletQueueProcessor() {
        // Initialize the queue
        this.requestQueue = new LinkedBlockingQueue<>();
        
        // Initialize the thread pool with a single thread to ensure sequential processing
        this.executor = new ThreadPoolExecutor(
                1, // Số luồng tối thiểu luôn hoạt động
                1, // Số luồng tối đa không thể vượt quá
                0L, // Thời gian giữ luồng không hoạt động (không áp dụng vì chỉ có 1 luồng cốt lõi)
                TimeUnit.MILLISECONDS,
                new LinkedBlockingQueue<>() //cho hàng đợi tác vụ của executor
        );
        
        // Start the queue processing thread
        startProcessingThread();
    }
    
    /**
     * Get the singleton instance
     * @return ServletQueueProcessor instance
     */
    //Phương thức getInstance() được đồng bộ hóa (synchronized) để tránh tạo nhiều thể hiện trong môi trường đa luồng.
    public static synchronized ServletQueueProcessor getInstance() {
        if (instance == null) {
            instance = new ServletQueueProcessor();
        }
        return instance;
    }
    
    /**
     * Add a servlet request to the queue for processing
     * @param servlet The servlet to process the request
     * @param request The HttpServletRequest
     * @param response The HttpServletResponse
     * @return true if the request was added to the queue
     */
    //Tạo một đối tượng ServletRequestTask chứa thông tin về servlet, request và response.
    //Sử dụng phương thức offer() để thêm tác vụ vào hàng đợi mà không chặn.
    //Trả về true nếu thêm thành công, false nếu hàng đợi đầy (không xảy ra với LinkedBlockingQueue không giới hạn).
    public boolean enqueueRequest(HttpServlet servlet, HttpServletRequest request, HttpServletResponse response) {
        ServletRequestTask task = new ServletRequestTask(servlet, request, response);
        return requestQueue.offer(task);
    }
    
    /**
     * Start a background thread to process queued requests
     */
    private void startProcessingThread() {
        executor.execute(() -> {
            while (isRunning) {
                try {
                    // Get the next request from the queue (blocking operation)
                    ServletRequestTask task = requestQueue.take();
                    
                    // Process the request
                    processRequest(task);
                    
                    //Khi request đã được xử lý xong, ghi log để xác nhận
                } catch (InterruptedException e) {
                    LOGGER.log(Level.WARNING, "Queue processing thread interrupted", e);
                    Thread.currentThread().interrupt();
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Error processing request from queue", e);
                }
            }
        });
    }
    
    /**
     * Process a servlet request task
     * @param task The task to process
     */
    private void processRequest(ServletRequestTask task) {
        try {
            // Get the task components
            HttpServlet servlet = task.getServlet();
            HttpServletRequest request = task.getRequest();
            HttpServletResponse response = task.getResponse();
            
            // Log the start of processing
            LOGGER.log(Level.INFO, "Processing request for: {0}", servlet.getClass().getName());
            
            // Call the servlet's service method to handle the request
            servlet.service(request, response);
            
            // Log the completion
            LOGGER.log(Level.INFO, "Finished processing request for: {0}", servlet.getClass().getName());
            
        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Error while processing servlet request", e);
        }
    }
    
    /**
     * Shutdown the queue processor
     */
    public void shutdown() {
        isRunning = false;
        executor.shutdown();
        try {
            if (!executor.awaitTermination(5, TimeUnit.SECONDS)) {
                executor.shutdownNow();
            }
        } catch (InterruptedException e) {
            executor.shutdownNow();
            Thread.currentThread().interrupt();
        }
    }
    
    /**
     * Inner class to hold the servlet request task information
     */
    private static class ServletRequestTask {
        private final HttpServlet servlet;
        private final HttpServletRequest request;
        private final HttpServletResponse response;
        
        public ServletRequestTask(HttpServlet servlet, HttpServletRequest request, HttpServletResponse response) {
            this.servlet = servlet;
            this.request = request;
            this.response = response;
        }
        
        public HttpServlet getServlet() {
            return servlet;
        }
        
        public HttpServletRequest getRequest() {
            return request;
        }
        
        public HttpServletResponse getResponse() {
            return response;
        }
    }
}