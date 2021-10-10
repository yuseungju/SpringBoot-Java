package com.gnbang.webserver.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnbang.webserver.dto.UserVO;
import com.gnbang.webserver.service.MemberService;

//회원관리
@Controller
@RequestMapping("/member") 
public class MemberController {

	@Autowired
	public MemberService memberService;
	private final static Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	public MemberController() {
		logger.info("MemberController initialize");
	}
	
	//회원정보수정페이지, 로그인한 회원의 권한에따라 다르게 접근
	@RequestMapping(value = { "/mypage" }, method = RequestMethod.GET)
	public String enrollMain(HttpServletRequest request,Model model) {
		logger.debug("GET /member/mypage called");
		try{
			/*
			//중개사와 일반회원에 따라 마이페이지 뷰를 다르게 설정
		    if(request.isUserInRole("ROLE_AGENT")){//중개사의 뷰
				return "redirect:/member/agent/mypage";// 중개사회원정보 기본화면으로
		    }
		    else if(request.isUserInRole("ROLE_USER")){//일반회원의 뷰
				return "redirect:/";// 일반회원 회원정보 기본화면으로
		    }/*else if(request.isUserInRole("..")){
		    	//....
		    }*/
			return "redirect:/member/agent/mypage";// 중개사회원정보 기본화면으로
		}catch(Exception E){}
		return "redirect:/";// 일반회원정보 기본화면으로
	}	
		
	//중개사 회원정보(기본화면) 수정 화면으로
	@RequestMapping(value = { "/agent/mypage" }, method = RequestMethod.GET)
	public String mypage(Model model) {
		logger.debug("GET /member/agent/mypage called");
		model.addAttribute("bodyClass", "mypage sub");//<body> css
		model.addAttribute("selectPage", "mypage");//죄측 선택 메뉴  css
		return "member.agent.modify_infor.mypage";
	}
	
	//중개사의 비밀번호 변경 화면으로
	@RequestMapping(value = { "/agent/password/modify" }, method = RequestMethod.GET)
	public String password(Model model) {
		logger.debug("GET /member/agent/password/modify called");
		model.addAttribute("bodyClass", "mypage sub");//<body> css
		model.addAttribute("selectPage", "password");//죄측 선택 메뉴  css
		return "member.agent.modify_password.password";
	}
	
	/*	//비밀번호 찾기에서  변경 화면으로
	@RequestMapping(value = { "/agent/password" }, method = RequestMethod.GET)
	public String findPassword(Model model) {
		logger.debug("/member/password called");
		model.addAttribute("bodyClass", "join");
		return "member.agent.modify_password.password";
	}*/
	
	//중개사의 관심매물 폴더목록으로
	@RequestMapping(value = { "/agent/interest" }, method = RequestMethod.GET)
	public String interest(Model model) {
		logger.debug("GET /member/agent/interest called");
		model.addAttribute("bodyClass", "mypage sub");//<body> css
		model.addAttribute("selectPage", "interest");//죄측 선택 메뉴  css
		return "member.agent.interest.interest";
	}
	//중개사의 관심매물 상세 관리로 
	@RequestMapping(value = { "/agent/interest/detail" }, method = RequestMethod.GET)
	public String interestDetail(Model model, @RequestParam("cart_list_no") Integer roomItemCartListNo) {
		logger.debug("GET /member/agent/interest/detail called");
		//관심 고객 폴더 정보  설정
		model.addAttribute("roomItemCartList", memberService.getCartUserAboutCartListNo(roomItemCartListNo));//<body> css
		//cart_list_no번호에 해당되는 폴더를 가져오기위해 설정(관심매 물번호로 조인해서 가져옴)
		model.addAttribute("bodyClass", "mypage sub");//<body> css
		model.addAttribute("selectPage", "interest");//죄측 선택 메뉴  css
		return "member.agent.interest.detail";
	}
	
	//중개사의 사진관리화면으로(전체사진)
	@RequestMapping(value = { "/agent/picture" }, method = RequestMethod.GET)
	public String allPicture(Model model) {
		logger.debug("GET /member/agent/picture called");
		model.addAttribute("bodyClass", "mypage sub");//<body> css
		model.addAttribute("selectPage", "picture");//죄측 선택 메뉴  css
		return "member.agent.picture.picture";
	}
	//중개사의 사진수정으로(하나의 매물에 대한 사진 수정)
	@RequestMapping(value = { "/agent/picture/modify" }, method = RequestMethod.GET)
	public String modifyPicture(Model model, @RequestParam("no") Integer no) {
		logger.debug("GET /member/agent/picture/modify called");
		model.addAttribute("bodyClass", "mypage sub");//<body> css
		model.addAttribute("selectPage", "picture");//죄측 선택 메뉴  css
		model.addAttribute("roomNo", no);//죄측 선택 메뉴  css
		return "member.agent.picture.modify";
	}

	//사용기기등록 화면으로
	@RequestMapping(value = { "/agent/hardware_enroll" }, method = RequestMethod.GET)
	public String enrollHardwareForm(Model model) {
		logger.debug("GET /member/agent/hardware_enroll called");
		model.addAttribute("bodyClass", "mypage sub");//<body> css
		model.addAttribute("selectPage", "hardware_enroll");//죄측 선택 메뉴  css
		return "member.agent.hardware_enroll.hardware_enroll";
	}
}
