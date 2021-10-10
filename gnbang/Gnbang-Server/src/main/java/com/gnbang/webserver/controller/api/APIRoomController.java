package com.gnbang.webserver.controller.api;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gnbang.webserver.dto.AdminInformationModifyVO;
import com.gnbang.webserver.dto.ConsultVO;
import com.gnbang.webserver.dto.ContractCompleteVO;
import com.gnbang.webserver.dto.NoteVO;
import com.gnbang.webserver.dto.RoomItemCartListVO;
import com.gnbang.webserver.dto.RoomPhotoVO;
import com.gnbang.webserver.dto.UserVO;
import com.gnbang.webserver.object.Address;
import com.gnbang.webserver.object.CartUser;
import com.gnbang.webserver.object.CartUserDetail;
import com.gnbang.webserver.object.EnrolledRoom;
import com.gnbang.webserver.object.LessorInfor;
import com.gnbang.webserver.object.NoteComment;
import com.gnbang.webserver.object.SearchRoomDetail;
import com.gnbang.webserver.object.SearchRoomSumary;
import com.gnbang.webserver.security.domain.MyRoleAndTokenService;
import com.gnbang.webserver.security.domain.MyUser;
import com.gnbang.webserver.service.RoomService;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("/api/room")
public class APIRoomController {

	private final static Logger logger = LoggerFactory.getLogger(APIRoomController.class);

	@Autowired
	private RoomService roomService;
	@Autowired
	private  MyRoleAndTokenService myRoleAndTokenService;
	
