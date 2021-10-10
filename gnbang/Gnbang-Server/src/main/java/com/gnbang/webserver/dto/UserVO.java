package com.gnbang.webserver.dto;

import com.gnbang.webserver.pojo.LoggableElement;

/* User테이블 
    `no`        INT(11)      NOT NULL, -- no
	`level`     INT(11)      NULL,     -- level
	`type`      INT(11)      NULL,     -- type
	`password`  VARCHAR(100) NULL,     -- password
	`name`      VARCHAR(20)  NULL,     -- name
	`email`     VARCHAR(50)  NULL,     -- email
	`phone`     VARCHAR(20)  NULL,     -- phone
	`date`      TIMESTAMP    NULL     DEFAULT 	CURRENT_TIMESTAMP, -- date
	`agreement` BOOL         NULL      -- agreement
*/

public class UserVO extends LoggableElement {
	int no;
	int level;
	int type;
	String password;
	String name;
	String email;
	String phone;
	String date;
	String photo_url;//프로필 사진경로
	boolean agreement;

	
	public String getPhoto_url() {
		return photo_url;
	}

	public void setPhoto_url(String photo_url) {
		this.photo_url = photo_url;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public boolean getAgreement() {
		return agreement;
	}

	public void setAgreement(boolean agreement) {
		this.agreement = agreement;
	}
}
