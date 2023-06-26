package com.spring.javaweb14S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberMidChk(@Param("mid") String mid);

	public void setMemberLastLogin(@Param("mid") String mid);

	public MemberVO getMemberNickNameChk(@Param("nickName") String nickName);

	public int setMemberInput(@Param("vo")MemberVO vo);

	public MemberVO getMemberIdSearch(@Param("email")String email);

	

}
