package com.spring.javaweb14S.service.member;

import java.util.ArrayList;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb14S.common.FileUploadProvide;
import com.spring.javaweb14S.dao.MemberDAO;
import com.spring.javaweb14S.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	FileUploadProvide provider;

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
		// 0: 닉네임 중복 1: 닉네임 중복 x
		if(vo == null) return 1;
		else return 0;
	}

	// 회원 가입 처리(비밀번호 BCryptPasswordEncoder)
	@Override
	public int setMemberInput(MemberVO vo) {

		if(memberDAO.getMemberMidChk(vo.getMid()) == null && memberDAO.getMemberNickNameChk(vo.getNickName()) == null) {
			vo.setPwd(passwordEncoder.encode(vo.getPwd()));
			return memberDAO.setMemberInput(vo);
		}
		else return 0;

	}

	// 아이디 찾기
	@Override
	public ArrayList<MemberVO> getMemberIdSearch(String name, String identiNum, String email) {
		ArrayList<MemberVO> vos = memberDAO.getMemberIdSearch(name, identiNum,email);
		
		
		if(!vos.isEmpty()) return vos;
		else return null;
	}

	// 비밀번호 찾기(인증 번호 발송)
	@Override
	public String authCkeckMail(String mid, String identiNum, String email) {
		
		
		MemberVO memberVO = memberDAO.getMemberMidChk(mid);
		// 계정 정보가 일치할 경우
		if( memberVO != null && memberVO.getIdentiNum().equals(identiNum) && memberVO.getEmail().equals(email)) {
			UUID uid = UUID.randomUUID();
			String imsi = uid.toString().substring(0, 8);
			
			String toMail = email;
			String title = "임시 인증 번호 발송";
			String content = "";

			try {
				// 메일 전송을 위한 객체: MimeMessage(), MimeMessageHelper()
				MimeMessage message =  mailSender.createMimeMessage();
				
				//보관함
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true , "UTF-8");
				
				//메일 보관함에 회원이 보내온 메시지들의 정보를 모두 저장시킨 후 작업 
				messageHelper.setTo(toMail);
				messageHelper.setSubject(title);
				
				content += "<br><hr><h3>CGV Green에서 보냅니다.</h3><hr><br>";
				content += "<p>아래의 인증 번호를 인증번호 입력창에 입력 해주세요</p>";
				content += "<p>인증번호: "+imsi+"</p>";
				
				messageHelper.setText(content, true);
				//mailSender.send(message);
				System.out.println("imsi: " + imsi);
			} catch (MessagingException e) {
				e.printStackTrace();
				return "-1";
			}
			
			return imsi;
		}
		// 계정 정보가 일치하지 않을 경우
		else return null;
	}
	
	// 비밀번호 변경 처리
	@Override
	public int setMemberPwdUpdate(String mid, String pwd1) {
		String pwd = passwordEncoder.encode(pwd1);
		return memberDAO.setMemberPwdUpdate(mid, pwd);
	}

	// 회원 정보 확인
	@Override
	public MemberVO getUserInfo(String mid) {
		return memberDAO.getMemberMidChk(mid);
	}

	@Override
	public int setMemberPhotoUpdate(MultipartFile file, String sMid, String realPath) {
		MemberVO vo = memberDAO.getMemberMidChk(sMid);
		
		//이미지 저장
		String saveFileName = provider.fileUploadUid(file, realPath);
		
		if(saveFileName != null) {
			// 기존 이미지 삭제(기본 이미지 noImage.jpg 제외)
			if(!vo.getPhoto().equals("noImage.jpg")) provider.deleteFile(realPath,vo.getPhoto());
			
			// 새로운 이미지 DB업데이트 
			return memberDAO.setMemberPhotoUpdate(sMid,saveFileName);
		}
		
		return 0;
	}

	// 회원 닉네임 수정
	@Override
	public int setMemberNickNameUpdate(String mid, String nickName) {
		return memberDAO.setMemberNickNameUpdate(mid,nickName);
	}
	
	//회원 이름 수정
	@Override
	public int setmemberNameUpdate(String mid, String name) {
		return memberDAO.setMemberNameUpdate(mid,name);
	}

	//회원 성별 수정
	@Override
	public int setmemberGenderUpdate(String mid, String gender) {
		return memberDAO.setMemberGenderUpdate(mid,gender);
	}

	//회원 생일 수정
	@Override
	public int setmemberBirthdayUpdate(String mid, String birthday) {
		return memberDAO.setMemberBirthdayUpdate(mid,birthday);
	}
	
	

}
