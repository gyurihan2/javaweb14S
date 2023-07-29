package com.spring.javaweb14S.service.reservation;

import java.util.ArrayList;

import com.spring.javaweb14S.vo.AgeStatisticsVO;
import com.spring.javaweb14S.vo.GenderRatioVO;
import com.spring.javaweb14S.vo.MyReservationVO;
import com.spring.javaweb14S.vo.ReservationStaticsVO;
import com.spring.javaweb14S.vo.ReservationVO;
import com.spring.javaweb14S.vo.ScheduleVO;
import com.spring.javaweb14S.vo.WeekReservationCntVO;

public interface ReservationService {

	public String reservationGetSeat(ReservationVO vo);

	// 영화 예약 처리
	public String setReservationInput(ReservationVO vo);

	// 영화 결제 취소
	public int setReservationCansel(String idx, int scheduleIdx, int peapleCnt);

	// 예약 상세 보기
	public MyReservationVO getReservationDetail(String idx);

	// 예약 취소
	public int reservationCallOff(String idx, int scheduleIdx, int peapleCnt);

	// 영화 예매 연령 층
	public ArrayList<AgeStatisticsVO> getReservationAgeStatic(String movieIdx);

	// 영화 예매 성비
	public GenderRatioVO getReservationGenderRatio(String movieIdx);

	// 일주일 간 예매 수
	public ArrayList<WeekReservationCntVO> getWeekReservationCnt();

	// 관리자 페이지 현재 상영중인 각 영화의 예약 건수
	public ArrayList<ReservationStaticsVO> getTotalReserCntList();

}
