package com.gnbang.webserver.js.controller.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnbang.webserver.controller.IndexController;

@Controller
@RequestMapping("/js/common/server_data")
public class ServerDataJsController {

	private final static Logger logger = LoggerFactory.getLogger(ServerDataJsController.class);
	@RequestMapping(value = "/login.js", method = RequestMethod.GET, produces =  "application/javascript")
	public String login(Model model) {
		logger.debug("load /WEB-INF/js/common/server_data/login.jsp load");
		return "/WEB-INF/js/common/server_data/login.jsp";
	}
	@RequestMapping(value = "/member_infor.js", method = RequestMethod.GET, produces =  "application/javascript")
	public String memberInfor(Model model) {
		logger.debug("load WEB-INF/js/common/server_data/member_infor.jsp");
		return "/WEB-INF/js/common/server_data/member_infor.jsp";
	}
	@RequestMapping(value = "/room_photo.js", method = RequestMethod.GET, produces =  "application/javascript")
	public String roomPhoto(Model model) {
		logger.debug("load WEB-INF/js/common/server_data/room_photo.jsp");
		return "/WEB-INF/js/common/server_data/room_photo.jsp";
	}
}
