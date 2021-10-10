package com.gnbang.webserver.controller.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnbang.webserver.dto.ConsultVO;
import com.gnbang.webserver.security.domain.MyUser;
import com.gnbang.webserver.service.ConsultService;

@Controller
@RequestMapping("/api/consult")
public class APIConsultController {

	private final static Logger logger = LoggerFactory.getLogger(APIConsultController.class);

	@Autowired
	private ConsultService consultService;
	
	public APIConsultController() {
		logger.info("APIConsultController initialize");
	}
	//상담내역 등록
	@ResponseBody
	@RequestMapping(value = "", method = RequestMethod.POST)
	public void addConsult(Model model, @RequestBody ConsultVO consultVO) {
		logger.debug("POST /api/consult");
		System.out.println(consultVO.getNo());
		model.addAttribute("bodyClass", "consult sub");
		model.addAttribute("selectPage", "consult");// 상단 선택 메뉴  css 
	}
	//상담내역 수정
	@ResponseBody
	@RequestMapping(value = "", method = RequestMethod.PUT)
	public void editConsult(Model model, @RequestBody ConsultVO consultVO) {
		logger.debug("PUT /api/consult");
		model.addAttribute("bodyClass", "consult sub");
		model.addAttribute("selectPage", "consult");// 상단 선택 메뉴  css 
	}
	
	
}




