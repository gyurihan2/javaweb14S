package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class PageVO {

	//page
	private int pag=1;
	private int pageSize=5;
	private int totRecCnt;
	private int totPage;
	private int startIndexNo;
	private int curScrStartNo;
	
	// block
	private int blockSize;
	private int curBlock;
	private int lastBlock;
	
	
	
	//게시판 검색
	private String part,search,searchString;
}
