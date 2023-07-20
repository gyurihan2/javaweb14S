package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class ScheduleVO {
	private int idx,theaterIdx,screenOrder;
	private String movieIdx;
	
	private String groupId;
	
	private String playDate,playTime,endTime,leftSeat,waitTime;
	
	///
	private String startDate, endDate;
	private String theaterName, movieTitle, main_poster;
	private int runtime, theaterWork;
	private String themaName;
}
