package com.gnbang.webserver.controller.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gnbang.webserver.dto.RoomPhotoVO;
import com.gnbang.webserver.security.domain.MyRoleAndTokenService;
import com.gnbang.webserver.security.domain.MyUser;
import com.gnbang.webserver.service.LoginService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/api/login")
public class APILoginController {
	private final static Logger logger = LoggerFactory.getLogger(APIMemberController.class);

	@Autowired
	private LoginService loginService;
	@Autowired
	public UserDetailsService userDetailsService;
	@Autowired
	public MyRoleAndTokenService myRoleAndTokenService;

	//이메일 존재확인
	@RequestMapping(value = "/email_overlap", method = RequestMethod.GET)
	@ResponseBody
	public boolean checkEmail(@RequestParam("email") String email) {
		logger.info("GET /api/login/email_overlap");
		if(loginService.overlapEmail(email))//중복이면
			return true;
		return false;
	}
	//로그인 한 회원의 권한을 가져옴
	@RequestMapping(value = "/roles", method = RequestMethod.GET)
	@ResponseBody
	public JSONArray roles()  {
		logger.debug("GET /api/login/roles called");
		ArrayList<String> roleList = new ArrayList<String>();
		roleList = myRoleAndTokenService.getRoles();//로그인 회원의 권한들을 가져옴
		
		// 권한정보들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roleList);
		return jsonArray;
	}
}
