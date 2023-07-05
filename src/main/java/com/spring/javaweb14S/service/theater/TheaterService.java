package com.spring.javaweb14S.service.theater;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb14S.vo.TheaterVO;
import com.spring.javaweb14S.vo.ThemaVO;

public interface TheaterService {

	// 상영관 전체 리스트
	public ArrayList<TheaterVO> getTheaterList();

	// 상영관 상세 정보
	public TheaterVO getTheater(int idx);

	// 상영관 작동여부 수정
	public int setTheaterChange(int idx, int work);

	// 상영관 테마 생성
	public int setThemaInput(ThemaVO vo, MultipartFile file1, MultipartHttpServletRequest file2, String realPath);

	// 상영관 테마 전체 리스트
	public ArrayList<ThemaVO> getThemaList();

	// 상영관 테마 메인 화면 출력 여부
	public int setThemaDisplayChange(int idx, String display);

	// 상영관 테마 상세 정보
	public ThemaVO getThemaDetail(int idx);


	

}
