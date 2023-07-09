package com.spring.javaweb14S.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class GuestInterceptor extends HandlerInterceptorAdapter{

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		int level = session.getAttribute("sLevel") == null ? 0: (int)session.getAttribute("sLevel");
		
		if(session.getAttribute("sImsiAuth")!= null) session.removeAttribute("sImsiAuth");
		
		// 로그인 하여 guestPage(로그인 페이지, 회원가입 페이지 등 접근 X)
		if(level == 0) return true;
		else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/memberMsg/guestPage");
			dispatcher.forward(request, response);
			return false;
		}
		
		
	}

}
