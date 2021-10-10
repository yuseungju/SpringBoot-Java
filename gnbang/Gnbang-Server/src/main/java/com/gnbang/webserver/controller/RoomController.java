package com.gnbang.webserver.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnbang.webserver.object.Address;
import com.gnbang.webserver.object.SearchRoomDetail;
import com.gnbang.webserver.security.domain.MyRoleAndTokenService;
import com.gnbang.webserver.service.RoomService;

//방 관리
@Controller
@RequestMapping("/room")
public class RoomController {

	private final static Logger logger = LoggerFactory.getLogger(RoomController.class);

	@Autowired
	private RoomService roomService;
	@Autowired
	private MyRoleAndTokenService myRoleAndTokenService;
	
	public RoomController() {
		logger.info("RoomInforController initialize");
	}
	
	//방등록화면 로그인한 회원의 권한에따라 다르게 접근
	@RequestMapping(value = { "/enroll" }, method = RequestMethod.GET)
	public String enrollMain(HttpServletRequest request, @CookieValue(value ="pc_token", required = false)  String clientToken) {
		logger.debug("GET room/enroll called");
		try{
			//중개사와 일반회원에 따라 방등록 뷰를 다르게 설정
		    if(request.isUserInRole("ROLE_AGENT")){//중개사의 뷰
		    	logger.debug("current loign auth : ROLE_AGENT ");
				return "redirect:/room/enroll/agent";// 중개사회원 방등록 기본화면으
		    } else if(request.isUserInRole("ROLE_USER")){//일반회원의 뷰
		    	logger.debug("current loign auth : ROLE_USER ");
				return "redirect:/room/enroll/normal";// 일반회원 방등록 기본화면으로
		    }/*else if(request.isUserInRole("..")){
		    	//....
		    }*/
		}catch(Exception E){}
		
    	logger.debug("current loign auth : not exist ");
		return "redirect:/room/enroll/normal";// 일반회원 방등록 기본화면으로
	}	
	
	// 중개사회원 방등록 기본화면으로
    @PreAuthorize("hasRole('ROLE_AGENT')")
	@RequestMapping(value = { "/enroll/agent" }, method = RequestMethod.GET)
	public String agentEnrolledRoom(Model model) {
		logger.debug("GET /room/enroll/agent called");
		model.addAttribute("bodyClass", "room sub agent");
		model.addAttribute("selectPage", "enroll");// 상단 선택 메뉴  css
		return "room.agent.enrolled";
	}
	
	/*// 일반회원 방등록 기본화면으로
    @PreAuthorize("hasRole('ROLE_USER')")*/
	@RequestMapping(value = { "/enroll/normal" }, method = RequestMethod.GET)
	public String permissioned(Model model) {
		logger.debug("GET /room/enroll/normal called");
		model.addAttribute("bodyClass", "room sub");
		model.addAttribute("selectPage", "enroll");// 상단 선택 메뉴  css
		return "room.user.enroll";
	}
  	
	// 중개사회원 방수정 화면으로
    @PreAuthorize("hasRole('ROLE_AGENT')")
	@RequestMapping(value = { "/modify/agent/{no}" }, method = RequestMethod.GET)
	public String modifyAgentRoom(Model model, @PathVariable("no") Integer no) throws UnsupportedEncodingException {
		logger.debug("GET /room/modify/agent{"+ no + "} called");
		//매물번호로 매물상세정보를 가져오고, 회원번호로 찜 값을 가져온다.
		SearchRoomDetail roomDetail = roomService.getDetailRoomAboutRoomNo(no, myRoleAndTokenService.getLoginNo());

 		Address address = new Address();
		address.setAddressFromSearchRoomDetail(roomDetail);
		address.setCode(roomService.getLocalCode(address));
		
		model.addAttribute("bodyClass", "room sub agent");
		model.addAttribute("selectPage", "enroll");// 상단 선택 메뉴  css
 		model.addAttribute("room", roomDetail);
		return "room.agent.modify";
	}
    
/*
	// 일반회원 방등록 승인대기방으로
	@RequestMapping(value = { "/enroll/normal/standby"  }, method = RequestMethod.GET)
	public String waitPermission(Model model) {
		logger.debug("GET /enroll/normal/standby called");
		model.addAttribute("bodyClass", "room sub");
		return "room.waitPermission";
	}*/
/*
	//일반회원 방등록 승인반려방으로
	@RequestMapping(value = { "/enroll/normal/reject" }, method = RequestMethod.GET)
	public String notPermission(Model model) {
		logger.debug("GET /enroll/normal/reject called");
		model.addAttribute("bodyClass", "room sub");
		return "room.user.not_permission";
	}*/

	//주소 중복검사화면으로
	@RequestMapping(value = { "/enroll/overlap_check" }, method = RequestMethod.GET)
	public String enrollOverlapCheck(Model model) {
		logger.debug("GET room/enroll_overlap_check called");
		model.addAttribute("bodyClass", "room sub agent");
		return "room.agent_and_user.enroll_overlap_check";
	}
	//방등록시 정보입력창으로
	@RequestMapping(value = { "/enroll/write" }, method = RequestMethod.GET ) 
	public String enrollInformation(Model model, Address address) throws UnsupportedEncodingException{
		logger.debug("GET room/write called");
		//주소코드를 저장
		address.setCode(roomService.getLocalCode(address));
		//front로 보내는 정보 설정
 		model.addAttribute("postAddress", address);//주소정보들 설정
		model.addAttribute("bodyClass", "room sub agent");
		return "room.agent_and_user.enroll_information";
	}
	//방등록시 등록완료 창으로
	@RequestMapping(value = { "/enroll/complete" }, method = RequestMethod.GET)
	public String enrollComplete(Model model) {
		logger.debug("GET /enroll/agent/approval called");
		model.addAttribute("bodyClass", "room sub agent");
		return "room.agent_and_user.enroll_complete";
	}
	
	//내가본방으로
	@RequestMapping(value = { "/recently" }, method = RequestMethod.GET)
	public String recently(Model model) {
		logger.debug("GET room/recently called");
		//죄측 선택 메뉴  css
		model.addAttribute("selectPage", "recent");
		return "search.recently";
	}

	// 찜한방으로
	@RequestMapping(value = { "/zzim" }, method = RequestMethod.GET)
	public String zzim(Model model) {
		logger.debug("/room/zzim called");
		//죄측 선택 메뉴  css
		model.addAttribute("selectPage", "zzim");
		return "search.zzim";
	}
	
	// input : 방번호
	// output : 방번호에 해당되는 방 상세 정보
    @RequestMapping(value = "/{no}", method = RequestMethod.GET)
	public String main(Model model, @PathVariable("no") Integer no) {
    	logger.debug("GET /room/{"+ no+ "} called");
		SearchRoomDetail room = roomService.getDetailRoomAboutRoomNo(no, myRoleAndTokenService.getLoginNo());
		// 방정보 들을 js에 보냄
 		model.addAttribute("room", room);
		model.addAttribute("bodyClass", "detail");
 		return "room.common.detail";
 	}
}
