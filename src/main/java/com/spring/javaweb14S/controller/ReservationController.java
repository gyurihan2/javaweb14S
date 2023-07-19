package com.spring.javaweb14S.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb14S.service.reservation.ReservationService;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

	@Autowired
	ReservationService reservationService;
	
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
	
	
	private String getDayOfWeek(int res) {
		if(res == 1) return "일";
		else if(res == 2) return "월";
		else if(res == 3) return "화";
		else if(res == 4) return "수";
		else if(res == 5) return "목";
		else if(res == 6) return "금";
		else  return "토";

	}
}
