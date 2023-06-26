package com.spring.javaweb14S.service.member;

import java.util.ArrayList;

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

	// 아이디 중복 체크
	@Override
	public int getMemberMidSearch(String mid) {
		MemberVO vo =memberDAO.getMemberMidChk(mid);
		
		if(vo == null) return 1;
		else return 0;
	}

	//닉네임 중복 체크
	@Override
	public int getMemberNickNameSearch(String nickName) {
		MemberVO vo =memberDAO.getMemberNickNameChk(nickName);
		
		if(vo == null) return 1;
		else return 0;
	}

	// 회원 가입 처리(비밀번호 BCryptPasswordEncoder / 이메일 하나당 하나 ID생성 가능)
	@Override
	public int setMemberInput(MemberVO vo) {

		if(memberDAO.getMemberIdSearch(vo.getEmail()) == null && memberDAO.getMemberMidChk(vo.getMid()) == null && memberDAO.getMemberNickNameChk(vo.getNickName()) == null) {
			vo.setPwd(passwordEncoder.encode(vo.getPwd()));
			return memberDAO.setMemberInput(vo);
		}
		else return 0;

	}

	@Override
	public MemberVO getMemberIdSearch(String name, String identiNum, String email) {
		MemberVO memberVO = memberDAO.getMemberIdSearch(email);
		
		if( memberVO != null && memberVO.getName().equals(name) && memberVO.getIdentiNum().equals(identiNum)) return memberVO;
		else return null;
	}

	
	
}
