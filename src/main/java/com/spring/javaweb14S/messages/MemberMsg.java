package com.spring.javaweb14S.messages;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberMsg {
	
	@RequestMapping(value = "/memberMsg/{msgFlag}", method = RequestMethod.GET)
	public String messageGet(Model model, 
			@PathVariable String msgFlag) {
		
		if(msgFlag.equals("loginOk")) {
			model.addAttribute("msg", "로그인 되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("loginNo")) {
			model.addAttribute("msg", "로그인 실패.");
			model.addAttribute("url", "/member/loginPage");
		}
		
		return "include/message";
	}
}
