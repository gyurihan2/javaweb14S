package com.spring.javaweb14S.vo;

import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class MemberVO {
	
	private int idx,level,point,totPoint;
	
	private String  pwd, name, identiNum, gender,birthday,
					phone, address, startDate, lastLogin, userDel, levelIUpDate;
	
	@NotEmpty(message = "NotNull")
	private String mid,nickName,email;
}
