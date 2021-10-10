package com.gnbang.webserver.dto;
/*section 테이블
		`no`    INT         NOT NULL, -- no
		`gu`    VARCHAR(10) NULL,     -- 새 컬럼
		`name`  VARCHAR(20) NULL,     -- name
		`shape` TEXT        NULL      -- shape
);*/
public class SectorVO {
	int no;//섹터번호
	String gu;//섹터  분류 이름 (섹터구)
	String name;//섹터 구분 이름 (섹터동)
	String shape;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getGu() {
		return gu;
	}
	public void setGu(String gu) {
		this.gu = gu;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getShape() {
		return shape;
	}
	public void setShape(String shape) {
		this.shape = shape;
	}
}
