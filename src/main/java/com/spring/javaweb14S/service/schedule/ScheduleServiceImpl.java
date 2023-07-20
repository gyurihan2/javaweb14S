package com.spring.javaweb14S.service.schedule;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb14S.common.JsonProcess;
import com.spring.javaweb14S.dao.ScheduleDAO;
import com.spring.javaweb14S.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService{
	@Autowired
	ScheduleDAO scheduleDAO;
	
	@Autowired
	JsonProcess jsonProcess;

	@Override
	public String  getScheduleList() {
		ArrayList<ScheduleVO> vos =  scheduleDAO.getSchduleList();
		
		if(vos.size() != 0) {
			try {
				return jsonProcess.parseToString(vos);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return null;
		
	}

	// 스케줄 등록
	@Override
	public int setScheduleInput(ScheduleVO vo, String[] order) {
		String groupId= vo.getTheaterIdx()+"_"+vo.getMovieIdx() + "_" + vo.getStartDate() + "_" + vo.getEndDate();
		vo.setGroupId(groupId);
		
		// 등록 날짜 차이 계산
		Date fmt1=null;
		int diffDay =-1;
		
		
		try {
			fmt1 = new SimpleDateFormat("yyyy-MM-dd").parse(vo.getStartDate());
			Date fmt2 = new SimpleDateFormat("yyyy-MM-dd").parse(vo.getEndDate());
			diffDay = (int)((fmt2.getTime() - fmt1.getTime())/(24*60*60*1000));
		} catch (ParseException e) {
			e.printStackTrace();
		}
			
		if(diffDay==-1 && order.length == 0) return -1;
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(fmt1);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		ArrayList<ScheduleVO> vos = new ArrayList<ScheduleVO>();
		
		for(int i=0;i<=(diffDay+1); i++) {
			String playDate = sdf.format(cal.getTime());
			
			int cnt=1;
			for(String playTime:order) {
				
				ScheduleVO tempVO = new ScheduleVO();
				tempVO.setTheaterIdx(vo.getTheaterIdx());
				tempVO.setGroupId(vo.getGroupId());
				tempVO.setPlayDate(playDate);
				tempVO.setMovieIdx(vo.getMovieIdx());
				tempVO.setScreenOrder(cnt++);
				tempVO.setPlayTime(playTime);
				tempVO.setRuntime(vo.getRuntime());
				tempVO.setLeftSeat(vo.getLeftSeat());
				
				vos.add(tempVO);
			}
			// 하루 증가
			cal.add(Calendar.DATE,1);
		}
		return scheduleDAO.setScheduleInput(vos);
	}

	// 해당 일의 일정 출력
	@SuppressWarnings("unchecked")
	@Override
	public String getScheduleDateListJson(String selectDate) {
		ArrayList<ScheduleVO> vos = scheduleDAO.getSchduleDateList(selectDate);
		
		if(vos.size()==0) {
			return null;
		}
		
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		ArrayList<Integer> screenOrder = new ArrayList<>();
		ArrayList<String> playTimeList = new ArrayList<>();
		ArrayList<String> endTimeList = new ArrayList<>();
		ArrayList<String> leftSeatList = new ArrayList<>();
		
		String groupId = vos.get(0).getGroupId();
		jsonObject.put("theaterName",vos.get(0).getTheaterName());
		jsonObject.put("theaterWork",vos.get(0).getTheaterWork());
		jsonObject.put("theaterIdx",vos.get(0).getTheaterIdx());
		jsonObject.put("movieTitle",vos.get(0).getMovieTitle());
		jsonObject.put("movieIdx",vos.get(0).getMovieIdx());
		jsonObject.put("leftSeat",vos.get(0).getLeftSeat());
		jsonObject.put("main_poster",vos.get(0).getMain_poster());
		jsonObject.put("themaName",vos.get(0).getThemaName());
		
		
		for(ScheduleVO vo : vos) {
			if(groupId.equals(vo.getGroupId())) {
				screenOrder.add(vo.getScreenOrder());
				playTimeList.add(vo.getPlayTime());
				endTimeList.add(vo.getEndTime());
				leftSeatList.add(vo.getLeftSeat());
			}
			else {
				jsonObject.put("screenOrder",screenOrder);
				jsonObject.put("playTime",playTimeList);
				jsonObject.put("endTime",endTimeList);
				jsonObject.put("leftSeat",leftSeatList);
				jsonArray.add(jsonObject);
				
				// 초기화
				screenOrder=new ArrayList<>();
				playTimeList=new ArrayList<>();
				endTimeList=new ArrayList<>();
				leftSeatList=new ArrayList<>();
				
				groupId = vo.getGroupId();
				jsonObject = new JSONObject();
				jsonObject.put("theaterName",vo.getTheaterName());
				jsonObject.put("theaterWork",vo.getTheaterWork());
				jsonObject.put("theaterIdx",vo.getTheaterIdx());
				jsonObject.put("movieTitle",vo.getMovieTitle());
				jsonObject.put("movieIdx",vo.getMovieIdx());
				jsonObject.put("leftSeat",vo.getLeftSeat());
				jsonObject.put("main_poster",vo.getMain_poster());
				jsonObject.put("themaName", vo.getThemaName());
			}
		}
		jsonObject.put("screenOrder",screenOrder);
		jsonObject.put("playTime",playTimeList);
		jsonObject.put("endTime",endTimeList);
		jsonObject.put("leftSeat",leftSeatList);
		jsonArray.add(jsonObject);
		
		
		return jsonArray.toJSONString();
	}

	// 일정 그룹 아이디 삭제
	@Override
	public int setScheduleDeleteGroup(String groupId) {
		return scheduleDAO.setScheduleDeleteGroup(groupId);
	}
	
	
	
}