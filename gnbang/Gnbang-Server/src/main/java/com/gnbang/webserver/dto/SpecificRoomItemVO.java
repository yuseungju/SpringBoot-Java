package com.gnbang.webserver.dto;

import com.gnbang.webserver.pojo.LoggableElement;

/*`specific_room_item테이블
`no`                      INT(11)     NOT NULL, -- no									
`user_no`                 INT(11)     NULL,     -- no3							누가 작성(수정)했는지		
`item_no`                 INT(11)     NULL,     -- 새 컬럼3						room_item.no와 매핑		
`recommend`               TINYINT(4)  NULL,     -- recommend					추천매물(지점장급이 선정)		
`urgent_sale`             TINYINT(1)  NULL,     -- urgent_sale					급매물(지점장급이 선정)		
`apartment`               TINYINT(1)  NULL,     -- apartment					아파트		
`officetel`               TINYINT(1)  NULL,     -- officetel					오피스텔		
`house`                   TINYINT(1)  NULL,     -- house						주택		
`normal_room`             TINYINT(1)  NULL,     -- normal_room					원룸		
`full_option_room`        TINYINT(1)  NULL,     -- full_option_room				풀옵션		
`shop`                    TINYINT(1)  NULL,     -- shop							상가		
`office`                  TINYINT(1)  NULL,     -- office						사무실		
`building`                TINYINT(1)  NULL,     -- buliding						건물		
`redevelopment`           TINYINT(1)  NULL,     -- redevelopment				재개발		
`land`                    TINYINT(1)  NULL,     -- land							땅		
`event`                   TINYINT(1)  NULL,     -- event						이벤트		
`all_floor`               INT         NULL,     -- all_floor					건물 전체 층		
`floor_no`                INT         NULL,     -- floor_no						해당하는 층		
`semi_basement`           TINYINT(1)  NULL,     -- semi_basement				반지하		
`rooftop`                 TINYINT(1)  NULL,     -- rooftop						옥탑방		
`built`                   INT         NULL,     -- built						준공년도		
`room_count`              INT         NULL,     -- room_count					원룸	투룸	쓰리룸+
`room_count_onepointfive` TINYINT(1)  NULL,     -- room_count_onepointfive		1.5룸		
`bathroom_count`          INT(11)     NULL,     -- bathroom_count				샤워실수		
`room_type`               TINYINT(4)  NULL,     -- room_type					오픈형	분리형	복층형
`empty`                   TINYINT(1)  NULL,     -- empty						현재 공실인가		
`type`                    TINYINT(4)  NULL,     -- type									
`leased_area`             FLOAT       NULL,     -- leased_area					공급면적 
`exclusive_area`          FLOAT       NULL,     -- exclusive_area				전용면적		
`move_now`                TINYINT(1)  NULL,     -- move_now						바로 이사가능		
`move_modify`             TINYINT(1)  NULL,     -- move_modify					이사날짜조정가능		
`move_day`                DATE        NULL,     -- move_day						이사가능날짜		
`standard_deposit`        INT(11)     NULL,     -- standard_deposit				기준가		
`charter_deposit`         INT(11)     NULL,     -- charter_deopsit				전세가		
`deposit`                 INT(11)     NULL,     -- deposit						보증금
`monthly_rent`            INT(11)     NULL,     -- monthly_rent					월세		
`maintenance_cost`        INT(11)     NULL,     -- maintenance_cost				관리비		
`deposit_modify`          TINYINT(1)  NULL,     -- deposit_modify				보증금 협의가능		
`in_electronic_bill`      TINYINT(1)  NULL,     -- in_electronic_bill			전기세포함		
`in_gas_bill`             TINYINT(1)  NULL,     -- in_gas_bill					가스비포함		
`in_water_bill`           TINYINT(1)  NULL,     -- in_water_bill				수도세포함		
`in_internet_bill`        TINYINT(1)  NULL,     -- in_internet_bill				인터넷포함		
`in_tv_bill`              TINYINT(1)  NULL,     -- in_tv_bill					티비포함		
`in_clean_fee`            TINYINT(1)  NULL,     -- in_clean_fee					청소비포함		
`airconditioner`          TINYINT(1)  NULL,     -- airconditioner				에어컨		
`refrigerator`            TINYINT(1)  NULL,     -- regrigerator					냉장고		
`washer`                  TINYINT(1)  NULL,     -- washer						세탁기		
`tv`                      TINYINT(1)  NULL,     -- tv							tv		
`microwave`               TINYINT(1)  NULL,     -- microwave					전자레인지		
`induction`               TINYINT(1)  NULL,     -- induction					인덕션		
`gasrange`                TINYINT(1)  NULL,     -- gasrange						가스레인지		
`bed`                     TINYINT(1)  NULL,     -- bed							침대		
`built_in_closet`         TINYINT(1)  NULL,     -- built_in_closet				붙박이장		
`closet`                  TINYINT(1)  NULL,     -- closet						옷장		
`dressing_table`          TINYINT(1)  NULL,     -- dressing_table				화장대		
`veranda`                 TINYINT(1)  NULL,     -- veranda						베란다		
`security`                TINYINT(1)  NULL,     -- security						현관보안		
`digital_doorlock`        TINYINT(1)  NULL,     -- digital_doorlock				디지털도어락		
`other_option`            TEXT        NULL,     -- other_option					다른옵션들(검색에선잘안쓸듯)		
`elevator`                TINYINT(1)  NULL,     -- elevator						엘리베이터 		
`animal`                  TINYINT(1)  NULL,     -- animal						반려동물		
`parking`                 TINYINT(1)  NULL,     -- parking						주차가능		
`parking_free`            TINYINT(1)  NULL,     -- parking_free					주차비용포함		
`parking_count`           TINYINT(4)  NULL,     -- parking_count				주차가능대수		
`parking_option`          VARCHAR(50) NULL,     -- parking_option				주차다른옵션들(검색에선잘안쓸듯)		
`heating_type`            TINYINT(4)  NULL,     -- heating_type					난방타입		
`detail`                  TEXT        NULL,     -- detail						다른설명들(검색에선잘안쓸듯)		
`requirement`             TEXT        NULL,     -- requirement					임대인요구사항(검색에선잘안쓸듯)		
`movie_url`               VARCHAR(50) NULL,     -- movie_url					동영상url		
`z_explain`               TEXT        NULL,     -- z_explain					다른설명들(검색에선잘안쓸듯)		
`contact_who_1`           VARCHAR(20) NULL,     -- contact_who_1				연락처1		
`contact_phone_1`         VARCHAR(20) NULL,     -- contact_phone_1				연락처전화번호1		
`contact_who_2`           VARCHAR(20) NULL,     -- contact_who_2				연락처2		
`contact_phone_2`         VARCHAR(20) NULL,     -- contact_phone_2				연락처전화번호2		
`contact_who_3`           VARCHAR(20) NULL,     -- contact_who_3				연락처3		
`contact_phone_3`         VARCHAR(20) NULL,     -- contact_phone_3				연락처전화번호3		
`contact_who_4`           VARCHAR(20) NULL,     -- contact_who_4				연락처4		
`contact_phone_4`         VARCHAR(20) NULL,     -- contact_phone_4				연락처전화번호4		
`confirm_date`            TIMESTAMP   NULL,     -- confirm_date					최종확인날짜		
`date`                    TIMESTAMP   NULL     DEFAULT 	CURRENT_TIMESTAMP, -- date		등록날짜		
`read_cnt`                INT(11)     NULL,     -- read_cnt						읽은수		
`photo_open`              TINYINT(1)  NULL,     -- photo_open					사진있음	사진없음	
`snum`                    INT         NULL      -- 새 컬럼							공실등록번호(검색에선잘안쓸듯)		

*/
public class SpecificRoomItemVO extends LoggableElement {
	 int  no;
	 int  user_no;
	 int  item_no;
	 short  recommend;
	 short  urgent_sale;
	 short  apartment;
	 short officetel;
	 short house;
	 short normal_room;
	 short full_option_room;
	 short shop;
	 short office;
	 short building;
	 short redevelopment;
	 short land;
	 short event;
	 int all_floor;
	 int floor_no;
	 short semi_basement;
	 short rooftop;
	 int built;
	 int room_count;
	 short room_count_onepointfive;
	 short bathroom_count;
	 short room_type;
	 short empty;
	 short type;
	 float leased_area;
	 float exclusive_area;
	 short move_now;
	 short move_modify;
	 String move_day;
	 int standard_deposit;
	 int charter_deposit;
	 int sale_price;// 매매가
	 int deposit;
	 int monthly_rent;
	 int maintenance_cost;
	 short deposit_modify;
	 short in_electronic_bill;
	 short in_gas_bill;
	 short in_water_bill;
	 short in_internet_bill;
	 short in_tv_bill;
	 short in_clean_fee;
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
	 short security;
	 short digital_doorlock;
	 String other_option;
	 short elevator;
	 short animal;
	 short parking;
	 short parking_free;
	 short parking_count;
	 String parking_option;
	 short heating_type;
	 String detail;
	 String requirement;
	 String movie_url;
	 String z_explain;
	 String contact_who_1;
	 String contact_phone_1;
	 String contact_who_2;
	 String contact_phone_2;
	 String contact_who_3;
	 String contact_phone_3;
	 String contact_who_4;
	 String contact_phone_4;
	 String confirm_date;
	 String date;
	 int read_cnt;
	 short photo_open;
	 int snum;
	 
