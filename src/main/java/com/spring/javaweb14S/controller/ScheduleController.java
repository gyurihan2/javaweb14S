package com.spring.javaweb14S.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb14S.service.schedule.ScheduleService;
import com.spring.javaweb14S.vo.ScheduleVO;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	ScheduleService scheduleService;
	
	// 일정 추가 페이지
	@RequestMapping(value = "scheduleInputPage", method = RequestMethod.GET)
	public String scheduleInputPageGet(Model model,
			@RequestParam(name="startDate",required = false) String startDate,
			@RequestParam(name="endDate",required = false) String endDate){
		
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		return "adminPage/schedule/scheduleInputPage";
	}
	// 일정 추가 처리
	@RequestMapping(value = "scheduleInput", method = RequestMethod.POST)
	public String scheduleInputPost(ScheduleVO vo,
			@RequestParam(value="order",required = false) String[] order){
		
		// -1 : 전달 받은 값 오류 / 0: 등록 실패 / 1 이상 : 등록 완료
		int res = scheduleService.setScheduleInput(vo,order);
		if(res == -1) return "redirect:/scheduleMsg/sheduleInputDataNo";
		else if(res == 0) return "redirect:/scheduleMsg/sheduleInputNo";
		else return "redirect:/scheduleMsg/sheduleInputOk";
	}
	
	// 일자 클릭시 일정 상세 보기
	@RequestMapping(value = "scheduleSelectDate", method = RequestMethod.GET)
	public String scheduleSelectDatetGet(Model model,
			@RequestParam(value = "selectDate", defaultValue = "2022-13-13", required = false) String selectDate){
		
		String jsonData = scheduleService.getScheduleDateListJson(selectDate);
		
		if(jsonData == null) return "redirect:/scheduleMsg/sheduleSelectDateNo";
		else {
			model.addAttribute("jsonData", jsonData);
			return "adminPage/schedule/scheduleSelectDate";
		}
	}
	
	@RequestMapping(value = "scheduleDelete", method = RequestMethod.POST)
	@ResponseBody
	public int scheduleDeletePost(
			@RequestParam(value = "groupId", defaultValue = "2022-13-13", required = false) String groupId){
			int res = scheduleService.setScheduleDeleteGroup(groupId);
			return res;
		}

}
