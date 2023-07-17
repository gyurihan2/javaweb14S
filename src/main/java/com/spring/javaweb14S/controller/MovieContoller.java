package com.spring.javaweb14S.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb14S.common.JsonProcess;
import com.spring.javaweb14S.service.movie.MovieService;
import com.spring.javaweb14S.vo.MovieVO;

@Controller
@RequestMapping("/movie")
public class MovieContoller {
	
	@Autowired
	MovieService movieService;
	
	@Autowired
	JsonProcess jsonProcess;
	
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
	
	// 등록된 영화 상세 보기
	@RequestMapping(value = "movieDetailPage", method = RequestMethod.GET)
	public String movieDetailPageGet(Model model,
			@RequestParam(name = "idx",required = false) String idx) {
		
		MovieVO vo =movieService.getMovie(idx);
		model.addAttribute("vo", vo);
		
		if(vo != null) return "adminPage/movie/movieDetailPage";
		else return "redirect:/movieMsg/movieDetailNo";
	}
	
	// 등록된 영화 메인 포스터 변경
	@RequestMapping(value = "movieMainImageChange", method = RequestMethod.POST)
	@ResponseBody
	public int movieMainImageChangePost(
			@RequestParam(name = "idx",required = false) String idx, @RequestParam(name="posterSrc", required = false) String posterSrc) {
		
		return movieService.setMovieMainImageChage(idx,posterSrc);
	}
	// 등록된 영화 메인 포스터 변경
	@RequestMapping(value = "movieUpdate", method = RequestMethod.POST)
	@ResponseBody
	public int movieUpdatePost(
			@RequestParam(name = "idx",required = false) String idx, @RequestParam(name="jsonData", required = false) String jsonData) {
		// -1: 기존 IDX와 업데이트 정보의 IDX가 일치 X(삭제하고 다시 등록 필요)
		// 0: 업데이트 실패 / 1: 업데이트 완료
		return movieService.setmovieUpdate(idx,jsonData);
	}
	
	// 등록된 영화 메인 포스터 변경
	@RequestMapping(value = "movieDelete", method = RequestMethod.POST)
	@ResponseBody
	public int movieDeletePost(
			@RequestParam(name = "idx",required = false) String idx) {
		return movieService.setmovieDelete(idx);
	}
	
	// 시작일 기준 상영 가능한 영화 리스트
	@RequestMapping(value = "movieListPage", method = RequestMethod.GET)
	public String movieListPageGet(Model model,
			@RequestParam(name = "startDate",defaultValue = "0",required = false) String startDate) throws JsonGenerationException, JsonMappingException, IOException {
		
		if(startDate.equals("0")) return "redirect:/movieMsg/movieDateNo";
		ArrayList<MovieVO>  vos = movieService.getMovieDateList(startDate);
		String jsonData = jsonProcess.parseToString(vos);
		
		model.addAttribute("vos", vos);
		model.addAttribute("jsonData", jsonData);
		
		return "adminPage/movie/movieListPage";
	}

	
}