	public APIRoomController() {
		logger.info("APIRoomController initialize");
	}
//찜
	//찜 좌표검색으로 가져오기
	@ResponseBody
	@RequestMapping(value = "/zzim/geo", method = RequestMethod.GET)
	public JSONObject getZzim(Model model, 
			@RequestParam("s") String s ,@RequestParam("w") String w,
			@RequestParam("n") String n,@RequestParam("e") String e, 
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@CookieValue(value ="pc_token", required = false)  String clientToken) {
		logger.debug("GET /api/room/zzim/geo");
		
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
		
		ArrayList<SearchRoomSumary> roomList = roomService.getSpecificRoomItemAboutGeoZzim(s,w,n,e,loginNo,sort,pg);
		myRoleAndTokenService.limitSearchRoomSumaryListAboutRole(roomList, clientToken);
		int allSearchCount = roomService.getCountRoomAboutGeoZzim(s,w,n,e,loginNo);
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roomList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allSearchCount", allSearchCount);
		map.put("roomList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	//찜하기 등록
	@ResponseBody
	@RequestMapping(value = "/{no}/zzim", method = RequestMethod.PUT)
	public String addZzim(Model model, @PathVariable("no") Integer no) {
		logger.debug("PUT /api/room/{"+no+"}/zzim called");
		
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
				
		roomService.addZzim(no, loginNo);//찜추가
		return null;
	}
	//찜하기 삭제***************************************************************정의필요
	@ResponseBody
	@RequestMapping(value = "/{no}/zzim", method = RequestMethod.DELETE)
	public String deleteZzim(Model model, @PathVariable("no") Integer no) {
		logger.debug("DELETE /api/room/{"+no+"}/zzim called");
		
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
				
		roomService.delZzim(no,loginNo);//찜삭제
		return null;
	}
//최근본방	
	//최근본방 좌표검색으로 가져오기
	@ResponseBody
	@RequestMapping(value = "/recently/geo", method = RequestMethod.GET)
	public JSONObject getRecently(Model model, 
			@RequestParam("s") String s ,@RequestParam("w") String w,
			@RequestParam("n") String n,@RequestParam("e") String e, 
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@CookieValue(value ="pc_token", required = false)  String clientToken) {
		logger.debug("GET /api/room/recently/geo");
		
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
		
		ArrayList<SearchRoomSumary> roomList = roomService.getSpecificRoomItemAboutGeoRecently(s,w,n,e,loginNo,sort,pg);
		myRoleAndTokenService.limitSearchRoomSumaryListAboutRole(roomList, clientToken);
		int allSearchCount = roomService.getCountRoomAboutGeoRecently(s,w,n,e,loginNo);
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roomList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allSearchCount", allSearchCount);
		map.put("roomList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	//최근본방 추가
	@RequestMapping(value = "/recently", method = RequestMethod.POST)
	@ResponseBody
	public void insertRecent(Model model, @RequestParam("room_no") Integer room_no) {
		logger.debug("POST /api/room/recently. called");
		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ return;}
		//최근본방 등록
		 roomService.addRecently(loginNo, room_no);
	}
	//최근본방 삭제***************************************************************정의필요
	@ResponseBody
	@RequestMapping(value = "/{no}/recently", method = RequestMethod.DELETE)
	public String deleteRecently(Model model, @PathVariable("no") Integer no) {
		logger.debug("DELETE /api/room/{"+no+"}/recently called");
		return null;
	}

//조회 수
	//조회수 증가시키기
	@ResponseBody
	@RequestMapping(value = "/{no}/increaseReadCount", method = RequestMethod.PUT)
	public void increaseReadCnt(Model model, @PathVariable("no") Integer roomItemNo) {
		logger.debug("PUT /api/room/{"+roomItemNo+"}/increaseReadCount called");
		roomService.increaseReadCnt(roomItemNo);
	}
	
	//내가 입력한 방 수정 요청 내용을 가져옴
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/modify_room_info", method = RequestMethod.GET)
	public JSONObject getModifyRoomInfo(Model model, @PathVariable("no") Integer no) {
		logger.debug("GET /api/room/{"+no+"}/agent/modify_room_info called");
		
		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
				
		logger.debug("inset infor -> user_no:" +loginNo);
		ArrayList<String> modifyText = roomService.getModifyText(loginNo, no);
		
		//수정 내역들을 js에 보내기 위한 json 변환 과정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("modifyText", modifyText);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	
	//방 수정 요청등록
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/modify_room_info", method = RequestMethod.PUT)
	public int modifyRoomInfor(Model model, @PathVariable("no") Integer roomItemNo , 
			@RequestBody AdminInformationModifyVO AdminInformationModifyVO) {
		logger.debug("PUT /api/room/{"+roomItemNo+"}/agent/modify_room_info called");
		
		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
				
		
		if(roomService.insertModifyContent(loginNo, roomItemNo, AdminInformationModifyVO.getText()) == 1)//새로 추가되었으면
			return 1;//추가
		return 2;//업데이트
	}
	
	//코멘트 가져오기
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/comment", method = RequestMethod.GET)
	public JSONObject getComment(Model model, @PathVariable("no") Integer no) {
		logger.debug("GET /api/room/{"+no+"}/agent/comment called");
		ArrayList<NoteComment> commentList = roomService.getCommentAboutRoomNo(no);
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(commentList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("commentList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	
	//내가 입력한 코멘트 입력
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/comment", method = RequestMethod.PUT)
	public int updateAndInsertMyComment(Model model, @PathVariable("no") Integer no, 
		@RequestBody NoteVO noteVO) {
		logger.debug("PUT /api/room/{"+ no + "}/agent/comment called");
		
		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
				
		logger.debug("inset infor -> room_item_no:" + no  +"/user_no:" +loginNo +"/text:" + noteVO.getText() );
		
		int result = roomService.insertComment(loginNo, no, noteVO.getText());
		if(result == -1){//방에 해당되는 코멘트의 수가 이미 3개임(하나의 방에대해 코멘트는 3개제한)
			logger.debug("코멘트의 수가 이미 3개");
			return -1;
		}else if (result == -2){//선택된 중개사로 방에 등록한 코멘트가 이미존재함(중개사마다 코멘트는 1개 제한)
			logger.debug("해당 중개사는 코멘트를 이미 등록한적있음");
			return -2;
		}
		return 1;//코멘트 등록 성공
	}
	
	//내가계약완료한 내용 가져오기***************************************************************정의필요
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/complete_contract", method = RequestMethod.GET)
	public String getMyCompleteContract(Model model, @PathVariable("no") String no) {
		logger.debug("GET /api/room/{"+no+"}/agent/complete_contract called");
		return null;
	}
	
	//계약완료 신청
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/complete_contract", method = RequestMethod.PUT)
	public boolean enrollCompleteContract(Model model, @PathVariable("no") Integer no
			,@CookieValue(value ="pc_token", required = false)  String clientToken) {
		logger.debug("PUT /api/room/{"+no+"}/agent/complete_contract called");
		//인증하지않은중개사가 요청했을경우 요청 불가
		if(!myRoleAndTokenService.isAuthenticableClientToken(clientToken/*, request*/))
			return false;
		
		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
				
		ContractCompleteVO contractComplete = new ContractCompleteVO();
		contractComplete.setUser_no(loginNo);
		if(roomService.addCompleteContract(contractComplete , no))
			return true;
		return false;
	}
	
	//계약완료 취소***************************************************************정의필요
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/complete_contract", method = RequestMethod.DELETE)
	public String cancleCompleteContract(Model model, @PathVariable("no") String no) {
		return null;
	}
	//매물담기 에서 고객 목록들 가져오기(고객폴더 목록)
	@ResponseBody
	@RequestMapping(value = "/agent/interest/client", method = RequestMethod.GET)
	public JSONObject getClientSelectList(Model model
			,@CookieValue(value ="pc_token", required = false)  String clientToken) {
		logger.debug("GET /api/room/agent/interest/client called");
		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ 
		}
		ArrayList<RoomItemCartListVO> cartUserList = roomService.getCartUserAboutAgentNo(loginNo);//중개사의 고객 정보리스트를 get
		
		//고객 정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(cartUserList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cartUserList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	//매물담기 에서 고객 목록 수정
	@ResponseBody
	@RequestMapping(value = "/agent/interest/client", method = RequestMethod.PUT)
	public void updateClientSelectList(Model model, @RequestBody RoomItemCartListVO roomItemCartListVO) {
		logger.debug("PUT /api/room/agent/interest/client called");
		roomService.updateCartUserAboutCartListNo(roomItemCartListVO);//중개사의 고객 정보리스트를 get
	}
	// input :  고객(폴더) 번호들
	// output : 고객 (폴더) 번호들에 등록된 각각의 매물수를 가져옴
	@ResponseBody
	@RequestMapping(value = "/agent/interest_counts", method = RequestMethod.GET)
	public JSONObject getCountClientSelectList(Model model, @RequestParam("room_item_cart_list_no") String  RoomItemCartListNo) {
		logger.debug("GET /api/room/agent/interest_counts called");
		ArrayList<String> RoomItemCartListNoList = new Gson().fromJson(RoomItemCartListNo, new TypeToken<ArrayList<String>>(){}.getType());
		
		ArrayList<Integer> room_item_cart_counts = new ArrayList<Integer>();//섹터별 매물수
		for(int a=0; a<RoomItemCartListNoList.size(); a++)
			room_item_cart_counts.add(roomService.getCountAboutAgentAndCartUser(Integer.parseInt(RoomItemCartListNoList.get(a))));
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("room_item_cart_counts", room_item_cart_counts);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	// 새로운 관심매물폴더인 고객(폴더)생성
	@ResponseBody
	@RequestMapping(value = "/agent/interest/client", method = RequestMethod.POST)
	public boolean addNewClient(Model model, @RequestBody RoomItemCartListVO roomItemCartListVO) {
		logger.debug("POST /api/room/agent/interest/client called");
		
		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ 
		}
				
		roomItemCartListVO.setUser_no(loginNo);//고객생성한 중개사의 번호
		logger.debug("create informaion :" + roomItemCartListVO.getUser_no() + "/"
				+ roomItemCartListVO.getName() + "/" + roomItemCartListVO.getExplain()+ "/ getClient_no: " + roomItemCartListVO.getClient_no());
		if(roomService.insertCartUesr(roomItemCartListVO))//새로운 관심고객 정보가 등록
			return true;
		return false;
	}
	//관심매물폴더인 고객(폴더)에서 중개사 번호(담당 중개사 번호)를 수정
	@ResponseBody
	@RequestMapping(value = "/agent/interest/client_agent_no", method = RequestMethod.PUT)	
	public void changeAgentOfCart(Model model,  @RequestBody RoomItemCartListVO roomItemCartListVO) {
		logger.debug("PUT /api/room/agent/interest/client_agent_no called");
		roomService.changeAgentNoOfCartUesrList(roomItemCartListVO);//고객폴더 중개사의 지정 해제
	}
	//관심매물을 고객들에게 담아주기(1: n = 매물: 고객)
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/interest", method = RequestMethod.PUT)
	public void addInterestUser(Model model, @PathVariable("no") Integer no, @RequestBody ArrayList<Integer> cartListNoList) {
		logger.debug("PUT /api/room/{" + no +"}/agent/interest called");
		logger.debug("      info  -> no: " + no + " cartListNoList(관심매물등록 고객번호들): " + cartListNoList);
		roomService.addCartList(no , cartListNoList);//관심매물을 고객들에게 추가(하나의 매물번호)
	}
	//고객의 관심매물 삭제
	@ResponseBody
	@RequestMapping(value = "/agent/interest", method = RequestMethod.DELETE)
	public void deleteInterestUser(Model model, @RequestParam("no") Integer no) {
		logger.debug("DELETE /api/room/agent/interest called");
		logger.debug("      info  -> room_item_no(삭제할 관심고객폴더내에 관심매물번호): " + no);
		roomService.deleteInterest(no);
	}
	//고객에게 담아준 관심매물정보 가져오기(검색 메인화면에서 간략한 정보)
	@ResponseBody
    @RequestMapping(value = "/agent/interest", method = RequestMethod.GET)
   	public JSONObject getInterestUserAndRoom(Model model,
			@CookieValue(value ="pc_token", required = false)  String clientToken) {		
		logger.debug("GET /api/room/agent/interest called");
		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ 
		}
		ArrayList<CartUser> interest = roomService.getInterestCartUser(loginNo);
		myRoleAndTokenService.limitCartUserListAboutRole(interest, clientToken);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("interestCartUser", interest);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
    }
	//고객에게 담아준 관심매물 가져오기(방정보를 포함하는 좀더 많은 (상세)정보- 중개사 마이페이지에서 상세히 제공)
	@ResponseBody
    @RequestMapping(value = "/agent/interest_detail", method = RequestMethod.GET)
   	public JSONObject getDetailInterestUserAndRoom(Model model, @RequestParam("roomItemCartListNo") Integer roomItemCartListNo
   			,@CookieValue(value ="pc_token", required = false)  String clientToken) {		
		logger.debug("GET /api/room/agent/interest_detail called");

		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ 
		}
		ArrayList<CartUserDetail> interest = roomService.getDetailInterestCartUser(loginNo, roomItemCartListNo);
		myRoleAndTokenService.limitCartUserDetail(interest, clientToken);
		
		//해당 중개사가 관심고객을 담당하고있으면 관심고객의 총 매물수를 가져옴
		int allSearchCount = 0;
		if(0 < interest.size())
			allSearchCount = roomService.getCountDetailInterestCartUser(roomItemCartListNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("interestCartUser", interest);
		map.put("allSearchCount", allSearchCount);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
    }
	//매물담기 클릭 시 상단의 새로운 고객생성 할 떄 회원인지 확인하기(고객명 자동완성목록 가져오기)
	@ResponseBody
	@RequestMapping(value = "/agent/interest/client_list", method = RequestMethod.GET)
	public JSONObject enrolledClientList(Model model,  @RequestParam("name") String name) {
		logger.debug("POST /api/room/agent/interest/client_list called");
		
		try {
			name = URLDecoder.decode(name,"UTF-8");
		} catch (Exception e) {
		}
		ArrayList<UserVO> userList;
		userList = roomService.getUserAboutName(name);
		
		// 한 매물에 대한 관심고객 정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(userList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	//임대인의 연락처를 가져오기
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/lessor_phone", method = RequestMethod.POST)
	public JSONObject lessorPhone(Model model, @PathVariable("no") Integer no
			,@RequestBody ArrayList<Integer> cartListNoList
			,@CookieValue(value ="pc_token", required = false)  String clientToken) {
		logger.debug("POST /api/{no}/agent/lessor_phone called");
		logger.debug("no :"+ no +"/ cartListNoList :" + cartListNoList);
		
		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){
		}
				
		//연락처 확인 기록 저장, 임대인 연락처 가져오기
		LessorInfor lessorInfor = roomService.getLessorInfor(no, cartListNoList, loginNo);
		myRoleAndTokenService.limitLessorInfor(lessorInfor, clientToken);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("lessorInfor", lessorInfor);
		JSONObject jsonObject = JSONObject.fromObject(map);
		logger.debug("lessorContact json:  " + jsonObject);
		return jsonObject;
	}
	//매물 담당 연락처 확인기록
	@ResponseBody
	@RequestMapping(value = "/room_phone_history", method = RequestMethod.POST)
	public void roomPhoneHistory(@RequestParam("room_no") Integer roomNo) {
		logger.debug("POST api/room/room_phone_history called");
		//로그인한 회원의 번호획득
		int loginNo =  myRoleAndTokenService.getLoginNo();
		if(loginNo == -1)//로그인상태가아니면 연락처확인기록을 안함
			return;
		roomService.insertRoomPhoneHistory(loginNo, roomNo);//로그인번호 매물번호를 매물 연락처확인기록으로 저장
	}
	// 허위 매물  신고 하기
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/report_fake_room", method = RequestMethod.PUT)
	public int addReportFakeRoom(Model model, @PathVariable("no") Integer roomItemNo , 
			@RequestBody AdminInformationModifyVO AdminInformationModifyVO) {
		logger.debug("PUT /api/room/{"+roomItemNo+"}/agent/report_fake_room called");
		
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ 
			return -1;
		}
				
		logger.debug("inset infor -> user_no:" +loginNo +"/ fakeContent:" + AdminInformationModifyVO.getText() );
		if(roomService.insertFakeRoom(loginNo, roomItemNo, AdminInformationModifyVO.getText()) == 1)//새로 추가되었으면
			return 1;//추가
		return 2;//업데이트
	}
	//내가 신고한 허위 매물  내용 가져오기
	@ResponseBody
	@RequestMapping(value = "/{no}/agent/report_fake_room", method = RequestMethod.GET)
	public JSONObject getReportFakeRoom(Model model, @PathVariable("no") Integer no) {
		logger.debug("GET /api/room/{"+no+"}/agent/report_fake_room called");
		
		//로그인한 중개사의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ 
		}
		
		logger.debug("inset infor -> user_no:" +loginNo );
		ArrayList<String> fakeText = roomService.getFakeText(loginNo, no);
		//신고 내역들을 js에 보내기 위한 json 변환 과정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fakeText", fakeText);
		JSONObject jsonObject = JSONObject.fromObject(map);
		logger.debug("fakeText json:  " + jsonObject);
		return jsonObject;
	}
	
	//상담문의신청
	@ResponseBody
	@RequestMapping(value = "/{no}/consult", method = RequestMethod.POST)
	public String addConsultApply(Model model, @PathVariable("no") Integer no, @RequestBody ConsultVO ConsultVO) {
		logger.debug("GET /api/room/{"+no+"}/consult called");
		
		//로그인한 중개사 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ 
			return "errLogin";
		}
		logger.debug("inset infor -> Phone:" +ConsultVO.getPhone()  +"/ posible time(comment)" +ConsultVO.getComment() );
		if(roomService.insertConsult(loginNo , no, ConsultVO))//상담 문의신청 성공시
			return "success";
		return "errOverlap";
	}


//방등록 
	//방의 사진을 임시로 서버에 추가
	@ResponseBody
    @RequestMapping(value = "/enroll/temp_photo", method = RequestMethod.POST)
    public JSONObject addTempPhoto(
    		@RequestParam("uploadFile") MultipartFile uploadfile, HttpServletRequest request ) {
		logger.debug("GET /api/room/enroll/temp_photo called");
		
		//js보내기 위한 데이터(업로드 정보) 셋팅
		Map<String, Object> map = new HashMap<String, Object>();
		String tempPath;
		//로그인한 중개사 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
			//임시폴더 생성후 이미지 저장
			tempPath = roomService.uploadTempToGNServer(uploadfile, request,loginNo);//워터마크 임시경로를 가져옴
		}catch(Exception E){//로그인 정보 가져오지 못하면
			tempPath =  "ErrLogin";
		}
		
		//js보내는 데이터 (ErrSize(용량초과) / ErrLogin(로그인안됨)/ ErrExtension(jpg형식아님)// 워터마크 임시업로드 경로(tempUplload))
		map.put("tempPath", tempPath);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
    }
	//유사 주소 가져오기(중복 확인시 사용 ) 
	@ResponseBody
	@RequestMapping(value = { "/enroll/address" }, method = RequestMethod.GET)
	public JSONObject getSameAddress(Address address) throws UnsupportedEncodingException{
		logger.debug("GET /api/room/enroll/address called");
		
		//서브 메인 하위 주소를 비교하여 같은 값의 주소를 가져옴 
		ArrayList<Address> addressList = roomService.getSameAddress(address);
		
		JSONArray jsonArray = JSONArray.fromObject(addressList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sameAddress", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	//방등록처리
	@ResponseBody
	@RequestMapping(value = { "/enroll" }, method = RequestMethod.POST)
	public boolean enrollPro( HttpServletRequest request, 
			@RequestBody EnrolledRoom enrolledRoom) {
		logger.debug("POST /api/room/enroll called");	
		
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ 
			return false;//로그인 안되어있으면 등록 중지
		}
		
		// 로그인한 중개사번호, 방등록정보 ->  방등록(db)
		Integer roomNo = roomService.insertSpecificRoomItemAboutAgent(enrolledRoom,loginNo);
		if(roomNo == -1)//방등록에 실패했으면 이미지 저장 x, 종료
			return false;
		//방번호와 , 가져올 이미지의 경로 ->  ftp(워터마크) 강남방서버(원본/워터마크) 업로드
		roomService.movePhotoTempToReal(request, loginNo, roomNo, enrolledRoom.getTempPathArr());
		return true;
	}
	//방삭제처리
	@ResponseBody
	@RequestMapping(value = { "/aboutRoomItemNO" }, method = RequestMethod.DELETE)
	public boolean deleteRoom( HttpServletRequest request, 
			@RequestParam("roomItemNo") Integer roomItemNo) {
		logger.debug("DELETE /api/room(roomItemNo) called");	

		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ 
			return false;//로그인 안되어있으면 등록 중지
		}
		//로그인 성공시 삭제가능
		if(loginNo != -1)
			roomService.deleteAllInforOfRoomAboutRoomItemNo(roomItemNo);//방등록삭제처리
		return true;
	}
	//방삭제처리
	@ResponseBody
	@RequestMapping(value = { "/aboutLoginNo" }, method = RequestMethod.DELETE)
	public boolean deleteRoomAboutUserId( HttpServletRequest request ,
			@RequestParam(value="userNo",required=false, defaultValue="-1") Integer userNo) {
		logger.debug("DELETE /api/room(userNo) called");	
		if(userNo == -1){
			//로그인한 회원의 번호획득
			try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			userNo = user.getNo();
			}catch(Exception E){ 
				userNo = -1;
				return false;//로그인 안되어있으면 등록 중지
			}
		}
		//로그인 성공시 삭제가능
		if(userNo != -1)
			roomService.deleteAllInforsOfRoomAboutUserNo(userNo);//방등록삭제처리
		return true;
	}
	//방상세보기에서 사진추가시 임시경로에 저장해둔 이미지를 ftp및 서버에업로드
	@ResponseBody
    @RequestMapping(value = "/{no}/photo", method = RequestMethod.POST)
    public boolean fileUpload(@PathVariable("no") Integer roomNo,  HttpServletRequest request, @RequestBody ArrayList<String> tempPath ) {
		logger.debug("POST /api/room/{no}/photo called");
		
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ 
			return false;
		}
		if(roomNo == -1)//방등록에 실패했으면 이미지 저장 x, 종료
			return false;
		//방번호와 , 가져올 임시 이미지의 경로 ->  ftp(워터마크) 강남방서버(원본) 업로드
		roomService.movePhotoTempToReal(request, loginNo, roomNo, tempPath);
		return true;
    }
	//방에 등록된 이미지의 수를 가져온다.
	@ResponseBody
	@RequestMapping(value = "/photo_count", method = RequestMethod.GET)
    public Integer getPhotoCount(@RequestParam("room_no") Integer room_no) {
		logger.debug("GET api/room/photo_count called");
		Integer roomCount = roomService.getPhotoCount(room_no);//room_no로 등록된 이미지의 수를 가져온다.
		return roomCount;
    }
	// input : 지하철번호, 매물번호, 지역번호, 센터번호, 상세필터내용들
	// output : 로그인한 중개사가 가지는 방들의 정보를 가져옴
	@RequestMapping(value = "/enroll/search/agent", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject agent(Model model,
			@RequestParam(value="p",required=false, defaultValue="") String p ,
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "metro_no", required = false, defaultValue="")  String metro_no ,
			@RequestParam(value = "addr", required = false, defaultValue="")  String addr ,
			@RequestParam(value = "room_no", required = false, defaultValue="")  String room_no ,
			@RequestParam(value = "sector_code", required = false, defaultValue="")  String sector_code ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@RequestParam(value = "num_per_page", required = false , defaultValue="10") Integer roomNumPerPage
			)  {
		logger.debug("GET /api/room/enroll/search/agent called");
		ArrayList<SearchRoomSumary> roomList = new ArrayList<SearchRoomSumary>();
		int allSearchCount = 0;
		//로그인한 중개사의 번호획득
		int loginNo =  -1; 
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
		
		roomList = roomService.getSpecificRoomItemAboutAgent(metro_no,addr,room_no,sector_code,loginNo,p,sort,pg,roomNumPerPage);
		logger.debug("findRoom of agent result size: " + roomList.size());
		//필터에 맞게 검색되는 모든 방의 개수
		allSearchCount =  roomService.getRoomCount(metro_no,addr,room_no,sector_code,loginNo,p); 

		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roomList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomList", jsonArray);
		map.put("allSearchCount", allSearchCount);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	// input : 지하철번호, 매물번호, 지역번호, 센터번호, 상세필터내용들
	// output : 로그인한 중개사가 가지는 방들의 정보를 가져옴
	@RequestMapping(value = "/enroll_photo/search/agent", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject agentEnrollPhoto(Model model,
			@RequestParam(value = "picture_modifiable", required = false , defaultValue= "false") boolean picture_modifiable,//0: 매물사진 수정여부 상관없음  1: 매물사진 수정가능  2: 매물사진 수정불가능
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@RequestParam(value = "num_per_page", required = false , defaultValue="10") Integer roomNumPerPage,
			@CookieValue(value ="pc_token", required = false)  String clientToken
			)  {
		logger.debug("GET /api/room/enroll_photo/search/agent called");
		ArrayList<SearchRoomSumary> roomList = new ArrayList<SearchRoomSumary>();
		int allSearchCount = 0;
		//로그인한 중개사의 번호획득
		int loginNo =  -1; 
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
		
		roomList = roomService.getSpecificRoomItemAboutPictureOfAgent(loginNo, pg, roomNumPerPage, picture_modifiable);
		myRoleAndTokenService.limitSearchRoomSumaryListAboutRole(roomList, clientToken);
		
		logger.debug("findRoom of agent result size: " + roomList.size());
		//필터에 맞게 검색되는 모든 방의 개수
		allSearchCount =  roomService.getPictureRoomCount(loginNo, pg, roomNumPerPage, picture_modifiable); 
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roomList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomList", jsonArray);
		map.put("allSearchCount", allSearchCount);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}

	// input : 매물번호
	// output : 매물에 등록된 사진들 
	@RequestMapping(value = "/photo", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getRoomPhoto(
		@RequestParam(value = "room_no", required = false, defaultValue="")  Integer roomNo)  {
		logger.debug("GET /api/room/photo called");
		ArrayList<RoomPhotoVO> photoList = new ArrayList<RoomPhotoVO>();

		//매물에 등록된 사진 경로들을 가져옴
		photoList = roomService.getPhotoAboutRoomNo(roomNo);
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(photoList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("photoList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	// input : 사진번호와 사진순서
	// output : 사진순서를 업데이트
	@RequestMapping(value = "/photo", method = RequestMethod.PUT)
	@ResponseBody
	public JSONObject updateRoomPhoto(@RequestBody RoomPhotoVO roomPhotoVO)  {
		logger.debug("PUT /api/room/photo called");
		ArrayList<RoomPhotoVO> photoList = new ArrayList<RoomPhotoVO>();

		//사진의 순서를 수정함
		roomService.updateRoomPhotoOrder(roomPhotoVO.getNo(), roomPhotoVO.getOrder());
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(photoList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("photoList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	// input : 매물사진번호
	@RequestMapping(value = "/photo", method = RequestMethod.DELETE)
	@ResponseBody
	public void deleteRoomPhoto(@RequestParam("photo_no")  Integer photoNo)  {
		roomService.deleteRoomPhoto(photoNo);
		logger.debug("DELETE /api/room/photo called");
	}
/*	//input : no(매물번호)-> room_item의 no , specific_room_item의 item_no)
	//process: 매물번호로 등록된 방의 상세 정보를 가져옴(room_photo, room_item, specific_room_item, zzim)
	//output: SearchRoomDetail(매물번호로 등록된 방의 상세 정보) -> (room_photo, room_item, specific_room_item, zzim)
	@RequestMapping(value = "/{no}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getEnrolledRoomFullInfor(Model model, @PathVariable("no")  Integer no)  {
		logger.debug("GET /api/room/{"+ no+ "} called");
		//매물번호로 매물상세정보를 가져오고, 회원번호로 찜 값을 가져온다.
		SearchRoomDetail roomDetail = roomService.getDetailRoomAboutRoomNo(no, myRoleAndTokenService.getLoginNo());
		JSONObject jsonObject = JSONObject.fromObject(roomDetail);
		return jsonObject;
	}
	*/
}

















