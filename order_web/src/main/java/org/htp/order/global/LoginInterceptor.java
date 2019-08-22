package org.htp.order.global;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginInterceptor implements HandlerInterceptor {
    /**
     * 1. boolean preHandle (HttpServletRequest request, HttpServletResponse response, Object handle)
     * 方法：该方法将在请求处理之前进行调用，只有该方法返回true，
     * 才会继续执行后续的Interceptor和Controller，
     * 当返回值为true 时就会继续调用下一个Interceptor的preHandle 方法，
     * 如果已经是最后一个Interceptor的时候就会是调用当前请求的Controller方法；
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
        String url = request.getRequestURI().toLowerCase();
        if(url.contains("login") || url.contains("register")){
            return true;
        }
        HttpSession session = request.getSession();
        if(session.getAttribute("user")!=null){
            return true;
        }
        response.sendRedirect("/order/to_login");
        return false;
    }
}
