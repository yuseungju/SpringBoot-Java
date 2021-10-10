package com.gnbang.webserver.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.gnbang.webserver.dto.AdminInformationModifyVO;
import com.gnbang.webserver.dto.ConsultVO;
import com.gnbang.webserver.dto.ContractCompleteVO;
import com.gnbang.webserver.dto.LessorPhoneHistoryVO;
import com.gnbang.webserver.dto.NoteVO;
import com.gnbang.webserver.dto.RecentlyVO;
import com.gnbang.webserver.dto.RoomFakeReportVO;
import com.gnbang.webserver.dto.RoomItemCartListVO;
import com.gnbang.webserver.dto.RoomItemCartVO;
import com.gnbang.webserver.dto.RoomPhoneHistoryVO;
import com.gnbang.webserver.dto.RoomPhotoVO;
import com.gnbang.webserver.dto.SpecificRoomItemVO;
import com.gnbang.webserver.dto.UserVO;
import com.gnbang.webserver.dto.ZzimVO;
import com.gnbang.webserver.object.Address;
import com.gnbang.webserver.object.CartUser;
import com.gnbang.webserver.object.CartUserDetail;
import com.gnbang.webserver.object.EnrolledRoom;
import com.gnbang.webserver.object.LessorInfor;
import com.gnbang.webserver.object.NoteComment;
import com.gnbang.webserver.object.SearchRoomDetail;
import com.gnbang.webserver.object.SearchRoomSumary;

public interface RoomMapper {
	
	//방 상세보기의  메인 정보
	SearchRoomDetail getDetailRoomAboutRoomNo(@Param("no") Integer no);//해당되는 방번호의 상세정보를 가져온다
	String getManageName(@Param("roomNo") Integer roomNo);//방등록한 중개사회원의 이름을 가져옴
	String getManagePhone(@Param("roomNo") Integer roomItemNo);//방등록한 중개사회원의 연락처를 가져옴
	String getPhotoManageName(@Param("roomNo") Integer roomNo);//방사진을 최초로 등록한 중개사회원의 이름을 가져옴
	String getPhotoManagePhone(@Param("roomNo") Integer roomItemNo);//방사진을 최초로 등록한 중개사회원의 연락처를 가져옴

	//찜
	//찜 추가 삭제
	void addZzim(ZzimVO zzimVO);//찜추가
	void delZzim(ZzimVO zzimVO);//찜삭제
	//찜 검색
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutGeoZzim(@Param("s") String s, @Param("w") String w, @Param("n") String n, @Param("e") String e, @Param("userNo") Integer userNo,
			@Param("sort") String sort, @Param("pg") Integer pg, @Param("roomNumPerPage") Integer roomNumPerPage);//회원의 찜매물 가져옴
	Integer getCountRoomAboutGeoZzim(@Param("s") String s, @Param("w") String w, @Param("n") String n, @Param("e") String e, @Param("userNo") Integer userNo);//회원의 찜매물의 개수 가져옴
	//매물에대한 찜수를 가져옴
	Integer getCountInZzimAboutRoomItemNo(@Param("room_item_no") Integer roomItemNo);
	
	//조회수 
	void updateReadCntInSpeicificRoomItem(@Param("read_cnt") Integer readCount, @Param("room_item_no") Integer roomItemNo);//조회수를 수정한다.
	Integer getReadCntInSpeicificRoomItemAboutRoomNo(@Param("room_item_no") Integer roomItemNo);//매물번호에 해단되는 조회수를 가져온다.
	
	//최근본방
	//최근본방추가
	Integer getCountRecently(@Param("loginNo") Integer loginNo);//회원의 최근기록 개수를 가져옴
	void addRecently(RecentlyVO recentlyVO);//최근본방을 추가(회원번호, 매물번호)
	void deleteRecently(RecentlyVO recentlyVO);//최근본방을 삭제(회원번호, 매물번호)
	void deleteRecentlyAboutOldest(@Param("loginNo") Integer loginNo);//회원의 최근기록중 가장오랜된 행을 삭제

	//최근본방 검색
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutGeoRecently(@Param("s") String s, @Param("w") String w, @Param("n") String n, @Param("e") String e, @Param("userNo") Integer userNo,
			@Param("sort") String sort, @Param("pg") Integer pg, @Param("roomNumPerPage") Integer roomNumPerPage);//회원의 최근본방을 가져옴
	Integer getCountRoomAboutGeoRecently(@Param("s") String s, @Param("w") String w, @Param("n") String n, @Param("e") String e, @Param("userNo") Integer userNo);//회원의 최근본방의 검색결과수를 가져옴
		
	//코멘트
	ArrayList<NoteComment> getCommentAboutRoomNo(Integer no);//해당되는 방번호의 코멘트들을 가져온다.(중개사의 이름도 포함)
	NoteVO getCommentAboutUserNoAndRoomItemNo(@Param("userNo") Integer userNo,
			@Param("roomItemNo") Integer roomItemNo);//해당되는 방번호와 중개사번호의 코멘트들을 가져온다.
	void insertComment(NoteVO noteVO);//코멘트의 정보로 코멘트 추가(방번호/중개사번호/코멘트내용)
	
