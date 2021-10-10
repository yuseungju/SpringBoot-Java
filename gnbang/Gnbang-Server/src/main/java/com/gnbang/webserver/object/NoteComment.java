package com.gnbang.webserver.object;

/*  방상세보기에서의 코멘트
  note와 user 테이블의 조인값 
  
		1.note 테이블
		`no`           INT(11)   NOT NULL, -- 새 컬럼
		`user_no`      INT(11)   NULL,     -- no
		`room_item_no` INT(11)   NULL,     -- 새 컬럼4
		`text`         TEXT      NULL,     -- 새 컬럼2
		`date`         TIMESTAMP NULL     DEFAULT 	CURRENT_TIMESTAMP -- 새 컬럼3
	
		2.user` 테이블
		`name`      VARCHAR(20)  NULL,     -- name
);
*/

public class NoteComment {
	int no;// 작성번호
	int user_no;// 작성자번호
	int room_item_no;// 매물 번호
	String text;// 코멘트내용
	String date;// 작성날짜
	String name;// 작성자 이름
	String phone;// 연락처

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
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

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
