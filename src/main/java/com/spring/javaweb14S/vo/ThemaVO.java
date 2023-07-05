package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class ThemaVO {
	private int idx, price;
	private String name,content,hashTag,display;
	
	private String mainImg, images, imgFName;
	
	private String regDate, modifyDate;
}
