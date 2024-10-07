package Filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class AdminFilter implements Filter {
    private boolean shouldExclude(String requestURI) {
        return requestURI.endsWith("/admin/login");
    }
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        if (shouldExclude(request.getRequestURI())){
            filterChain.doFilter(request, response);
        } else {
            if (request.getSession().getAttribute("admin") == null){
                request.getSession().setAttribute("mess", "warning|" + "Vui lòng đăng nhập.");
                response.sendRedirect(request.getContextPath() + "/admin/login");
            } else {
                filterChain.doFilter(request, response);
            }
        }
    }
}
