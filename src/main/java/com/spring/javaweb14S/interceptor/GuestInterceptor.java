package com.spring.javaweb14S.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class GuestInterceptor extends HandlerInterceptorAdapter{

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		int level = session.getAttribute("sLevel") == null ? 0: (int)session.getAttribute("sLevel");
		
		// 로그인 하여 guestPage(로그인 페이지, 회원가입 페이지 등 접근 X)
		if(level == 0) return true;
		else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/memberMsg/guestPage");
			dispatcher.forward(request, response);
			return false;
		}
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		
		String requestUrl = request.getRequestURI();
		requestUrl = requestUrl.substring(requestUrl.lastIndexOf("/"),requestUrl.length());
		// 인증번호 관련 
		if(session.getAttribute("sImsiAuth")!= null) {
			
			
			// 회원 수정 페이지의 이메일 인증 발송시 제외
			if(!requestUrl.equals("/authNumSend")) {
				System.out.println("실행");
				session.removeAttribute("sImsiAuth");
			}
		}
		else if(session.getAttribute("sImsiMid")!= null) {
			if(!requestUrl.equals("/pwdSearchPage")) {
				session.removeAttribute("sImsiMid");
			}
		}
		
		
	}

}
