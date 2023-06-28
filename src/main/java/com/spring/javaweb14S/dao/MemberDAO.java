package com.spring.javaweb14S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberMidChk(@Param("mid") String mid);

	public void setMemberLastLogin(@Param("mid") String mid);

	public MemberVO getMemberNickNameChk(@Param("nickName") String nickName);

	public int setMemberInput(@Param("vo")MemberVO vo);

	public int setMemberPwdUpdate(@Param("mid")String mid, @Param("pwd")String pwd);

	public ArrayList<MemberVO> getMemberIdSearch(@Param("name")String name, @Param("identiNum")String identiNum, @Param("email")String email);

	public int setMemberPhotoUpdate(@Param("mid")String mid, @Param("saveFileName")String saveFileName);



}
