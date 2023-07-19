package com.spring.javaweb14S.service.schedule;

import com.spring.javaweb14S.vo.ScheduleVO;

public interface ScheduleService {

	// 해당일의 스케줄 리스트(Json)
	public String getScheduleList();

	// 일정 등록
	public int setScheduleInput(ScheduleVO vo, String[] order);

	// 일자 클리시 해당일의 일정 상세 보기
	public String getScheduleDateListJson(String selectDate);

	// 일정(gorupID) 삭제
	public int setScheduleDeleteGroup(String groupId);

}
