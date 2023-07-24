package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class ReservationVO {

	private String idx,groupId;
	
	
	private String memberMid, seatInfo, reserDate;
	private int adultCnt, childCnt;
	
	//
	private int scheduleIdx,theaterIdx;
	private String movieIdx;
	private String playDate;
}
