package com.spring.javaweb14S.messages;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MovieMsg {
	
	@RequestMapping(value = "/movieMsg/{msgFlag}", method = RequestMethod.GET)
	public String messageGet(Model model, HttpServletRequest request, 
			@PathVariable(name = "msgFlag") String msgFlag,
			@RequestParam(name = "idx",defaultValue = "0", required = false) int idx) {
		
		if(msgFlag.equals("movieDetailNo")) {
			model.addAttribute("msg", "영화 정보가 없습니다.");
			return "include/messageClose";
		}
	
		else if(msgFlag.equals("movieDateNo")) {
			model.addAttribute("msg", "상영 시작일을 설정 하세요");
			model.addAttribute("url", "/schedule/scheduleInputPage");
		}
		
		return "include/message";
	}
	
}
