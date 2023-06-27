package com.spring.javaweb14S.service.member;

import java.util.ArrayList;

import com.spring.javaweb14S.vo.MemberVO;


public interface MemberService {

	//로그인 아이디 패스워드 체크
	public MemberVO getMemberLoginChk(String mid, String pwd);

	// 아이디 중복 체크
	public int getMemberMidSearch(String mid);

	// 닉네임 중복 체크
	public int getMemberNickNameSearch(String nickName);

	// 회원가입 처리
	public int setMemberInput(MemberVO vo);

	// 회원 아이디 찾기 처리
	public ArrayList<MemberVO> getMemberIdSearch(String name, String identiNum, String email);

	public String authCkeckMail(String mid, String identiNum, String email);

	public int setMemberPwdUpdate(String mid, String pwd);

	

}
