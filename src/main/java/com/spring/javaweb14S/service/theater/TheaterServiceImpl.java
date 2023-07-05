package com.spring.javaweb14S.service.theater;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb14S.common.CkeditorUpload;
import com.spring.javaweb14S.common.FileUploadProvide;
import com.spring.javaweb14S.dao.TheaterDAO;
import com.spring.javaweb14S.vo.TheaterVO;
import com.spring.javaweb14S.vo.ThemaVO;

@Service
public class TheaterServiceImpl implements TheaterService {
	@Autowired
	TheaterDAO theaterDAO;
	
	@Autowired
	FileUploadProvide fileProvide;

	// 상영관 전체 리스트
	@Override
	public ArrayList<TheaterVO> getTheaterList() {
		return theaterDAO.getTheaterList();
	}

	// 상영관 상세 정보
	@Override
	public TheaterVO getTheater(int idx) {
		return theaterDAO.getTheater(idx);
	}

	// 상여관 작동여부 수정
	@Override
	public int setTheaterChange(int idx, int work) {
		return theaterDAO.getTheaterChange(idx,work);
	}
	
	//상영관 테마 생성
	@Override
	public int setThemaInput(ThemaVO vo, MultipartFile file1, MultipartHttpServletRequest file2, String realPath) {
		String orgFName="";
		String saveFName="";
		
		CkeditorUpload ckUpload= new CkeditorUpload();
		
		ckUpload.fileUploadPathChange("thema", vo.getContent());
		
		List<MultipartFile> imagesList = file2.getFiles("file2");
		imagesList.add(0,file1);
		
		for(MultipartFile file : imagesList) {
			if(!file.isEmpty()) {
				orgFName += file.getOriginalFilename()+"/";
				saveFName += fileProvide.fileUploadUid(file, realPath)+"/";
			}
		}
		
		if(orgFName.equals("")) {
			vo.setMainImg("noImage.jpg");
			vo.setImages("noImage.jpg");
			vo.setImgFName("noImage.jpg");
		}
		else {
			String temp[] = saveFName.split("/");
			vo.setMainImg(temp[0]);
			vo.setImages(orgFName);
			vo.setImgFName(saveFName);
		}
		
		vo.setContent(vo.getContent().replace("/javaweb14S/ckeditorUpload", "/javaweb14S/thema/image"));
		
		return theaterDAO.setThemaInput(vo);
		
	}

	// 상영관 테마 전체 리스트
	@Override
	public ArrayList<ThemaVO> getThemaList() {
		return theaterDAO.getThemaList();
	}

	// 상영관 테마 메인 화면 출력 여부
	@Override
	public int setThemaDisplayChange(int idx, String display) {
		return theaterDAO.setThemaDisplayChange(idx,display);
	}

	// 상영관 테마 상세 정보
	@Override
	public ThemaVO getThemaDetail(int idx) {
		return theaterDAO.getThemaDetail(idx);
	}

	
}
