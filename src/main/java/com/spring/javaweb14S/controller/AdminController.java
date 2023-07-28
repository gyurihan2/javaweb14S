package com.spring.javaweb14S.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb14S.common.JsonProcess;
import com.spring.javaweb14S.service.movie.MovieService;
import com.spring.javaweb14S.service.reservation.ReservationService;
import com.spring.javaweb14S.service.schedule.ScheduleService;
import com.spring.javaweb14S.service.theater.TheaterService;
import com.spring.javaweb14S.vo.MovieVO;
import com.spring.javaweb14S.vo.TheaterVO;
import com.spring.javaweb14S.vo.ThemaVO;
import com.spring.javaweb14S.vo.WeekReservationCntVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	TheaterService theaterService;
	
	@Autowired
	MovieService movieServie;
	
	@Autowired
	ScheduleService scheduleService;
	
	@Autowired
	ReservationService reservationService;
	
	@Autowired
	JsonProcess jsonProcess;
	// 관리자 메인 페이지
	@RequestMapping(value = "/mainPage", method = RequestMethod.GET)
	public String adminMainPage(Model model) {
		
		ArrayList<WeekReservationCntVO> weekReserVOS = reservationService.getWeekReservationCnt();
		model.addAttribute("weekReserVOS", weekReserVOS);
		return "adminPage/mainPage";
	}
	// 상영관 관리 페이지
	@RequestMapping(value = "/theater/mgmtPage", method = RequestMethod.GET)
	public String theaterMgmtPage(Model model) {
		
		ArrayList<TheaterVO> theaterVOS = theaterService.getTheaterList();
		ArrayList<ThemaVO> themaVOS = theaterService.getThemaList();
		
		model.addAttribute("theaterVOS", theaterVOS);
		model.addAttribute("themaVOS", themaVOS);
		
		return "adminPage/theater/mgmtPage";
	}
	// 영화 관리 페이지
	@RequestMapping(value = "/movie/mgmtPage", method = RequestMethod.GET)
	public String movieMgmtPage(Model model) {
		ArrayList<MovieVO> movieVOS = movieServie.getMovieList();
		String movieJsonData="";
		try {
			movieJsonData= jsonProcess.parseToString(movieVOS);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("movieVOS", movieVOS);
		model.addAttribute("movieJsonData", movieJsonData);
		return "adminPage/movie/mgmtPage";
	}
	// 스케줄 관리 페이지
	@RequestMapping(value = "/schedule/mgmtPage", method = RequestMethod.GET)
	public String scheduleMgmtPage(Model model) {
		
		String jsonData = scheduleService.getScheduleList();
		if(jsonData == null) jsonData="-1";
		model.addAttribute("jsonData", jsonData);
		return "adminPage/schedule/mgmtPage";
	}
	
	
}
