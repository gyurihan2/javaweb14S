package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class ReservationVO {
	private int idx;
	private String groupId;
	
	
	private String memberMid, seatInfo, reserDate;
	private int seatCnt;
	
	//
	private int scheduleIdx,theaterIdx;
	private String movieIdx;
}
