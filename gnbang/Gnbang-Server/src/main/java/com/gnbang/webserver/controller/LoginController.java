package com.gnbang.webserver.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gnbang.webserver.security.domain.MyUser;
import com.gnbang.webserver.service.LoginService;

@Controller

@RequestMapping("/login")
public class LoginController {
	@Autowired
	public UserDetailsService userDetailsService;
	@Autowired
	private LoginService loginService;
	
	private final static Logger logger = LoggerFactory.getLogger(LoginController.class);

	public LoginController() {
		logger.info("LoginController initialize");
	}
/*
	// 로그인 화면으로
	@RequestMapping(value = "/pop", method = RequestMethod.GET)
	public String pop(Model model) {
		logger.debug("/login/pop called");
		return "redirect:/";
	}
*/
/*	//로그인 실패 이후
	@RequestMapping(value = { "/success" }, method = RequestMethod.GET)
	public String success(HttpServletResponse res, Authentication auth) throws IOException {
		logger.debug("/login/success");
			  res.setContentType("text/html;charset=utf-8");
			  PrintWriter out = res.getWriter();
			  out.println("<script>alert('Delete Success'); location.href='/';</script>"); 
			  out.flush(); 
		return "redirect:/";
	}*/
	
	//kakao , facebook으로 가입했던 회원을 찾아 강남방 회원으로 로그인
	@RequestMapping(value = { "/social" }, method = RequestMethod.GET)
	public String login(HttpServletRequest request, @RequestParam("email") String email) throws Exception {
		logger.debug("/login/social called");
		UserDetails ckUserDetails = userDetailsService.loadUserByUsername(email);
		Authentication authentication = new UsernamePasswordAuthenticationToken(ckUserDetails, email,
				ckUserDetails.getAuthorities());
		SecurityContext securityContext = SecurityContextHolder.getContext();
		securityContext.setAuthentication(authentication);
		HttpSession session = request.getSession(true);
		session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
		return "redirect:/";
	}

	//새 비밀번호 입력창으로
	@RequestMapping(value = { "/new_password" }, method = RequestMethod.GET)
	public String newPassword(Model model, Authentication auth, @RequestParam("email") String email, @RequestParam("encodedPassword") String encodedPassword) {
		logger.debug("/login/new_password called");
		if(!loginService.checkEncodedPassword(email, encodedPassword)){//입력 패스워드와 저장된 패스워드가 일치하지 않으면
	 		return "/";
		}
		model.addAttribute("email", email);
		model.addAttribute("bodyClass", "join");
 		return "new_password";
	}
		
}
