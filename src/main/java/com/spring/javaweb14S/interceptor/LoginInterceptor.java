package com.spring.javaweb14S.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		int level = session.getAttribute("sLevel") == null ? 0: (int)session.getAttribute("sLevel");
				
		if(level == 0) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/memberMsg/loginChkNo");
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		
		// 인증번호 관련 
		if(session.getAttribute("sImsiAuth")!= null) {
			String requestUrl = request.getRequestURI();
			requestUrl = requestUrl.substring(requestUrl.lastIndexOf("/"),requestUrl.length());
			
			// 회원 수정 페이지의 이메일 인증 발송시 제외
			if(!requestUrl.equals("/myPageAuthNumSend"))session.removeAttribute("sImsiAuth");
		}
	}

}
