package com.spring.javaweb14S.messages;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ScheduleMsg {
	
	@RequestMapping(value = "/scheduleMsg/{msgFlag}", method = RequestMethod.GET)
	public String messageGet(Model model, HttpServletRequest request, 
			@PathVariable(name = "msgFlag") String msgFlag,
			@RequestParam(name = "idx",defaultValue = "0", required = false) int idx) {
		
		if(msgFlag.equals("sheduleInputDataNo")) {
			model.addAttribute("msg", "입력 값을 확인하세요");
			model.addAttribute("url", "/schedule/scheduleInputPage");
		}
		else if(msgFlag.equals("sheduleInputNo")) {
			model.addAttribute("msg", "스케줄 등록 실패");
			model.addAttribute("url", "/schedule/scheduleInputPage");
		}
		else if(msgFlag.equals("sheduleInputOk")) {
			model.addAttribute("msg", "스케줄 등록 성공");
			model.addAttribute("url", "/schedule/scheduleInputPage");
			return "include/messageCloseChk";
		}
		else if(msgFlag.equals("sheduleSelectDateNo")) {
			model.addAttribute("msg", "일정이 없습니다.");
			return "include/messageClose";
		}
	
		
		
		return "include/message";
	}
	
}
