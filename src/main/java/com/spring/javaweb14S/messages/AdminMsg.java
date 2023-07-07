package com.spring.javaweb14S.messages;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminMsg {
	
	@RequestMapping(value = "/adminMsg/{msgFlag}", method = RequestMethod.GET)
	public String messageGet(Model model, HttpServletRequest request, 
			@PathVariable(name = "msgFlag") String msgFlag,
			@RequestParam(name = "idx",defaultValue = "0", required = false) int idx) {
		
		if(msgFlag.equals("levelNo")) {
			model.addAttribute("msg", "잘못된 접근 입니다.\\n(관리자 전용 페이이지입니다.)");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("theaterDetailNo")) {
			model.addAttribute("msg", "검색한 상영관 정보가 없습니다.");
			return "include/messageClose";
		}
		else if(msgFlag.equals("themaInputOk")){
			model.addAttribute("msg", "테마가 추가 되었습니다.");
			model.addAttribute("url", "/theater/themaInputPage");
		}
		else if(msgFlag.equals("themaInputNo")){
			model.addAttribute("msg", "테마가 추가 실패했습니다.");
			model.addAttribute("url", "/theater/themaInputPage");
		}
		else if(msgFlag.equals("themaDetailNo")){
			model.addAttribute("msg", "테마가 정보가 없습니다..");
			return "include/messageClose";
		}
		else if(msgFlag.equals("themaImageAddOk")){
			model.addAttribute("msg", "테마가 이미지 추가 되었습니다.");
			model.addAttribute("url", "/theater/themaDetailPage?idx="+idx);
		}
		else if(msgFlag.equals("themaImageAddNo")){
			model.addAttribute("msg", "테마가 이미지 추가 실패했습니다.");
			model.addAttribute("url", "/theater/themaDetailPage?idx="+idx);
		}
		else if(msgFlag.equals("themMainContentUpdateOk")){
			model.addAttribute("msg", "테마 수정 되었습니다.");
			model.addAttribute("url", "/theater/themaDetailPage?idx="+idx);
		}
		else if(msgFlag.equals("themMainContentUpdateNo")){
			model.addAttribute("msg", "테마 수정 되었습니다.");
			model.addAttribute("url", "/theater/themaDetailPage?idx="+idx);
		}
		else if(msgFlag.equals("theaterInputPageOk")){
			model.addAttribute("msg", "상영관이 추가 되었습니다.");
			model.addAttribute("url", "/theater/theaterInputPage");
			return "include/messageCloseChk";
		}
		else if(msgFlag.equals("theaterInputPageNo")){
			model.addAttribute("msg", "상영관이 추가 실패되었습니다.");
			model.addAttribute("url", "/theater/theaterInputPage");
		}
		
		return "include/message";
	}
	
}
