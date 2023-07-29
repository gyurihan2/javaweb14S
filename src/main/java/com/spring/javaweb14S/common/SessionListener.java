package com.spring.javaweb14S.common;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;

import com.spring.javaweb14S.service.reservation.ReservationService;

public class SessionListener implements HttpSessionListener {

	/*
	 * @Autowired ReservationService reservationService;
	 */
	
	//public static Map<String, HttpSession> sessionsMap =  new HashMap<String, HttpSession>();
	
//  public synchronized static String sessionLoginCheck(String compareId){
//    String result = "";
//    for( String key : sessionsMap.keySet() ){
//        HttpSession value = sessionsMap.get(key);
//        if(value != null && value.getAttribute("sMid") != null && value.getAttribute("sMid").toString().equals(compareId) ){
//            result =  key.toString();
//        }
//    }
//    return result;
//  }
  
//  public synchronized static void sessionDuplicateLogout(String sessionId){
//    if(sessionId != null && sessionId.length() > 0){
//    	sessionsMap.get(sessionId).invalidate();
//    	sessionsMap.remove(sessionId);    		
//    }
//  }
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		//sessionsMap.put(se.getSession().getId(), se.getSession());
		System.out.println("세션 생성"+se.getSession().getId());
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
//		if(sessionsMap.get(se.getSession().getId()) != null){
//			sessionsMap.get(se.getSession().getId()).invalidate();
//			sessionsMap.remove(se.getSession().getId());	
//		}
		
		/*
		 * HttpSession session = se.getSession();
		 * if(sessionsMap.get(se.getSession().getId()) != null) { HttpSession value =
		 * sessionsMap.get(se.getSession().getId());
		 * System.out.println(value.getAttribute("sPaymentStatus")); String[] res =
		 * ((String)session.getAttribute("sPaymentStatus")).split("_");
		 * 
		 * int i =reservationService.setReservationCansel(res[0],
		 * Integer.parseInt(res[1]), Integer.parseInt(res[2]));
		 * System.out.println("결재 취소 상태: " + i);
		 * sessionsMap.get(se.getSession().getId()).invalidate(); }
		 */

	}

	
	
	
	
}
