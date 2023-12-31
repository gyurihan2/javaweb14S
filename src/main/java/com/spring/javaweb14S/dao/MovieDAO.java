package com.spring.javaweb14S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb14S.vo.MovieVO;

public interface MovieDAO {

	// 영화 신규 등록
	public int setMovieArrInput(@Param("vos") ArrayList<MovieVO> vos);
	
	// 등록된 영화 상세정보
	public MovieVO getMovie(@Param("idx")String idx);

	// 등록된 영화 리스트
	public ArrayList<MovieVO> getMovieList();

	// 등록된 영화 메인 포스터 변경
	public int setMovieMainImageChange(@Param("idx")String idx, @Param("posterSrc")String posterSrc);

	// 등록된 영화 업데이트
	public int setMovieUpdate(@Param("vo") MovieVO vo);

	// 영화 삭제
	public int setmovieDelete(@Param("idx") String idx);

	// 상영 시작일 기준 상영 가능한 영화 리스트
	public ArrayList<MovieVO> getMovieDateList(@Param("startDate") String startDate);

	// 메인 화면에 표시할 영화 리스트
	public ArrayList<MovieVO> getMovieTodaySchedule(@Param("todayFmt")String todayFmt);

	// top_nav에서 영화 검색할경우
	public ArrayList<MovieVO> getMovieSearchList(@Param("title")String title);

}
