package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx,level,point,totPoint;
	private String mid, pwd, salt, name, nickName, identiNum, gender,birthday,
					phone, address, email, startDate, lastLogin, userDel;
}
