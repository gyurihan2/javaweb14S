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

}
