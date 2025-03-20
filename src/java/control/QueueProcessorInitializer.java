package control;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Web application lifecycle listener for initializing and shutting down 
 * the ServletQueueProcessor.
 */
@WebListener
public class QueueProcessorInitializer implements ServletContextListener {
    private static final Logger LOGGER = Logger.getLogger(QueueProcessorInitializer.class.getName());

    /**
     * Initialize the ServletQueueProcessor when the web application starts
     * @param sce the ServletContextEvent containing the ServletContext that is being initialized
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.log(Level.INFO, "Initializing ServletQueueProcessor");
        // Initialize the queue processor
        ServletQueueProcessor.getInstance();
        LOGGER.log(Level.INFO, "ServletQueueProcessor initialized successfully");
    }

    /**
     * Shutdown the ServletQueueProcessor when the web application is shutting down
     * @param sce the ServletContextEvent containing the ServletContext that is being destroyed
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LOGGER.log(Level.INFO, "Shutting down ServletQueueProcessor");
        // Shutdown the queue processor
        ServletQueueProcessor.getInstance().shutdown();
        LOGGER.log(Level.INFO, "ServletQueueProcessor shut down successfully");
    }
}