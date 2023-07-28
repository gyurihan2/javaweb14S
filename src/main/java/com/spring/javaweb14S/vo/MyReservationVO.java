package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class MyReservationVO {
	private String idx;
	private int scheduleIdx,movieIdx;
	private String seatInfo;
	private int adultCnt, childCnt;
	private String reserDate;
	private int screenOrder;
	private String playDate,playTime,endTime;
	private String theaterName,themaName,movieName,moviePoster;
	
}
