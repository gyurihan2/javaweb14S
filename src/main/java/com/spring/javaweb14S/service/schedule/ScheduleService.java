package com.spring.javaweb14S.service.schedule;

import com.spring.javaweb14S.vo.ScheduleVO;

public interface ScheduleService {

	public String getScheduleList(String requestDate);

	public int setScheduleInput(ScheduleVO vo, String[] order);

	public String getScheduleDateListJson(String selectDate);

}
