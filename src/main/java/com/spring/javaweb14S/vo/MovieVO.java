package com.spring.javaweb14S.vo;

import lombok.Data;

@Data
public class MovieVO {
	
	private int idx;
	private int runtime,totalView,vote_count;
	
	private float vote_average, rating;
	
	private String main_poster, poster_path;
	
	private String title, tagline, original_title, original_language, genres, release_date, overview;
	private String production_companies, actor;
	
	private String videos;
	
}
