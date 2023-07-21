package com.spring.javaweb14S.service.reservation;

import java.util.ArrayList;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

		ArrayList<String> seatInfoList = reservationDAO.getSeatInfoList(groupId);
		
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

	
}
