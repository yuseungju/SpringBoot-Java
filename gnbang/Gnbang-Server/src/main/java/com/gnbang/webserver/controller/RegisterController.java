package com.gnbang.webserver.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

public class RegisterController  {

	private final static Logger logger = LoggerFactory.getLogger(RegisterController.class);

	//@Autowired
	//register service 
	
	public RegisterController() {
		logger.info("SearchController initialize");
	}
	
	@RequestMapping(value = { "" }, method = RequestMethod.GET)
	public String register(Model model) {
		logger.debug("GET /register/ called");
		return "register.register";
	}
	
	@RequestMapping(value = { "" }, method = RequestMethod.POST)
	public String search(Model model) {
		logger.debug("POST /register/ called");
		return "register.register";
	}
	
	@RequestMapping(value = { "" }, method = RequestMethod.GET)
	public String approval(Model model) {
		logger.debug("GET /register/approval called");
		return "register.approval";
	}
	
	@RequestMapping(value = { "" }, method = RequestMethod.GET)
	public String standby(Model model) {
		logger.debug("GET /register/standby called");
		return "register.standby";
	}
	
	@RequestMapping(value = { "" }, method = RequestMethod.GET)
	public String reject(Model model) {
		logger.debug("GET /register/reject called");
		return "register.reject";
	}

}