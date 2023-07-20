package com.spring.javaweb14S.service.reservation;

import org.springframework.stereotype.Service;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Override
	public void reservationGetSeat(int theaterIdx, int movieIdx, int screenOrder, String playDate) {
		String groupId = playDate+"_"+screenOrder+"_"+theaterIdx+"_"+movieIdx;
		System.out.println(groupId);
		
	}

	
}
