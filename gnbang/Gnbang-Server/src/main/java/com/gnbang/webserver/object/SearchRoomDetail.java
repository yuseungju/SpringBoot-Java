package com.gnbang.webserver.object;

import java.util.ArrayList;

/*
 * 중개사정보, 방상세정보, 방정보 , 주소
 * user_agent,  specific_room_item,  room_item , note테이블
 * address_code 테이블의 조인
 * */
public class SearchRoomDetail {

	Integer close;//매물여부
	String close_reason;//매물보류이유 
	
	Integer zzimCount;//찜수
	Integer read_cnt;//초회수
	Integer  zzimNo;//찜 번호 
	
	// 지도좌표
	float lat;
	float lng;

	// 공급 전용
	float exclusive_area;// 전용면적
	float leased_area;// 공급면적
	// ** 주소정보 address_code테이블
	String si;
	String gungu;
	String dong;
	int sub_address;// 번지 마지막
	String last_address;// 기타주소
	int main_address;// 번지 처음
	String new_address;//새주소

	// ** 방정보 specific_room_item테이블
	int charter_deposit; // 전세가
	int sale_price;// 매매가
	int monthly_rent; // 월세
	short deposit_modify;// 보증금 협의가능
	int deposit; // 보증금
	int standard_deposit;// 기준가격 중개수수료부분에서사용
	int brokerage;//중개수수료
	String movie_url; // 동영상경로
	String detail;// 상세설명
	int movieUrlNumber; // 동영상경로번호

	//거래 종류
	short type;// 매매 전세  전월세  월세  단기임대
	
	// 관리비 와 관리비포함
	int maintenance_cost;// 관리비
	short in_electronic_bill;// 전기세포함
	short in_gas_bill; // 가스비포함
	short in_water_bill; // 수도세포함
	short in_internet_bill; // 인터넷포함
	short in_tv_bill; // 티비포함
	short in_clean_fee; // 청소비포함

	// 방수
	int room_count;// 룸 개수
	short room_count_onepointfive;// 1.5룸여부
	// 욕실수
	int bathroom_count;

	// 방종류
	short room_type;// 오픈/분리/복층형

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
	short redevelopment;// 재개발

	int no;// 매물번호
	// 방위치
	int all_floor;// 전체층
	int floor_no;// 해당층
	short semi_basement;// 반지하
	short rooftop;// 옥탑방

	// 입주가능여부
	short move_now; // 바로 이사가능
	short move_modify;// 이사날짜조정가능
	String move_day; // 이사가능날짜

	short full_option_room;// 풀옵션
	short veranda;// 베란다
	short airconditioner;// 에어컨
	short refrigerator;// 내장고
	short washer;// 세탁기
	short tv;// tv
	short microwave;// 전자레인지
	short induction;// 인덕션
	short gasrange;// 가스레인지
	short bed;// 침대
	short built_in_closet;// 붙박이장
	short closet;// 옷장
	short dressing_table;// 화장대
	String other_option;// 다른옵션

	short elevator;// 엘리베이터여부
	short animal;// 반려동물

	short parking;// 주차가능
	short parking_free;// 주차비용포함
	short parking_count;// 주차가능대수
	String parking_option;// 주차 옵션
	int built;// 준공년도

	Short heating_type;// 난방종류

	ArrayList<String> fake_url;//사진경로
	String date;//매물등록날짜
	
	//중개사 정보
	String manageName;//담당자
	String managePhone;//담당자번호
	String photoManageName;//사진등록자
	String photoManagePhone;////사진등록자번호
	
	
	public String getNew_address() {
		return new_address;
	}

