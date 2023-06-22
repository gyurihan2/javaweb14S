package com.spring.javaweb14S.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb14S.service.member.MemberService;
import com.spring.javaweb14S.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	//로그인 화면 
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPageGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();

		/* 아이디 기억을 했다면 아이디 기억 / 아이디 쿠키값 전달*/
		if(cookies != null){
			for(int i=0; i<cookies.length; i++){
				if(cookies[i].getName().equals("cIdSave")) request.setAttribute("cIdSave", cookies[i].getValue());
				else if(cookies[i].getName().equals("cMid")) request.setAttribute("cMid", cookies[i].getValue());
			}
		}
		return "userPage/member/loginPage";
	}
	
	//로그인 처리 
	@RequestMapping(value = "/loginPage", method = RequestMethod.POST)
	public String loginPagePost(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "mid",defaultValue = "",required = false) String mid,
			@RequestParam(name = "pwd",defaultValue = "",required = false) String pwd,
			@RequestParam(name = "idSave",defaultValue = "off",required = false) String idSave
			) {
		
		// 아이디 패스워드 체크
		MemberVO vo = memberService.getMemberLoginChk(mid,pwd);
		
		// 로그인 성공
		if(vo != null) {
			// 세션 처리
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			
			// 아이디 저장 쿠키 처리
			// idSave 체크 되어있을경우 "on"
			if(idSave.equals("on")) {
				Cookie cIdSave = new Cookie("cIdSave",idSave);
				Cookie cMid = new Cookie("cMid",mid);
				cIdSave.setMaxAge(60*60*24*31);
				cMid.setMaxAge(60*60*24*31);
				cMid.setPath("/javaweb14S");
				cIdSave.setPath("/javaweb14S");
				response.addCookie(cIdSave);
				response.addCookie(cMid);
			}
			// 아이디 기억 체크 해제 시 쿠키 삭제
			else{
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length;i++) {
					if(cookies[i].getName().equals("cIdSave")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
					}
					else if(cookies[i].getName().equals("cMid")){
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
					}
				}
			}
			
			return "redirect:/memberMsg/loginOk";
		}
		// 로그인 실패
		else return "redirect:/memberMsg/loginNo";
		
	}
	
	
	// 회원 가입 페이지
	@RequestMapping(value = "signUpPage", method = RequestMethod.GET)
	public String signUpPageGet() {
		return "userPage/member/signUpPage";
	}
	
	// 회원가입 페이지 아이디 중복 처리 페이지
	@RequestMapping(value = "signUpIdChk", method = RequestMethod.GET)
	public String signUpIdChkGet(Model model,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid) {
		
		// 0: 아이디 중복 1:아이디 사용가능
		int res = memberService.getMemberMidSearch(mid);
		model.addAttribute("mid", mid);
		model.addAttribute("res", res);
		
		return "userPage/member/signUpIdChk";
	}
	
	// 회원가입 페이지 닉네임 중복 처리 페이지
	@RequestMapping(value = "signUpNickNameChk", method = RequestMethod.GET)
	public String signUpNickNameChkGet(Model model,
			@RequestParam(name = "nickName", defaultValue = "", required = false) String nickName) {
		
		// 0: 닉네임 중복 1:닉네임 사용가능
		int res = memberService.getMemberNickNameSearch(nickName);
		model.addAttribute("nickName", nickName);
		model.addAttribute("res", res);
		
		return "userPage/member/signUpNickNameChk";
	}
	
	//회원 가입 처리
	@RequestMapping(value = "signUpPage", method = RequestMethod.POST)
	public String signUpPagePost(MemberVO vo) {
			System.out.println(vo.toString());
		return "userPage/member/signUpPage";
	}
	
}
