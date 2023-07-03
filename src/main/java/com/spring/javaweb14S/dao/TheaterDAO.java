package com.spring.javaweb14S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.TheaterVO;

public interface TheaterDAO {

	// 상영관 전체 리스트
	public ArrayList<TheaterVO> getTheaterList();

	// 상영관 상세 정보
	public TheaterVO getTheater(@Param("idx") int idx);

	// 상영관 작동 여부 수정
	public int getTheaterChange(@Param("idx")int idx, @Param("work")int work);

}
