package com.spring.javaweb14S.service.reservation;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.UUID;

import org.apache.ibatis.binding.BindingException;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javaweb14S.dao.ReservationDAO;
import com.spring.javaweb14S.vo.MovieVO;
import com.spring.javaweb14S.vo.ReservationVO;
import com.spring.javaweb14S.vo.ScheduleVO;
import com.spring.javaweb14S.vo.TheaterVO;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	ReservationDAO reservationDAO; 
	
	@Override
	@SuppressWarnings("unchecked")
	public String reservationGetSeat(ReservationVO vo) {
		
		TheaterVO theaterVO = reservationDAO.getTheater(vo.getTheaterIdx());
		MovieVO movieVO = reservationDAO.getMovie(vo.getMovieIdx());
		ScheduleVO scheduleVO = reservationDAO.getSchedule(vo.getScheduleIdx());
		
		// 정보가 이상할경우 null 리턴
		if(theaterVO == null || movieVO == null || scheduleVO == null) return null;
	
		String groupId = scheduleVO.getPlayDate()+"_"+scheduleVO.getIdx()+"_"+theaterVO.getIdx()+"_"+movieVO.getIdx();
		ArrayList<String> seatInfoListTemp = reservationDAO.getSeatInfoList(groupId);
		ArrayList<String> seatInfoList = new ArrayList<String>(theaterVO.getSeat());
		
		for(String temp : seatInfoListTemp) {
			String[] tempArr = temp.split("/");
			for(int i=0; i<tempArr.length;i++) {
				seatInfoList.add(tempArr[i]);
			}
		}
		seatInfoList.sort(Comparator.naturalOrder());
		System.out.println(seatInfoList);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("theaterName", theaterVO.getName());
		jsonObject.put("theaterIdx", theaterVO.getIdx());
		jsonObject.put("themaPrice", theaterVO.getThemaPrice());
		jsonObject.put("totalSeat", theaterVO.getSeat());
		jsonObject.put("movieTitle", movieVO.getTitle());
		jsonObject.put("movieIdx", movieVO.getIdx());
		jsonObject.put("seatInfoList", seatInfoList);
		
		return jsonObject.toString();
	}

	// 영화 예약 처리
	@Override
	@Transactional(rollbackFor = { NullPointerException.class })
	public String setReservationInput(ReservationVO vo) {
		System.out.println(vo.toString());
		
		//상영일_스케줄IDX_상영관IDX_영화IDX_인원수
		String groupId = vo.getPlayDate() + "_" + vo.getScheduleIdx() + "_" + vo.getTheaterIdx() + "_" + vo.getMovieIdx();
		vo.setGroupId(groupId);
		
		// 예약 idx = 멤버MID_난수(5자리)_스케줄IDX 
		String idx=vo.getMemberMid()+"_"+UUID.randomUUID().toString().subSequence(0, 5)+"_"+vo.getScheduleIdx();
		vo.setIdx(idx);
		
		try {
			int res = reservationDAO.setReservationInput(vo);
			
			if(res == 1) {
				int res2 = reservationDAO.setLeftSeatSub(vo.getScheduleIdx(),vo.getAdultCnt()+vo.getChildCnt());
				if(res2 == 0) throw new NullPointerException();
				return idx;
			}
			else return null;
			
		}catch (DataIntegrityViolationException e) {
			e.printStackTrace(); // 유니크 키
			return "-1";
		}
	}

	@Override
	public int setReservationCansel(String idx, int scheduleIdx, int peapleCnt) {
		int res=0;
		if(reservationDAO.setReservationDelete(idx) != 0) {
			res =reservationDAO.setLeftSeatAdd(scheduleIdx,peapleCnt);
		};
		
		return res;
	}

	
}
