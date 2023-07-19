package com.spring.javaweb14S;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb14S.common.JsonProcess;
import com.spring.javaweb14S.service.movie.MovieService;
import com.spring.javaweb14S.service.schedule.ScheduleService;
import com.spring.javaweb14S.service.theater.TheaterService;
import com.spring.javaweb14S.vo.MovieVO;
import com.spring.javaweb14S.vo.TheaterVO;

@Controller
public class HomeController {
	@Autowired
	MovieService movieService;
	
	@Autowired
	TheaterService theaterService;
	
	@Autowired
	JsonProcess jsonProcess;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		ArrayList<MovieVO> vos =  movieService.getMovieTodaySchedule();
		ArrayList<TheaterVO> themaVOS = theaterService.getThemaDisplayList();
		
		try {
			String jsonData = jsonProcess.parseToString(vos);
			String jsonData2 = jsonProcess.parseToString(themaVOS);
			model.addAttribute("jsonData", jsonData);
			model.addAttribute("jsonData2", jsonData2);
		} catch (IOException e) {
			e.printStackTrace();
		}
		model.addAttribute("vos", vos);
		model.addAttribute("themaVOS", themaVOS);
		return "userPage/homeMainPage";
	}
	
}
