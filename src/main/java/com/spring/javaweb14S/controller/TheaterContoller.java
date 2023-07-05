package com.spring.javaweb14S.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb14S.service.theater.TheaterService;
import com.spring.javaweb14S.vo.TheaterVO;
import com.spring.javaweb14S.vo.ThemaVO;

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
	// 테마 등록 처리
	@RequestMapping(value = "themaInputPage",method = RequestMethod.POST)
	public String themaInputPagePost(ThemaVO vo, MultipartFile file1, MultipartHttpServletRequest file2, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/thema/");
		
		int res = theaterService.setThemaInput(vo, file1, file2, realPath);
		
		if(res == 1) return "redirect:/adminMsg/themaInputOk";
		else return "redirect:/adminMsg/themaInputNo";
	}
	//테마 메인 페이지 출력 수정(ajax)
	@ResponseBody
	@RequestMapping(value = "themaChangeDisplay",method = RequestMethod.POST)
	public int themaChangeDisplay(
			@RequestParam(name = "idx",defaultValue = "0", required = false) int idx, 
			@RequestParam(name = "display",defaultValue = "No", required = false) String display) {
		return theaterService.setThemaDisplayChange(idx,display);
	}
	//상영관 테마 상세 보기
	@RequestMapping(value = "themaDetailPage", method = RequestMethod.GET)
	public String themaDetailPage( Model model,
			@RequestParam(name = "idx", defaultValue = "-1",required = false) int idx) {
		
		ThemaVO vo = theaterService.getThemaDetail(idx);
		if(vo != null) {
			model.addAttribute("vo", vo);
			return "adminPage/theater/themaDetailPage";
		}
		else {
			return "redirect:/adminMsg/theaterDetailNo";
		}
	}
	
}
