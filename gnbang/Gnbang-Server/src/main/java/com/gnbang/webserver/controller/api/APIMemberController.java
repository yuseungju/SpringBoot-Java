package com.gnbang.webserver.controller.api;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gnbang.webserver.security.domain.MyRoleAndTokenService;
import com.gnbang.webserver.security.domain.MyUser;
import com.gnbang.webserver.service.MemberService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/api/member")
public class APIMemberController {
		private final static Logger logger = LoggerFactory.getLogger(APIMemberController.class);
	
		@Autowired
		private MemberService memberService;
		@Autowired
		private UserDetailsService userDetailsService;
		@Autowired
		private MyRoleAndTokenService myRoleAndTokenService;
		
		public APIMemberController() {
			logger.info("APIMemberController initialize");
		}
		//회원 탈퇴처리(마이페이지에서) 
		@ResponseBody
		@RequestMapping(value = "/secession", method = RequestMethod.PUT)
		public boolean getMyCompleteContract(Model model) {
			logger.debug("PUT /api/member/secession called");
			//로그인한 회원의 email획득
			String email;
			try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				email = user.getUsername();
			}catch(Exception E){ 
				return false;
			}
			return memberService.secession(email);
		}
		//비밀번호 일치하는지 확인(마이페이지에서) 
		@ResponseBody
		@RequestMapping(value = "/check_password", method = RequestMethod.GET)
		public Integer checkPassword(Model model, @RequestParam("password") String password) {
			logger.debug("GET /api/member/check_password called");
			//로그인한 회원의 email획득
			String email;
			try{ 
				MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				email = user.getUsername();
			}catch(Exception E){ 
				return 0;
			}
			if(memberService.checkPassword(email, password))
				return 1;
			else
				return -1;
		}
		//비밀번호 변경(마이페이지에서) 
		@ResponseBody
		@RequestMapping(value = "/password", method = RequestMethod.PUT)
		public boolean changePassword(Model model, @RequestParam("password") String password,  @RequestParam(value="email",required=false) String email) {
			logger.debug("PUT /api/member/password called");
			//로그인한 회원의 email획득
			if(email == null){
				try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
					email = user.getUsername();
				}catch(Exception E){ 
					return false;
				}
			}
			if(memberService.changePassword(email, password))
				return true;
			return false;
		}
		//프로필 사진을 서버와 ftp에 추가
		@ResponseBody
	    @RequestMapping(value = "/photo", method = RequestMethod.POST)
	    public JSONObject addPhotoPath(
	    		@RequestParam("uploadFile") MultipartFile uploadfile, HttpServletRequest request ) {
			logger.debug("POST /api/member/photo called");
			//js보내기 위한 데이터(업로드 정보) 셋팅
			Map<String, Object> map = new HashMap<String, Object>();
			String err ="";
			if(0 < uploadfile.getOriginalFilename().length()){//프로필 사진 파일이 존재하면
				//로그인한 중개사 회원의 번호획득
				int loginNo =  -1;
				try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
					loginNo = user.getNo();
					err = memberService.uploadPhotoToServer(uploadfile, request, loginNo);//강남방서버에 저장
				}catch(Exception E){//로그인 정보 가져오지 못하면
					err =  "ErrLogin";
				}
			}
			//js보내는 데이터 (ErrSize(용량초과) / ErrLogin(로그인안됨)/ ErrExtension(jpg형식아님)// 워터마크 임시업로드 경로(tempUplload))
			map.put("err", err);
			JSONObject jsonObject = JSONObject.fromObject(map);
			return jsonObject;
	    }
		
		@ResponseBody
	    @RequestMapping(value = "/photo", method = RequestMethod.GET)
	    public String getPhotoPath(@RequestParam(value="user_no",required=false, defaultValue="-1")  Integer user_no) {
			logger.debug("GET /api/member/photo called");
			String path = "";
			if(user_no == -1){
				//로그인한 중개사 회원의 번호획득
				try{ 
					MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
					user_no = user.getNo();
					path = memberService.getPhotoUrl(user_no);//프로필 사진경로를 가져옴
				}catch(Exception E){//로그인 정보 가져오지 못하면
					path =  "ErrLogin";
				}
			}else{
				path = memberService.getPhotoUrl(user_no);//프로필 사진경로를 가져옴
			}
			return path;
	    }
		//연락처가져오기
		@ResponseBody
	    @RequestMapping(value = "/phone", method = RequestMethod.GET)
	    public String getPhone() {
			logger.debug("GET /api/member/phone called");
			String phone = "";
			//로그인한 중개사 회원의 번호획득
			int loginNo =  -1;
			try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				loginNo = user.getNo();
				phone = memberService.getPhone(loginNo);//프로필 사진경로를 가져옴
			}catch(Exception E){//로그인 정보 가져오지 못하면
				phone =  "ErrLogin";
			}
			return phone;
	    }
		//연락처가져오기
		@ResponseBody
	    @RequestMapping(value = "/phone", method = RequestMethod.POST)
	    public String updatePhone(@RequestParam("phone") String phone) {
			logger.debug("POST /api/member/phone called");
			//로그인한 중개사 회원의 번호획득
			int loginNo =  -1;
			try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				loginNo = user.getNo();
				memberService.updatePhone(loginNo, phone);//프로필 사진경로를 가져옴
			}catch(Exception E){//로그인 정보 가져오지 못하면
				phone =  "ErrLogin";
			}
			return phone;
	    }
		//사용기기 맥주소 등록 처리
		@ResponseBody
		@RequestMapping(value = "/agent/mac_address", method = RequestMethod.PUT)
		public void enrollPC(Model model , @RequestParam("mac_address") String mac_address) {
			logger.debug("PUT /api/member/agent/mac_address called");
			//로그인 정보획득
			int loginNo =  -1;
			try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
			}catch(Exception E){ }
			//사용 기기등록  
			memberService.enrollMacAddress(loginNo, mac_address);
		}
		//사용기기 맥주소 가져오기
		@ResponseBody
		@RequestMapping(value = "/agent/mac_address", method = RequestMethod.GET)
		public String getPC(Model model) {
			logger.debug("GET /api/member/agent/mac_address called");
			//로그인 정보획득
			int loginNo =  -1;
			try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
			}catch(Exception E){ }
			//사용 기기등록  
			return memberService.getMacAddress(loginNo);
		}
		//사용기기 인증토큰값 설정
		@ResponseBody
		@RequestMapping(value = "/agent/pc_token", method = RequestMethod.PUT)
		public void enrollPcToken(Model model , @RequestParam("pc_token") String pc_token) {
			logger.debug("PUT /api/member/agent/pc_token called");
			//로그인 정보획득
			int loginNo =  -1;
			try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
			}catch(Exception E){}
			//사용 기기등록  
			memberService.enrollPcToken(loginNo, pc_token);
		}
		//사용기기 인증토큰값 을가져옴
		@ResponseBody
		@RequestMapping(value = "/agent/pc_token", method = RequestMethod.GET)
		public String getPcToken(Model model) {
			logger.debug("GET /api/member/agent/pc_token called");

			//사용 기기등록  
			String pcToken = "";/*
			pcToken = memberService.getPcToken(loginNo);*/
			pcToken = myRoleAndTokenService.getServerPcToken();
			return pcToken;
		}
		//서버 토큰값과  클라이언트 토큰 쿠키값의 일치여부를확인
		@ResponseBody
		@RequestMapping(value = "/agent/token_effectiveness", method = RequestMethod.GET)
		public Boolean getPcTokenEffectiveness(
				@CookieValue(value ="pc_token", required = false)  String clientToken) {
			logger.debug("GET /api/member/agent/token_effectiveness called");/*
			String serverToken = memberService.getPcToken(MyRoleService.getLoginNo());//db로부터회원의 토큰값을 가져옴
*/			return myRoleAndTokenService.isAuthenticableClientToken(clientToken);
		}
		//로그인 한 회원의 mac주소를 가져옴
		@RequestMapping(value = "/mac_address", method = RequestMethod.GET)
		@ResponseBody
		public String getMacAddress()  {
			logger.debug("GET /api/member/mac_address called");
			String macAddress = memberService.getMacAddress(myRoleAndTokenService.getLoginNo());//로그인 회원의 맥주소를 가져옴
			return macAddress;
		}
		//로그인 한 회원의  접속 기기 종류를 가져옴
		@RequestMapping(value = "/connect_type", method = RequestMethod.GET)
		@ResponseBody
		public String getConnectType()  {
			logger.debug("GET /api/member/connect_type called");
			String connectType = myRoleAndTokenService.getCurrentConnectType();//로그인 회원의 권한들을 가져옴
			return connectType;
		}
		
}
