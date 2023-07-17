package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class TheaterVO {
	private int idx, seat, work;
	private String name, themaIdx, regDate, modifyDate;
	
	private int themaPrice;
	
	// 출력을 위한 변수
	private String themaName;
}
