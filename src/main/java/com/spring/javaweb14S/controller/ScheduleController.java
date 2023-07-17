package com.spring.javaweb14S.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb14S.service.schedule.ScheduleService;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	ScheduleService scheduleService;
	
	// 해당 월의 일정 
	@RequestMapping(value = "scheduleGetList", method = RequestMethod.POST)
	@ResponseBody
	public String scheduleGetList(
			@RequestParam(name = "requestDate", defaultValue = "2023-13", required = false) String requestDate) {
		String jsonData = scheduleService.getScheduleList(requestDate);
		return jsonData;
	}
	
	// 일정 추가
	@RequestMapping(value = "scheduleInputPage", method = RequestMethod.GET)
	public String scheduleInputPage(Model model,
			@RequestParam(name="startDate",required = false) String startDate,
			@RequestParam(name="endDate",required = false) String endDate){
		
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		return "adminPage/schedule/scheduleInputPage";
	}
}
