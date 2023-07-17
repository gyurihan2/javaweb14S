package com.spring.javaweb14S.service.movie;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.javaweb14S.dao.MovieDAO;
import com.spring.javaweb14S.vo.MovieVO;

@Service
public class MovieServiceImpl implements MovieService {
	@Autowired
	MovieDAO movieDAO;
	
	// 영화 신규 등록
	@Override
	public int setMovieInput(String movieDetail) {
		ArrayList<MovieVO> vos = new ArrayList<MovieVO>();
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			vos= mapper.readValue(movieDetail, new TypeReference<ArrayList<MovieVO>>() {});
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return movieDAO.setMovieArrInput(vos);
	}

	// 등록된 영화 상세 정보 가져오기
	@Override
	public MovieVO getMovie(String idx) {
		return movieDAO.getMovie(idx);
	}

	// 등록된 영화 전체 리스트
	@Override
	public ArrayList<MovieVO> getMovieList() {
		return movieDAO.getMovieList();
	}

	//등록된 영화 메인 포스터 변경
	@Override
	public int setMovieMainImageChage(String idx, String posterSrc) {
		return movieDAO.setMovieMainImageChange(idx,posterSrc);
	}

	// 등록된 영화 정보 업데이트
	@Override
	public int setmovieUpdate(String idx, String jsonData) {
		MovieVO vo=null;
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			vo = mapper.readValue(jsonData, MovieVO.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		if(!vo.getIdx().equals(idx)) return -1;
		else return movieDAO.setMovieUpdate(vo);
	}

	@Override
	public int setmovieDelete(String idx) {
		return movieDAO.setmovieDelete(idx);
	}

	// 상영 시작일 기준 상영 가능한 영화 리스트
	@Override
	public ArrayList<MovieVO> getMovieDateList(String startDate) {
		return movieDAO.getMovieDateList(startDate);
	}
	
	
	


}
