package com.spring.javaweb14S.service.member;

import com.spring.javaweb14S.vo.MemberVO;


public interface MemberService {

	//로그인 아이디 패스워드 체크
	public MemberVO getMemberLoginChk(String mid, String pwd);

	

}
