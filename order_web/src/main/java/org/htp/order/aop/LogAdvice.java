package org.htp.order.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.htp.order.biz.LogBiz;
import org.htp.order.entity.Log;
import org.htp.order.entity.User;
import org.htp.order.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Aspect
@Component
public class LogAdvice {
    @Autowired
    private LogBiz logBiz;

    @After("execution(* org.htp.order.controller.*.*(..) ) &&"+
            "!execution(* org.htp.order.controller.*.to*(..) ) &&"+
            "!execution(* org.htp.order.controller.DefaultController.showLog(..)) &&"+
            "!execution(* org.htp.order.controller.DefaultController.logout(..))")
    public void log(JoinPoint joinPoint){
        Log log = new Log();
        //获得类名
        String className = joinPoint.getTarget().getClass().getSimpleName();
        String methodName = joinPoint.getSignature().getName();
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user==null){
            user = new User();
            if(request.getParameter("username")!=null){
                user.setUsername(request.getParameter("username"));
            }else{
                user.setUsername("username:null");
            }
        }
        log = Utils.createNormalLog(className,methodName,user.getUsername(),log,false);
        logBiz.add(log);
    }

    @Before("execution(* org.htp.order.controller.DefaultController.logout(..))")
    public void logout(JoinPoint joinPoint){
        Log log = new Log();
        //获得类名
        String methodName = joinPoint.getSignature().getName();
        String className = joinPoint.getTarget().getClass().getSimpleName();
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        log = Utils.createNormalLog(className,methodName,user.getUsername(),log,false);
        logBiz.add(log);
    }

    @AfterThrowing(throwing = "e",pointcut = "execution ( * org.htp.order.controller.*.*(..))")
    public void exceptionLog(JoinPoint joinPoint,Throwable e){
        Log log = new Log();
        String className = joinPoint.getTarget().getClass().getSimpleName();
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String methodName = joinPoint.getSignature().getName();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user==null){
            user = new User();
            if(request.getParameter("username")!=null){
                user.setUsername(request.getParameter("username"));
            }else{
                user.setUsername("username:null");
            }
        }
        log = Utils.createNormalLog(className,methodName,user.getUsername(),log,true);
        log.setResult(e.getClass().getSimpleName());
        logBiz.add(log);
    }

}
