package com.spring.javaweb14S.controller;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb14S.common.JsonProcess;
import com.spring.javaweb14S.service.movie.MovieService;

@Controller
@RequestMapping("/movie")
public class MovieContoller {
	
	@Autowired
	MovieService movieService;
	
	@Autowired
	JsonProcess jsonProcess;
	
	//영화 조회 페이지
	@RequestMapping(value = "movieSearchPage", method = RequestMethod.GET)
	public String theaterInputPageGet(Model model) throws JsonGenerationException, JsonMappingException, IOException {
		return "adminPage/movie/movieSearchPage";
	}

	
}
