package com.gnbang.webserver.dto;

/*
 * CREATE TABLE `room_item_cart` (
		`no`                     INT(11) NOT NULL, -- 새 컬럼2
		`room_item_cart_list_no` INT(11) NULL,     -- 새 컬럼
		`room_item_no`           INT(11) NULL      -- 새 컬럼3
	);
*/
public class RoomItemCartVO {
	int no;// cart고유번호(key)
	int room_item_cart_list_no;//매물 관심고객 정보 번호(admin_information_modify 테이블의key)
	int room_item_no;// 매물번호

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getRoom_item_cart_list_no() {
		return room_item_cart_list_no;
	}

	public void setRoom_item_cart_list_no(int room_item_cart_list_no) {
		this.room_item_cart_list_no = room_item_cart_list_no;
	}

	public int getRoom_item_no() {
		return room_item_no;
	}

	public void setRoom_item_no(int room_item_no) {
		this.room_item_no = room_item_no;
	}
}
