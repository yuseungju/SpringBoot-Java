package com.gnbang.webserver.dto;

import com.gnbang.webserver.pojo.LoggableElement;

public class RoleVO extends LoggableElement {
	/*
	 * Role 테이블 `no` INT(11) NOT NULL, -- 새 컬럼 `user_no` INT(11) NULL, -- no
	 * `role_list_no` INT(11) NULL
	 */
	int no;//권한번호
	int user_no;//사용자의 번호(user테이블의 고유번호 key)
	int role_list_no;//권한 리스트의 번호(rile_list의 고유 번호key)

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

	public int getRole_list_no() {
		return role_list_no;
	}

	public void setRole_list_no(int role_list_no) {
		this.role_list_no = role_list_no;
	}
}
