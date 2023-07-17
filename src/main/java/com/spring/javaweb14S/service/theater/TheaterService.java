package com.spring.javaweb14S.service.theater;

import java.util.ArrayList;
import java.util.List;

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
	public int setTheaterChangeWork(int idx, int work);
	
	//상영관 추가
	public int setTheaterInput(TheaterVO vo);
	
	// 상영관 수정
	public int setTheaterChange(TheaterVO vo);
	
	

	// 상영관 테마 생성
	public int setThemaInput(ThemaVO vo, MultipartFile file1, MultipartHttpServletRequest file2, String realPath,String contextPath);

	// 상영관 테마 전체 리스트
	public ArrayList<ThemaVO> getThemaList();

	// 상영관 테마 메인 화면 출력 여부
	public int setThemaDisplayChange(int idx, String display);

	// 상영관 테마 상세 정보
	public ThemaVO getThemaDetail(int idx);

	// 상영관 테마 메인 이미지 수정
	public int setThemaMainImgChange(int idx, String mainImg);
	
	//상영관 테마 이미지 추가	
	public int setThemaImgInsert(int idx, MultipartHttpServletRequest imagesAddFile, String realPath);

	//상영관 테마 이미지 삭제
	public int setThemaImgDelete(int idx, List<String> imgArr,String realPath);

	//테마 업로드 폴더 제외한 업데이트(테마명, 입장료, 해시태그, 메인페이지 출력 여부, 설명)
	public int setThemMainContentUpdate(ThemaVO vo,String saved_Path);
	
	// 테마 삭제
	public int setThemaDelete(String idx);

	// 선택한 기간에 사용 가능한 상영관 리스트
	public ArrayList<TheaterVO> getTheaterDateList(String startDate, String endDate);

	


}
