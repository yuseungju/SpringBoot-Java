package com.gnbang.webserver.dto;
/*
 * TABLE `note` (
	`no`           INT(11)   NOT NULL, 
	`user_no`      INT(11)   NULL,  
	`room_item_no` INT(11)   NULL,  
	`text`         TEXT      NULL,  
	`date`         TIMESTAMP NULL     DEFAULT 	CURRENT_TIMESTAMP
*/
public class NoteVO {
	int no;//코멘트 고유번호 key
	int user_no;//코멘트 작성 중개사 번호(중개사 고유 번호 key)
	int room_item_no;//코멘트 해당되는 매물(방)의 번호(방의 고유번호 key)
	String text;//코멘트 내용
	String date;//코멘트 작성 시간

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

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}
