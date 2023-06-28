package com.spring.javaweb14S.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
// Request 객체 직접 생성(업로드 시 RealPath 얻어오기)
public class FileUploadProvide {

	// 단일 파일 업로드 시 파일 이름 랜덤(UID) 생성 메소드
	public String fileUploadUid(MultipartFile fName, String realPath) {
		String res = null;
		try {
			UUID uid = UUID.randomUUID();
			String oFileName = fName.getOriginalFilename();
			String saveFileName = uid + "_" + oFileName;
			
			byte[] data = fName.getBytes();
			
			writeFile(data,realPath, saveFileName);
			
			res = saveFileName;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	// 단일 업로드 진행 
	public void writeFile(byte[] data, String realPath, String saveFileName) throws IOException {
		FileOutputStream fos = new FileOutputStream(realPath+saveFileName);

		fos.write(data);
		fos.close();
	}

	// 기존 파일 삭제
	public void deleteFile(String realPath, String fNames) {
		String temp[] = fNames.split("/");
		
		// 업로드 된 파일 삭제
		for(String fPath : temp) {
			File fileDelete = new File(realPath+fPath);
			if(fileDelete.exists()) {
				fileDelete.delete();
			}
		}
		
	}
}
