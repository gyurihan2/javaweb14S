package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class TheaterVO {
	private int idx, seat, work;
	private String name, themaIdx, regDate, modifyDate;
	
	private String themaName;
	private int themaPrice;
}
