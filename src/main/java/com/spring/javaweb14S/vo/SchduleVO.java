package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class SchduleVO {
	private int idx,theaterIdx;
	private String movieIdx;
	
	private String groupId, sreenOrder;
	
	private String playTime,title,leftSeat,waitTime;
}
