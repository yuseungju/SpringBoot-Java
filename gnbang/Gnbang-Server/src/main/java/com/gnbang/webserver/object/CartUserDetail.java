package com.gnbang.webserver.object;

import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

//방등록시 방의 정보를 가짐
//spcificRoomItem  &&  roomItem  && room_item_cart && room_item_cart_list 테이블의 속성
public class CartUserDetail {

	// ******************************room_item_cart 테이블********************************
	int room_item_cart_no; //관심고객 내에 담아놓은 매물의  key값
	
	// ******************************room_item_cart_list 테이블********************************
	String name;//고객폴더이름
	String explain;//고객폴더설명
	String date;//고객폴더생성일
	
	// ******************************room_item 테이블
							//방상세정보 등록 입력폼 (프론트)정보********************************

	int no;// 매물 방 번호  room_item의 no
	//우편주소검색 번호
	String si;// 시
	String gungu;// 군 또는 구
	String dong;// 동
	int main_address;// 번지수 앞
	int sub_address;// 번지수 뒤
	String last_address;// 상세주소
	// ******************************specfic_room_item 테이블 
							//방상세정보 등록 입력폼 (프론트)정보********************************
	// 건물 형태 옵션중 하나선택
	short apartment;
	short officetel;// 오피스텔
	short house;// 주택
	short normal_room;// 원룸
	short shop;// 상가
	short office;// 사무실
	short building;// 건물
	short event;// 이벤트
	short redevelopment;// 재개발
	short full_option_room;//풀옵션 

	// 방위치
	int all_floor;// 전체층
	int floor_no;// 해당층
	short semi_basement;// 반지하
	short rooftop;// 옥탑방

	double exclusive_area; // 전용면적
	double leased_area; // 공급면적

	// 이사가능날짜
	short move_now;// 이사 가능날짜즉시
	short move_modify;// 이사 가능날짜 협의
	String move_day;// 입주가능일

	short type;// 거래 종류 매매/전세/전월세/월세/단기임대

	// 가격
	int standard_deposit;// 기준가
	int sale_price;// 매매가
	int charter_deposit;// 전세
	int deposit;// 보증금
	int monthly_rent;// 월세
	int maintenance_cost;// 관리비
	int brokerage;// 중개수수료

	// 보증금 조정여부
	short deposit_modify;

	String detail;// 상세보기 상세설명
	String requirement;// 요구사항
	String movie_url;// 동영상경로


	// ****************************방등록 과정에서의 계산 필드(서버에서 생성)********************************
    String createDateOfRoomItemCartList;//고객폴더 생성일
	String modifyDateOfRoomItemCartList;//고객 폴더 최근 수정일

	String main_fake_url;//사진경로 이미지 경로 (메인사진 첫번째)
	int user_no;//등록자번호
	short photo_open;//매물 상세 정보 사진 존재여부(specific_room_item)
	short photo;//매물 사진 존재여부 (room_item)

	
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

	public void setMain_address(int main_address) {
		this.main_address = main_address;
	}

	public void setSub_address(int sub_address) {
		this.sub_address = sub_address;
	}

	public short getFull_option_room() {
		return full_option_room;
	}

	public void setFull_option_room(short full_option_room) {
		this.full_option_room = full_option_room;
	}

	public String getMain_fake_url() {
		return main_fake_url;
	}