	public int getSale_price() {
		return sale_price;
	}
	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
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
	public int getItem_no() {
		return item_no;
	}
	public void setItem_no(int item_no) {
		this.item_no = item_no;
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
	public short getRedevelopment() {
		return redevelopment;
	}
	public void setRedevelopment(short redevelopment) {
		this.redevelopment = redevelopment;
	}
	public short getLand() {
		return land;
	}
	public void setLand(short land) {
		this.land = land;
	}
	public short getEvent() {
		return event;
	}
	public void setEvent(short event) {
		this.event = event;
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
	public int getBuilt() {
		return built;
	}
	public void setBuilt(int built) {
		this.built = built;
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
	public short getBathroom_count() {
		return bathroom_count;
	}
	public void setBathroom_count(short bathroom_count) {
		this.bathroom_count = bathroom_count;
	}
	public short getRoom_type() {
		return room_type;
	}
	public void setRoom_type(short room_type) {
		this.room_type = room_type;
	}
	public short getEmpty() {
		return empty;
	}
	public void setEmpty(short empty) {
		this.empty = empty;
	}
	public short getType() {
		return type;
	}
	public void setType(short type) {
		this.type = type;
	}
	public float getLeased_area() {
		return leased_area;
	}
	public void setLeased_area(float leased_area) {
		this.leased_area = leased_area;
	}
	public float getExclusive_area() {
		return exclusive_area;
	}
	public void setExclusive_area(float exclusive_area) {
		this.exclusive_area = exclusive_area;
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
	public short getDeposit_modify() {
		return deposit_modify;
	}
	public void setDeposit_modify(short deposit_modify) {
		this.deposit_modify = deposit_modify;
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
	public String getParking_option() {
		return parking_option;
	}
	public void setParking_option(String parking_option) {
		this.parking_option = parking_option;
	}
	public short getHeating_type() {
		return heating_type;
	}
	public void setHeating_type(short heating_type) {
		this.heating_type = heating_type;
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
	public String getZ_explain() {
		return z_explain;
	}
	public void setZ_explain(String z_explain) {
		this.z_explain = z_explain;
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
	public String getContact_who_4() {
		return contact_who_4;
	}
	public void setContact_who_4(String contact_who_4) {
		this.contact_who_4 = contact_who_4;
	}
	public String getContact_phone_4() {
		return contact_phone_4;
	}
	public void setContact_phone_4(String contact_phone_4) {
		this.contact_phone_4 = contact_phone_4;
	}
	public String getConfirm_date() {
		return confirm_date;
	}
	public void setConfirm_date(String confirm_date) {
		this.confirm_date = confirm_date;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getRead_cnt() {
		return read_cnt;
	}
	public void setRead_cnt(int read_cnt) {
		this.read_cnt = read_cnt;
	}
	public short getPhoto_open() {
		return photo_open;
	}
	public void setPhoto_open(short photo_open) {
		this.photo_open = photo_open;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	 
}
