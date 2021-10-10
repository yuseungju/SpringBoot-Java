package com.gnbang.webserver.object;

import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

//방등록시 방의 정보를 가짐
//spcificRoomItem  &&  roomItem  테이블의 속성
public class EnrolledRoom {
	
	// ******************************room_item 테이블
							//방상세정보 등록 입력폼 (프론트)정보********************************
	//우편주소검색 번호
	long local_code;//우편번호
	int main_address;//번지수 앞
	int sub_address; //번지수 뒤
	String last_address; //상세주소
	String new_address; //도로명주소
	//지도좌표
	double lat;//위도
	double lng;//경도
	//지하철 번호 
	int metro1;//인근지하철 1 (metro테이블의 key)
	int metro2;//인근지하철 2 (metro테이블의 key)
	int metro3;//인근지하철 3 (metro테이블의 key)
	int metro4;//인근지하철 4 (metro테이블의 key)
	int metro5;//인근지하철 5 (metro테이블의 key)
	
	String metroName1;//인근지하철 이름 1
	String metroName2;//인근지하철 이름2
	String metroName3;//인근지하철 이름3
	String metroName4;//인근지하철 이름4
	String metroName5;//인근지하철 이름5
	
	String sectionName;//섹션이름
	int section_no;//섹션번호
	
	
	// ******************************specfic_room_item 테이블 
							//방상세정보 등록 입력폼 (프론트)정보********************************
	
	short close;// 매물 여부 매물(0)/보류(1)
	String close_reason;// '계약완료'/'임대인요청'/'기타'

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

	// 방위치
	int all_floor;// 전체층
	int floor_no;// 해당층
	short semi_basement;// 반지하
	short rooftop;// 옥탑방

	// 준공년도
	int built;

	// 욕실수
	int bathroom_count;

	// 방수
	int room_count;// 룸 개수
	short room_count_onepointfive;// 1.5룸여부

	short room_type; // 방형태
	double exclusive_area; // 전용면적
	double leased_area; // 공급면적
	short empty;// 공실여부

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

	// 관리비포함사항
	short in_electronic_bill;// 전기세
	short in_gas_bill;// 가스비
	short in_water_bill;// 수도세
	short in_tv_bill;// tv수신료
	short in_internet_bill;// 인터넷비
	short in_clean_fee;// 청소비

	// 보증금 조정여부
	short deposit_modify;

	// 보안
	short security;// 현관보안
	short digital_doorlock;// 번호키

	String other_option;// 기타옵션(보안/신발장/쇼파/싱크대/난방/..)

	// 옵션
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
	short veranda;

	short elevator;// 엘리베이터
	short animal;// 반려동물

	short parking;// 주차
	String parking_option;// 주차옵션
	short heating_type;// 난방종류

	String detail;// 상세보기 상세설명
	String requirement;// 요구사항
	String movie_url;// 동영상경로

	String contact_who_1;// 연락처 관계1(임대)
	String contact_phone_1;// 연락처
	String contact_who_2;// 연락처 관계2(관리)
	String contact_phone_2;// 연락처
	String contact_who_3;// 연락처 관계3(부동산)
	String contact_phone_3;// 연락처
	
	
	// ****************************방등록 과정에서의 계산 필드(서버에서 생성)********************************
	ArrayList<String> tempPathArr;// 이미지 임시업로드의 경로
	int user_no;//등록자번호
	short photo_open;//매물 상세 정보 사진 존재여부(specific_room_item)
	short photo;//매물 사진 존재여부 (room_item)
	int item_no;// 매물 방 번호  room_item의 no
	
	public void setTempPathArr(String tempPathArr) {//throws ParseException {
		
//		JSONParser parser = new JSONParser();
//		org.jooq.tools.json.JSONArray arr = (org.jooq.tools.json.JSONArray) parser.parse(tempPathArr);
		this.tempPathArr = new Gson().fromJson(tempPathArr, new TypeToken<ArrayList<String>>(){}.getType());
	}

	public ArrayList<String> getTempPathArr() {
		return tempPathArr;
	}

	public String getNew_address() {
		return new_address;
	}

	public void setNew_address(String new_address) {
		this.new_address = new_address;
	}

	public String getSectionName() {
		return sectionName;
	}

	public void setSectionName(String sectionName) {
		this.sectionName = sectionName;
	}

	public int getSection_no() {
		return section_no;
	}

	public void setSection_no(int section_no) {
		this.section_no = section_no;
	}

	public short getPhoto() {
		return photo;
	}

	public void setPhoto(short photo) {
		this.photo = photo;
	}

