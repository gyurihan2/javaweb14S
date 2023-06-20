package com.spring.javaweb14S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberMidChk(@Param("mid") String mid);

	public void setMemberLastLogin(@Param("mid") String mid);

}
