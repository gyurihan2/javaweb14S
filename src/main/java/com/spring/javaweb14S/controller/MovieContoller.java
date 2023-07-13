package com.spring.javaweb14S.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb14S.service.movie.MovieService;
import com.spring.javaweb14S.vo.MovieVO;

@Controller
@RequestMapping("/movie")
public class MovieContoller {
	
	@Autowired
	MovieService movieService;
	
	//영화 조회 페이지
	@RequestMapping(value = "movieSearchPage", method = RequestMethod.GET)
	public String movieInputPageGet(){
		return "adminPage/movie/movieSearchPage";
	}
	
	//영화 목록 추가 처리
	@RequestMapping(value = "movieInput", method = RequestMethod.POST)
	@ResponseBody
	public int movieInputPost(@RequestParam(name = "movieDetailArr",required = false) String movieDetail) {
		
		return movieService.setMovieInput(movieDetail);
	}
	
	//등록된 영화 정보 가져오기
	@RequestMapping(value = "getMovie", method = RequestMethod.POST)
	@ResponseBody
	public int getMoviePost(@RequestParam(name = "idx",required = false) String idx) {
		MovieVO vo = movieService.getMovie(idx);
		if(vo != null) return 0;
		else return 1;
	}

	
}
