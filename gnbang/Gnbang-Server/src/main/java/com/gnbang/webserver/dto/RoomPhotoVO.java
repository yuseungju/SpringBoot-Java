package com.gnbang.webserver.dto;

/*CREATE TABLE `room_photo` (
		`no`           INT(11)      NOT NULL, -- 새 컬럼
		`user_no`      INT(11)      NULL,     -- no
		`room_item_no` INT(11)      NULL,     -- 새 컬럼7
		`comment`      TEXT         NULL,     -- 새 컬럼2
		`original_url` VARCHAR(200) NULL,     -- 새 컬럼3
		`fake_url`     VARCHAR(200) NULL,     -- 새 컬럼6
		`date`         TIMESTAMP    NULL     DEFAULT 	CURRENT_TIMESTAMP, -- 새 컬럼4
		`is_use`       TINYINT(1)   NULL      -- 새 컬럼5
	);*/
public class RoomPhotoVO {
	int no;//사진 key
	int user_no;//중개사번호
	int room_item_no;//방번호
	String comment;
	String original_url;//경로저장 
	String fake_url;
	String date;//등록날짜
	short is_use;
	int order;//사진순서
	
	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
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

	public int getRoom_item_no() {
		return room_item_no;
	}

	public void setRoom_item_no(int room_item_no) {
		this.room_item_no = room_item_no;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getOriginal_url() {
		return original_url;
	}

	public void setOriginal_url(String original_url) {
		this.original_url = original_url;
	}

	public String getFake_url() {
		return fake_url;
	}

	public void setFake_url(String fake_url) {
		this.fake_url = fake_url;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public short getIs_use() {
		return is_use;
	}

	public void setIs_use(short is_use) {
		this.is_use = is_use;
	}
}
