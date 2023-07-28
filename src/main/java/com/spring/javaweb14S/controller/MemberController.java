package com.spring.javaweb14S.controller;

import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;

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
			
			if(vo.getLevel() == 2) session.setAttribute("sStrLevel", "VIP");
			else if(vo.getLevel() == 3) session.setAttribute("sStrLevel", "VVIP");
			else if(vo.getLevel() == 4) session.setAttribute("sStrLevel", "SVIP");
			else session.setAttribute("sStrLevel", "Nomal");
			
			
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
	
/////////////////////////////////		
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
	
/////////////////////////////////		
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
	
/////////////////////////////////		
	//비밀번호 찾기 폼
	@RequestMapping(value = "/pwdSearchPage", method = RequestMethod.GET)
	public String pwdSearchPageGet(HttpSession session ) {
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
		
		// session에 있는 임시비밀번호 저장
		String sImsiAuth = (String)session.getAttribute("sImsiAuth");
		
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
	
/////////////////////////////////	
	//회원 정보 페이지(myPage)
	@RequestMapping(value = "/myPage",method = RequestMethod.GET)
	public String myPagePost(HttpSession session, Model model) {
		String sMid = (String)session.getAttribute("sMid");
		
		//회원 정보 가져오기
		MemberVO vo = memberService.getUserInfo(sMid);
		model.addAttribute("vo", vo);
		
		//예약 정보 가져오기
		String myReserJsonData = memberService.getMyReservationList(sMid);
		model.addAttribute("myReserJsonData", myReserJsonData);
		
		return "userPage/member/myPage";
	}
	// 회원 프로필 이미지 변경 페이지
	@RequestMapping(value = "/photoChangePage",method = RequestMethod.GET)
	public String photoChangeGet(HttpSession session,Model model) {
		String sMid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getUserInfo(sMid);
		model.addAttribute("vo", vo);
		
		return "userPage/member/photoChangePage";
	}
	// 회원 프로필 이미지 변경 처리
	@RequestMapping(value = "/photoChangePage",method = RequestMethod.POST)
	public String photoChangePOST(HttpSession session,MultipartFile file) {
		String sMid = (String)session.getAttribute("sMid");
		String realPath = session.getServletContext().getRealPath("/resources/data/member/");
		
		int res = memberService.setMemberPhotoUpdate(file, sMid, realPath);
		
		if(res == 1) return "redirect:/memberMsg/photoUpdateOk";
		else return "redirect:/memberMsg/photoUpdateNo";
	}
	//회원 닉네임 변경 페이지
	@RequestMapping(value = "/nickNameChangePage",method = RequestMethod.GET)
	public String NickNameChangePageGet(HttpSession session,Model model) {
		String sMid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getUserInfo(sMid);
		model.addAttribute("vo", vo);
		
		return "userPage/member/nickNameChangePage";
	}
	// 회원 닉네임 중복 확인(Ajax)
	@RequestMapping(value = "/nickNameChk",method = RequestMethod.POST)
	@ResponseBody
	public int NickNameChk(String nickName,HttpSession session) {
		String sNickName = (String)session.getAttribute("sNickName");
		
		// 0: 닉네임 중복 1:닉네임 사용가능 2:사용하기전 닉네임과 동일
		if(sNickName.equals(nickName)) return 2;
		else return memberService.getMemberNickNameSearch(nickName);
	}
	//회원 닉네임 변경  처리
	@RequestMapping(value = "/nickNameChangePage",method = RequestMethod.POST)
	public String NickNameChangePagePost(String nickName,HttpSession session) {
		int res = 0;
		String sNickName = (String)session.getAttribute("sNickName");
		String sMid = (String)session.getAttribute("sMid");
		
		if(!nickName.equals(sNickName)) res = memberService.setMemberNickNameUpdate(sMid,nickName);
		
		if(res == 1) {
			session.setAttribute("sNickName", nickName);
			return "redirect:/memberMsg/nickNameUpdateOk";
		}
		else return "redirect:/memberMsg/nickNameUpdateNo";
	}
	// 회원 정보 수정 전 회원 확인 페이지(비밀번호)
	@RequestMapping(value = "/memberPwdChkPage",method = RequestMethod.GET)
	public String memberPwdChkPageGet() {
		return "userPage/member/memberPwdChkPage";
	}
	// 회원 정보 수정 전 회원 확인 페이지(비밀번호 확인 Ajax)
	@RequestMapping(value = "/memberPwdChkPage",method = RequestMethod.POST)
	@ResponseBody
	public int memberPwdChkPageGet(HttpSession session,String pwd) {
		String sMid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberLoginChk(sMid, pwd);
		if(vo == null) return 0;
		else {
			session.setAttribute("loginChk", "OK");
			return 1;
		}
	}
	//회원정보 변경 페이지 
	@RequestMapping(value = "/memberInfoPage",method = RequestMethod.GET)
	public String memberInfoPageGet(HttpSession session, Model model) {
		String loginChk = session.getAttribute("loginChk") == null ? "" : (String)session.getAttribute("loginChk");
		String sMid = (String)session.getAttribute("sMid");
		session.removeAttribute("loginChk");
		
		if(loginChk.equals("OK")) {
			MemberVO vo = memberService.getUserInfo(sMid);
			model.addAttribute("vo", vo);
			return "userPage/member/memberInfoPage";
		}
		else return "userPage/member/memberPwdChkPage";
	}
	//회원 정보 변경 페이지 ->  비밀번호 변경(Ajax)
	@RequestMapping(value = "/memberPwdChange",method = RequestMethod.POST)
	@ResponseBody
	public int memberPwdChange(HttpSession session, String pwd) {
		String sMid = (String)session.getAttribute("sMid");
		
		int res = memberService.setMemberPwdUpdate(sMid, pwd);
		
		if(res == 1) return 1;
		else return 0;
	}
	//회원 정보 변경 페이지 ->  이름 변경(Ajax)
	@RequestMapping(value = "/memberNameChange",method = RequestMethod.POST)
	@ResponseBody
	public int memberNameChange(HttpSession session, String name) {
		String sMid = (String)session.getAttribute("sMid");
		
		int res = memberService.setmemberNameUpdate(sMid,name);
		
		if(res == 1) return 1;
		else return 0;
	}
	//회원 정보 변경 페이지 ->  성별 변경(Ajax)
	@RequestMapping(value = "/memberGenderChange",method = RequestMethod.POST)
	@ResponseBody
	public int memberGenderChange(HttpSession session, String gender) {
		String sMid = (String)session.getAttribute("sMid");
		
		int res = memberService.setmemberGenderUpdate(sMid,gender);
		
		if(res == 1) return 1;
		else return 0;
	}
	//회원 정보 변경 페이지 ->  성별 변경(Ajax)
	@RequestMapping(value = "/memberBirthdayChange",method = RequestMethod.POST)
	@ResponseBody
	public int memberBirthdayChange(HttpSession session, String birthday) {
		String sMid = (String)session.getAttribute("sMid");
		
		int res = memberService.setmemberBirthdayUpdate(sMid,birthday);
		
		if(res == 1) return 1;
		else return 0;
	}
	// 회원 정보 변경 페이지 - > email 변경(Ajax 인증 번호 발송)
	@RequestMapping(value = "/myPageAuthNumSend",method = RequestMethod.POST)
	@ResponseBody
	public int myPageAuthNumSend(HttpSession session, String email,HttpServletRequest request) {
		String sMid = (String)session.getAttribute("sMid");
		
		String imsiAuth = memberService.myPageAuthSend(sMid,email);
		
		if(imsiAuth != null) {
			session.setAttribute("sImsiAuth", imsiAuth);
			return 1;
		}
		else return 0;
		
	}
	// 인증번호 왁인 및 이메일 수정
	@RequestMapping(value = "/memberAuthNumChk",method = RequestMethod.POST)
	@ResponseBody
	public int memberAuthNumChk(HttpSession session,String authNum ,String email) {
		String mid = (String)session.getAttribute("sMid");
		String imsiNum = session.getAttribute("sImsiAuth") == null ? "" : (String)session.getAttribute("sImsiAuth");
		
		if(imsiNum.equals(authNum)) return memberService.setMemberEmailUpdate(mid,email);
		else return 0;
	}
	// 인증번호 왁인 및 이메일 수정
	@RequestMapping(value = "/memberAddressChange",method = RequestMethod.POST)
	@ResponseBody
	public int memberAddressChange(HttpSession session,String address) {
		String mid = (String)session.getAttribute("sMid");
		System.out.println(address);
		return memberService.setMemberAddressUpdate(mid,address);
		
	}
}
