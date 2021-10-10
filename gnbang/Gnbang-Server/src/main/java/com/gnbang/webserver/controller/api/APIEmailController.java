package com.gnbang.webserver.controller.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnbang.webserver.service.EmailService;
 
@Controller
@RequestMapping(value = "/api/email")
public class APIEmailController {

   private final static Logger logger = LoggerFactory.getLogger(APIEmailController.class);

   @Autowired
   EmailService emailService;

   public APIEmailController() {
      logger.info("APIEmailController initialize");
   }

   //랜덤으로 인증코드생성후에  이메일과 front로 인증코드를 보냄
   @RequestMapping(value = "/code", method = RequestMethod.GET)
   @ResponseBody
   public Integer getSendEmail(Model model, @RequestParam("email") String email) {
      logger.debug("GET /api/email/code called");
      int code = emailService.sendRandomCodeToEmail(email);
      return code;
   }

   //랜덤으로 인증코드생성후에  이메일과 front로 인증코드를 보냄
   @RequestMapping(value = "/password_link", method = RequestMethod.GET)
   @ResponseBody
   public boolean sendPasswordLink(Model model, @RequestParam("email") String email) {
       logger.debug("GET /api/email/password_link called");
       if(emailService.sendPasswordLink(email))//새 비밀번호 입력창의 링크를 이메일로 전송
    	   return true;
       return false;
   }
}