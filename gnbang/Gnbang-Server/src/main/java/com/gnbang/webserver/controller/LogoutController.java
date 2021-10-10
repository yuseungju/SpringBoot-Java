package com.gnbang.webserver.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/logout")
public class LogoutController {
	@Autowired
	public UserDetailsService userDetailsService;

	private final static Logger logger = LoggerFactory.getLogger(LogoutController.class);

	public LogoutController() {
		logger.info("LogoutController initialize");
	}

	@RequestMapping(value = { "/gnbang" }, method = RequestMethod.GET)
	public String gnbang(HttpServletRequest request, HttpServletResponse response) {
		logger.debug("/logout/gnbang called");
		System.out.println("gnbang");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return "redirect:/";
	}

	@RequestMapping(value = { "/all" }, method = RequestMethod.GET)
	public String all(HttpServletRequest request, HttpServletResponse response) {
		logger.debug("/logout/all called");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return "redirect:/";
	}
}
