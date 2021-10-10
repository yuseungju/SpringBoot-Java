package com.gnbang.webserver.dto;
/*CREATE TABLE `recently` (
		`no`           INT(11)   NOT NULL, 
		`user_no`      INT(11)   NULL,    
		`room_item_no` INT(11)   NULL,   
		`date`         TIMESTAMP NULL     DEFAULT 	CURRENT_TIMESTAMP 
);*/

public class RecentlyVO {
	int no;//최근본방 고유 키값
	int user_no;// 회원번호
	int room_item_no;// 매문번호
	String date;//매물은 확인한 날짜

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
}
