package com.spring.javaweb14S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.ScheduleVO;

public interface ScheduleDAO {

	// 달력에 표시할 스케줄 리스트
	public ArrayList<ScheduleVO> getSchduleList(@Param("requestDate") String requestDate);

	// 스케줄 등록
	public int setScheduleInput(@Param("vos")ArrayList<ScheduleVO> vos);

	// 해당일의 스케줄 리스트
	public ArrayList<ScheduleVO> getSchduleDateList(@Param("selectDate")String selectDate);

}