	public int getSale_price() {
		return sale_price;
	}

	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
	}

	public String getMetroName1() {
		return metroName1;
	}

	public void setMetroName1(String metroName1) {
		this.metroName1 = metroName1;
	}

	public String getMetroName2() {
		return metroName2;
	}

	public void setMetroName2(String metroName2) {
		this.metroName2 = metroName2;
	}

	public String getMetroName3() {
		return metroName3;
	}

	public void setMetroName3(String metroName3) {
		this.metroName3 = metroName3;
	}

	public String getMetroName4() {
		return metroName4;
	}

	public void setMetroName4(String metroName4) {
		this.metroName4 = metroName4;
	}

	public String getMetroName5() {
		return metroName5;
	}

	public void setMetroName5(String metroName5) {
		this.metroName5 = metroName5;
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

	public short getPhoto_open() {
		return photo_open;
	}

	public void setPhoto_open(short photo_open) {
		this.photo_open = photo_open;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getItem_no() {
		return item_no;
	}

	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}

	public void setTempPathArr(ArrayList<String> tempPathArr) {
		this.tempPathArr = tempPathArr;
	}
	
	public String getContact_who_1() {
		return contact_who_1;
	}

	public void setContact_who_1(String contact_who_1) {
		this.contact_who_1 = contact_who_1;
	}

	public String getContact_phone_1() {
		return contact_phone_1;
	}

	public void setContact_phone_1(String contact_phone_1) {
		this.contact_phone_1 = contact_phone_1;
	}

	public String getContact_who_2() {
		return contact_who_2;
	}

	public void setContact_who_2(String contact_who_2) {
		this.contact_who_2 = contact_who_2;
	}

	public String getContact_phone_2() {
		return contact_phone_2;
	}

	public void setContact_phone_2(String contact_phone_2) {
		this.contact_phone_2 = contact_phone_2;
	}

	public String getContact_who_3() {
		return contact_who_3;
	}

	public void setContact_who_3(String contact_who_3) {
		this.contact_who_3 = contact_who_3;
	}

	public String getContact_phone_3() {
		return contact_phone_3;
	}

	public void setContact_phone_3(String contact_phone_3) {
		this.contact_phone_3 = contact_phone_3;
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

	public short getHeating_type() {
		return heating_type;
	}

	public void setHeating_type(short heating_type) {
		this.heating_type = heating_type;
	}

	public short getClose() {
		return close;
	}

	public void setClose(short close) {
		this.close = close;
	}

	public String getClose_reason() {
		return close_reason;
	}

	public void setClose_reason(String close_reason) {
		this.close_reason = close_reason;
	}

	public String getMove_day() {
		return move_day;
	}

	public void setMove_day(String move_day) {
		this.move_day = move_day;
	}

	public short getCloset() {
		return closet;
	}

	public void setCloset(short closet) {
		this.closet = closet;
	}

	public int getBrokerage() {
		return brokerage;
	}

	public void setBrokerage(int brokerage) {
		this.brokerage = brokerage;
	}

	public short getIn_electronic_bill() {
		return in_electronic_bill;
	}

	public void setIn_electronic_bill(short in_electronic_bill) {
		this.in_electronic_bill = in_electronic_bill;
	}

	public short getIn_gas_bill() {
		return in_gas_bill;
	}

	public void setIn_gas_bill(short in_gas_bill) {
		this.in_gas_bill = in_gas_bill;
	}

	public short getIn_water_bill() {
		return in_water_bill;
	}

	public void setIn_water_bill(short in_water_bill) {
		this.in_water_bill = in_water_bill;
	}

	public short getIn_tv_bill() {
		return in_tv_bill;
	}

	public void setIn_tv_bill(short in_tv_bill) {
		this.in_tv_bill = in_tv_bill;
	}

	public short getIn_internet_bill() {
		return in_internet_bill;
	}

	public void setIn_internet_bill(short in_internet_bill) {
		this.in_internet_bill = in_internet_bill;
	}

	public short getIn_clean_fee() {
		return in_clean_fee;
	}

	public void setIn_clean_fee(short in_clean_fee) {
		this.in_clean_fee = in_clean_fee;
	}

	public short getDeposit_modify() {
		return deposit_modify;
	}

	public void setDeposit_modify(short deposit_modify) {
		this.deposit_modify = deposit_modify;
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

	public String getOther_option() {
		return other_option;
	}

	public void setOther_option(String other_option) {
		this.other_option = other_option;
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

	public short getElevator() {
		return elevator;
	}

	public void setElevator(short elevator) {
		this.elevator = elevator;
	}

	public short getAnimal() {
		return animal;
	}

	public void setAnimal(short animal) {
		this.animal = animal;
	}

	public short getParking() {
		return parking;
	}

	public void setParking(short parking) {
		this.parking = parking;
	}

	public String getParking_option() {
		return parking_option;
	}

	public void setParking_option(String parking_option) {
		this.parking_option = parking_option;
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

	public short getRoom_type() {
		return room_type;
	}

	public void setRoom_type(short room_type) {
		this.room_type = room_type;
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

	public short getEmpty() {
		return empty;
	}

	public void setEmpty(short empty) {
		this.empty = empty;
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

	public int getBathroom_count() {
		return bathroom_count;
	}

	public void setBathroom_count(int bathroom_count) {
		this.bathroom_count = bathroom_count;
	}

	public int getBuilt() {
		return built;
	}

	public void setBuilt(int built) {
		this.built = built;
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
}
