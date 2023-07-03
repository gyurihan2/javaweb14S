package com.spring.javaweb14S.service.theater;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb14S.dao.TheaterDAO;
import com.spring.javaweb14S.vo.TheaterVO;

@Service
public class TheaterServiceImpl implements TheaterService {
	@Autowired
	TheaterDAO theaterDAO;

	// 상영관 전체 리스트
	@Override
	public ArrayList<TheaterVO> getTheaterList() {
		return theaterDAO.getTheaterList();
	}

	// 상영관 상세 정보
	@Override
	public TheaterVO getTheater(int idx) {
		return theaterDAO.getTheater(idx);
	}

	// 상여관 작동여부 수정
	@Override
	public int setTheaterChange(int idx, int work) {
		return theaterDAO.getTheaterChange(idx,work);
	}
	
	
	
}
