package com.gnbang.webserver.dto;

/*  room_item 테이블
		`no`               INT(11)     NOT NULL, -- 새 컬럼
		`local_code`       BIGINT(12)  NULL,     -- 새 컬럼2
		`main_address`     INT(11)     NULL,     -- 새 컬럼3
		`sub_address`      INT(11)     NULL,     -- 새 컬럼4
		`last_address`     VARCHAR(50) NULL,     -- 새 컬럼5
		`new_address`      VARCHAR(50) NULL,     -- 새 컬럼6
		`building_address` VARCHAR(50) NULL,     -- 새 컬럼7
		`lat`              FLOAT       NULL,     -- 새 컬럼8
		`lng`              FLOAT       NULL,     -- 새 컬럼9
		`metro1`           INT(11)     NULL,     -- 새 컬럼10
		`metro2`           INT(11)     NULL,     -- 새 컬럼11
		`metro3`           INT(11)     NULL,     -- 새 컬럼12
		`metro4`           INT(11)     NULL,     -- 새 컬럼13
		`metro5`           INT(11)     NULL,     -- 새 컬럼14
		`section_no`       INT         NULL      -- no
*/
public class RoomItemVO {
	int no;//매물 방의 고유번호 (key)
	long local_code;//주소 코드(address_code테이블의 고유번호 key)
	int main_address;
	int sub_address;//번지수의 처음(- 이전)
	String last_address;//번지수의 끝(- 이후)
	String new_address;
	String building_address;
	float lat;//위도
	float lng;//경도
	int metro1;//인근지하철역 1
	int metro2;//인근지하철역 2
	int metro3;//인근지하철역 3
	int metro4;//인근지하철역 4
	int metro5;//인근지하철역 5
	int section_no;

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public long getLocal_code() {
		return local_code;
	}

	public void setLocal_code(long local_code) {
		this.local_code = local_code;
	}

	public int getMain_address() {
		return main_address;
	}

	public void setMain_address(int main_address) {
		this.main_address = main_address;
	}

	public int getSub_address() {
		return sub_address;
	}

	public void setSub_address(int sub_address) {
		this.sub_address = sub_address;
	}

	public String getLast_address() {
		return last_address;
	}

	public void setLast_address(String last_address) {
		this.last_address = last_address;
	}

	public String getNew_address() {
		return new_address;
	}

	public void setNew_address(String new_address) {
		this.new_address = new_address;
	}

	public String getBuilding_address() {
		return building_address;
	}

	public void setBuilding_address(String building_address) {
		this.building_address = building_address;
	}

	public float getLat() {
		return lat;
	}

	public void setLat(float lat) {
		this.lat = lat;
	}

	public float getLng() {
		return lng;
	}

	public void setLng(float lng) {
		this.lng = lng;
	}

	public int getMetro1() {
		return metro1;
	}

	public void setMetro1(int metro1) {
		this.metro1 = metro1;
	}

	public int getMetro2() {
		return metro2;
	}

	public void setMetro2(int metro2) {
		this.metro2 = metro2;
	}

	public int getMetro3() {
		return metro3;
	}

	public void setMetro3(int metro3) {
		this.metro3 = metro3;
	}

	public int getMetro4() {
		return metro4;
	}

	public void setMetro4(int metro4) {
		this.metro4 = metro4;
	}

	public int getMetro5() {
		return metro5;
	}

	public void setMetro5(int metro5) {
		this.metro5 = metro5;
	}

	public int getSection_no() {
		return section_no;
	}

	public void setSection_no(int section_no) {
		this.section_no = section_no;
	}
}