	public void setMain_fake_url(String main_fake_url) {
		this.main_fake_url = main_fake_url;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public int getMain_address() {
		return main_address;
	}

	public int getSub_address() {
		return sub_address;
	}

	public String getLast_address() {
		return last_address;
	}

	public void setLast_address(String last_address) {
		this.last_address = last_address;
	}

	public short getApartment() {
		return apartment;
	}

	public void setApartment(short apartment) {
		this.apartment = apartment;
	}

	public short getOfficetel() {
		return officetel;
	}

	public void setOfficetel(short officetel) {
		this.officetel = officetel;
	}

	public short getHouse() {
		return house;
	}

	public void setHouse(short house) {
		this.house = house;
	}

	public short getNormal_room() {
		return normal_room;
	}

	public void setNormal_room(short normal_room) {
		this.normal_room = normal_room;
	}

	public short getShop() {
		return shop;
	}

	public void setShop(short shop) {
		this.shop = shop;
	}

	public short getOffice() {
		return office;
	}

	public void setOffice(short office) {
		this.office = office;
	}

	public short getBuilding() {
		return building;
	}

	public void setBuilding(short building) {
		this.building = building;
	}

	public short getEvent() {
		return event;
	}

	public void setEvent(short event) {
		this.event = event;
	}

	public short getRedevelopment() {
		return redevelopment;
	}

	public void setRedevelopment(short redevelopment) {
		this.redevelopment = redevelopment;
	}

	public int getAll_floor() {
		return all_floor;
	}

	public void setAll_floor(int all_floor) {
		this.all_floor = all_floor;
	}

	public int getFloor_no() {
		return floor_no;
	}

	public void setFloor_no(int floor_no) {
		this.floor_no = floor_no;
	}

	public short getSemi_basement() {
		return semi_basement;
	}

	public void setSemi_basement(short semi_basement) {
		this.semi_basement = semi_basement;
	}

	public short getRooftop() {
		return rooftop;
	}

	public void setRooftop(short rooftop) {
		this.rooftop = rooftop;
	}

	public double getExclusive_area() {
		return exclusive_area;
	}

	public void setExclusive_area(double exclusive_area) {
		this.exclusive_area = exclusive_area;
	}

	public double getLeased_area() {
		return leased_area;
	}

	public void setLeased_area(double leased_area) {
		this.leased_area = leased_area;
	}

	public short getMove_now() {
		return move_now;
	}

	public void setMove_now(short move_now) {
		this.move_now = move_now;
	}

	public short getMove_modify() {
		return move_modify;
	}

	public void setMove_modify(short move_modify) {
		this.move_modify = move_modify;
	}

	public String getMove_day() {
		return move_day;
	}

	public void setMove_day(String move_day) {
		this.move_day = move_day;
	}

	public short getType() {
		return type;
	}

	public void setType(short type) {
		this.type = type;
	}

	public int getStandard_deposit() {
		return standard_deposit;
	}

	public void setStandard_deposit(int standard_deposit) {
		this.standard_deposit = standard_deposit;
	}

	public int getSale_price() {
		return sale_price;
	}

	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
	}

	public int getCharter_deposit() {
		return charter_deposit;
	}

	public void setCharter_deposit(int charter_deposit) {
		this.charter_deposit = charter_deposit;
	}

	public int getDeposit() {
		return deposit;
	}

	public void setDeposit(int deposit) {
		this.deposit = deposit;
	}

	public int getMonthly_rent() {
		return monthly_rent;
	}

	public void setMonthly_rent(int monthly_rent) {
		this.monthly_rent = monthly_rent;
	}

	public int getMaintenance_cost() {
		return maintenance_cost;
	}

	public void setMaintenance_cost(int maintenance_cost) {
		this.maintenance_cost = maintenance_cost;
	}

	public int getBrokerage() {
		return brokerage;
	}

	public void setBrokerage(int brokerage) {
		this.brokerage = brokerage;
	}

	public short getDeposit_modify() {
		return deposit_modify;
	}

	public void setDeposit_modify(short deposit_modify) {
		this.deposit_modify = deposit_modify;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getRequirement() {
		return requirement;
	}

	public void setRequirement(String requirement) {
		this.requirement = requirement;
	}

	public String getMovie_url() {
		return movie_url;
	}

	public void setMovie_url(String movie_url) {
		this.movie_url = movie_url;
	}

	public String getCreateDateOfRoomItemCartList() {
		return createDateOfRoomItemCartList;
	}

	public void setCreateDateOfRoomItemCartList(String createDateOfRoomItemCartList) {
		this.createDateOfRoomItemCartList = createDateOfRoomItemCartList;
	}

	public String getModifyDateOfRoomItemCartList() {
		return modifyDateOfRoomItemCartList;
	}

	public void setModifyDateOfRoomItemCartList(String modifyDateOfRoomItemCartList) {
		this.modifyDateOfRoomItemCartList = modifyDateOfRoomItemCartList;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public short getPhoto_open() {
		return photo_open;
	}

	public void setPhoto_open(short photo_open) {
		this.photo_open = photo_open;
	}

	public short getPhoto() {
		return photo;
	}

	public void setPhoto(short photo) {
		this.photo = photo;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getRoom_item_cart_no() {
		return room_item_cart_no;
	}

	public void setRoom_item_cart_no(int room_item_cart_no) {
		this.room_item_cart_no = room_item_cart_no;
	}
	
}