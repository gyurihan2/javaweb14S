package com.spring.javaweb14S.common;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener,HttpSessionAttributeListener {

	
	//@Autowired ReservationService reservationService;
	 
	
	//public static Map<String, HttpSession> SESSION_MAP =  new HashMap<String, HttpSession>();
	//public static Map<String, String> SESSION_RESERST =  new HashMap<String, String>();
	
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
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
//		if(sessionsMap.get(se.getSession().getId()) != null){
//			sessionsMap.get(se.getSession().getId()).invalidate();
//			sessionsMap.remove(se.getSession().getId());	
//		}
		

	}

	@Override
	public void attributeAdded(HttpSessionBindingEvent se) {
		
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent se) {
		
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent se) {
		
	}

	
	
	
	
}
