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
	public int setTheaterChangeWork(@Param("idx")int idx, @Param("work")int work);

	//상영관 추가
	public int setTheaterInput(@Param("vo")TheaterVO vo);
	
	// 상영관 수정
	public int setTheaterChange(@Param("vo")TheaterVO vo);
	
	
	
	// 상영관 테마 생성
	public int setThemaInput(@Param("vo")ThemaVO vo);

	// 상영관 테마 전체 리스트
	public ArrayList<ThemaVO> getThemaList();

	// 상영관 테마 메인 화면 출력 여부
	public int setThemaDisplayChange(@Param("idx") int idx, @Param("display") String display);

	// 상영관 테마 상세보기
	public ThemaVO getThemaDetail(@Param("idx")int idx);

	// 상영관 테마 메인 이미지 변경
	public int setThemaMainImagChange(@Param("idx")int idx, @Param("mainImg")String mainImg);

	// 상영관 테마 이미지 추가
	public int setThemaImageAdd(@Param("idx")int idx, @Param("orgFName")String orgFName, @Param("saveFName")String saveFName);

	// 상영관 테마 이미지 삭제
	public int setThemaImageUpdate(@Param("idx")int idx, @Param("images")String images, @Param("imgFName")String imgFName);

	// 상영관 테마 기본 이미지 noImage 설정(테마 이미지 다 삭제 할경우)
	public void setThemaImageNoImage(@Param("idx")int idx);

	//테마 업로드 폴더 제외한 업데이트(테마명, 입장료, 해시태그, 메인페이지 출력 여부, 설명)
	public int setThemaMainContentUpdate(@Param("vo")ThemaVO vo);

	// 테마 삭제
	public int setThemaDelete(@Param("idx")String idx);

	// 설정한 기간의 사용가능한 상영관 리스트
	public ArrayList<TheaterVO> getTheaterDateList(@Param("startDate") String startDate, @Param("endDate") String endDate);



}
