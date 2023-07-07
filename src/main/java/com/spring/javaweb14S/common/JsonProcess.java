package com.spring.javaweb14S.common;

import java.io.IOException;
import java.util.List;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

@Service
public class JsonProcess {

	public <E> String parseList(List<E> vos) throws JsonGenerationException, JsonMappingException, IOException {
		return new ObjectMapper().writeValueAsString(vos);
	}
}
