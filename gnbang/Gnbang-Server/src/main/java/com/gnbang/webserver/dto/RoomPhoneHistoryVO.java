package com.gnbang.webserver.dto;
/*TABLE `room_phone_history`
   `no`            INT(11)     NOT NULL,  -- 기본키
   `user_no`       INT(11)      NULL,     -- 회원번호
   `room_item_no`  INT(11)      NULL,     -- 매물번호
   `date`          TIMESTAMP    NULL     DEFAULT    CURRENT_TIMESTAMP*/
	
public class RoomPhoneHistoryVO {
	Integer no;//기본키 
	Integer user_no;//회원 번호
	Integer room_item_no;// 매물 번호
	String date;//매물 담당 연락처 확인 날짜 
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Integer getUser_no() {
		return user_no;
	}
	public void setUser_no(Integer user_no) {
		this.user_no = user_no;
	}
	public Integer getRoom_item_no() {
		return room_item_no;
	}
	public void setRoom_item_no(Integer room_item_no) {
		this.room_item_no = room_item_no;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
