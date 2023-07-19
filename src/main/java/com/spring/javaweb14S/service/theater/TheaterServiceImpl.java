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
	public int setTheaterChangeWork(int idx, int work) {
		return theaterDAO.setTheaterChangeWork(idx,work);
	}

	//상영관 추가
	@Override
	public int setTheaterInput(TheaterVO vo) {
		return theaterDAO.setTheaterInput(vo);
	}
	
	// 상영관 수정
	@Override
	public int setTheaterChange(TheaterVO vo) {
		return theaterDAO.setTheaterChange(vo);
	}

	//상영관 테마 생성
	@Override
	public int setThemaInput(ThemaVO vo, MultipartFile file1, MultipartHttpServletRequest file2, String realPath, String contextPath) {
		String orgFName="";
		String saveFName="";
		
		CkeditorUpload ckUpload= new CkeditorUpload();
		
		ckUpload.fileUploadSavePathChange("thema", vo.getContent());
		
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
			vo.setImages("");
			vo.setImgFName("");
		}
		else {
			String temp[] = saveFName.split("/");
			vo.setMainImg(temp[0]);
			vo.setImages(orgFName);
			vo.setImgFName(saveFName);
		}
		
		vo.setContent(vo.getContent().replace(contextPath+"/ckeditorUpload", contextPath+"/thema/image"));
		
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
	
	// 상영관 테마 메인 이미지 수정
	@Override
	public int setThemaMainImgChange(int idx, String mainImg) {
		return theaterDAO.setThemaMainImagChange(idx,mainImg);
	}

	// 상영관 테마 이미지 추가
	@Override
	public int setThemaImgInsert(int idx, MultipartHttpServletRequest imagesAddFile,String realPath) {
		String orgFName="";
		String saveFName="";
		
		List<MultipartFile> imagesList = imagesAddFile.getFiles("imagesAddFile");
		
		for(MultipartFile file : imagesList) {
			if(!file.isEmpty()) {
				orgFName += file.getOriginalFilename()+"/";
				saveFName += fileProvide.fileUploadUid(file, realPath)+"/";
				
			}
		}
		
		if(!orgFName.equals("")) {
			return theaterDAO.setThemaImageAdd(idx,orgFName,saveFName);
		}
		
		return 0;
	}

	// 상영관 테마 이미지 삭제
	@Override
	public int setThemaImgDelete(int idx, List<String> imgArr, String realPath) {
		ThemaVO vo = theaterDAO.getThemaDetail(idx);
		
		String deleteFileName = "";
		for(String fName:imgArr) deleteFileName += fName+"/";
		
		fileProvide.deleteFile(realPath, deleteFileName);
		
		String[] imagesArr = vo.getImages().split("/");
		String[] imgFNameArr = vo.getImgFName().split("/");
		
		for(String fName:imgArr) {
			for(int i=0; i<imgFNameArr.length; i++) {
				if(fName.equals(imgFNameArr[i])) {
					imgFNameArr[i] = null;
					imagesArr[i] = null;
				}
			}
		}
		
		String images="";
		String imgFName="";
		
		for(int i=0; i<imgFNameArr.length;i++) {
			if(imgFNameArr[i] != null) {
				images += imagesArr[i]+"/";
				imgFName += imgFNameArr[i]+"/";
			}
		}
		
		if(images.equals("")) theaterDAO.setThemaImageNoImage(idx);
		return theaterDAO.setThemaImageUpdate(idx, images, imgFName);
	}
	
	//테마 업로드 폴더 제외한 업데이트(테마명, 입장료, 해시태그, 메인페이지 출력 여부, 설명)
	@Override
	public int setThemMainContentUpdate(ThemaVO vo, String saved_Path) {
		String flag="thema";
		ThemaVO orgVO = theaterDAO.getThemaDetail(vo.getIdx());
		
		
		CkeditorUpload ckUpload= new CkeditorUpload();
		
		//  설명(content)가  수정 될 경우
		if(!orgVO.getContent().equals(vo.getContent())) {
			// 저장된 파일 임시 폴더로 이동
			ckUpload.fileUploadImsiPathChange(saved_Path, flag, vo.getContent());
			
			//저장된 파일 경로 변경
			String contextPath = saved_Path.split("/")[0];
			vo.setContent(vo.getContent().replace(contextPath+"/thema/image", contextPath+"/ckeditorUpload"));
			
			// 임시폴더 -> 저장폴더 이동
			ckUpload.fileUploadSavePathChange(flag, vo.getContent());
			
			//저장된 파일 경로 변경
			vo.setContent(vo.getContent().replace(contextPath+"/ckeditorUpload", contextPath+"/thema/image"));
			
		}
		
		return theaterDAO.setThemaMainContentUpdate(vo);
	}

	// 테마 삭제
	@Override
	public int setThemaDelete(String idx) {
		return theaterDAO.setThemaDelete(idx);
	}

	// 설정한 기간의 사용가능한 상영관 리스트
	@Override
	public ArrayList<TheaterVO> getTheaterDateList(String startDate, String endDate) {
		
		return theaterDAO.getTheaterDateList(startDate, endDate);
	}

	// 메인 홈페이지에 표시 할 테마
	@Override
	public ArrayList<TheaterVO> getThemaDisplayList() {
		return theaterDAO.getThemaDisplayList();
	}
	
	
	
	
	
	
}
