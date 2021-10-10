package com.gnbang.webserver.dto;

import com.gnbang.webserver.pojo.LoggableElement;

/*
 * CREATE TABLE `admin_information_modify` (
		`no`      INT(11)    NOT NULL, -- 새 컬럼
		`user_no` INT(11)    NULL,     -- no
		`date`    TIMESTAMP  NULL     DEFAULT 	CURRENT_TIMESTAMP, -- 새 컬럼2
		`check`   TINYINT(1) NULL,     -- 새 컬럼3
		`text`    TEXT       NULL      -- 새 컬럼4
	);*/
public class AdminInformationModifyVO extends LoggableElement{
	int no;// 수정내역 고유번호 key
	int user_no;// 수정내역 요청한 중개사
	String date;// 수정내역 추가시간
	short check;
	int room_no;//매물번호
	String text;// 수정내역 ex)금액을 수정해주세요 : : 기타 : 사진을수정해주세요 : ....

	
	public int getRoom_no() {
		return room_no;
	}

	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}

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

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public short getCheck() {
		return check;
	}

	public void setCheck(short check) {
		this.check = check;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
}
