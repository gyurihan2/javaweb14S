package com.spring.javaweb14S.service.reservation;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.UUID;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javaweb14S.dao.ReservationDAO;
import com.spring.javaweb14S.vo.AgeStatisticsVO;
import com.spring.javaweb14S.vo.GenderRatioVO;
import com.spring.javaweb14S.vo.MovieVO;
import com.spring.javaweb14S.vo.MyReservationVO;
import com.spring.javaweb14S.vo.ReservationStaticsVO;
import com.spring.javaweb14S.vo.ReservationVO;
import com.spring.javaweb14S.vo.ScheduleVO;
import com.spring.javaweb14S.vo.TheaterVO;
import com.spring.javaweb14S.vo.WeekReservationCntVO;

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
	@Transactional(rollbackFor = { Exception.class })
	public String setReservationInput(ReservationVO vo) {
		
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

	// 결제 취소시 예약 처리 취소
	@Override
	public int setReservationCansel(String idx, int scheduleIdx, int peapleCnt) {
		int res=0;
		if(reservationDAO.setReservationDelete(idx) != 0) {
			res =reservationDAO.setLeftSeatAdd(scheduleIdx,peapleCnt);
		};
		
		return res;
	}

	// 예약 정보 상세 보기
	@Override
	public MyReservationVO getReservationDetail(String idx) {
		MyReservationVO vo= reservationDAO.getReservationDetail(idx);
		String seatInfo = parseSeatInfo(vo.getSeatInfo());
		vo.setSeatInfo(seatInfo);
		
		return vo;
	}
	
	private String parseSeatInfo(String seatInfo) {
		String[]seatInfoArr = seatInfo.split("/");
		String temp="";
		
		for(String i : seatInfoArr) {
			int row = Integer.parseInt(i)/20;
			int col = Integer.parseInt(i)%20;
			if(row == 0) temp+="A열 "+col+"/";
			else if(row == 1) temp+="B열 "+col+"/";
			else if(row == 2) temp+="C열 "+col+"/";
			else if(row == 3) temp+="D열 "+col+"/";
			else if(row == 4) temp+="E열 "+col+"/";
			else if(row == 5) temp+="F열 "+col+"/";
			else if(row == 6) temp+="G열 "+col+"/";
			else if(row == 7) temp+="H열 "+col+"/";
			else if(row == 8) temp+="I열 "+col+"/";
			else if(row == 9) temp+="J열 "+col+"/";
			else if(row == 10) temp+="K열 "+col+"/";
			else if(row == 11) temp+="L열 "+col+"/";
			else if(row == 12) temp+="n열 "+col+"/";
			else if(row == 13) temp+="M열 "+col+"/";
			else if(row == 14) temp+="O열 "+col+"/";
			else if(row == 15) temp+="P열 "+col+"/";
			else if(row == 16) temp+="Q열 "+col+"/";
			else if(row == 17) temp+="R열 "+col+"/";
			else if(row == 18) temp+="S열 "+col+"/";
			else if(row == 19) temp+="T열 "+col+"/";
			else if(row == 20) temp+="U열 "+col+"/";
			else if(row == 21) temp+="V열 "+col+"/";
			else if(row == 22) temp+="W열 "+col+"/";
			else if(row == 23) temp+="X열 "+col+"/";
			else if(row == 24) temp+="Y열 "+col+"/";
			else if(row == 25) temp+="Z열 "+col+"/";
		}
		return temp.substring(0,temp.length()-1);
	}

	@Override
	@Transactional(rollbackFor = { Exception.class })
	public int reservationCallOff(String idx, int scheduleIdx, int peapleCnt) {
		
		
		int res = reservationDAO.setReservationDelete(idx);
		if(res == 0) throw new NullPointerException();
		
		res = reservationDAO.setLeftSeatAdd(scheduleIdx, peapleCnt);
		if(res == 0) throw new NullPointerException();
		
		return res;
	}

	// 영화 예매 연령층
	@Override
	public ArrayList<AgeStatisticsVO> getReservationAgeStatic(String movieIdx) {
		ArrayList<AgeStatisticsVO> vosTemp = reservationDAO.getReservationAgeStatic(movieIdx);
		ArrayList<AgeStatisticsVO> vos = new ArrayList<AgeStatisticsVO>();
		
		
		if(vosTemp.size() == 0) vos=null;
		else {
			int index=0;
			for(int i=1; i<6;i++) {
				AgeStatisticsVO vo = new AgeStatisticsVO();
				vo.setAge_group(i+"0대");
				if(vosTemp.get(index).getAge_group().equals(i+"0대")) {
					vo.setCnt(vosTemp.get(index).getCnt());
					if(index<vosTemp.size()-1) index++; 
				}
				else {
					vo.setCnt(0);
				}
				vos.add(vo);
			}
		}
		
		return vos;
	}

	// 영화 예매 성비
	@Override
	public GenderRatioVO getReservationGenderRatio(String movieIdx) {
		GenderRatioVO vo = reservationDAO.getReservationGenderRatio(movieIdx);
		if(vo.getTotal() == 0) vo=null;
		return vo;
	}

	// 일주일간 예매 수
	@Override
	public ArrayList<WeekReservationCntVO> getWeekReservationCnt() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, -3);
		
		ArrayList<WeekReservationCntVO> vos= new ArrayList<WeekReservationCntVO>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for(int i=0; i<7; i++) {
			WeekReservationCntVO vo = new WeekReservationCntVO();
			vo.setDay(sdf.format(cal.getTime()));
			vo.setCnt(reservationDAO.getWeekReservationCnt(sdf.format(cal.getTime())));
			vos.add(vo);
			cal.add(Calendar.DATE, 1);
		}
		return vos;
	}

	//관리자 페이지 현재 상영중인 각 영화의 예약 건수
	@Override
	public ArrayList<ReservationStaticsVO> getTotalReserCntList() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<ReservationStaticsVO> vos = reservationDAO.getTodayMovieList(sdf.format(cal.getTime()));
		
		if(vos.size() !=0)
			for(ReservationStaticsVO vo : vos) vo.setCnt(reservationDAO.getTotalReserCntList(vo.getMovieIdx()));
		
		return vos;
	}
	
	
	
}
