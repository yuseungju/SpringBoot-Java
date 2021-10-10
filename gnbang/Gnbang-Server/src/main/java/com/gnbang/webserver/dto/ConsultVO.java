package com.gnbang.webserver.dto;

import com.gnbang.webserver.pojo.LoggableElement;

/*
-- consult
CREATE TABLE `consult` (
	`no`               INT(11)     NOT NULL, 
	`type`             TINYINT(4)  NULL,   
	`room_item_no`     INT(11)     NULL,  
	`deposit_min`      INT(11)     NULL,    
	`deposit_max`      INT(11)     NULL,   
	`monthly_rent_min` INT(11)     NULL,    
	`monthly_rent_max` INT(11)     NULL,  
	`phone`            VARCHAR(20) NULL,     
	`user_no`          INT(11)     NULL,    
	`comment`          TEXT        NULL,    
	`agent_no`         INT(11)     NULL,     
	`date`             TIMESTAMP   NULL     DEFAULT 	CURRENT_TIMESTAMP 
);*/
public class ConsultVO extends LoggableElement{
	int no;
	short type;
	int room_item_no;// 매물(방)번호
	int deposit_min;
	int deposit_max;
	int monthly_rent_min;
	int monthly_rent_max;
	String phone;// 상담받는사람의 연락처
	int user_no;// 상담받는사람
	String comment;// 상담시간
	int agent_no;
	String date;// 상담요청 시간

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public short getType() {
		return type;
	}

	public void setType(short type) {
		this.type = type;
	}

	public int getRoom_item_no() {
		return room_item_no;
	}

	public void setRoom_item_no(int room_item_no) {
		this.room_item_no = room_item_no;
	}

	public int getDeposit_min() {
		return deposit_min;
	}

	public void setDeposit_min(int deposit_min) {
		this.deposit_min = deposit_min;
	}

	public int getDeposit_max() {
		return deposit_max;
	}

	public void setDeposit_max(int deposit_max) {
		this.deposit_max = deposit_max;
	}

	public int getMonthly_rent_min() {
		return monthly_rent_min;
	}

	public void setMonthly_rent_min(int monthly_rent_min) {
		this.monthly_rent_min = monthly_rent_min;
	}

	public int getMonthly_rent_max() {
		return monthly_rent_max;
	}

	public void setMonthly_rent_max(int monthly_rent_max) {
		this.monthly_rent_max = monthly_rent_max;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getAgent_no() {
		return agent_no;
	}

	public void setAgent_no(int agent_no) {
		this.agent_no = agent_no;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
}
