package com.gnbang.webserver.dto;

import com.gnbang.webserver.pojo.LoggableElement;

/*  metro 테이블
CREATE TABLE `metro` (
	`no`   INT         NOT NULL, -- 지하철역 고유번호
	`name` VARCHAR(10) NULL      -- 지하철 역이름
);
 */
public class MetroVO extends LoggableElement {
	int no;//지하철역의 고유 번호(key)
	String name;//지하철역의 이름

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
}
