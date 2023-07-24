package com.spring.javaweb14S.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb14S.service.member.MemberService;
import com.spring.javaweb14S.service.reservation.ReservationService;
import com.spring.javaweb14S.vo.MemberVO;
import com.spring.javaweb14S.vo.ReservationVO;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

	@Autowired
	ReservationService reservationService;
	
	@Autowired
	MemberService memberService;
	
	// 예약 메인 페이지
	@RequestMapping(value = "/reservationMainPage", method = RequestMethod.GET)
	public String reservationMainPage(Model model,HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		
		if(mid != null) {
			MemberVO memberVO = memberService.getUserInfo(mid);
			System.out.println(memberVO.toString());
			model.addAttribute("memberVO", memberVO);
		}
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		SimpleDateFormat sfmt = new SimpleDateFormat("yyyy-MM-dd");
		
		int dayOfWeek;
		String dayOfWeekStr;
		ArrayList<String> dateVOS = new ArrayList<String>();
		
		for(int i=0; i<10; i++) {
			dayOfWeek=cal.get(Calendar.DAY_OF_WEEK);
			dayOfWeekStr = getDayOfWeek(dayOfWeek);
			dateVOS.add(sfmt.format(cal.getTime())+"("+dayOfWeekStr+")");
			cal.add(Calendar.DATE, 1);
		}
		
		model.addAttribute("dateVOS", dateVOS);
		
		return "userPage/reservation/reservationPage";
	}
	// 요일 변환
	private String getDayOfWeek(int res) {
		if(res == 1) return "일";
		else if(res == 2) return "월";
		else if(res == 3) return "화";
		else if(res == 4) return "수";
		else if(res == 5) return "목";
		else if(res == 6) return "금";
		else  return "토";
	}
	
	// 예약 정보를 통한 좌석 확인
	@RequestMapping(value = "/reservationGetSeat", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	@ResponseBody
	public String reservationGetSeatPost(ReservationVO vo){
		
		return reservationService.reservationGetSeat(vo);
	}
	
	//예약 처리
	@RequestMapping(value = "/reservationOk", method = RequestMethod.POST)
	@ResponseBody
	public String reservationOkPost(ReservationVO vo, HttpSession session) {
		try{
			String res = reservationService.setReservationInput(vo);
			if(res != null && res.equals("-1")) {
				session.setAttribute("sPaymentStatus", res+"_"+vo.getScheduleIdx()+"_"+(vo.getAdultCnt()+vo.getChildCnt()));
			}
			return res;
			
		}catch (NullPointerException e) {
			System.out.println("트랙잭션을 위한 강제 예외처리"+e.getMessage());
			return "-2";
		}
	}
	
	//예약 처리 확정(결제 완료)
	@RequestMapping(value = "/reservationConfirm", method = RequestMethod.POST)
	@ResponseBody
	public void reservationConfirmPost(HttpSession session) {
		if(session.getAttribute("sPaymentStatus") != null) session.removeAttribute("sPaymentStatus");
	}
	
	//예약 처리 확정(결제 취소)
	@RequestMapping(value = "/reservationCancel", method = RequestMethod.POST)
	@ResponseBody
	public void reservationCancelPost(HttpSession session,
			String idx, int scheduleIdx, int peapleCnt) {
		int res = reservationService.setReservationCansel(idx,scheduleIdx,peapleCnt);
		if(res != 0) session.removeAttribute("sPaymentStatus");
	}
}
