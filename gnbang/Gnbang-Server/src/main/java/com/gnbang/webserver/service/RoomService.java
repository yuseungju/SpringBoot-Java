package com.gnbang.webserver.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gnbang.webserver.config.GlobalValue;
import com.gnbang.webserver.dto.AdminInformationModifyVO;
import com.gnbang.webserver.dto.ConsultVO;
import com.gnbang.webserver.dto.ContractCompleteVO;
import com.gnbang.webserver.dto.LessorPhoneHistoryVO;
import com.gnbang.webserver.dto.NoteVO;
import com.gnbang.webserver.dto.RecentlyVO;
import com.gnbang.webserver.dto.RoomFakeReportVO;
import com.gnbang.webserver.dto.RoomItemCartListVO;
import com.gnbang.webserver.dto.RoomItemCartVO;
import com.gnbang.webserver.dto.RoomPhotoVO;
import com.gnbang.webserver.dto.SpecificRoomItemVO;
import com.gnbang.webserver.dto.UserVO;
import com.gnbang.webserver.dto.ZzimVO;
import com.gnbang.webserver.mapper.RoomMapper;
import com.gnbang.webserver.object.Address;
import com.gnbang.webserver.object.CartUser;
import com.gnbang.webserver.object.CartUserDetail;
import com.gnbang.webserver.object.EnrolledRoom;
import com.gnbang.webserver.object.LessorInfor;
import com.gnbang.webserver.object.NoteComment;
import com.gnbang.webserver.object.SearchRoomDetail;
import com.gnbang.webserver.object.SearchRoomSumary;
import com.gnbang.webserver.service.function.ExpressionFunction;
import com.gnbang.webserver.service.function.RoomAddressFunction;
import com.gnbang.webserver.upload.FTPFile;
import com.gnbang.webserver.upload.FTPUtil;
import com.gnbang.webserver.upload.ImageResizing;
import com.gnbang.webserver.upload.UploadStatus;
import com.gnbang.webserver.upload.WaterMark;

//JoinController에서 사용
@Service
public class RoomService {

	private final static Logger logger = LoggerFactory.getLogger(RoomService.class);
	
	@Autowired
	private RoomMapper roomMapper;
	
	private final int roomNumPerPage = 10;//방 검색시 한페이지에 보여지는 방의수\
	private final int recentlyLimit = 20;//방 검색시 한페이지에 보여지는 방의수\
	
	
	
//***********************************방 상세보기**********************************************
	// 방번호를 통해 방번호의 상세정보들을 가져온다.
	public SearchRoomDetail getDetailRoomAboutRoomNo(Integer roomItemNo, Integer loginNo) {
		logger.debug("search detail roomNo: " + roomItemNo);
		// 방의 상세정보를 가져온다
		SearchRoomDetail searchRoomDetail = roomMapper.getDetailRoomAboutRoomNo(roomItemNo);
		// 방의 사진경로url(ftp)을 가져와 설정
		searchRoomDetail.setFake_url(roomMapper.getFakeUrlList(roomItemNo));

		// 담당자와 사진등록자를 가져와 설정
		String manageName;// 매물 등록자 이름
		String managePhone;//매물 등록자 연락처
		String photoManageName;// 사진 등록자 이름
		String photoManagePhone;// 사진 등록자 연락처
		
		//1.사진 담당자 이름설정
		photoManageName = roomMapper.getPhotoManageName(roomItemNo);// 사진 담당자이름을 가져옴
		if (photoManageName == null)
			photoManageName = "";
		searchRoomDetail.setPhotoManageName(photoManageName);
		//2.사진담당자 연락처 설정
		photoManagePhone = roomMapper.getPhotoManagePhone(roomItemNo);// 사진 담당자연락처를가져옴
		if (photoManagePhone == null)
			photoManagePhone = "";
		searchRoomDetail.setPhotoManagePhone(ExpressionFunction.convertDisplayedContract(photoManagePhone));
		//3.매물 담당자 이름 설정
		manageName = roomMapper.getManageName(roomItemNo);// 담당자이름을 가져옴
		if(manageName == null){
			if(photoManageName != "")
				manageName = photoManageName;
			else
				manageName = GlobalValue.agentManager;
		}
		searchRoomDetail.setManageName(manageName);
		//4.매물 담당자 연락처 설정
		managePhone = roomMapper.getManagePhone(roomItemNo);// 담당자이름을 가져옴
		if(managePhone == null){
			if(photoManagePhone != "")
				managePhone = photoManagePhone;
			else
				managePhone = GlobalValue.gnbangCorporationContact;
		}
		searchRoomDetail.setManagePhone(ExpressionFunction.convertDisplayedContract(managePhone));
		
		//매물의 동영상 url중 번호만 가져와서 설정
		String movieUrl = searchRoomDetail.getMovie_url();
		String movieUrlNumber = "-1";
		if(movieUrl != null){
			movieUrlNumber = "";
			for(int a = 0; a < movieUrl.length(); a++){
				try{
					movieUrlNumber += ""+Integer.parseInt(movieUrl.charAt(a)+"");
				}catch(Exception e){
				}
			}
			if(movieUrlNumber.length() == 0)
				movieUrlNumber ="-1";
		}
		searchRoomDetail.setMovieUrlNumber(Integer.parseInt(movieUrlNumber));
		//찜수를 설정
		searchRoomDetail.setZzimCount(roomMapper.getCountInZzimAboutRoomItemNo(roomItemNo));
		//해당 매물로  찜을 했다면, 찜번호를 설정
		searchRoomDetail.setZzimNo(roomMapper.getZzimNo(roomItemNo, loginNo));
		
		return searchRoomDetail;
	}

	// 방번호에 해당되는 코멘트를 모두 가져온다.
	public ArrayList<NoteComment> getCommentAboutRoomNo(Integer no) {
		logger.debug("getCommentAboutRoomNo service search no: " + no);
		ArrayList<NoteComment> commentList = roomMapper.getCommentAboutRoomNo(no);//코멘트 기본정보들을 가져옴
		return commentList;
	}

	// 코멘트 추가(해당 방번호에 중개사가 이미등록했거나, 등록된 코멘트가 3개이상이면 등록x)
	public int insertComment(Integer userNo, Integer roomItemNo, String text) {
		logger.debug("insertMyComment userNo: " + userNo + "/roomItemNo :" + roomItemNo + "/comment : " + text);
		// 코멘트 정보 중복 및 초과확인
		if (roomMapper.getCommentAboutRoomNo(roomItemNo) != null) {
			System.out.println(roomMapper.getCommentAboutRoomNo(roomItemNo).size());
			if (3 <= roomMapper.getCommentAboutRoomNo(roomItemNo).size())// 등록된 코멘트가 3개  이상이면
				return -1;
			else if (roomMapper.getCommentAboutUserNoAndRoomItemNo(userNo, roomItemNo) != null) {// 이미 코멘트가  등록되어있으면
				
				return -2;
			}
		}
		// 코멘트정보 담기
		NoteVO noteVO = new NoteVO();
		noteVO.setUser_no(userNo);
		;
		noteVO.setRoom_item_no(roomItemNo);
		noteVO.setText(text);
		// 담은 코멘트정보로 추가(해당 방번호와 중개사 번호로 코멘트 등록)
		roomMapper.insertComment(noteVO);
		return 1;
	}

	// 수정 내역 추가
	public int insertModifyContent(Integer userNo, Integer roomItemNo, String text) {
		logger.debug(
				"insertModifyContent userNo: " + userNo + "/modifyContent : " + text + "/roomItemNo : " + roomItemNo);
		// 수정내역 정보 담기
		AdminInformationModifyVO adminInformationModifyVO = new AdminInformationModifyVO();
		adminInformationModifyVO.setUser_no(userNo);
		adminInformationModifyVO.setText(text);
		adminInformationModifyVO.setRoom_no(roomItemNo);
		// 수정내역요청 중복확인
		if (roomMapper.getModifyContent(adminInformationModifyVO) != null) {
			/// 이미 수정요청을 했던 중개사 번호이면
			logger.debug("insertModifyContent about roomItemNo is already enrolled update try");
			roomMapper.updateModifyContent(adminInformationModifyVO);
			return 2;
		}
		// 담은 수정내역정보로 추가
		roomMapper.insertModifyContent(adminInformationModifyVO);
		return 1;
	}

