package com.spring.javaweb14S.messages;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MemberMsg {
	
	@RequestMapping(value = "/memberMsg/{msgFlag}", method = RequestMethod.GET)
	public String messageGet(Model model, 
			@PathVariable String msgFlag, HttpServletRequest request) {
		
		if(msgFlag.equals("loginOk")) {
			model.addAttribute("msg", "로그인 되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("loginNo")) {
			model.addAttribute("msg", "로그인 실패.");
			model.addAttribute("url", "/member/loginPage");
		}
		else if(msgFlag.equals("loginOutOk")) {
			model.addAttribute("msg", "로그아웃 되었습니다.");
			model.addAttribute("url", "/member/loginPage");
		}
		else if(msgFlag.equals("memberInputOk")) {
			model.addAttribute("msg", "회원가입 완료되었습니다.");
			model.addAttribute("url", "/member/loginPage");
		}
		else if(msgFlag.equals("memberInputNo")) {
			model.addAttribute("msg", "회원가입 실패했습니다.");
			model.addAttribute("url", "/member/signUpPage");
		}
		else if(msgFlag.equals("guestPage")) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("loginChkNo")) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/loginPage");
		}
		else if(msgFlag.equals("pwdChangeNo")) {
			model.addAttribute("msg", "인증번호가 일치하지않습니다.");
			model.addAttribute("url", "/member/pwdSearchPage");
		}
		else if(msgFlag.equals("pwdUpdateOk")) {
			model.addAttribute("msg", "패스워드가 변경 되었습니다.");
			model.addAttribute("url", "/member/pwdSearchPage");
		}
		else if(msgFlag.equals("pwdUpdateNo")) {
			model.addAttribute("msg", "패스워드가 변경 실패.");
			model.addAttribute("url", "/member/pwdSearchPage");
		}
		else if(msgFlag.equals("wrongAccess")) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			
			String redircetPath = request.getParameter("redirectPath") == null ? "/member/loginPage" : request.getParameter("redirectPath");
			model.addAttribute("url", redircetPath);
		}
		// validator 에러
		else if(msgFlag.equals("validatorNo")) {
			if(request.getParameter("validatorFlag").equals("NotNull")) {
				model.addAttribute("msg", "필수 입력값을 입력하세요");
				model.addAttribute("url", request.getParameter("redircetPath"));
			}
			else {
				model.addAttribute("msg", "입력 값을 확인하세요");
				model.addAttribute("url", "/");
			}
		}
		
		return "include/message";
	}
}
