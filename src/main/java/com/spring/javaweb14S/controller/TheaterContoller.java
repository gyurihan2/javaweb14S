package com.spring.javaweb14S.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb14S.common.JsonProcess;
import com.spring.javaweb14S.service.theater.TheaterService;
import com.spring.javaweb14S.vo.TheaterVO;
import com.spring.javaweb14S.vo.ThemaVO;

@Controller
@RequestMapping("/theater")
public class TheaterContoller {
	
	@Autowired
	TheaterService theaterService;
	
	@Autowired
	JsonProcess jsonProcess;
	
	//상영관 등록 페이지
	@RequestMapping(value = "theaterInputPage", method = RequestMethod.GET)
	public String theaterInputPageGet(Model model) throws JsonGenerationException, JsonMappingException, IOException {
		ArrayList<ThemaVO> vos = theaterService.getThemaList();
		
		String json = new ObjectMapper().writeValueAsString(vos);
		
		model.addAttribute("vos", vos);
		model.addAttribute("json", json);
		
		return "adminPage/theater/theaterInputPage";
	}
	//상영관 등록 처리
	@RequestMapping(value = "theaterInputPage", method = RequestMethod.POST)
	public String theaterInputPagePost(Model model, TheaterVO vo) {
		int res = theaterService.setTheaterInput(vo);
		
		if(res == 1) return "redirect:/adminMsg/theaterInputPageOk";
		else return "redirect:/adminMsg/theaterInputPageNo";
	}
	
	// 상영관 상세 보기
	@RequestMapping(value = "theaterDetailPage", method = RequestMethod.GET)
	public String theaterDetailPage( Model model,
			@RequestParam(name = "idx", defaultValue = "-1",required = false) int idx) throws JsonGenerationException, JsonMappingException, IOException {
		
		TheaterVO vo = theaterService.getTheater(idx);
		if(vo != null) {
			ArrayList<ThemaVO> themaVOS = theaterService.getThemaList();
			String jsonThemaList = jsonProcess.parseList(themaVOS);

			model.addAttribute("vo", vo);
			model.addAttribute("jsonThemaList", jsonThemaList);
			model.addAttribute("themaVOS", themaVOS);
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
		String contextPath = request.getSession().getServletContext().getContextPath();
		
		int res = theaterService.setThemaInput(vo, file1, file2, realPath,contextPath);
		
		if(res == 1) return "redirect:/adminMsg/themaInputOk";
		else return "redirect:/adminMsg/themaInputNo";
	}
	//테마 메인 페이지 출력 여부 수정(ajax)
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
			return "redirect:/adminMsg/themaDetailNo";
		}
	}
	// 상여관 테마 메인 이미지 수정(ajax)
	@ResponseBody
	@RequestMapping(value = "themaMainImageChange",method = RequestMethod.POST)
	public int themaMainImageChange(
			@RequestParam(name = "idx",defaultValue = "0", required = false) int idx, 
			@RequestParam(name = "mainImg",defaultValue = "noImage.jpg", required = false) String mainImg) {
		return theaterService.setThemaMainImgChange(idx,mainImg);
	}
	// 상영관 테마 이미지 추가
	@RequestMapping(value = "themaImageAdd",method = RequestMethod.POST)
	public String themaImageAdd(MultipartHttpServletRequest imagesAddFile, int idx, HttpServletRequest request,Model model) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/thema/");
		int res = theaterService.setThemaImgInsert(idx,imagesAddFile,realPath);
		
		model.addAttribute("idx", idx);
		if(res == 1) {
			return "redirect:/adminMsg/themaImageAddOk";
		}
		else {
			return "redirect:/adminMsg/themaImageAddNo";
		}
	}
	// 테마 이미지 삭제(ajax)
	@ResponseBody
	@RequestMapping(value = "themaImageDelete",method = RequestMethod.POST)
	public int themaImageDelete(int idx, @RequestParam(value="imgArr[]")List<String> imgArr, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/thema/");
		int res = theaterService.setThemaImgDelete(idx,imgArr,realPath);
				
		return res;
	}
	// 테마 업로드 폴더 제외한 업데이트(테마명, 입장료, 해시태그, 메인페이지 출력 여부, 설명)
	@RequestMapping(value = "themMainContentUpdate",method = RequestMethod.POST)
	public String themMainContentUpdate(ThemaVO vo,HttpSession session) {
		String contextPath=session.getServletContext().getContextPath();
		String saved_Path=contextPath+"/thema/image";

		int res = theaterService.setThemMainContentUpdate(vo,saved_Path);
		
		if(res == 1) return "redirect:/adminMsg/themMainContentUpdateOk?idx="+vo.getIdx();
		else return "redirect:/adminMsg/themMainContentUpdateNo?idx="+vo.getIdx();
	}
	//테마 삭제
	@ResponseBody
	@RequestMapping(value = "themaDelete",method = RequestMethod.POST)
	public int themaDelete(String idx) {
		return theaterService.setThemaDelete(idx);
	}
	
}