	public void setNew_address(String new_address) {
		this.new_address = new_address;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public Integer getZzimNo() {
		return zzimNo;
	}

	public void setZzimNo(Integer zzimNo) {
		this.zzimNo = zzimNo;
	}

	public int getMovieUrlNumber() {
		return movieUrlNumber;
	}

	public void setMovieUrlNumber(int movieUrlNumber) {
		this.movieUrlNumber = movieUrlNumber;
	}

	public String getPhotoManagePhone() {
		return photoManagePhone;
	}

	public void setPhotoManagePhone(String photoManagePhone) {
		this.photoManagePhone = photoManagePhone;
	}

	public String getManagePhone() {
		return managePhone;
	}

	public void setManagePhone(String managePhone) {
		this.managePhone = managePhone;
	}

	public short getType() {
		return type;
	}

	public void setType(short type) {
		this.type = type;
	}

	public int getSale_price() {
		return sale_price;
	}

	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
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

	public int getBrokerage() {
		return brokerage;
	}

	public void setBrokerage(int brokerage) {
		this.brokerage = brokerage;
	}

	public ArrayList<String> getFake_url() {
		return fake_url;
	}

	public void setFake_url(ArrayList<String> fake_url) {
		this.fake_url = fake_url;
	}

	public String getManageName() {
		return manageName;
	}

	public void setManageName(String manageName) {
		this.manageName = manageName;
	}

	public String getPhotoManageName() {
		return photoManageName;
	}

	public void setPhotoManageName(String photoManageName) {
		this.photoManageName = photoManageName;
	}

	public String getParking_option() {
		return parking_option;
	}

	public void setParking_option(String parking_option) {
		this.parking_option = parking_option;
	}

	public String getOther_option() {
		return other_option;
	}

	public void setOther_option(String other_option) {
		this.other_option = other_option;
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

	public float getExclusive_area() {
		return exclusive_area;
	}

	public void setExclusive_area(float exclusive_area) {
		this.exclusive_area = exclusive_area;
	}

	public float getLeased_area() {
		return leased_area;
	}

	public void setLeased_area(float leased_area) {
		this.leased_area = leased_area;
	}

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

	public int getCharter_deposit() {
		return charter_deposit;
	}

	public void setCharter_deposit(int charter_deposit) {
		this.charter_deposit = charter_deposit;
	}

	public int getMonthly_rent() {
		return monthly_rent;
	}

	public void setMonthly_rent(int monthly_rent) {
		this.monthly_rent = monthly_rent;
	}

	public short getDeposit_modify() {
		return deposit_modify;
	}

	public void setDeposit_modify(short deposit_modify) {
		this.deposit_modify = deposit_modify;
	}

	public int getDeposit() {
		return deposit;
	}

	public void setDeposit(int deposit) {
		this.deposit = deposit;
	}

	public String getMovie_url() {
		return movie_url;
	}

	public void setMovie_url(String movie_url) {
		this.movie_url = movie_url;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public int getMaintenance_cost() {
		return maintenance_cost;
	}

	public void setMaintenance_cost(int maintenance_cost) {
		this.maintenance_cost = maintenance_cost;
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

	public short getIn_internet_bill() {
		return in_internet_bill;
	}

	public void setIn_internet_bill(short in_internet_bill) {
		this.in_internet_bill = in_internet_bill;
	}

	public short getIn_tv_bill() {
		return in_tv_bill;
	}

	public void setIn_tv_bill(short in_tv_bill) {
		this.in_tv_bill = in_tv_bill;
	}

	public short getIn_clean_fee() {
		return in_clean_fee;
	}

	public void setIn_clean_fee(short in_clean_fee) {
		this.in_clean_fee = in_clean_fee;
	}

	public int getStandard_deposit() {
		return standard_deposit;
	}

	public void setStandard_deposit(int standard_deposit) {
		this.standard_deposit = standard_deposit;
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

	public short getRoom_type() {
		return room_type;
	}

	public void setRoom_type(short room_type) {
		this.room_type = room_type;
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

	public short getLand() {
		return land;
	}

	public void setLand(short land) {
		this.land = land;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
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

	public short getFull_option_room() {
		return full_option_room;
	}

	public void setFull_option_room(short full_option_room) {
		this.full_option_room = full_option_room;
	}

	public short getVeranda() {
		return veranda;
	}

	public void setVeranda(short veranda) {
		this.veranda = veranda;
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

	public short getParking_free() {
		return parking_free;
	}

	public void setParking_free(short parking_free) {
		this.parking_free = parking_free;
	}

	public short getParking_count() {
		return parking_count;
	}

	public void setParking_count(short parking_count) {
		this.parking_count = parking_count;
	}

	public int getBuilt() {
		return built;
	}

	public void setBuilt(int built) {
		this.built = built;
	}

	public Short getHeating_type() {
		return heating_type;
	}

	public void setHeating_type(Short heating_type) {
		this.heating_type = heating_type;
	}

	public Integer getZzimCount() {
		return zzimCount;
	}

	public void setZzimCount(Integer zzimCount) {
		this.zzimCount = zzimCount;
	}

	public Integer getRead_cnt() {
		return read_cnt;
	}

	public void setRead_cnt(Integer read_cnt) {
		this.read_cnt = read_cnt;
	}

	public Integer getClose() {
		return close;
	}

	public void setClose(Integer close) {
		this.close = close;
	}

	public String getClose_reason() {
		return close_reason;
	}

	public void setClose_reason(String close_reason) {
		this.close_reason = close_reason;
	}

	public short getRedevelopment() {
		return redevelopment;
	}

	public void setRedevelopment(short redevelopment) {
		this.redevelopment = redevelopment;
	}

}
