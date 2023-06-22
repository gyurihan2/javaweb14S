package com.spring.javaweb14S.service.member;

import com.spring.javaweb14S.vo.MemberVO;


public interface MemberService {

	//로그인 아이디 패스워드 체크
	public MemberVO getMemberLoginChk(String mid, String pwd);

	// 아이디 중복 체크
	public int getMemberMidSearch(String mid);

	// 닉네임 중복 체크
	public int getMemberNickNameSearch(String nickName);

	

}
