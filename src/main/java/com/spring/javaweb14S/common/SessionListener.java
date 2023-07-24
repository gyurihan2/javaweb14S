package com.spring.javaweb14S.common;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;

import com.spring.javaweb14S.service.reservation.ReservationService;

public class SessionListener implements HttpSessionListener {

	@Autowired
	ReservationService reservationService;
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		System.out.println("세션 생성");
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		System.out.println("세션 종료");
		
	}
	
}
