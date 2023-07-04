package com.spring.javaweb14S.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb14S.service.theater.TheaterService;
import com.spring.javaweb14S.vo.TheaterVO;

@Controller
@RequestMapping("/theater")
public class TheaterContoller {
	
	@Autowired
	TheaterService theaterService;
	
	// 상영관 상세 보기
	@RequestMapping(value = "theaterDetailPage", method = RequestMethod.GET)
	public String theaterDetailPage( Model model,
			@RequestParam(name = "idx", defaultValue = "-1",required = false) int idx) {
		
		TheaterVO vo = theaterService.getTheater(idx);
		if(vo != null) {
			model.addAttribute("vo", vo);
			return "adminPage/theater/theaterDetailPage";
		}
		else {
			return "redirect:/adminMsg/theaterDetailNo";
		}
	}
	
	// 상영관 작동 여부 수정(ajax)
	@RequestMapping(value = "theaterChangWork",method = RequestMethod.POST)
	@ResponseBody
	public int theaterChangWork(int idx,int work) {
		int res = theaterService.setTheaterChange(idx,work);
		return res;
	}
	
	
	
	
	
	// 테마 등록 페이지
	@RequestMapping(value = "themaInputPage",method = RequestMethod.GET)
	public String themaInputPageGet() {
		return "adminPage/theater/themaInputPage";
	}
	
}