	//방정보 수정내역 
	void insertModifyContent(AdminInformationModifyVO adminInformationModifyVO);//수정요청내역으로 수정내역 추가.
	AdminInformationModifyVO getModifyContent(AdminInformationModifyVO adminInformationModifyVO);//해당되는 중개사번호로 수정요청내역을 가져옴 
	void updateModifyContent(AdminInformationModifyVO adminInformationModifyVO);//수정요청내역으로 수정내역 수정
	
	//고객정보 (관심매물)
	RoomItemCartListVO getCartListAdoutNameAndAgentNo(RoomItemCartListVO roomItemCartListVO);//이름과 전화번호 담당 중개사가 같은 관심고객정보를 가져옴
	ArrayList<UserVO> getUserNameAndPhone(UserVO userVO);//name과 phone가 포함되는 회원 get
	ArrayList<CartUser> getRoomItemCartListUser(@Param("agentNo") Integer agentNo);//중개사번호로 등록시킨 관심고객정보를 방의 간략한 정보와 함께  가져옴
	ArrayList<CartUserDetail> getCartUserDetailAboutCartUserListNoAndUserNo(@Param("agentNo") Integer agentNo, @Param("roomItemCartListNo") Integer roomItemCartListNo);//중개사번호로 등록시킨 관심고객폴더 하나에 대한 방상세정보를 가져옴
	void insertRoomItemCartList(RoomItemCartListVO roomItemCartListVO);//고객(관심매물폴더) 정보 추가
	void updateAgentNoInRoomItemCartList(@Param("no") Integer no, @Param("agentNo") Integer agentNo);//고객(관심매물폴더)에 매핑되는 중개사를 바꿈(고객폴더는유지)
	ArrayList<RoomItemCartListVO> getRoomItemListAboutAgentNo(Integer agentNo);//해당 중개사에 존재하는 모든 관심폴더 정보들을 가져옴
	void updateCartUserAboutCartListNo(RoomItemCartListVO roomItemCartListVO);//해당 고객폴더의 정보를 수정 
	Integer getCountCartUserAboutCartUserListNo(@Param("roomItemCartListNo") Integer roomItemCartListNo);//하나의 폴더에 해당되는 관심매물수를 가져옴
	void insertRoomItemCart(RoomItemCartVO roomItemCartVO);//관심매물폴더에 관심매물 내용 추가 (관심고객의 정보번호와 괌심매물번호 추가)
	void deleteRoomItemCart(@Param("no") Integer no);//고객(관심매물폴더)에 있는 관심매물삭제
	RoomItemCartVO getRoomItemCartAboutRoomItemCartNoAndRoomNo(RoomItemCartVO roomItemCartVO);//매물번호와 고객정보가 일치하는 관심매물  get 

	//계약 완료
	void insertCompleteContract(ContractCompleteVO contractComplete);//계약등록
	SpecificRoomItemVO getSpecificRoomItem(Integer roomItemNo);//방번호로 매물상태인 현재 매물정보를 가져옴
	void addSpecificRoomItemPrev(Integer specificRoomItemNo);//현재 매물정보를 이전 매물정보로 저장
	void removeSpecificRoomItem(Integer specificRoomItemNo);//현재매물정보를 삭제

	//임대인 연락처
	void insertLessorPhoneHistory(LessorPhoneHistoryVO lessorPhoneHistoryVO);
	LessorInfor getSepcificRoomItemAboutItemNo(Integer roomItemNo);	
	
	//매물담당 연락처 
	void insertAllInfroInRoomPhoneHistory(@Param("loginNo") Integer loginNo, @Param("roomNo") Integer roomNo);//연락처확인 내역 기록
	RoomPhoneHistoryVO getNoInRoomPhoneHistoryAboutRoomNoAndLoginNo(@Param("loginNo") Integer loginNo,  @Param("roomNo") Integer roomNo);//연락처확인 내역 기록을 매물번호와 회원번호로 가져옴
	
	//허위 매물 신고
	void insertRoomFakeReport(RoomFakeReportVO roomFakeReport);//신고 추가
	RoomFakeReportVO getFakeContent(RoomFakeReportVO roomFakeReportVO);//신고 정보 가져오기
	void updateRoomFakeReport(RoomFakeReportVO roomFakeReport);//신고 내역 업데이트

	//상담신청
	ConsultVO getConsult(ConsultVO consultVO);//상담신청내역 가져오기
	void insertConsult(ConsultVO consultVO);//상담신청하기

	//사진등록
	void insertRoomPhoto(RoomPhotoVO roomPhotoVO);//사진저장

	//검색시에 가져올 추가 정보
	Integer getZzimNo( @Param("no") Integer no, @Param("loginNo") Integer loginNo);//회원의 매물번호에 맞는 찜번호를 가져옴
	ArrayList<String> getFakeUrlList(Integer no);//매물번호에 맞는 사진 경로를 가져옴
	ArrayList<String> getPhotoEnrollDateList(Integer no);//매물번호에 맞는 사진 등록날짜를 가져옴
	
