package com.spring.javaweb14S.service.movie;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
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

	
	
	
}
