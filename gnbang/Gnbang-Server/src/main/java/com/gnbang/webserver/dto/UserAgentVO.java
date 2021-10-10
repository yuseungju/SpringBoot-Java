package com.gnbang.webserver.dto;

import com.gnbang.webserver.pojo.LoggableElement;

/* User_agent테이블
	`no`                            INT(11)      NOT NULL, -- no
	`name`                          VARCHAR(20)  NULL,     -- name
	`corporate_registration_number` VARCHAR(20)  NULL,     -- corporate_registration_number
	`representative`                VARCHAR(20)  NULL,     -- representative
	`address`                       VARCHAR(200) NULL,     -- address
	`phone`                         VARCHAR(20)  NULL,     -- phone
	`user_no`                       INT(11)      NULL      -- user_no
*/
public class UserAgentVO extends LoggableElement {
	int no;
	String name;
	String corporate_registration_number;
	String representative;
	String address;
	String phone;//연락처
	int user_no;//회원번호(user테이블 key값)
	int level;//중개사 직책/직급 
	String mac_address;//즁개사의 사용가능pc 맥주소
	
	public String getMac_address() {
		return mac_address;
	}

	public void setMac_address(String mac_address) {
		this.mac_address = mac_address;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCorporate_registration_number() {
		return corporate_registration_number;
	}

	public void setCorporate_registration_number(String corporate_registration_number) {
		this.corporate_registration_number = corporate_registration_number;
	}

	public String getRepresentative() {
		return representative;
	}

	public void setRepresentative(String representative) {
		this.representative = representative;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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
}
