package com.gnbang.webserver.object;

import java.util.ArrayList;

/*
 * Room_Item 테이블, specificRoomItem 테이블, address_code테이블, roo_photo테이블
 * */
public class SearchRoomSumary {
// Room_Item , address_code테이블
	// 주소정보
	String si;// 시
	String gungu;// 군 또는 구
	String dong;// 동
	int sub_address;// 번지 마지막
	String last_address;// 기타주소
	int main_address;// 번지 처음
	double lat;
	double lng;
	
//specificRoomItem 테이블
	// 방위치
	int all_floor;// 전체층
	int floor_no;// 해당층
	short semi_basement;// 반지하
	short rooftop;// 옥탑방

	// 방 상세 정보
	int no;// 매물번호 room_item의 no
	short recommend;// 추천여부
	short urgent_sale;// 급 여부

	// 건물 형태 옵션중 하나선택
	short apartment;
	short officetel;// 오피스텔
	short house;// 주택
	short normal_room;// 원룸
	short shop;// 상가
	short office;// 사무실
	short building;// 건물
	short event;// 이벤트
	short land;// 땅

	short type;// 매매 전세  전월세  월세  단기임대
	short full_option_room;// 풀옵션
	short empty;// 공실여부
	short room_type;// 0오픈형, 1분리형, 2복층형
	short parking;// 주차여부
	short redevelopment;// 재개발 여부
	int room_count;// 룸 개수
	short room_count_onepointfive;// 1.5룸여부

	short security; // 보안여부
	short digital_doorlock;// 도어락 여부

	int maintenance_cost;// 관리비
	int standard_deposit;// 기준가
	int sale_price;// 매매가
	int charter_deposit;// 전세가
	int deposit;// 보증금
	int monthly_rent;// 월세
	short deposit_modify;// 보증금협의가능

	short animal;// 반려동물 가능

	short elevator;// 엘리베이터존재 여부
	short veranda;// 베란다 존재여부
	short airconditioner;
	short refrigerator;
	short washer;
	short tv;
	short microwave;
	short induction;
	short gasrange;
	short bed;
	short built_in_closet;
	short closet;
	short dressing_table;
	String other_option;
	
	String contact_phone_1;//연락처
	String contact_who_1;//연락처이름
	String contact_phone_2;//연락처
	String contact_who_2;//연락처이름
	String contact_phone_3;//연락처
	String contact_who_3;//연락처이름
	String date;//등록날짜
	
//room_photo테이블
	ArrayList<String> fake_url;//사진경로
	ArrayList<String> photoEnrollDate;//사진등록 날짜
	boolean modifiable;//사진수정가능여부
	
//zzim테이블	
	Integer zzim_no;//찜번호 (찜이면 찜번호/찜이 아니면 0)
	

	public boolean isModifiable() {
		return modifiable;
	}

	public void setModifiable(boolean modifiable) {
		this.modifiable = modifiable;
	}

	public ArrayList<String> getPhotoEnrollDate() {
		return photoEnrollDate;
	}

	public void setPhotoEnrollDate(ArrayList<String> photoEnrollDate) {
		this.photoEnrollDate = photoEnrollDate;
	}

	public ArrayList<String> getFake_url() {
		return fake_url;
	}

	public void setFake_url(ArrayList<String> fake_url) {
		this.fake_url = fake_url;
	}

	public Integer getZzim_no() {
		return zzim_no;
	}

	public void setZzim_no(Integer zzim_no) {
		this.zzim_no = zzim_no;
	}

	public int getSale_price() {
		return sale_price;
	}

	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public String getContact_phone_1() {
		return contact_phone_1;
	}

	public void setContact_phone_1(String contact_phone_1) {
		this.contact_phone_1 = contact_phone_1;
	}

	public String getContact_who_1() {
		return contact_who_1;
	}

	public void setContact_who_1(String contact_who_1) {
		this.contact_who_1 = contact_who_1;
	}

	public String getContact_phone_2() {
		return contact_phone_2;
	}

	public void setContact_phone_2(String contact_phone_2) {
		this.contact_phone_2 = contact_phone_2;
	}

	public String getContact_who_2() {
		return contact_who_2;
	}

	public void setContact_who_2(String contact_who_2) {
		this.contact_who_2 = contact_who_2;
	}

	public String getContact_phone_3() {
		return contact_phone_3;
	}

	public void setContact_phone_3(String contact_phone_3) {
		this.contact_phone_3 = contact_phone_3;
	}

	public String getContact_who_3() {
		return contact_who_3;
	}

	public void setContact_who_3(String contact_who_3) {
		this.contact_who_3 = contact_who_3;
	}

	public int getMaintenance_cost() {
		return maintenance_cost;
	}

