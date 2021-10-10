package com.gnbang.webserver.dto;

/*
 * CREATE TABLE `contract_complete` (
		`no`           INT(11)    NOT NULL, 
		`user_no`      INT(11)    NULL,    
		`room_item_no` INT(11)    NULL,    
		`check`        TINYINT(1) NULL,     
		`date`         TIMESTAMP  NOT NULL DEFAULT 	CURRENT_TIMESTAMP 
	);*/
public class ContractCompleteVO {
	int no;// 계약 고유번호
	int user_no;// 중개사번호(거래한 중개사)
	int room_item_no;// 매물번호
	short check;// 계약상태
	String date;// 게약날짜

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

	public short getCheck() {
		return check;
	}

	public void setCheck(short check) {
		this.check = check;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
}
