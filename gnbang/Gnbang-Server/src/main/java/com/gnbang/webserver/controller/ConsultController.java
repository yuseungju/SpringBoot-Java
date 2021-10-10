package com.gnbang.webserver.controller;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnbang.webserver.dto.ConsultVO;

//상담 - 방 문의
@Controller
@RequestMapping("/consult")
public class ConsultController {

	private final static Logger logger = LoggerFactory.getLogger(ConsultController.class);

	public ConsultController() {
		logger.info("ConsultController initialize");
	}
	//조회,상담화면으로
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String consult(Model model) {
		logger.debug("GET /consult");
		model.addAttribute("bodyClass", "consult sub");
		model.addAttribute("selectPage", "consult");// 상단 선택 메뉴  css 
		return "consult.consult";
	}
	
	// 상담내역 추가
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String insert(Model model)
			throws ClassNotFoundException, SQLException {
		logger.debug("POST /consult/write"); 
		model.addAttribute("bodyClass", "consult sub");
		model.addAttribute("selectPage", "consult");// 상단 선택 메뉴  css 
		return "consult.write";
	}
	// 업데이트
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String update(Model model)
			throws ClassNotFoundException, SQLException {
		logger.debug("PUT /consult/edit"); 
		model.addAttribute("bodyClass", "consult sub");
		model.addAttribute("selectPage", "consult");// 상단 선택 메뉴  css 
		return "consult.edit";
	}
	// 삭제
	@RequestMapping(value = "/result", method = RequestMethod.GET)
	public String delete(Model model)
			throws ClassNotFoundException, SQLException {
		logger.debug("DELETE /consult"); 
		model.addAttribute("bodyClass", "consult sub");
		model.addAttribute("selectPage", "consult");// 상단 선택 메뉴  css 
		return "consult.result";
	}
}
