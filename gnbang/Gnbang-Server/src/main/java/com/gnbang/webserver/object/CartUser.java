package com.gnbang.webserver.object;

/*room_item_cart테이블
room_item_cart_list 테이블의 조인*/
public class CartUser {
	// 관심매물 고객정보
	int no;// 관심매물 담기번호
	int room_item_cart_list_no;// 고객번호
	int room_item_no;// 매물번호
	int user_no;// 등록시킨 중개사번호
	int client_no;//고객이 일반회원일 경우의 일반회원 번호
	String name;
	String phone;
	String explain;
	String date;

	// 관심매물 방정보
	int main_address;// 번지수 앞
	int sub_address;// 번지수 뒤
	String last_address;// 상세주소
	int floor_no;// 층수
	int all_floor;// 전체층수
	short  roof_top;// 옥탑방
	short semi_basement;// 반지하
	String si;// 시
	String gungu;// 군 또는 구
	String dong;// 동
		
	public String getSi() {
		return si;
	}

	public void setSi(String si) {
		this.si = si;
	}

	public String getGungu() {
		return gungu;
	}

	public void setGungu(String gungu) {
		this.gungu = gungu;
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
	}

	public int getFloor_no() {
		return floor_no;
	}

	public void setFloor_no(int floor_no) {
		this.floor_no = floor_no;
	}

	public int getAll_floor() {
		return all_floor;
	}

	public void setAll_floor(int all_floor) {
		this.all_floor = all_floor;
	}

	public short getRoof_top() {
		return roof_top;
	}

	public void setRoof_top(short roof_top) {
		this.roof_top = roof_top;
	}

	public short getSemi_basement() {
		return semi_basement;
	}

	public void setSemi_basement(short semi_basement) {
		this.semi_basement = semi_basement;
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

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getClient_no() {
		return client_no;
	}

	public void setClient_no(int client_no) {
		this.client_no = client_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getExplain() {
		return explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
}
