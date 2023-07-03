package com.spring.javaweb14S.service.theater;

import java.util.ArrayList;

import com.spring.javaweb14S.vo.TheaterVO;

public interface TheaterService {

	// 상영관 전체 리스트
	public ArrayList<TheaterVO> getTheaterList();

	// 상영관 상세 정보
	public TheaterVO getTheater(int idx);

	// 상영관 작동여부 수정
	public int setTheaterChange(int idx, int work);

}
