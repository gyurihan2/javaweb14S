package com.spring.javaweb14S.common;

import java.io.IOException;
import java.util.List;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

@Service
public class JsonProcess {

	// Json 변화(back -> front)
	public <E> String parseToString(List<E> vos) throws JsonGenerationException, JsonMappingException, IOException {
		return new ObjectMapper().writeValueAsString(vos);
	}

	// String -> JsonArray 변환
	public JSONArray parseToJsonArr(String movieDetail) {
		
		//json 변환
		JSONParser jsonPaser = new JSONParser();
		
		JSONArray jsonArray=null;
			try {
				Object obj = jsonPaser.parse(movieDetail);
				jsonArray = (JSONArray) obj;
				
			} catch (org.json.simple.parser.ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return jsonArray;
	}
	
	public String voToJsonString(Object vo) throws JsonGenerationException, JsonMappingException, IOException {
		return new ObjectMapper().writeValueAsString(vo);
	}
}