	// 수정 요청내역 가져오기
	public ArrayList<String> getModifyText(Integer userNo, Integer roomItemNo) {
		logger.debug("getModifyContent");
		AdminInformationModifyVO adminInformationModifyVO = new AdminInformationModifyVO();
		adminInformationModifyVO.setRoom_no(roomItemNo);
		adminInformationModifyVO.setUser_no(userNo);
		adminInformationModifyVO = roomMapper.getModifyContent(adminInformationModifyVO);

		ArrayList<String> modifyTextList = new ArrayList<String>();
		if (adminInformationModifyVO != null) {
			logger.debug("get modifyText : " + adminInformationModifyVO.getText());
			String[] words = adminInformationModifyVO.getText().split(":", -1);
			for (int i = 0; i < words.length; i++)
				modifyTextList.add(words[i]);
		} else {
			logger.debug("modify text is not exist");
		}
		return modifyTextList;
	}

	// 중개사의 고객(관심매물폴더)추가
	public boolean insertCartUesr(RoomItemCartListVO roomItemCartListVO) {
		logger.debug("insertCartUesr");
		if (roomItemCartListVO.getName().equals(""))// 입력한값이 없으면
			return false;
		if (roomMapper.getCartListAdoutNameAndAgentNo(roomItemCartListVO) != null) {
			// 고객(고객명 ,전화번호, 담당중개사의  번호)이 이미등록되어있으면
			logger.debug("roomItemCartListVO about Name is already enrolled");
			return false;
		}
		// 고객 추가
		roomMapper.insertRoomItemCartList(roomItemCartListVO);// 매물관심 고객정보 추가
		return true;
	}
	// 중개사의 고객(관심매물폴더)삭제(폴더에 속한 모든 매물정보도 삭제)
	public void changeAgentNoOfCartUesrList(RoomItemCartListVO roomItemCartListVO) {
		logger.debug("deleteCartUesr");
		// 고객폴더(관심매물폴더) 삭제
		roomMapper.updateAgentNoInRoomItemCartList(roomItemCartListVO.getNo(), roomItemCartListVO.getUser_no());//관심폴더 번호에 지정된 중개사 번호를 바꿈
	}
	
	// 중개사의 고객들을 가져옴
	public ArrayList<RoomItemCartListVO> getCartUserAboutAgentNo(Integer agentNo) {
		logger.debug("getCartUserAboutAgentNo  agentNo : " + agentNo);
		return roomMapper.getRoomItemListAboutAgentNo(agentNo);
	}
	//고객폴더의 정보 수정(고객폴더 수정)
	public void updateCartUserAboutCartListNo(RoomItemCartListVO roomItemCartListVO) {
		logger.debug("updateCartUserAboutCartListNo  cart_list_no : " + roomItemCartListVO.getNo());
		roomMapper.updateCartUserAboutCartListNo(roomItemCartListVO);//고객폴더의 번호를 찾아 고객폴더 정보를 수정한다.
	}
	
	//중개사의 고객번호(폴더번호) 하나에 등록된 매물수를 가져옴
	public int getCountAboutAgentAndCartUser(Integer RoomItemCartListNo) {
		logger.debug("getRoomCountAboutAgentAndCartUser service");
		int searchCount = 0;
		searchCount = roomMapper.getCountCartUserAboutCartUserListNo(RoomItemCartListNo);
		return searchCount;
	}
	// 중개사가 등록한 관심고객폴더 정보 가져오기
	public ArrayList<CartUser> getInterestCartUser(Integer agentNo) {
		logger.debug("getInterestCartUser  agentNo : " + agentNo);
		return roomMapper.getRoomItemCartListUser(agentNo);
	}
	// 중개사가 등록한 고객폴더에 있는 관심매물등의 정보 가져오기
	public ArrayList<CartUserDetail> getDetailInterestCartUser(Integer agentNo, Integer roomItemCartListNo) {
		logger.debug("getDetailInterestCartUser  agentNo : " + agentNo);
		ArrayList<CartUserDetail> CartUserDetailList = roomMapper.getCartUserDetailAboutCartUserListNoAndUserNo(agentNo, roomItemCartListNo);	
		//사진 경로 설정
		String main_url = "";
		ArrayList<String> urlList;
		for(int a=0; a<CartUserDetailList.size(); a++){
			urlList =  roomMapper.getFakeUrlList(CartUserDetailList.get(a).getNo());
			if(0 < urlList.size()){
				main_url = urlList.get(0);
				CartUserDetailList.get(a).setMain_fake_url(main_url);
			}else{
				CartUserDetailList.get(a).setMain_fake_url("");
			}
		}
		return CartUserDetailList;
	}
	//하나의 고객폴더에 있는 관심매물수를 가져옴
	public int getCountDetailInterestCartUser(Integer roomItemCartListNo) {
		logger.debug("getCountDetailInterestCartUser  roomItemCartListNo : " + roomItemCartListNo);
		return roomMapper.getCountCartUserAboutCartUserListNo(roomItemCartListNo);
	}
	// 중개사가 매물에 관심있어 하는 고객들의 정보를 추가(관심 매물 추가)
	public void addCartList(Integer no, ArrayList<Integer> cartListNoList) {
		logger.debug("addCartList  room_item_no : " + no + " /room_item_cart_list_no :" + cartListNoList);
		// 관심매물 정보(고객번호들, 매물번호)를 모두 추가
		RoomItemCartVO roomItemCartVO = new RoomItemCartVO();
		for (int i = 0; i < cartListNoList.size(); i++) {
			roomItemCartVO.setRoom_item_cart_list_no(cartListNoList.get(i));
			roomItemCartVO.setRoom_item_no(no);
			if (roomMapper.getRoomItemCartAboutRoomItemCartNoAndRoomNo(roomItemCartVO) == null) {
				// 관심매물이 등록되어있지 않으면 (방번호,고객번호)
				roomMapper.insertRoomItemCart(roomItemCartVO);// 새로 관심매물추가
				logger.debug("add success! roomItemCart about room_item_no, room_item_cart_list_no"
						+ " (cartListNoList: " + cartListNoList.get(i) + ")");
			} else {// 관심매물이 이미 등록되었으면
				logger.debug("roomItemCart about room_item_no, room_item_cart_list_no "
						+ "is already enrolled  (cartListNoList: " + cartListNoList.get(i) + ")");
			}
		}
	}
	//고객폴더내에있는 관심매물삭제
	public void deleteInterest(Integer no) {
		logger.debug("deleteInterest  관심매물에서 삭제할 관심매물 번호 : " + no );
		roomMapper.deleteRoomItemCart(no);
	}
	
	// 고객정보가(전화번호+실명)비슷한 웹의 회원정보들을 가져옴
	public ArrayList<UserVO> getUserAboutName(String fullName) {
		logger.debug("getRoomItemCartAboutNameAndAgentNo   name : " + fullName);
		// 이름과 전화번호를 분리
		String name = "";
		String phone = "";
		for (int a = 0; a < fullName.length(); a++) {
			try {
				Integer.parseInt(fullName.charAt(a) + "");
				phone += fullName.charAt(a) + "";
			} catch (Exception e) {
				name += fullName.charAt(a) + "";
			}
		}
		// 찾을 회원의 정보 설정
		UserVO userVO = new UserVO();
		userVO.setName(name);
		userVO.setPhone(phone);
		// 이름, 핸드폰번호가 유사한 회원 get
		logger.debug("try get    name : " + name + "/ phone : " + phone);
		return roomMapper.getUserNameAndPhone(userVO);
	}

	// 계약이 안된 매물번호이면 계약완료시킴
	public boolean addCompleteContract(ContractCompleteVO contractComplete, Integer roomItemNo) {
		logger.debug("addCompleteContract   no : " + roomItemNo);
		logger.debug("start synchronized/  process : 1.add SpecificRoomItemPrev 2.remove SpecificRoomItem");
		synchronized (this) {// 방번호가 존재하는지 확인함과 동시에 계약
			SpecificRoomItemVO specificRoomItemVO = roomMapper.getSpecificRoomItem(roomItemNo);
			if (specificRoomItemVO != null) {// 계약하려는 매물번호가(매물상태로)존재하면
				// 계약완료된 방을 이전 매물에 저장(specific_room_item_prev에 복사)
				roomMapper.addSpecificRoomItemPrev(specificRoomItemVO.getItem_no());
				// 현재 매물에서 계약된 방을 삭제(specific_room_item 을삭제)
				roomMapper.removeSpecificRoomItem(specificRoomItemVO.getItem_no());
			} else {// 계약하려는 매물이 존재하지 않으면
				logger.debug("SpecificRoomItem is not exist");
				return false;
			}
		}
		logger.debug("end synchronized");

		// 계약 정보 설정(방번호, 계약상태, 중개사)
		contractComplete.setRoom_item_no(roomItemNo);// 매물번호
		contractComplete.setCheck((short) 1);// 계약완료상태
		roomMapper.insertCompleteContract(contractComplete);
		return true;
	}

