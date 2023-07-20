package com.spring.javaweb14S.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb14S.service.reservation.ReservationService;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

	@Autowired
	ReservationService reservationService;
	
	// 예약 메인 페이지
	@RequestMapping(value = "/reservationMainPage", method = RequestMethod.GET)
	public String reservationMainPage(Model model) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		SimpleDateFormat sfmt = new SimpleDateFormat("yyyy-MM-dd");
		
		int dayOfWeek;
		String dayOfWeekStr;
		ArrayList<String> dateVOS = new ArrayList<String>();
		
		for(int i=0; i<10; i++) {
			dayOfWeek=cal.get(Calendar.DAY_OF_WEEK);
			dayOfWeekStr = getDayOfWeek(dayOfWeek);
			dateVOS.add(sfmt.format(cal.getTime())+"("+dayOfWeekStr+")");
			cal.add(Calendar.DATE, 1);
		}
		
		model.addAttribute("dateVOS", dateVOS);
		
		return "userPage/reservation/reservationPage";
	}
	// 요일 변환
	private String getDayOfWeek(int res) {
		if(res == 1) return "일";
		else if(res == 2) return "월";
		else if(res == 3) return "화";
		else if(res == 4) return "수";
		else if(res == 5) return "목";
		else if(res == 6) return "금";
		else  return "토";
	}
	
	// 예약 정보를 통한 좌석 확인
	@RequestMapping(value = "/reservationGetSeat", method = RequestMethod.POST)
	@ResponseBody
	public String reservationGetSeatPost(
			@RequestParam(name = "theaterIdx",defaultValue = "-1", required = false) int theaterIdx,
			@RequestParam(name = "movieIdx",defaultValue = "-1", required = false) int movieIdx,
			@RequestParam(name = "screenOrder",defaultValue = "-1", required = false) int screenOrder,
			@RequestParam(name = "playDate",defaultValue = "-1", required = false) String playDate) {
		
		if(theaterIdx == -1 || movieIdx == -1 || screenOrder == -1 || playDate == "-1" ) return "";
		
		reservationService.reservationGetSeat(theaterIdx,movieIdx,screenOrder,playDate);
		
		return "";
	}
}
