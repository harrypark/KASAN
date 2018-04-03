package com.kspat.util.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session  = request.getSession(false);

		if(session == null || session.getAttribute("id")==null){
//			response.sendRedirect(request.getContextPath()+"/login/loginCheck");
			response.sendRedirect(request.getContextPath()+"/login");
			return false;
		}
//		String id = (String)session.getAttribute("id");
//		if(id == null){
//			response.sendRedirect(request.getContextPath()+"/login");
//			return false;
//		}
		return true;
	}
}
