package com.spring.javaweb14S.controller;

import java.util.ArrayList;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	// 로그아웃 처리
	@RequestMapping(value = "/loginOutOk", method = RequestMethod.GET)
	public String loginOutOkGet(HttpSession session) {
		session.invalidate();
		return "redirect:/memberMsg/loginOutOk";
	}
	
	// 회원 가입 페이지
	@RequestMapping(value = "/signUpPage", method = RequestMethod.GET)
	public String signUpPageGet() {
		return "userPage/member/signUpPage";
	}
	
	// 회원가입 페이지 아이디 중복 처리 페이지
	@RequestMapping(value = "/signUpIdChk", method = RequestMethod.GET)
	public String signUpIdChkGet(Model model,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid) {
		
		// 0: 아이디 중복 1:아이디 사용가능
		int res = memberService.getMemberMidSearch(mid);
		model.addAttribute("mid", mid);
		model.addAttribute("res", res);
		
		return "userPage/member/signUpIdChk";
	}
	
	// 회원가입 페이지 닉네임 중복 처리 페이지
	@RequestMapping(value = "/signUpNickNameChk", method = RequestMethod.GET)
	public String signUpNickNameChkGet(Model model,
			@RequestParam(name = "nickName", defaultValue = "", required = false) String nickName) {
		
		// 0: 닉네임 중복 1:닉네임 사용가능
		int res = memberService.getMemberNickNameSearch(nickName);
		model.addAttribute("nickName", nickName);
		model.addAttribute("res", res);
		
		return "userPage/member/signUpNickNameChk";
	}
	
	//회원 가입 처리
	@RequestMapping(value = "/signUpPage", method = RequestMethod.POST)
	public String signUpPagePost(@Validated MemberVO vo, BindingResult bindingResult,Model model) {
		
		
		// mid nickName email null 유효성 처리(null 값)
		if(bindingResult.hasFieldErrors()) {
			List<ObjectError> list = bindingResult.getAllErrors();
			String validateFlag="";
			for(ObjectError e : list) {
				validateFlag=e.getDefaultMessage();
				break;
			}
			model.addAttribute("validateFlag", validateFlag);
			model.addAttribute("redircetPath", "/member/signUpPage");
			
			return "redirect:/memberMsg/validatorNo";
		}
	
		int res = memberService.setMemberInput(vo);
		
		if(res == 1)  return "redirect:/memberMsg/memberInputOk";
		else return "redirect:/memberMsg/memberInputNo";
	}
	
	// 아이디찾기 폼
	@RequestMapping(value = "/idSearchPage", method = RequestMethod.GET)
	public String idSearchPageGet() {
		return "userPage/member/idSearchPage";
	}
	// 아이디찾기 처리
	@RequestMapping(value = "/idSearchPage", method = RequestMethod.POST)
	public String idSearchPagePost(Model model,
			@RequestParam(name ="name", defaultValue = "", required = false ) String name, 
			@RequestParam(name ="identiNum", defaultValue = "", required = false ) String identiNum, 
			@RequestParam(name ="email", defaultValue = "", required = false ) String email) {
		
		ArrayList<MemberVO> vos = memberService.getMemberIdSearch(name,identiNum,email);
		
		if(vos != null) model.addAttribute("vos", vos);
			
		else model.addAttribute("sw", "1");
		
		return "userPage/member/idSearchPage";
	}
	
	//비밀번호 찾기 폼
	@RequestMapping(value = "/pwdSearchPage", method = RequestMethod.GET)
	public String pwdSearchPageGet(HttpSession session ) {
		session.removeAttribute("sImsiAuth");
		return "userPage/member/pwdSearchPage";
	}
	// 인증번호 발송
	@RequestMapping(value="/authNumSend", method = RequestMethod.POST)
	@ResponseBody
	public String authNumSendPost(Model model,HttpSession session, HttpServletRequest request,
			@RequestParam(name ="mid", defaultValue = "", required = false ) String mid, 
			@RequestParam(name ="identiNum", defaultValue = "", required = false ) String identiNum, 
			@RequestParam(name ="email", defaultValue = "", required = false ) String email) {
		
		String res = memberService.authCkeckMail(mid,identiNum,email);
		
		// 0: 유저 정보 X, -1: 메일 전송 실패, 1: 메일 전송 완료
		if(res == null) return "0";
		else if(res.equals("-1")) return "-1";
		else {
			// 회원 정보 및 메일 전송 성공시 세션 생성
			session.setMaxInactiveInterval(300); // 5분
			session.setAttribute("sImsiAuth", res);
			return "1";
		}
	}
	// 인증번호 검증 비밀번호 변경 폼 이동
	@RequestMapping(value = "/pwdSearchPage", method = RequestMethod.POST)
	public String pwdSearchPagePost(HttpSession session, Model model,
			@RequestParam(name ="mid", defaultValue = "", required = false ) String mid, 
			@RequestParam(name ="identiNum", defaultValue = "", required = false ) String identiNum, 
			@RequestParam(name ="email", defaultValue = "", required = false ) String email,
			@RequestParam(name ="imsiAuth", defaultValue = "", required = false ) String imsiAuth) {
		
		// session에 있는 임시비밀번호 저장후 session 삭제
		String sImsiAuth = (String)session.getAttribute("sImsiAuth");
		session.removeAttribute("sImsiAuth");
		
		if(sImsiAuth == null) return "redirect:/memberMsg/wrongAccess";
		else if(sImsiAuth.equals(imsiAuth)) {
			session.setAttribute("sImsiMid",mid);
			model.addAttribute("mid", mid);
			return "redirect:/member/pwdChangePage";
		}
		else return "redirect:/memberMsg/pwdChangeNo";
	}
	
	//비밀번호 변경 폼
	@RequestMapping(value = "/pwdChangePage",method = RequestMethod.GET) 
	public String pwcChangePageGet(HttpSession session, Model model, HttpServletRequest request,
			@RequestParam(name = "mid",defaultValue = "", required = false) String mid) {
		String sImsiMid = (String)session.getAttribute("sImsiMid");
		
		if(sImsiMid !=null && sImsiMid.equals(mid) ) {
			model.addAttribute("mid", sImsiMid);
			return "userPage/member/pwdChangePage";
		}
		else {
			model.addAttribute("redirectPath", "/member/pwdSearchPage");
			return "redirect:/memberMsg/wrongAccess";
		}
	}
	//비밀번호 변경 처리
	@RequestMapping(value = "/pwdChangePage",method = RequestMethod.POST) 
	public String pwcChangePagePost(HttpSession session,
			@RequestParam(name = "mid",defaultValue = "", required = false) String mid,
			@RequestParam(name = "pwd1",defaultValue = "", required = false) String pwd1,
			@RequestParam(name = "pwd2",defaultValue = "", required = false) String pwd2 ) {	
		
		session.removeAttribute("sImsiMid");
		
		int res = memberService.setMemberPwdUpdate(mid,pwd1);
		
		if(res == 1) return "redirect:/memberMsg/pwdUpdateOk";
		else return "redirect:/memberMsg/pwdUpdateNo";
	}
	 
}
