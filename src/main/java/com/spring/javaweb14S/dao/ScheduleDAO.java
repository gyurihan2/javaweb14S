package com.spring.javaweb14S.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.ScheduleVO;

public interface ScheduleDAO {

	// 달력에 표시할 스케줄 리스트
	public ArrayList<ScheduleVO> getSchduleList();

	// 스케줄 등록
	public int setScheduleInput(@Param("vos")ArrayList<ScheduleVO> vos);

	// 해당일의 스케줄 리스트
	public ArrayList<ScheduleVO> getSchduleDateList(@Param("selectDate")String selectDate);

	// 일정 그룹 아이디 삭제
	public int setScheduleDeleteGroup(@Param("groupId")String groupId);

	// 예약 그룹아이디를 통한 남은 좌석수 확인
	//public int getReservationListCnt(String string);

	// 영화 IDX로 스케줄 있는지 확인
	public ScheduleVO getScheduleMoiveIdx(@Param("movieIdx")String movieIdx, @Param("today")String today);

	//관리자 페이지 메인화면 상영중인 영화 리스트
	public ArrayList<ScheduleVO> getScheduleAdminList(@Param("today")String today);


}
