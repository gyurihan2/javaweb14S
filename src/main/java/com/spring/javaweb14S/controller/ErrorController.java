package com.spring.javaweb14S.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/errorPage")
public class ErrorController {
	
	
	// 에러 발생 폼
	@RequestMapping(value="/error404", method = RequestMethod.GET)
	public String error404Get() {
		return "errorPage/error404";
	}
	@RequestMapping(value="/error400", method = RequestMethod.GET)
	public String error400Get() {
		return "errorPage/error400";
	}
	// 에러 발생 폼
	@RequestMapping(value="/error500", method = RequestMethod.GET)
	public String error500Get() {
		return "errorPage/error500";
	}
	
}
