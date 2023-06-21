package com.spring.javaweb14S.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.javaweb14S.dao.MemberDAO;
import com.spring.javaweb14S.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	// 로그인 아이디 패스워드 체크
	@Override
	public MemberVO getMemberLoginChk(String mid, String pwd) {
		
		MemberVO vo = memberDAO.getMemberMidChk(mid);
		
		if(vo !=null && passwordEncoder.matches(pwd, vo.getPwd())) {
			// 마지막 로그인 일 수정
			memberDAO.setMemberLastLogin(mid);
			
			return vo;
		}
		else return null;

	}

	
	
}
