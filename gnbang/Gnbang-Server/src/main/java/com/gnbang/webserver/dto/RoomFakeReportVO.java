package com.gnbang.webserver.dto;

/*-- room_fake_report
CREATE TABLE `room_fake_report` (
	`no`           INT(11)   NOT NULL, 
	`user_no`      INT(11)   NULL,     
	`room_item_no` INT(11)   NULL,    
	`date`         TIMESTAMP NULL     DEFAULT 	CURRENT_TIMESTAMP
	`text`         TEXT      NULL     
);*/
public class RoomFakeReportVO {
	int no;// 허위 매물번호 (key)
	int user_no; // 신고한 회원번호
	int room_item_no;// 신고당한 매물번호
	String date;// 신고날짜
	String text;// 신고 내역 ( ':' 구분자사용하여 보관 )

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getRoom_item_no() {
		return room_item_no;
	}

	public void setRoom_item_no(int room_item_no) {
		this.room_item_no = room_item_no;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
}
