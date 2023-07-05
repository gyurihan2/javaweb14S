package com.spring.javaweb14S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.TheaterVO;
import com.spring.javaweb14S.vo.ThemaVO;

public interface TheaterDAO {

	// 상영관 전체 리스트
	public ArrayList<TheaterVO> getTheaterList();

	// 상영관 상세 정보
	public TheaterVO getTheater(@Param("idx") int idx);

	// 상영관 작동 여부 수정
	public int getTheaterChange(@Param("idx")int idx, @Param("work")int work);

	// 상영관 테마 생성
	public int setThemaInput(@Param("vo")ThemaVO vo);

	// 상영관 테마 전체 리스트
	public ArrayList<ThemaVO> getThemaList();

	// 상영관 테마 메인 화면 출력 여부
	public int setThemaDisplayChange(@Param("idx") int idx, @Param("display") String display);

	// 상영관 테마 상세보기
	public ThemaVO getThemaDetail(@Param("idx")int idx);

}
