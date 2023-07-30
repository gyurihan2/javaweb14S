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
	private HttpServletRequest request =((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
	final String REALPATH = request.getSession().getServletContext().getRealPath("/resources/data/");

	// 임시폴더 -> 저장폴더
	public int fileUploadSavePathChange(String savePath, String content) {
		// 이미지가 없을 경우 리턴
		if(content.indexOf("src=\"/") == -1) return 0;

		String saved_Path = "/javaweb14S/ckeditorUpload";
		String nextImg = content.substring(content.indexOf(saved_Path)+saved_Path.length());
		
		boolean sw=true;
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			String origFilePath = REALPATH+"ckeditor"+imgFile;
			String copyFilePath = REALPATH+savePath+imgFile;
			
			//ckeditor 파일을 thema폴더로 복사
			fileCopyCheck(origFilePath,copyFilePath,true);
			
			if(nextImg.indexOf("src=\"/") == -1) sw=false;
			
			else nextImg = nextImg.substring(nextImg.indexOf("/javaweb14S/ckeditorUpload")+saved_Path.length());
			
		}
		
		return 1;
	}
	
	//원본 파일을 다른곳으로 복사 처리 후 원본 파일 삭제
	private void fileCopyCheck(String origFilePath, String copyFilePath,Boolean delete) {
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
			
			if(delete) {
				File a = new File(origFilePath);
				a.delete();
			}
			
			
		}catch (FileNotFoundException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	
	public int fileUploadImsiPathChange(String saved_Path, String flag, String content) {
		// 이미지가 없을 경우 리턴
		if(content.indexOf("src=\"/") == -1) return 0;
		System.out.println(content);
		String nextImg = content.substring(content.indexOf(saved_Path)+saved_Path.length());
		System.out.println(nextImg);
		boolean sw=true;
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			System.out.println(imgFile);
			String origFilePath = REALPATH+flag+imgFile;
			String copyFilePath = REALPATH+"ckeditor"+imgFile;
			
			System.out.println("origFilePath: "+origFilePath);
			System.out.println("copyFilePath: "+copyFilePath);
			//ckeditor 파일을 board폴더로 복사
			fileCopyCheck(origFilePath, copyFilePath, true);
			
			if(nextImg.indexOf("src=\"/") == -1) sw=false;
			
			else nextImg = nextImg.substring(nextImg.indexOf("/javaweb14S/ckeditorUpload")+saved_Path.length());
			
		}
		
		return 1;
	}
	
	
}
