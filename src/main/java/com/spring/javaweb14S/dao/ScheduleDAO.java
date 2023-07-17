package com.spring.javaweb14S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.SchduleVO;

public interface ScheduleDAO {

	public ArrayList<SchduleVO> getSchduleList(@Param("requestDate") String requestDate);

}
