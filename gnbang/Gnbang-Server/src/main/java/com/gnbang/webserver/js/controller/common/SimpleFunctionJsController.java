package com.gnbang.webserver.js.controller.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/js/common/simple_function")
public class SimpleFunctionJsController {
	private final static Logger logger = LoggerFactory.getLogger(SimpleFunctionJsController.class);
	@RequestMapping(value = "/cookie.js", method = RequestMethod.GET, produces =  "application/javascript")
	public String cookie(Model model) {
		logger.debug("load /WEB-INF/js/common/simple_function/cookie.jsp load");
		return "/WEB-INF/js/common/simple_function/cookie.jsp";
	}
	@RequestMapping(value = "/expression.js", method = RequestMethod.GET, produces =  "application/javascript")
	public String expression(Model model) {
		logger.debug("load /WEB-INF/js/common/simple_function/expression.jsp load");
		return "/WEB-INF/js/common/simple_function/expression.jsp";
	}
	@RequestMapping(value = "/math.js", method = RequestMethod.GET, produces =  "application/javascript")
	public String math(Model model) {
		logger.debug("load /WEB-INF/js/common/simple_function/math.jsp load");
		return "/WEB-INF/js/common/simple_function/math.jsp";
	}
	@RequestMapping(value = "/thread.js", method = RequestMethod.GET, produces =  "application/javascript")
	public String thread(Model thread) {
		logger.debug("load /WEB-INF/js/common/simple_function/thread.jsp load");
		return "/WEB-INF/js/common/simple_function/thread.jsp";
	}
	@RequestMapping(value = "/html_and_js.js", method = RequestMethod.GET, produces =  "application/javascript")
	public String html(Model thread) {
		logger.debug("load /WEB-INF/js/common/simple_function/html_and_js.jsp load");
		return "/WEB-INF/js/common/simple_function/html_and_js.jsp";
	}
}
