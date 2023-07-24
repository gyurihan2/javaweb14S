package com.spring.javaweb14S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.MovieVO;
import com.spring.javaweb14S.vo.ReservationVO;
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

	// 영화 예약 처리
	public int setReservationInput(@Param("vo")ReservationVO vo);

	// 영화 예약 처리 후 남은 좌석후 업데이트
	public int setLeftSeatSub(@Param("scheduleIdx")int scheduleIdx, @Param("peapleCnt")int peapleCnt);

	// 예약 삭제(결제 취소)
	public int setReservationDelete(@Param("idx")String idx);

	// 결제 취소 시 남은 좌석 수 업데이트
	public int setLeftSeatAdd(@Param("scheduleIdx")int scheduleIdx, @Param("peapleCnt")int peapleCnt);
	
	

}
