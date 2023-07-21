package com.spring.javaweb14S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.MovieVO;
import com.spring.javaweb14S.vo.ScheduleVO;
import com.spring.javaweb14S.vo.TheaterVO;

public interface ReservationDAO {

	// 상영관 정보
	public TheaterVO getTheater(@Param("theaterIdx")int theaterIdx);

	// 영화 정보
	public MovieVO getMovie(@Param("movieIdx") String movieIdx);

	// 스케줄 정보
	public ScheduleVO getSchedule(@Param("scheduleIdx") int scheduleIdx);

	// 좌석 정보
	public ArrayList<String> getSeatInfoList(@Param("groupId") String groupId);

}
