package com.gnbang.webserver.dto;

/*
 * CREATE TABLE `room_item_cart_list` (
		`no`        INT(11)     NOT NULL, 
		`user_no`   INT(11)     NOT NULL, 
		`client_no` INT(11)     NULL,    
		`name`      VARCHAR(50) NULL,     
		`phone`     VARCHAR(50) NULL,   
		`explain`   TEXT        NULL,    
		`date`      TIMESTAMP   NOT NULL DEFAULT 	CURRENT_TIMESTAMP 
	);*/
public class RoomItemCartListVO {
	int no;//key값
	int user_no;//회원시에만 값설정 : 관심 고객의 회원번호(user 테이블의 no)
	int client_no;
	String name;//관심고객명+연락처
	String phone;
	String explain;//고객설명
	String date;//등록날짜

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

	public int getClient_no() {
		return client_no;
	}

	public void setClient_no(int client_no) {
		this.client_no = client_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getExplain() {
		return explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}
