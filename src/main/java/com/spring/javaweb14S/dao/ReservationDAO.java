package com.spring.javaweb14S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.AgeStatisticsVO;
import com.spring.javaweb14S.vo.GenderRatioVO;
import com.spring.javaweb14S.vo.MovieVO;
import com.spring.javaweb14S.vo.MyReservationVO;
import com.spring.javaweb14S.vo.ReservationStaticsVO;
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

	// 예약 상세 보기
	public MyReservationVO getReservationDetail(@Param("idx")String idx);

	// 영화 예매 연령층
	public ArrayList<AgeStatisticsVO> getReservationAgeStatic(@Param("movieIdx")String movieIdx);

	// 영화 예매 성비
	public GenderRatioVO getReservationGenderRatio(@Param("movieIdx")String movieIdx);

	// 일주일간 예매 수
	public int getWeekReservationCnt(@Param("days")String days);

	//관리자 페이지 현재 상영중인 각 영화의 예약 건수
	public int getTotalReserCntList(@Param("movieIdx")String movieIdx);

	//관리자 페이지 현재 상영중인 각 영화의 예약 건수
	public ArrayList<ReservationStaticsVO> getTodayMovieList(@Param("today")String today);
	
	
	
	

}
