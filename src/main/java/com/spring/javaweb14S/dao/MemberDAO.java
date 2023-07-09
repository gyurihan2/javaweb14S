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

	public int setMemberNickNameUpdate(@Param("mid")String mid, @Param("nickName")String nickName);

	public int setMemberNameUpdate(@Param("mid")String mid, @Param("name")String name);

	public int setMemberGenderUpdate(@Param("mid")String mid, @Param("gender")String gender);

	public int setMemberBirthdayUpdate(@Param("mid")String mid, @Param("birthday")String birthday);

	public int setMemberEmailUpdate(@Param("mid")String mid, @Param("email")String email);

	


}
