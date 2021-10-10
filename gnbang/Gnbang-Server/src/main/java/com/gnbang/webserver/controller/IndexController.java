package com.gnbang.webserver.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

//초기화면 이동 
@Controller
public class IndexController {
	
	private final static Logger logger = LoggerFactory.getLogger(IndexController.class);

	public IndexController() {
		logger.info("IndexController initialize");
	}
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) {
		logger.debug("GET / called");
		return "redirect:/search";//방찾기 기본화면으로
	}
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Model model) {
		logger.debug("GET test called");
		return "test";
	}
	@RequestMapping(value = "/test2.js", method = RequestMethod.GET, produces =  "application/javascript")
	public String te1st(Model model) {
		logger.debug("GET test called");
		return "test";
	}
}