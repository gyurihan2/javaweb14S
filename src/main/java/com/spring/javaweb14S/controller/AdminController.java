package com.spring.javaweb14S.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb14S.service.movie.MovieService;
import com.spring.javaweb14S.service.theater.TheaterService;
import com.spring.javaweb14S.vo.MovieVO;
import com.spring.javaweb14S.vo.TheaterVO;
import com.spring.javaweb14S.vo.ThemaVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	TheaterService theaterService;
	
	@Autowired
	MovieService movieServie;
	
	@RequestMapping(value = "/mainPage", method = RequestMethod.GET)
	public String adminMainPage() {
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
		
		model.addAttribute("movieVOS", movieVOS);
		return "adminPage/movie/mgmtPage";
	}
}
