package com.spring.javaweb14S.messages;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminMsg {
	
	@RequestMapping(value = "/adminMsg/{msgFlag}", method = RequestMethod.GET)
	public String messageGet(Model model, 
			@PathVariable(name = "msgFlag") String msgFlag, HttpServletRequest request) {
		
		if(msgFlag.equals("levelNo")) {
			model.addAttribute("msg", "잘못된 접근 입니다.\\n(관리자 전용 페이이지입니다.)");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("theaterDetailNo")) {
			model.addAttribute("msg", "검색한 상영관 정보가 없습니다.");
			return "include/messageClose";
		}
		
		return "include/message";
	}
	
}
