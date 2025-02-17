/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.*;

import jakarta.servlet.http.*;

/**
 * Authentication and Authorization Filter
 *
 * @author Viet Duc
 */
public class AuthenticationFilter implements Filter {

    private static final boolean debug = true;
    private FilterConfig filterConfig = null;
    private static final Logger logger = Logger.getLogger(AuthenticationFilter.class.getName());

    private static final int ROLE_ADMIN = 1;
    private static final int ROLE_STAFF = 2;
    private static final int ROLE_USER = 3;

    private static final List<String> STATIC_RESOURCES = Arrays.asList("css", "jpg", "png", "gif", "js");
    private static final List<String> PUBLIC_PAGES = Arrays.asList(
            "login.jsp", "register.jsp", "forgot-password.jsp", "error.jsp", "unauthorized.jsp"
    );

    public AuthenticationFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenticationFilter: DoBeforeProcessing");
        }
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenticationFilter: DoAfterProcessing");
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String requestURI = req.getRequestURI();

        try {
            if (isStaticResource(requestURI) || isPublicPage(requestURI)) {
                chain.doFilter(request, response);
                return;
            }

            boolean isLoggedIn = session != null && session.getAttribute("user") != null;
            if (!isLoggedIn) {
                session = req.getSession();
                session.setAttribute("requestedPage", requestURI);
                res.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }

            int roleType = (Integer) session.getAttribute("roleType");
            if (!hasAccess(requestURI, roleType)) {
                res.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
                return;
            }

            chain.doFilter(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in AuthenticationFilter", e);
            res.sendRedirect(req.getContextPath() + "/error.jsp");
        }
    }

    private boolean isStaticResource(String uri) {
        return STATIC_RESOURCES.stream().anyMatch(resource -> uri.toLowerCase().endsWith("." + resource));
    }

    private boolean isPublicPage(String uri) {
        return PUBLIC_PAGES.stream().anyMatch(page -> uri.toLowerCase().endsWith(page));
    }

    private boolean hasAccess(String uri, int roleType) {
        if (roleType == ROLE_ADMIN) {
            return true;
        }
        if (roleType == ROLE_STAFF && uri.contains("/admin/")) {
            return false;
        }
        if (roleType == ROLE_USER && (uri.contains("/admin/") || uri.contains("/staff/"))) {
            return false;
        }
        return true;
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        if (debug) {
            log("AuthFilter: Initializing filter");
        }
    }

    @Override
    public void destroy() {
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }
}




