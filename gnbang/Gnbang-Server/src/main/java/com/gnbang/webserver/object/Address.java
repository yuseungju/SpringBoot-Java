package com.gnbang.webserver.object;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import com.gnbang.webserver.pojo.LoggableElement;

//address_code table과 room_item table
//주소 시/군/구/동 번지수/상세 까지의 정보
public class Address extends LoggableElement{
	int no;//매물번호
	
	//address_code table
	String si;
	String gungu;
	String dong;
	long code;
	//room_item table
	int main_address;
	int sub_address;
	String last_address;
	//도로명 주소
	String new_address;
	//지도좌표
	double lat;//위도
	double lng;//경도
	
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public void setAddress(Address address) {
		this.si = address.si;
		this.gungu = address.gungu;
		this.dong = address.dong;
		this.code = address.code;
		this.main_address = address.main_address;
		this.sub_address = address.sub_address;
		this.last_address = address.last_address;
	}

	public void setAddressFromSearchRoomDetail(SearchRoomDetail searchRoomDetail) {
		this.si = searchRoomDetail.getSi();
		this.gungu = searchRoomDetail.getGungu();
		this.dong = searchRoomDetail.getDong();
		this.main_address = searchRoomDetail.getMain_address();
		this.sub_address = searchRoomDetail.getSub_address();
		this.last_address = searchRoomDetail.getLast_address();
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

	public String getNew_address() {
		return new_address;
	}

	public void setNew_address(String new_address) {
		try {
			this.new_address = URLDecoder.decode(new_address,"UTF-8");
		} catch (Exception e) {
			this.new_address = new_address;
		}
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
		try {
			this.last_address = URLDecoder.decode(last_address,"UTF-8");
		} catch (Exception e) {
			this.last_address = last_address;
		}
	}

	public String getSi() {
		return si;
	}

	public void setSi(String si) {
		try {
			this.si = URLDecoder.decode(si,"UTF-8");
		} catch (Exception e) {
			this.si = si;
		}
	}

	public String getGungu() {
		return gungu;
	}

	public void setGungu(String gungu){
		try {
			this.gungu = URLDecoder.decode(gungu,"UTF-8");
		} catch (Exception e) {
			this.gungu = gungu;
		}
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong){
		try {
			this.dong = URLDecoder.decode(dong,"UTF-8");
		} catch (Exception e) {
			this.dong = dong;
		}
	}

	public long getCode() {
		return code;
	}

	public void setCode(long code) {
		this.code = code;
	}
}

