package com.spring.javaweb14S.service.reservation;

import com.spring.javaweb14S.vo.ReservationVO;

public interface ReservationService {

	public String reservationGetSeat(ReservationVO vo);

	// 영화 예약 처리
	public String setReservationInput(ReservationVO vo);

	// 영화 결제 취소
	public int setReservationCansel(String idx, int scheduleIdx, int peapleCnt);

}
