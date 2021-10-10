package com.gnbang.webserver.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gnbang.webserver.dto.UserAgentVO;
import com.gnbang.webserver.dto.UserVO;
import com.gnbang.webserver.pojo.social.JoinFacebook;
import com.gnbang.webserver.pojo.social.JoinKakao;
import com.gnbang.webserver.service.JoinService;
import com.google.gson.Gson;


//회원 가입 기능 
@Controller
@RequestMapping(value = "/join")
public class JoinController {

	private final static Logger logger = LoggerFactory.getLogger(JoinController.class);

	public JoinController() {
		logger.info("JoinController initialize");
	}

	@Autowired
	private JoinService service;

	// 회원가입 작성 페이지
	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public String getJoinUser(Model model) {
		logger.debug("GET /join/user");
		model.addAttribute("selectPage", "join");// 상단 선택 메뉴  css
		model.addAttribute("bodyClass", "join");
		return "join.user";
	}

	// 회원가입 임대인
	@RequestMapping(value = "/lessor", method = RequestMethod.GET)
	public String getJoinLessor(Model model) {
		logger.debug("GET /join/lessor");
		model.addAttribute("bodyClass", "join");
		return "join.lessor";
	}

	// 회원가입 중개사
	@RequestMapping(value = "/agent", method = RequestMethod.GET)
	public String getJoinAgent(Model model) {
		logger.debug("GET /join/agent");
		model.addAttribute("bodyClass", "join");
		return "join.agent";
	}

	// 회원가입 처리후 강남방 계정 로그인 Kakao 일반회원
	@RequestMapping(value = "/kakao", method = RequestMethod.POST)
	public String postJoinKakao(@RequestParam("inforKakao") String inforKakao) {
		logger.debug("POST /join/kakao");
		//강남방 회원으로 미등록시 kakao id로 추가
		UserVO userVO = new UserVO();
		userVO.setEmail(String.valueOf(new Gson().fromJson(inforKakao, JoinKakao.class).getId()));
		userVO.setName(String.valueOf(new Gson().fromJson(inforKakao, JoinKakao.class).getProperties().getNickname()));
		service.addKakaoUser(userVO);
		
		//강남방 계정으로 로그인
		return "redirect:/login/social?email=" + userVO.getEmail();
	}

	// 회원가입 처리후  강남방 계정 로그인  Facebook 일반회원
	@RequestMapping(value = "/facebook", method = RequestMethod.POST)
	public String postJoinFacebook(@RequestParam("inforFacebook") String inforFacebook) {
		logger.debug("POST /join/facebook");
		System.out.println("inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook+"inforFacebook : "  + inforFacebook);
		//강남방 회원으로 미등록시 facebook id로 추가
		UserVO userVO = new UserVO();
		userVO.setEmail(String.valueOf(new Gson().fromJson(inforFacebook, JoinFacebook.class).getId()));
		userVO.setName(String.valueOf(new Gson().fromJson(inforFacebook, JoinFacebook.class).getName()));
		service.addFacebookUser(userVO);
		
		//강남방 계정으로 로그인
		return "redirect:/login/social?email=" + userVO.getEmail();
	}

	// 회원가입 처리 일반회원
	@RequestMapping(value = "/user", method = RequestMethod.POST)
	public String postJoinUser(@ModelAttribute("userVO") UserVO userVO) {
		logger.debug("POST /join/user");
		// 일반회원 추가
		service.addUser(userVO);
		return "redirect:/";
	}

	// 회원가입 처리 임대인회원
	@RequestMapping(value = "/lessor", method = RequestMethod.POST)
	public String postJoinLessor(@ModelAttribute("userVO")  UserVO userVO) {
		logger.debug("POST /join/lessor");
		service.addUserLessor(userVO);
		return "redirect:/";
	}

	// 회원가입 처리 중개사
	@RequestMapping(value = "/agent", method = RequestMethod.POST)
	public String postJoinAgent(@ModelAttribute("userVO") UserVO userVO, 
			@RequestParam("agent_name") String agent_name,
			@RequestParam("agent_address") String address,
			@RequestParam("agent_corporate_registration_number") String corporate_registration_number,
			@RequestParam("agent_phone") String phone, 
			@RequestParam("agent_representative") String representative
			, @RequestParam("agent_level") Integer level
			) {
		logger.debug("POST /join/agent"); 
		UserAgentVO userAgentVO = new UserAgentVO();
		userAgentVO.setName(agent_name);
		userAgentVO.setAddress(address);
		userAgentVO.setCorporate_registration_number(corporate_registration_number);
		userAgentVO.setPhone(phone);
		userAgentVO.setRepresentative(representative);
		userAgentVO.setLevel(level);
		System.out.println(userVO);
		System.out.println(userAgentVO);
		service.addUserAgent(userVO, userAgentVO);
		return "redirect:/";
	}

}