	// 해당 매물번호와 중개사로 연락처 확인한 기록을 추가, 임대인의 연락처를 가져옴
	public LessorInfor getLessorInfor(Integer no, ArrayList<Integer> cartListNoList, Integer agent_no) {
		logger.debug("getLessorPhone    RoomItemNo : " + no + "/" + "cart_list_no : " + cartListNoList + "/ agent_no : "
				+ agent_no);
		// 연락처보기 기록 ( agent_no , cart_list_no , no 값을 history에 저장)
		LessorPhoneHistoryVO lessorPhoneHistoryVO = new LessorPhoneHistoryVO();
		for (int a = 0; a < cartListNoList.size(); a++) {
			lessorPhoneHistoryVO.setCart_list_no(cartListNoList.get(a));
			lessorPhoneHistoryVO.setRoom_item_no(no);
			lessorPhoneHistoryVO.setUser_no(agent_no);
			roomMapper.insertLessorPhoneHistory(lessorPhoneHistoryVO);
		}
		//고객들을 위한 연락처확인이아니면 
		if(cartListNoList.size() == 0){
			lessorPhoneHistoryVO.setCart_list_no(-1);
			lessorPhoneHistoryVO.setRoom_item_no(no);
			lessorPhoneHistoryVO.setUser_no(agent_no);
			roomMapper.insertLessorPhoneHistory(lessorPhoneHistoryVO);
		}
		
		// 연락처가져오기
		LessorInfor lessorInfor = roomMapper.getSepcificRoomItemAboutItemNo(no);
		return lessorInfor;
	}
	//매물담당 연락처 확인을 기록
	public void insertRoomPhoneHistory(Integer loginNo, Integer roomNo) {
		if(roomMapper.getNoInRoomPhoneHistoryAboutRoomNoAndLoginNo(loginNo, roomNo) == null)//(매물번호와 회원번호)의 정보로 매물담당 연락처를 확인한적이 없으면
			roomMapper.insertAllInfroInRoomPhoneHistory(loginNo, roomNo); //매물담당 연락처 확인을 기록
	}
	// 매물번호와 회원번호로 찜추가
	public void addZzim(Integer roomItemNo, Integer userNo) {
		logger.debug("addZzim    roomItemNo : " + roomItemNo + "/" + "userNo : " + userNo);
		// 찜추가
		ZzimVO zzimVO = new ZzimVO();
		zzimVO.setRoom_item_no(roomItemNo);
		zzimVO.setUser_no(userNo);
		roomMapper.addZzim(zzimVO);
	}

	// 매물번호와 회원번호로 찜삭제
	public void delZzim(Integer roomItemNo, Integer userNo) {
		logger.debug("delZzim    roomItemNo : " + roomItemNo + "/" + "userNo : " + userNo);
		// 찜삭제
		ZzimVO zzimVO = new ZzimVO();
		zzimVO.setRoom_item_no(roomItemNo);
		zzimVO.setUser_no(userNo);
		roomMapper.delZzim(zzimVO);
	}

	//매물번호와 회원번호로 최근본방 추가
	public void addRecently(int loginNo, int room_no) {
		//최근본방 추가
		RecentlyVO recentlyVO = new RecentlyVO();
		recentlyVO.setRoom_item_no(room_no);
		recentlyVO.setUser_no(loginNo);
		roomMapper.deleteRecently(recentlyVO);//지금본 매물번호를 찾아 오래된 기록을 지움
		roomMapper.addRecently(recentlyVO);//지금본 매물번호를 가장최근기록으로 추가
		System.out.println(roomMapper.getCountRecently(loginNo));
		if(recentlyLimit < roomMapper.getCountRecently(loginNo))//회원의 최근기록 보유개수를 초과하면
			roomMapper.deleteRecentlyAboutOldest(loginNo);//회원의 가장 오래된 최근기록을 삭제
	}
	//매물번호에 해당하는 조회수 하나 증가시키기
	public void increaseReadCnt(Integer roomItemNo) {
		//조회수를 가져와 조회수를 하나 증가시킴
		synchronized (this) {
			int originalCnt = roomMapper.getReadCntInSpeicificRoomItemAboutRoomNo(roomItemNo);
			roomMapper.updateReadCntInSpeicificRoomItem(originalCnt + 1, roomItemNo);
		}
	}
	// 허위 매물신고 내역 추가
	public int insertFakeRoom(Integer userNo, Integer roomItemNo, String text) {
		logger.debug("insertFakeRoom  userNo: " + userNo + "/modifyContent : " + text + "/roomItemNo : " + roomItemNo);
		// 허위 매물 신고 내역 정보 담기
		RoomFakeReportVO roomFakeReport = new RoomFakeReportVO();
		roomFakeReport.setUser_no(userNo);
		roomFakeReport.setText(text);
		roomFakeReport.setRoom_item_no(roomItemNo);
		// 허위 매물 신고 중복확인
		if (roomMapper.getFakeContent(roomFakeReport) != null) {/// 이미 신고를 한적이
																/// 있는 했던 회원과
																/// 방번호이면
			logger.debug("insertFakeRoom about roomItemNo, user is already enrolled, try update");
			roomMapper.updateRoomFakeReport(roomFakeReport);
			return 2;
		}
		// 담은 수정내역정보로 추가
		roomMapper.insertRoomFakeReport(roomFakeReport);
		return 1;
	}

	// 허위 매물신고 내역 가져오기
	public ArrayList<String> getFakeText(Integer userNo, Integer roomItemNo) {
		logger.debug("getFakeText");
		RoomFakeReportVO roomFakeReport = new RoomFakeReportVO();
		roomFakeReport.setUser_no(userNo);
		roomFakeReport.setRoom_item_no(roomItemNo);
		roomFakeReport = roomMapper.getFakeContent(roomFakeReport);

		ArrayList<String> fakeTextList = new ArrayList<String>();
		if (roomFakeReport != null) {
			logger.debug("get FakeReportText : " + roomFakeReport.getText());
			String[] words = roomFakeReport.getText().split(":", -1);
			for (int i = 0; i < words.length; i++)
				fakeTextList.add(words[i]);
		} else {
			logger.debug("FakeReport text is not exist");
		}
		return fakeTextList;
	}

