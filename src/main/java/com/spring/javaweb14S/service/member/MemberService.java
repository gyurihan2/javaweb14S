package com.spring.javaweb14S.service.member;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb14S.vo.MemberVO;
import com.spring.javaweb14S.vo.MyReservationVO;


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

	// 회원 비밀번호 찾기(회원 정보가 일치할 경우 인증 번호 발송)
	public String authCkeckMail(String mid, String identiNum, String email);

	// 비밀번호 찾기 후 비밀번호 변경
	public int setMemberPwdUpdate(String mid, String pwd);

	// Mid를 이용하여 회원 정보(myPage)
	public MemberVO getUserInfo(String mid);

	//회원 프로필 사진 수정
	public int setMemberPhotoUpdate(MultipartFile file, String sMid, String realPath);

	//회원 닉네임 수정
	public int setMemberNickNameUpdate(String mid, String nickName);

	// 회원 이름 수정
	public int setmemberNameUpdate(String mid, String name);

	// 회원 성별 수정
	public int setmemberGenderUpdate(String mid, String gender);

	// 회원 생일 수정
	public int setmemberBirthdayUpdate(String mid, String birthday);

	// 회원 이메일 수정(인증번호 발송)
	public String myPageAuthSend(String sMid, String email);

	// 회원 이메일 수정 처리
	public int setMemberEmailUpdate(String mid, String email);

	// 회원 예약 전체 리스트
	public String getMyReservationList(String sMid);

	//회원 주소 수정
	public int setMemberAddressUpdate(String mid, String address);

	

	

	

}
