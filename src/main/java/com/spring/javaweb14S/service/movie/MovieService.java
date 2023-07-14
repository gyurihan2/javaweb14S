package com.spring.javaweb14S.service.movie;

import java.util.ArrayList;

import com.spring.javaweb14S.vo.MovieVO;

public interface MovieService {

	// 영화 신규 등록
	public int setMovieInput(String movieDetail);

	// 등록된 영화 상세정보 가져오기
	public MovieVO getMovie(String idx);

	// 영화 전체 리스트
	public ArrayList<MovieVO> getMovieList();

	// 영화 메인 포스터 변경
	public int setMovieMainImageChage(String idx, String posterSrc);

	// 영화 
	public int setmovieUpdate(String idx, String jsonData);

}
