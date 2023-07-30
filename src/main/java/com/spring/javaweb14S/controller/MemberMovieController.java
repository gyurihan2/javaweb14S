package com.spring.javaweb14S.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb14S.common.JsonProcess;
import com.spring.javaweb14S.service.movie.MovieService;
import com.spring.javaweb14S.service.reservation.ReservationService;
import com.spring.javaweb14S.service.schedule.ScheduleService;
import com.spring.javaweb14S.vo.AgeStatisticsVO;
import com.spring.javaweb14S.vo.GenderRatioVO;
import com.spring.javaweb14S.vo.MovieVO;
import com.spring.javaweb14S.vo.ScheduleVO;

@Controller
@RequestMapping("/memberMovie")
public class MemberMovieController {
	
	@Autowired
	MovieService movieService;
	
	@Autowired
	ScheduleService scheduleService;
	
	@Autowired
	ReservationService reservationService;
	
	@Autowired
	JsonProcess jsonProcess;
	
	@RequestMapping(value="/movieAllList",method = RequestMethod.GET)
	public String movieAllListGet(Model model) {
		
		ArrayList<MovieVO> vos = movieService.getMovieList();
		model.addAttribute("vos", vos);
		
		return "userPage/memberMovie/movieAllList";
	}
	
	@RequestMapping(value="/movieDetail",method = RequestMethod.GET)
	public String movieDeatilGet(Model model,
			@RequestParam(name = "idx", defaultValue = "-1", required = false) String idx) {
		
		MovieVO movieVO = movieService.getMovie(idx);
		ScheduleVO scheduleVO = scheduleService.getScheduleMoiveIdx(idx);
		ArrayList<AgeStatisticsVO> ageStatisticsVOS = reservationService.getReservationAgeStatic(idx);
		GenderRatioVO genderRatioVO = reservationService.getReservationGenderRatio(idx);
		
		String jsonData="";
	
		try {
			jsonData=jsonProcess.voToJsonString(movieVO);
		} catch (IOException e) {
			e.printStackTrace();
			jsonData="-1";
		}
		if(scheduleVO != null) {
			model.addAttribute("scheduleVO", scheduleVO);
		}
		
		model.addAttribute("movieVO", movieVO);
		model.addAttribute("jsonData", jsonData);
		model.addAttribute("ageStatisticsVOS", ageStatisticsVOS);
		model.addAttribute("genderRatioVO", genderRatioVO);
		
		return "userPage/memberMovie/movieDeatilPage";
	}
	
	//영화 검색(top nav)
	@RequestMapping(value="/movieSearchList",method = RequestMethod.GET)
	public String movieSearchListGet(@RequestParam(value="title",defaultValue = "",required = false) String title,
			Model model) {
		
		ArrayList<MovieVO> vos = movieService.getMovieSearchList(title);
		model.addAttribute("vos", vos);
		
		return "userPage/memberMovie/movieSearchList";
	}

}