	public void setMaintenance_cost(int maintenance_cost) {
		this.maintenance_cost = maintenance_cost;
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

	public int getMain_address() {
		return main_address;
	}

	public void setMain_address(int main_address) {
		this.main_address = main_address;
	}

	public int getStandard_deposit() {
		return standard_deposit;
	}

	public void setStandard_deposit(int standard_deposit) {
		this.standard_deposit = standard_deposit;
	}

	public String getSi() {
		return si;
	}

	public short getDeposit_modify() {
		return deposit_modify;
	}

	public void setDeposit_modify(short deposit_modify) {
		this.deposit_modify = deposit_modify;
	}

	public String getOther_option() {
		return other_option;
	}

	public void setOther_option(String other_option) {
		this.other_option = other_option;
	}

	public int getMonthly_rent() {
		return monthly_rent;
	}

	public void setMonthly_rent(int monthly_rent) {
		this.monthly_rent = monthly_rent;
	}

	public short getType() {
		return type;
	}

	public void setType(short type) {
		this.type = type;
	}

	public short getAirconditioner() {
		return airconditioner;
	}

	public void setAirconditioner(short airconditioner) {
		this.airconditioner = airconditioner;
	}

	public short getRefrigerator() {
		return refrigerator;
	}

	public void setRefrigerator(short refrigerator) {
		this.refrigerator = refrigerator;
	}

	public short getWasher() {
		return washer;
	}

	public void setWasher(short washer) {
		this.washer = washer;
	}

	public short getTv() {
		return tv;
	}

	public void setTv(short tv) {
		this.tv = tv;
	}

	public short getMicrowave() {
		return microwave;
	}

	public void setMicrowave(short microwave) {
		this.microwave = microwave;
	}

	public short getInduction() {
		return induction;
	}

	public void setInduction(short induction) {
		this.induction = induction;
	}

	public short getGasrange() {
		return gasrange;
	}

	public void setGasrange(short gasrange) {
		this.gasrange = gasrange;
	}

	public short getBed() {
		return bed;
	}

	public void setBed(short bed) {
		this.bed = bed;
	}

	public short getBuilt_in_closet() {
		return built_in_closet;
	}

	public void setBuilt_in_closet(short built_in_closet) {
		this.built_in_closet = built_in_closet;
	}

	public short getCloset() {
		return closet;
	}

	public void setCloset(short closet) {
		this.closet = closet;
	}

	public short getDressing_table() {
		return dressing_table;
	}

	public void setDressing_table(short dressing_table) {
		this.dressing_table = dressing_table;
	}

	public short getVeranda() {
		return veranda;
	}

	public void setVeranda(short veranda) {
		this.veranda = veranda;
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

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public short getRecommend() {
		return recommend;
	}

	public void setRecommend(short recommend) {
		this.recommend = recommend;
	}

	public short getUrgent_sale() {
		return urgent_sale;
	}

	public void setUrgent_sale(short urgent_sale) {
		this.urgent_sale = urgent_sale;
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

	public short getFull_option_room() {
		return full_option_room;
	}

	public void setFull_option_room(short full_option_room) {
		this.full_option_room = full_option_room;
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

	public short getLand() {
		return land;
	}

	public void setLand(short land) {
		this.land = land;
	}

	public short getEmpty() {
		return empty;
	}

	public void setEmpty(short empty) {
		this.empty = empty;
	}

	public short getRoom_type() {
		return room_type;
	}

	public void setRoom_type(short room_type) {
		this.room_type = room_type;
	}

	public short getParking() {
		return parking;
	}

	public void setParking(short parking) {
		this.parking = parking;
	}

	public short getRedevelopment() {
		return redevelopment;
	}

	public void setRedevelopment(short redevelopment) {
		this.redevelopment = redevelopment;
	}

	public int getRoom_count() {
		return room_count;
	}

	public void setRoom_count(int room_count) {
		this.room_count = room_count;
	}

	public short getRoom_count_onepointfive() {
		return room_count_onepointfive;
	}

	public void setRoom_count_onepointfive(short room_count_onepointfive) {
		this.room_count_onepointfive = room_count_onepointfive;
	}

	public short getSecurity() {
		return security;
	}

	public void setSecurity(short security) {
		this.security = security;
	}

	public short getDigital_doorlock() {
		return digital_doorlock;
	}

	public void setDigital_doorlock(short digital_doorlock) {
		this.digital_doorlock = digital_doorlock;
	}

	public int getDeposit() {
		return deposit;
	}

	public void setDeposit(int deposit) {
		this.deposit = deposit;
	}

	public short getAnimal() {
		return animal;
	}

	public void setAnimal(short animal) {
		this.animal = animal;
	}

	public short getElevator() {
		return elevator;
	}

	public void setElevator(short elevator) {
		this.elevator = elevator;
	}

	public int getCharter_deposit() {
		return charter_deposit;
	}

	public void setCharter_deposit(int charter_deposit) {
		this.charter_deposit = charter_deposit;
	}
}
