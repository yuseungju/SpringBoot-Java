package com.gnbang.webserver.dto;

/*
 * CREATE TABLE `lessor_phone_history` (
		`no`           INT(11)   NOT NULL, -- 새 컬럼
		`user_no`      INT(11)            NULL,     -- no
		`cart_list_no` INT(11)            NULL,     -- 새 컬럼2
		`room_item_no` INT(11)            NULL,     -- 새 컬럼4
		`date`         TIMESTAMP          NOT NULL DEFAULT 	CURRENT_TIMESTAMP -- 새 컬럼3
	);*/
public class LessorPhoneHistoryVO {
	int no;
	int user_no;// 중개사번호
	int cart_list_no;// 고객번호
	int room_item_no;// 매물번호
	String date;// 연락처 확인 날짜

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

	public int getCart_list_no() {
		return cart_list_no;
	}

	public void setCart_list_no(int cart_list_no) {
		this.cart_list_no = cart_list_no;
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