	//중개사의 매물검색(상세)
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutAgent(@Param("metro_no") String metro_no, @Param("addr")  String addr, @Param("room_no")  String room_no,
			@Param("sector_code") String sector_code,	@Param("agentNo")  Integer agentNo, @Param("pMap") HashMap<String, String> pMap, @Param("sort") String sort, @Param("pg") Integer pg ,  @Param("roomNumPerPage") Integer roomNumPerPage);
	Integer getCountRoomAboutAgent(@Param("metro_no") String metro_no, @Param("addr")  String addr, @Param("room_no")  String room_no,
			@Param("sector_code") String sector_code,	@Param("agentNo")  Integer agentNo, @Param("pMap") HashMap<String, String> pMap);//중개사가 가지고있는 방들의 필터 검색결과 수

	//중개사의 방등록 
	void insertRoomItem(EnrolledRoom enrolledRoom);//방의 기본정보등록 
	void insertSpecificRoomItem(EnrolledRoom enrolledRoom);//매물정보 등록
	Integer getRoomItemNo();//최근등록한 방번호를 가져옴
	Integer getMetroNo(String metroName);//지하철 이름에 해당되는 지하철 번호를 가져온다
	Integer getSectionNo(String sectionName);//섹션 이름에 해당되는 섹션 번호를 가져온다
	Integer getUserNoAboutRoomNo(@Param ("item_no") Integer item_no);//방번호에 해당되는 중개사의 번호를 가져옴
	Integer getPhotoCount(@Param("room_item_no") Integer room_item_no);//방번호에 해당되는 이미지의 수를 가져옴

	//방삭제 
	void deleteRoomItemAboutNo(@Param("roomItemNo") Integer roomItemNo);//매물번호에 해당되는 매물삭제
	void deleteRoomPhotoAboutRoomItemNo(@Param("roomItemNo") Integer roomItemNo);//매물번호에 해당되는 사진경로삭제
	void removeSpecificRoomItemAboutAgentNo(@Param("agentNo") Integer agentNo);//로그인한 중개사가 등록한 방상세정보를 삭제
	void deleteRoomItemAboutAgentNo(@Param("agentNo") Integer agentNo);//로그인한 중개사가 등록한 매물정보를 삭제
	void deleteRoomPhotoAboutAgentNo(@Param("agentNo") Integer agentNo);//로그인한 중개사가 등록한 모든 사진경로를 삭제
	
	//주소찾기 등록  페이지
	long getAddressCode(Address address);//시 구 동에 해당되는 주소코드를 가져옴
	ArrayList<Address> getAddressListInSpecificRoomItem(Address address);//주소코드/번지수가 같은 방이 존재하면 주소들을 가져옴

	//중개사의 사진관리
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutPhotoLimit1Day(@Param("agentNo") Integer agentNo, @Param("pg") Integer pg, @Param("roomNumPerPage") Integer roomNumPerPage);//중개사가 사진 등록한 사진 수정가능한 매물을 가져옴
	Integer getCountRoomAboutPhotoLimit1Day(@Param("agentNo") Integer agentNo);//중개사가 사진 등록한 사진 수정가능한 매물의 총 개수를 가져옴
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutPhoto(@Param("agentNo") Integer agentNo, @Param("pg") Integer pg, @Param("roomNumPerPage") Integer roomNumPerPage);//중개사가 사진 등록한  매물을 가져옴
	Integer getCountRoomAboutPhoto(@Param("agentNo") Integer agentNo);//중개사가 사진 등록한  매물의 총 개수를 가져옴
	boolean timeIsIn1Day(@Param("date") String date);//날짜가 하루차이 미만인지 확인
	ArrayList<RoomPhotoVO> getPhotoAboutRoomNo(@Param("room_no") Integer room_no);//하나의 매물에 등록한 사진정보들을 가져옴
	void updateRoomPhotoOrder(@Param("no") Integer no, @Param("order") Integer order);//사진번호를 찾아 해당사진의 순서를 수정
	void deleteRoomPhoto(@Param("no") Integer no);//사진번호를 찾아 사진경로삭제
	Integer getRoomItemNoAboutPhotoNo(@Param("photoNo") Integer  photoNo);//사진이 등록돼있는 매물번호를 가져옴
	Integer getCountPhotoAboutItemNo(@Param("itemNo") Integer  itemNo);//매물번호에 저장된 사진의 개수를 가져옴
	void updatePhotoOpenInRoomSpecificItemAboutItemNo(@Param("itemNo") Integer itemNo, @Param("photoOpen") Integer  photoOpen);//매물번호에 해당되는 방상세정보의 사진여부를 변경
	void updatePhotoInRoomItemAboutItemNo(@Param("itemNo") Integer itemNo, @Param("photo") Integer  photo);//매물번호에 해당되는 방상세정보의 사진여부를 변경



} 