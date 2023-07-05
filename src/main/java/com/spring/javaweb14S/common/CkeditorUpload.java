package com.spring.javaweb14S.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class CkeditorUpload {

	public int fileUploadPathChange(String savePath, String content) {
		// 이미지가 없을 경우 리턴
		if(content.indexOf("src=\"/") == -1) return 0;
		
		HttpServletRequest request =((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		String insertPath = "/javaweb14S/ckeditorUpload";
		String nextImg = content.substring(content.indexOf(insertPath)+insertPath.length());
		
		boolean sw=true;
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			String origFilePath = realPath+"ckeditor"+imgFile;
			String copyFilePath = realPath+savePath+imgFile;
			
			//ckeditor 파일을 board폴더로 복사
			fileCopyCheck(origFilePath,copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw=false;
			
			else nextImg = nextImg.substring(nextImg.indexOf("/javaweb14S/ckeditorUpload")+insertPath.length());
			
		}
		
		
		return 0;
	}
	
	//원본 파일을 다른곳으로 복사 처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			
			byte[] bytes = new byte[2048];
			int cnt=0;
			while((cnt = fis.read(bytes)) != -1) {
			
				fos.write(bytes,0,cnt);
			}
			
			fos.flush();
			fos.close();
			fis.close();
			
			File a = new File(origFilePath);
			a.delete();
			
			
		}catch (FileNotFoundException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
}
