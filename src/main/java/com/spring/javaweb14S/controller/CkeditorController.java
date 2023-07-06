package com.spring.javaweb14S.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/ckeditor")
public class CkeditorController {
	
	@RequestMapping(value = "themaContentUpload")
	public void themaContentGet(MultipartFile upload, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		
		// 한글 처리가 안되는 경우가 있어 한글 처리
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		// 저장 위치
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		// 파일 저장 이름(날짜 + '_' +fileName)
		String oFileName = upload.getOriginalFilename();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			
		oFileName = sdf.format(date) +"_"+oFileName;
			
		// 메모리에 올라온 바이너리를 바이트 변환
		byte[] bytes = upload.getBytes();
		
		// FileOutputStream 부모 -> OutputStream
		// ckeditor에서 올린(업로드)한 파일을 서버파일시스템에 저장 처리
		FileOutputStream fos = new FileOutputStream(new File(realPath+oFileName));
		fos.write(bytes);
		
		//서버 파일시스템에 저장(업로드한) 그림을 브라우저 에 보여준다.
		PrintWriter out = response.getWriter();
		String fileUrl =request.getContextPath()+"/ckeditorUpload/"+oFileName;
		

		// 키는 고정 ckeditor 제공하는 예약어를 사용해야됨
		out.println("{\"originalFilename\":\""+oFileName+"\","
				+ "\"uploaded\":1,"
				+ "\"url\":\""+fileUrl+"\"}");
		
		// 객체 반환
		out.flush();
		fos.close();
		
	}
}