	// 상담문의 신청
	public boolean insertConsult(Integer userNo, Integer roomItemNo, ConsultVO consultVO) {
		logger.debug("insertConsult");
		consultVO.setUser_no(userNo);// 회원번호 설정
		consultVO.setRoom_item_no(roomItemNo);// 방번호 설정
		if (roomMapper.getConsult(consultVO) != null) {// 상담신청을 한적이 있으면
			logger.debug("allready consult apply is exist");
			return false;
		}
		roomMapper.insertConsult(consultVO);
		return true;
	}

//***********************************방 등록**********************************************
	// 강남방서버 원본/리사이징/워터마크이미지를 임시로저장
	public String uploadTempToGNServer(MultipartFile uploadfile, HttpServletRequest request, Integer loginNo) {
		logger.debug("start upload(my server) basic and resize and watermark img");

		// (저장공간)디렉토리명
		String dirSub = "tempUpload/" + loginNo;
		String orginalPath;
		String waterMarkPath;
		orginalPath = "";// 저장 위치의 파일전체경로
		// 확장자
		String extension;
		extension = uploadfile.getOriginalFilename().
				substring(uploadfile.getOriginalFilename().lastIndexOf("."));

		// 파일이름
		String fileName = uploadfile.getOriginalFilename();
		fileName = UUID.randomUUID().toString();

		// 파일 용량 제한
		if (10485760 < uploadfile.getSize())// 10*1024*1024(10MB)를 넘으면 
			return "ErrSize";
		// 확장자 추출 후 적합성 확인
		if (!(extension.equals(".jpg")  || extension.equals(".jpeg") || extension.equals(".JPG")  || extension.equals(".JPEG"))){
			// ||// extension.equals(".PNG")||// extension.equals(".png")
			return "ErrExtension";
		}else if(extension.equals(".jpeg") || extension.equals(".JPG")  || extension.equals(".JPEG")){
			extension = extension.replace("jpeg", "jpg");
			extension = extension.replace("JPG", "jpg");
			extension = extension.replace("JPEG", "jpg");
		}
		// 1.강남방 서버 임시 파일업로드
		try {
			// 강남방 서버 임시 업로드 되는 디렉토리
			String srcDir = request.getSession().getServletContext().getRealPath("/") 
					+ "upload/" + dirSub + "/original/";
			// 임시 원본 이미지의 전체경로
			orginalPath = srcDir + fileName + extension;

			// 임시 디렉토리 생성
			File targetDir = new File(srcDir);
			if (!targetDir.exists()) {// 폴더가없으면
				targetDir.mkdirs();
			}

			// 임시 파일 저장
			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(orginalPath)));
			stream.write(uploadfile.getBytes());
			stream.close();
		} catch (Exception e) {
		}

		// 2.강남방 서버 임시  워터마크&리사이징 이미지 저장
		// 리사이징/ 워터마크 임시 디렉토리와 파일명 지정
		String srcDir = "";
		srcDir = request.getSession().getServletContext().getRealPath("/") + "upload";
		srcDir = srcDir + "/" + dirSub + "/";
		String resizePath = srcDir + "resize/" + fileName + extension;// 리사이즈 임시 이미지 전체경로
		waterMarkPath = srcDir + "watermark/" + fileName + extension;// 워터마크 임시 전체경로

		// 디렉토리 없으면 생성
		File targetDir = new File(srcDir + "resize/");
		if (!targetDir.exists())
			targetDir.mkdirs();
		targetDir = new File(srcDir + "watermark/");
		if (!targetDir.exists())
			targetDir.mkdirs();

		// 리사이징/ 워터마크 처리
		ImageResizing ir = new ImageResizing();
		ir.process(orginalPath, resizePath);
		String watermarkDir = request.getSession().getServletContext().getRealPath("/") + "upload/tempUpload/";
		logger.debug("watermark file directory :" + watermarkDir);
		WaterMark.addImageWatermark(new File(resizePath), new File(waterMarkPath), watermarkDir);
		return waterMarkPath;// out put 값 : 워터마크 이미지가 저장된경로
	}

	// 방등록 , 매물 및 방의 정보를 db에저장
	public Integer insertSpecificRoomItemAboutAgent(EnrolledRoom enrolledRoom, Integer userNo) {
		logger.debug("insertSpecificRoomItemAboutAgent");
		try {
			// 지하철 이름을 지하철의 번호로 설정
			Integer metroNum = roomMapper.getMetroNo(enrolledRoom.getMetroName1());
			if(metroNum != null)
				enrolledRoom.setMetro1(metroNum);
			metroNum = roomMapper.getMetroNo(enrolledRoom.getMetroName2());
			if(metroNum != null)
				enrolledRoom.setMetro1(metroNum);
			metroNum = roomMapper.getMetroNo(enrolledRoom.getMetroName3());
			if(metroNum != null)
				enrolledRoom.setMetro1(metroNum);
			metroNum = roomMapper.getMetroNo(enrolledRoom.getMetroName4());
			if(metroNum != null)
				enrolledRoom.setMetro1(metroNum);
			metroNum = roomMapper.getMetroNo(enrolledRoom.getMetroName5());
			if(metroNum != null)
				enrolledRoom.setMetro1(metroNum);
		} catch (Exception e) {
		}

		//섹션이름을 섹션 번호로 설정
		Integer sectionNo = roomMapper.getSectionNo(enrolledRoom.getSectionName());
		if(sectionNo != null)
			enrolledRoom.setSection_no(sectionNo);
		
		try {
			enrolledRoom.setUser_no(userNo);// 등록할 방정보에 등록자 번호포함
			// 방추가
			int roomNo = -1;
			synchronized (this) {
				roomMapper.insertRoomItem(enrolledRoom);// 방의 기본정보등록
				roomNo = roomMapper.getRoomItemNo();// 최근등록된(위에서) 방의 번호를 가져온다.
			}
			logger.debug("success add(->db) roomItem,  roomNo:" + roomNo);
			// 추가된 방 번호로 매물추가
			enrolledRoom.setItem_no(roomNo);
			roomMapper.insertSpecificRoomItem(enrolledRoom);// 매물정보 등록
			logger.debug("success add(->db) SpecificRoomItem");
			return roomNo;
		} catch (Exception e) {
			logger.debug("fail add(->db) roomItem or SpecificRoomItem");
			return -1;
		}
	}

	// 워터마크 임시경로에서 이미지를 가져와  ftp서버로 업로드, 원본임시경로를 통해 강남방서버에 업로드
	public void movePhotoTempToReal(HttpServletRequest request, Integer loginNo, Integer roomNo,
			ArrayList<String> photoTempList) {
		// 1.임시(원본) -> 강남방서버(원본)
		ArrayList<String> originalPathMyServer = moveTempToMyServer(request, roomNo, photoTempList);
		if (originalPathMyServer.size() == 0)
			return;
		else
			logger.debug("success add   temp(original)  -> my server(original)");

		// 2.임시(워터마크) -> ftp서버(워터마크)
		ArrayList<String> watermarkPathFTP = uploadFromGNServerToFTP(request, roomNo, photoTempList);
		if (watermarkPathFTP.size() == 0)
			return;
		else
			logger.debug("success add  my server(watermark)  -> ftp server(watermark)");

		// 3.ftp와 강남방서버 이미지 경로 -> db저장
		boolean insert = enrollPhotoPath(loginNo, roomNo, originalPathMyServer, watermarkPathFTP, (short) 1);

		// 4.회원의 기존 임시(워터마크/원본)삭제
		deleteDirectory(new File(request.getSession().getServletContext().getRealPath("/") + "upload" + "/"
				+ "tempUpload/" + loginNo + "/"));
		
		if (insert)
			logger.debug("success add  watermark, orginal path  -> DB");
		else
			logger.debug("fail add  watermark, orginal path  -> DB");
		return;
	}

	// input: 임시로 저장된 원본경로
	// process: 임시저장된 원본이미지를 강남방서버로 옮김
	// sumary : 임시(원본) -> 강남방서버(원본)
	private ArrayList<String> moveTempToMyServer(HttpServletRequest request, int roomNo,
			ArrayList<String> watermarkTempList) {
		// (저장공간)디렉토리명 규칙 적용 - 100 단위의 폴더이름
		String dirSubPer00000000 = String.format("%09d", Integer.parseInt((int) (roomNo / 100000000) + "00000000"));
		String dirSubPer000000 = String.format("%09d", Integer.parseInt((int) (roomNo / 1000000) + "000000"));
		String dirSubPer0000 = String.format("%09d", Integer.parseInt((int) (roomNo / 10000) + "0000"));
		String dirSubPer00 = String.format("%09d", Integer.parseInt((int) (roomNo / 100) + "00"));
		String dirSubPer = String.format("%09d", Integer.parseInt((int) (roomNo / 1) + ""));
		String dirSub = dirSubPer00000000 + "/" + dirSubPer000000 + "/" + dirSubPer0000 + "/" + dirSubPer00 + "/"
				+ dirSubPer;
		String orginalPath;// 원본이미지 저장될 경로(파일명포함 전체)
		String orginalDirPath = GlobalValue.serverPhotoDir + dirSub
				+ "/";// 원본이미지 저장될 경로(파일명 제외)
		String fileName = "";// 파일명(확장자 포함)
		String watermarkTempPath = "";// 복사대상 이미지를 가져올 경로(파일명 포함),워터마크이미지
		String originalTempPath = "";// 복사대상 이미지를 가져올 경로(파일명 포함),원본이미지
		ArrayList<String> originalPathMyServer = new ArrayList<String>();// 저장된 워터마크의  이미지 경로 보관

		for (int i = 0; i < watermarkTempList.size(); i++) {
			logger.debug("my server, upload file index:    :" + i);
			watermarkTempPath = watermarkTempList.get(i);
			// 임시 워터마크의 경로로 임시 원본에 해당되는 경로 계산
			originalTempPath = watermarkTempPath.replace("watermark", "original");

			//임시 원본의 파일명 추출
			int index = (originalTempPath.lastIndexOf("/") + 1);
			if ((originalTempPath.lastIndexOf("/") + 1) < (originalTempPath.lastIndexOf("\\") + 1))
				index = (originalTempPath.lastIndexOf("\\") + 1);
			fileName = originalTempPath.substring(index);

			// 전체경로 설정(파일명포함)
			orginalPath = orginalDirPath + fileName;
		
			// 디렉토리 없으면 생성
			File orginalDir = new File(orginalDirPath);
			if (!orginalDir.exists()) {
				orginalDir.mkdirs();
			}

			if (!copy(originalTempPath, orginalPath))// 복사 : 임시 원본 -> 서버 원본
				continue;
			originalPathMyServer.add(orginalPath);
		}
		return originalPathMyServer;
	}

	// input :워터마크이미지의 경로
	// process : 워터마크를 ftp에 저장
	// sumary : 강남방서버(워터마크이미지) -> ftp서버(워터마크이미지)
	private ArrayList<String> uploadFromGNServerToFTP(HttpServletRequest request, int roomNo,
			ArrayList<String> watermarkPathTemp) {
		// (저장공간)디렉토리명 규칙 적용 - 100 단위의 폴더이름
		String dirSubPer00000000 = String.format("%09d", Integer.parseInt((int) (roomNo / 100000000) + "00000000"));
		String dirSubPer000000 = String.format("%09d", Integer.parseInt((int) (roomNo / 1000000) + "000000"));
		String dirSubPer0000 = String.format("%09d", Integer.parseInt((int) (roomNo / 10000) + "0000"));
		String dirSubPer00 = String.format("%09d", Integer.parseInt((int) (roomNo / 100) + "00"));
		String dirSubPer = String.format("%09d", Integer.parseInt((int) (roomNo / 1) + ""));
		String dirSub = GlobalValue.ftpDir + "/photo/" + dirSubPer00000000 + "/" + dirSubPer000000 + "/" + dirSubPer0000 + "/" + dirSubPer00
				+ "/" + dirSubPer;// 워터마크 저장되는 ftp경로(파일명제외)
		String srcWatermarkPath;// 저장할 이미지가 존재하는 경로(파일명포함)
		String dstWatermarkPath;// 앞으로 저장될 이미지의 경로(파일명포함)
		String fileName;// 파일명
		ArrayList<String> watermarkPathFTP = new ArrayList<String>();

		// ftp연결 및 디렉토리 설정
		FTPUtil ftpUtil = FTPUtil.getInstance("112.175.245.57", 21, "gnb01", "gnbp01");
		boolean success;
		success = ftpUtil.connect();
		if (!success) {
			logger.debug("connect failed ");
			return null;
		}
		// 디렉토리 생성
		success = ftpUtil.createDirectory(dirSub);

		// 서버에존재하는 원터마크들을 저장 : 서버(워터마크) -> ftp(워터마크)
		for (int a = 0; a < watermarkPathTemp.size(); a++) {
			srcWatermarkPath = watermarkPathTemp.get(a);

			// 파일명 추출
			int index = (srcWatermarkPath.lastIndexOf("/") + 1);
			if ((srcWatermarkPath.lastIndexOf("/") + 1) < (srcWatermarkPath.lastIndexOf("\\") + 1))
				index = (srcWatermarkPath.lastIndexOf("\\") + 1);
			fileName = srcWatermarkPath.substring(index);

			// 저장될 전체경로 설정(파일명포함)
			dstWatermarkPath = dirSub + "/" + fileName;
			logger.debug("my  server  , source        srcWatermarkPath img save full path :" + srcWatermarkPath);
			logger.debug("ftp server  , destination   dstWatermarkPath img save full path :" + dstWatermarkPath);
			FTPFile file = new FTPFile(srcWatermarkPath, dstWatermarkPath);
		
			ftpUtil.addUploadQueue(file);
			do {
				try {
					Thread.sleep(100);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} while (ftpUtil.checkStatus(file) == UploadStatus.NOT_YET);

			watermarkPathFTP.add(dstWatermarkPath);// ftp저장경로 보관
			UploadStatus uploadStatus = ftpUtil.checkStatus(file);
			ftpUtil.clearList(file);
		}
		return watermarkPathFTP;
	}

	//매물번호로 매물삭제. 매물등록했을때의 모든 db정보를 지움(이전 매물정보로 옮기지 않음 : 웹 test시에만 사용)
	public Integer deleteAllInforOfRoomAboutRoomItemNo(Integer roomItemNo) {
		//방상세정보 테이블(specific_room_item)정보 삭제
		roomMapper.removeSpecificRoomItem(roomItemNo);
		//매물 테이블(room_item)정보 삭제
		roomMapper.deleteRoomItemAboutNo(roomItemNo);
		//사진경로 (room_photo)정보 삭제
		roomMapper.deleteRoomPhotoAboutRoomItemNo(roomItemNo);
		//* 사진파일은 삭제되지않음 별도로 삭제 필요
		return null;
	}
	//로그인번호에해당되는 모든 매물삭제. 매물등록했을때의 모든 db정보를 지움(이전 매물정보로 옮기지 않음 : 웹 test시에만 사용)
	public Integer deleteAllInforsOfRoomAboutUserNo(Integer agentNo) {
		//매물 테이블(room_item)정보 삭제
		roomMapper.deleteRoomItemAboutAgentNo(agentNo);
		//방상세정보 테이블(specific_room_item)정보 삭제
		roomMapper.removeSpecificRoomItemAboutAgentNo(agentNo);
		//사진경로 (room_photo)정보 삭제
		roomMapper.deleteRoomPhotoAboutAgentNo(agentNo);
		//* 사진파일은 삭제되지않음 별도로 삭제 필요
		return null;
	}
		
	// db로 ftp와 원본이미지의 경로를 저장한다.
	private boolean enrollPhotoPath(Integer UserNo, Integer roomNo, ArrayList<String> watermarkPathMyServer,
			ArrayList<String> watermarkPathFTP, short isUse) {
		try {
			String pathMyServerWater;// 강남방서버 워터마크 이미지경로
			String pathMyServerOriginal;// 강남방서버 이미지원본 경로
			String pathFTPWater;// FTP서버 워터마크 이미지경로
			for (int a = 0; a < watermarkPathFTP.size(); a++) {
				pathMyServerWater = watermarkPathMyServer.get(a);
				pathMyServerOriginal = pathMyServerWater.replace("watermark", "original");
				pathFTPWater = watermarkPathFTP.get(a);

				RoomPhotoVO roomPhotoVO = new RoomPhotoVO();
				roomPhotoVO.setIs_use(isUse);
				roomPhotoVO.setUser_no(UserNo);
				roomPhotoVO.setRoom_item_no(roomNo);
				roomPhotoVO.setFake_url(pathFTPWater);
				roomPhotoVO.setOriginal_url(pathMyServerOriginal);
				roomMapper.insertRoomPhoto(roomPhotoVO);
			}
			if(0 <  watermarkPathFTP.size()){
				//photo도 업데이트 
				roomMapper.updatePhotoOpenInRoomSpecificItemAboutItemNo(roomNo, 1);//등록한 방의 사진상태를 open한다
				roomMapper.updatePhotoInRoomItemAboutItemNo(roomNo, 1);//등록한 방의 사진상태를 open한다
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// 매물에 등록된 사진의 수를 가져온다.
	public Integer getPhotoCount(Integer room_no) {
		return roomMapper.getPhotoCount(room_no);
	}

	// 지하철번호, 매물번호, 지역번호, 센터번호, 상세필터내용 들로 중개사가 등록했던 방 검색.
	public ArrayList<SearchRoomSumary> getSpecificRoomItemAboutAgent(String metro_no, String addr, String room_no,
			String sector_code, Integer agentNo, String p, String sort, Integer pg, Integer roomNumPerPage) {
		logger.debug(
				"service input   metro_no:" + metro_no + "  addr:" + addr + "  room_no:" + room_no + "  sector_code:"
						+ sector_code + "  agentNo:" + agentNo + "  p:" + p + "  sort:" + sort + "  pg:" + pg);
		if(sort.equals(""))
			sort ="photo desc, date desc";//사진 있는 매물을 먼저나오게 정렬
		else
			sort = sort + ", photo desc";//사진 있는 매물을 먼저나오게 정렬
		
		// 방들의 정보를 가져옴
		ArrayList<SearchRoomSumary> searchRoomSumaryList = roomMapper.getSpecificRoomItemAboutAgent(metro_no, addr,
				room_no, sector_code, agentNo, getMapAboutFilter(p), sort, (pg - 1) * roomNumPerPage, roomNumPerPage);
		// 방들의 정보에 사진경로리스트를 추가
		String room_photo_date;//사진의 등록날짜
		for (int a = 0; a < searchRoomSumaryList.size(); a++){
			searchRoomSumaryList.get(a).setFake_url(roomMapper.getFakeUrlList(searchRoomSumaryList.get(a).getNo()));
			searchRoomSumaryList.get(a).setPhotoEnrollDate(roomMapper.getPhotoEnrollDateList(searchRoomSumaryList.get(a).getNo()));
			// 사진데이터들을 통해 사진수정여부를 설정해줌
			searchRoomSumaryList.get(a).setModifiable(true);//수정가능상태로 시작
			//사진등록날짜들중 하루 이상된 사진이 있다면 수정불가능상태로 설정
			for(int b = 0; b < searchRoomSumaryList.get(a).getPhotoEnrollDate().size(); b++){//하나의 매물에대한 사진수만큼
				room_photo_date = searchRoomSumaryList.get(a).getPhotoEnrollDate().get(b);
				if(!roomMapper.timeIsIn1Day(room_photo_date))//room_photo_date와 현재시간의 차이가 하루가 안됐으면 
					searchRoomSumaryList.get(a).setModifiable(false);
			}
		}
		return searchRoomSumaryList;
	}
	// 지하철번호, 매물번호, 지역번호, 센터번호, 상세필터내용 들로 중개사가 등록했던 방의 모든 개수를 가져옴
	public int getRoomCount(String metro_no, String addr, String room_no, String sector_code, int agentNo, String p) {
		int searchRoomSumaryList = roomMapper.getCountRoomAboutAgent(metro_no, addr, 
				room_no, sector_code, agentNo, getMapAboutFilter(p));
		return searchRoomSumaryList;
	}

	//매물에 등록된 사진들의 경로를 가져옴
	public ArrayList<RoomPhotoVO> getPhotoAboutRoomNo(Integer room_no) {
		return roomMapper.getPhotoAboutRoomNo(room_no);
	}
	//중개사가 등록한 사진 수정가능한 매물 
	public ArrayList<SearchRoomSumary> getSpecificRoomItemAboutPictureOfAgent(int agentNo, Integer pg, Integer roomNumPerPage, boolean picture_modifiable) {// 방들의 정보를 가져옴
		logger.debug(" ArrayList<SearchRoomSumary> getSpecificRoomItemAboutModifiablePicture(int loginNo, Integer pg, Integer roomNumPerPage)");
		ArrayList<SearchRoomSumary> searchRoomSumaryList = new ArrayList<SearchRoomSumary>();
		if(picture_modifiable){//매물사진 수정가능한 경우만 검색하려면
			// 방들의 기본 정보를 가져옴
			searchRoomSumaryList = roomMapper.getSpecificRoomItemAboutPhotoLimit1Day(agentNo, (pg - 1) * roomNumPerPage, roomNumPerPage);
			// 방들의 정보에 사진경로리스트와 사진등록데이터들을 추가
			for (int a = 0; a < searchRoomSumaryList.size(); a++){
				searchRoomSumaryList.get(a).setFake_url(roomMapper.getFakeUrlList(searchRoomSumaryList.get(a).getNo()));
				searchRoomSumaryList.get(a).setPhotoEnrollDate(roomMapper.getPhotoEnrollDateList(searchRoomSumaryList.get(a).getNo()));
				// 사진데이터들을 통해 사진수정여부를 설정해줌
				searchRoomSumaryList.get(a).setModifiable(true);//수정가능상태로 시작
			}
		}else{// 방들의 기본 정보를 가져옴
			searchRoomSumaryList = roomMapper.getSpecificRoomItemAboutPhoto(agentNo, (pg - 1) * roomNumPerPage, roomNumPerPage);
			// 방들의 정보에 사진경로리스트와 사진등록데이터들을 추가
			for (int a = 0; a < searchRoomSumaryList.size(); a++){
				searchRoomSumaryList.get(a).setFake_url(roomMapper.getFakeUrlList(searchRoomSumaryList.get(a).getNo()));
				searchRoomSumaryList.get(a).setPhotoEnrollDate(roomMapper.getPhotoEnrollDateList(searchRoomSumaryList.get(a).getNo()));
				// 사진데이터들을 통해 사진수정여부를 설정해줌
				searchRoomSumaryList.get(a).setModifiable(true);//수정가능상태로 시작
				String room_photo_date;//사진등록날
				for(int b = 0; b < searchRoomSumaryList.get(a).getPhotoEnrollDate().size(); b++){
					room_photo_date = searchRoomSumaryList.get(a).getPhotoEnrollDate().get(b);
					if(!roomMapper.timeIsIn1Day(room_photo_date))
						searchRoomSumaryList.get(a).setModifiable(false);
				}
			}
		}
		return searchRoomSumaryList;
	}
	//중개사가 등록한 사진 수정가능한 매물의 총 개수를 가져옴
	public int getPictureRoomCount(int agentNo, Integer pg, Integer roomNumPerPage, boolean picture_modifiable) {
		int modifiablePictureRoomCount = 0;
		if(picture_modifiable)//매물사진 수정가능한 경우만 검색하려면
			modifiablePictureRoomCount = roomMapper.getCountRoomAboutPhotoLimit1Day(agentNo);//중개사가 사진을등록한지 하루미만인 매물들의수를가져옴
		else
			modifiablePictureRoomCount = roomMapper.getCountRoomAboutPhoto(agentNo);//중개사가 사진을등록한 매물들의수를가져옴
		return modifiablePictureRoomCount;
	}
	//사진의 순서를 수정함
	public void updateRoomPhotoOrder(int roomPhotoNo, int order) {
		roomMapper.updateRoomPhotoOrder(roomPhotoNo, order);//사진번호를 찾아 순서를 변경
	}
	//사진을 삭제함
	public void deleteRoomPhoto(Integer photoNo) {
		//삭제할 사진을 가지는 매물의 번호를 가져옴
		Integer itemNo = roomMapper.getRoomItemNoAboutPhotoNo(photoNo);
		//사진번호를 찾아 경로 삭제
		roomMapper.deleteRoomPhoto(photoNo);
		//사진을 가졌던 매물의 남은 사진수를 가져옴
		Integer photoCount = roomMapper.getCountPhotoAboutItemNo(itemNo);
		if(photoCount == 0){//사진수가없으면
			roomMapper.updatePhotoOpenInRoomSpecificItemAboutItemNo(itemNo, 0);//사진 없는상태로 설정
			roomMapper.updatePhotoInRoomItemAboutItemNo(itemNo, 0);
		}
		//필요할경우 ftp 및 서버에서 파일 자체를 삭제하는 방법 구현
	}
	
	//입력주소와 일치하는 이미등록된 주소들을 가져옴
	public ArrayList<Address> getSameAddress(Address address) throws UnsupportedEncodingException {
		logger.debug("service input : address:" + address);
		ArrayList<Address> resultAddressList = new ArrayList<Address>();// 주소들
		ArrayList<Address> basicAddressList = new ArrayList<Address>();// 상세주소들
		if (address.getSi() == null || address.getDong() == null)// 찾을 주소값이  존재안할경우
			return resultAddressList;

		// 코드값을 가져와 설정 ,
		// address : (시, 구, 동 )에 코드 값을 더함
		address.setCode(getLocalCode(address));

		//이미 등록된 주소중, 기본주소가 일치하는 주소의 상세 주소를 가져옴
		basicAddressList = roomMapper.getAddressListInSpecificRoomItem(address);
		
		//(상세주소까지 모두일치하는 주소중에)상세주소값을 포함해 모두 일치하는 주소 결과값을 저장
		Address resultAddress;
		for (int a = 0; a < basicAddressList.size(); a++) {
			//상세주소 일치여부 확인
			if(RoomAddressFunction.isSameLastAddress(basicAddressList.get(a).getLast_address(),  address.getLast_address())){
				resultAddress = new Address();
				resultAddress.setNo(basicAddressList.get(a).getNo());
				resultAddress.setMain_address(basicAddressList.get(a).getMain_address());
				resultAddress.setSub_address(basicAddressList.get(a).getSub_address());
				resultAddress.setLast_address(basicAddressList.get(a).getLast_address());
				resultAddressList.add(resultAddress);
			}
		}
		return  resultAddressList;
	}
	//주소 코드를 가져옴
	public long getLocalCode(Address address) throws UnsupportedEncodingException {
		// 시 라는 문자를 분리하여 모두 포함되어 있으면 검색되게함
		// ex 서울 -> %서%울%
		// 서울을 서울특별시에서 검색해야함
		String si = address.getSi();
		String searchSi = "";
		Address searchAddress = new Address();
		searchAddress.setAddress(address);
		searchSi += "%";
		for (int a = 0; a < si.length(); a++) {
			searchSi += si.charAt(a);
			searchSi += "%";
		}
		searchAddress.setSi(searchSi);
		/*
		 * 동과 군구의 문자열 재설정 ... .. 필요할경우 정의 하는부분
		 */

		long localCode;
		try {
			localCode = roomMapper.getAddressCode(searchAddress);
		} catch (Exception e) {
			logger.debug("address_code database doesn't have address :" + address.getSi() + " " + address.getGungu()
					+ " " + address.getDong());
			return -1;
		}
		return localCode;
	}
	// service에서 사용
	// 파일 복사, 속도개선
	private boolean copy(String src, String dst) {
		try {
			FileInputStream inputStream = new FileInputStream(src);
			FileOutputStream outputStream = new FileOutputStream(dst);
			FileChannel fcin = inputStream.getChannel();
			FileChannel fcout = outputStream.getChannel();
			long size;
			size = fcin.size();
			fcin.transferTo(0, size, fcout);
			fcout.close();
			fcin.close();
			outputStream.close();
			inputStream.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}

	// 디렉토리 삭제
	private static boolean deleteDirectory(File path) {
		if (!path.exists()) {
			return false;
		}
		File[] files = path.listFiles();
		for (File file : files) {
			if (file.isDirectory()) {
				deleteDirectory(file);
			} else {
				file.delete();
			}
		}
		return path.delete();
	}

//**********************************찜 검색**********************************************
	//지도위치로 검색한 찜 매물  가져옴
	public ArrayList<SearchRoomSumary> getSpecificRoomItemAboutGeoZzim(
			String s, String w, String n, String e , Integer userNo,  String sort,  Integer pg){
		logger.debug("getSpecificRoomItemAboutGeoZzim");
		if(sort.equals(""))
			sort ="photo desc, sri.date desc";//사진 있는 매물을 먼저나오게 정렬
		else
			sort = sort + ",photo desc";//사진 있는 매물을 먼저나오게 정렬
		
		ArrayList<SearchRoomSumary> searchRoomSumary;
		
		//검색
		searchRoomSumary = roomMapper.getSpecificRoomItemAboutGeoZzim(s,w,n,e, userNo, sort , (pg-1)*roomNumPerPage , roomNumPerPage );

		//매물의 사진정보를 가져와 설정
		for(int a=0;  a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setFake_url(roomMapper.getFakeUrlList(searchRoomSumary.get(a).getNo()));
		//매물의 찜 정보를 가져와 찜여부 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setZzim_no(1);//모두 찜상태로
		return searchRoomSumary;
	}
	//지도위치로 매물 검색한 찜 결과수
	public int getCountRoomAboutGeoZzim(String s, String w, String n, String e, Integer userNo) {
		logger.debug("getCountRoomAboutGeoZzim");
		int searchCount = 0;
		searchCount = roomMapper.getCountRoomAboutGeoZzim(s,w,n,e, userNo);
		return searchCount;
	}

//**********************************최근본방 검색**********************************************
	//지도위치로 검색한 최근본방 매물 가져옴
	public ArrayList<SearchRoomSumary> getSpecificRoomItemAboutGeoRecently(String s, String w, String n, String e,
			int userNo, String sort, Integer pg) {
		logger.debug("getSpecificRoomItemAboutGeoRecently");
		if(sort.equals(""))
			sort ="sri.date desc";
		/*sort =  "photo desc, " + sort;//사진 있는 매물을 먼저나오게 정렬*/		
		ArrayList<SearchRoomSumary> searchRoomSumary;
		
		//검색
		searchRoomSumary = roomMapper.getSpecificRoomItemAboutGeoRecently(s,w,n,e, userNo, sort , (pg-1)*roomNumPerPage , roomNumPerPage );
		//매물의 사진정보를 가져와 설정
		for(int a=0;  a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setFake_url(roomMapper.getFakeUrlList(searchRoomSumary.get(a).getNo()));
		//매물의 찜 정보를 가져와 찜여부 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setZzim_no(roomMapper.getZzimNo(searchRoomSumary.get(a).getNo(), userNo));
		return searchRoomSumary;
	}
	//지도위치로 매물 검색한 최근본방 결과수
	public int getCountRoomAboutGeoRecently(String s, String w, String n, String e, int userNo) {
		logger.debug("getCountRoomAboutGeoRecently");
		int searchCount = 0;
		searchCount = roomMapper.getCountRoomAboutGeoRecently(s,w,n,e, userNo);
		return searchCount;
	}
	
//**********************************방등록, 찜검색 util**********************************************
		// 방정보를 가져오기위한 검색 필터의 인덱스 설정
		public HashMap<String, String> getMapAboutFilter(String p) {
			if(p.length() == 0)
				p =":::::0:999999999:0:999999999:0:999999999:0:999999999"
						+ "::::::::::2017::::::::::::0:999999999:0:999999999"
						+ "::::::::::::::::::::::::::::";
			String[] filterSprit = p.split(":", -1);
			ArrayList<String> arr = new ArrayList<String>();
			for (int a = 0; a < filterSprit.length; a++) {
				arr.add(filterSprit[a]);
			}
			HashMap<String, String> pMap = new HashMap<String, String>();

			// 거래종류
			pMap.put("trade", arr.get(FILTER_SETTING.TRADE.filterNo));// 매매
			pMap.put("charter", arr.get(FILTER_SETTING.CHARTER.filterNo));// 전세
			pMap.put("monthly_and_charter", arr.get(FILTER_SETTING.MONTHLY_AND_CHARTER.filterNo));// 전월세
			pMap.put("monthly", arr.get(FILTER_SETTING.MONTYLY.filterNo));// 월세
			pMap.put("short_lease", arr.get(FILTER_SETTING.SHORT_LEASE.filterNo));// 단기
																					// 임대

			// 금액
			pMap.put("depositmin", arr.get(FILTER_SETTING.DEPOSITMIN.filterNo));// 보증금
																				// 최소
			pMap.put("depositmax", arr.get(FILTER_SETTING.DEPOSITMAX.filterNo));// 보증금
																				// 최대
			pMap.put("monthmin", arr.get(FILTER_SETTING.MONTHMIN.filterNo));// 월세 최소
			pMap.put("monthmax", arr.get(FILTER_SETTING.MONTHMAX.filterNo));// 월세 최대
			pMap.put("chartermin", arr.get(FILTER_SETTING.CHARTERMIN.filterNo));// 전세
																				// 최소
			pMap.put("chartermax", arr.get(FILTER_SETTING.CHARTERMAX.filterNo));// 전세
																				// 최대
			pMap.put("standardmin", arr.get(FILTER_SETTING.STANDARDMIN.filterNo));// 기준가
																					// 최소
			pMap.put("standardmax", arr.get(FILTER_SETTING.STANDARDMAX.filterNo));// 기준가
																					// 최대

			// 건물형태
			pMap.put("apartment", arr.get(FILTER_SETTING.APARTMENT.filterNo));// 아파트
			pMap.put("officetel", arr.get(FILTER_SETTING.OFFICETEL.filterNo));// 오피스텔
			pMap.put("house", arr.get(FILTER_SETTING.HOUSE.filterNo));// 주택
			pMap.put("normal_room", arr.get(FILTER_SETTING.NORMAL_ROOM.filterNo));// 원룸
			pMap.put("shop", arr.get(FILTER_SETTING.SHOP.filterNo));// 상가
			pMap.put("office", arr.get(FILTER_SETTING.OFFICE.filterNo));// 사무실
			pMap.put("building", arr.get(FILTER_SETTING.BUILDING.filterNo));// 건물
			pMap.put("redevelopment", arr.get(FILTER_SETTING.REDEVELOPMENT.filterNo));// 재개발
			pMap.put("event", arr.get(FILTER_SETTING.EVENT.filterNo));// 이벤트

			// 준공년도와 번지수
			pMap.put("built", arr.get(FILTER_SETTING.BUILT.filterNo));// 준공년도
			pMap.put("address", arr.get(FILTER_SETTING.ADDRESS.filterNo));// 번지

			// 방 형태 room_type로 매칭
			pMap.put("open_room", arr.get(FILTER_SETTING.OPEN_ROOM.filterNo));// 오픈형
			pMap.put("part_room", arr.get(FILTER_SETTING.PART_ROOM.filterNo));// 분리형
			pMap.put("duplex_room", arr.get(FILTER_SETTING.DUPLEX_ROOM.filterNo));// 복층형

			// 룸개수 room_count
			pMap.put("one_room", arr.get(FILTER_SETTING.OND_ROOM.filterNo));// 1룸
			pMap.put("two_room", arr.get(FILTER_SETTING.TRO_ROOM.filterNo));// 2룸
			pMap.put("three_room", arr.get(FILTER_SETTING.THREE_ROOM.filterNo));// 3룸

			// 방위치
			pMap.put("up_ground", arr.get(FILTER_SETTING.UP_GROUND.filterNo));// 지상
			pMap.put("under_ground", arr.get(FILTER_SETTING.UNDER_GROUND.filterNo));// 지하
			pMap.put("semi_basement", arr.get(FILTER_SETTING.SEMI_BASEMENT.filterNo));// 반지하
			pMap.put("rooftop", arr.get(FILTER_SETTING.ROOFTOP.filterNo));// 옥탑방

			// 면적
			pMap.put("exclusive_area_min", arr.get(FILTER_SETTING.EXCLUSIVE_AREA_MIN.filterNo));// 전용면적
																								// 최소
			pMap.put("exclusive_area_max", arr.get(FILTER_SETTING.EXCLUSIVE_AREA_MAX.filterNo));// 전용면적
																								// 최대
			pMap.put("leased_area_min", arr.get(FILTER_SETTING.LEASED_AREA_MIN.filterNo));// 공급면적
																							// 최소
			pMap.put("leased_area_max", arr.get(FILTER_SETTING.LEASED_AREA_MAX.filterNo));// 공급면적
																							// 최대
			// 옵션
			pMap.put("full_option_room", arr.get(FILTER_SETTING.FULL_OPTION_ROOM.filterNo));// 풀옵션
																							// 최대
			pMap.put("airconditioner", arr.get(FILTER_SETTING.AIRCONDITIONER.filterNo));// 에어컨
			pMap.put("refrigerator", arr.get(FILTER_SETTING.REFRIGERATO.filterNo));// 냉장고
			pMap.put("washer", arr.get(FILTER_SETTING.WASHER.filterNo));// 세탁기
			pMap.put("tv", arr.get(FILTER_SETTING.TV.filterNo));// tv
			pMap.put("microwave", arr.get(FILTER_SETTING.MICROWAVE.filterNo));// 전자레인지
			pMap.put("induction", arr.get(FILTER_SETTING.INDUCTION.filterNo));// 인덕션
			pMap.put("sink", arr.get(FILTER_SETTING.SINK.filterNo));// 싱크대
			pMap.put("gasrange", arr.get(FILTER_SETTING.GASRANGE.filterNo));// 가스레인지
			pMap.put("sofa", arr.get(FILTER_SETTING.SOFA.filterNo));// 소파
			pMap.put("bed", arr.get(FILTER_SETTING.BED.filterNo));// 침대
			pMap.put("built_in_closet", arr.get(FILTER_SETTING.BUILT_IN_CLOSET.filterNo));// 붙박이장
			pMap.put("dressing_table", arr.get(FILTER_SETTING.DRESSING_TABLE.filterNo));// 화장대
			pMap.put("veranda", arr.get(FILTER_SETTING.VERANDA.filterNo));// 베란다
			pMap.put("shoe_closet", arr.get(FILTER_SETTING.SHOE_CLOSET.filterNo));// 신발장
			pMap.put("door_security", arr.get(FILTER_SETTING.DOOR_SECURITY.filterNo));// 현관보안
			pMap.put("cctv", arr.get(FILTER_SETTING.CCTV.filterNo));// cctv
			pMap.put("number_key", arr.get(FILTER_SETTING.NUMBER_KEY.filterNo));// 자동번호키

			// 기타옵션
			pMap.put("elevator", arr.get(FILTER_SETTING.ELEVATOR.filterNo));// 엘리베이터
			pMap.put("parking", arr.get(FILTER_SETTING.PARKING.filterNo));// 주차가능
			pMap.put("animal", arr.get(FILTER_SETTING.ANIMAL.filterNo));// 반려동물
			pMap.put("empty", arr.get(FILTER_SETTING.EMPTY.filterNo));// 공실
			pMap.put("sale", arr.get(FILTER_SETTING.SALE.filterNo));// 매물

			// resource 영상 유무
			pMap.put("pic_keep", arr.get(FILTER_SETTING.PIC_KEEP.filterNo));// 사진있음
			pMap.put("pic_none", arr.get(FILTER_SETTING.PIC_NONE.filterNo));// 사진없음
			pMap.put("movie_keep", arr.get(FILTER_SETTING.MOVIE_KEEP.filterNo));// 동영상있음
			pMap.put("movie_none", arr.get(FILTER_SETTING.MOVIE_NONE.filterNo));// 동영상없음

			/*logger.debug("filter information -- >");
			Set key = pMap.keySet();
			for (Iterator iterator = key.iterator(); iterator.hasNext();) {
				String keyName = (String) iterator.next();
				String valueName = (String) pMap.get(keyName);
				logger.debug(keyName + " = " + valueName);
			}*/
			return pMap;
		}
	public static enum FILTER_SETTING {
		// 거래 종류
		TRADE(0), // 매매
		CHARTER(1), // 전세
		MONTHLY_AND_CHARTER(2), // 전월세
		MONTYLY(3), // 월세
		SHORT_LEASE(4), // 단기임대

		// 금액
		DEPOSITMIN(5), // 보증금 최소
		DEPOSITMAX(6), // 보증금 최대
		MONTHMIN(7), // 월세 최소
		MONTHMAX(8), // 월세 최대
		CHARTERMIN(9), // 전세 최소
		CHARTERMAX(10), // 전세 최대
		STANDARDMIN(11), // 기준가 최소
		STANDARDMAX(12), // 기준가 최대

		// 건물형태
		APARTMENT(13), // 아파트
		OFFICETEL(14), // 이벤트
		HOUSE(15), // 주택
		NORMAL_ROOM(16), // 원룸
		SHOP(17), // 상가
		OFFICE(18), // 오피스텔
		BUILDING(19), // 건물
		REDEVELOPMENT(20), // 재개발
		EVENT(21), // 이벤트

		BUILT(22), // 준공년도
		ADDRESS(23), // 번지

		// 방 형태 room_type로 매칭
		OPEN_ROOM(24), // 오픈형
		PART_ROOM(25), // 분리형
		DUPLEX_ROOM(26), // 복층형

		// 룸개수 room_count
		OND_ROOM(27), TRO_ROOM(28), THREE_ROOM(29),

		// 방위치
		UP_GROUND(30), // 지상
		UNDER_GROUND(31), // 지하
		SEMI_BASEMENT(32), // 반지하
		ROOFTOP(33), // 옥탑방

		// 면적
		EXCLUSIVE_AREA_MIN(34), // 전용면적 최소
		EXCLUSIVE_AREA_MAX(35), // 전용면적 최대
		LEASED_AREA_MIN(36), // 공급면적 최소
		LEASED_AREA_MAX(37), // 공급면적 최대

		// 옵션
		FULL_OPTION_ROOM(38), // 풀옵션
		AIRCONDITIONER(39), // 에어컨
		REFRIGERATO(40), // 냉장고
		WASHER(41), // 세탁기
		TV(42), // tv
		MICROWAVE(43), // 전자레인지
		INDUCTION(44), // 인덕션
		SINK(45), // 싱크대
		GASRANGE(46), // 가스레인지
		SOFA(47), // 소파
		BED(48), // 침대
		BUILT_IN_CLOSET(49), // 붙박이장
		DRESSING_TABLE(50), // 화장대
		VERANDA(51), // 베란다
		SHOE_CLOSET(52), // 신발장

		// 기타옵션
		DOOR_SECURITY(53), // 현관보안
		CCTV(54), // cctv
		NUMBER_KEY(55), // 자동번호키
		ELEVATOR(56), // 엘리베이터
		PARKING(57), // 주차가능
		ANIMAL(58), // 반려동물
		EMPTY(59), // 공실
		SALE(60), // 매물

		// resource 유무
		PIC_KEEP(61), // 사진있음
		PIC_NONE(62), // 사진없음
		MOVIE_KEEP(63), // 동영상있음
		MOVIE_NONE(64); // 동영상없음

		private int filterNo;

		private FILTER_SETTING(int filterNo) {
			this.filterNo = filterNo;
		}
		public int getFilterName() {
			return filterNo;
		}
	}
}
