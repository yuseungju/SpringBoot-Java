package com.gnbang.webserver.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnbang.webserver.dto.AddressCodeVO;
import com.gnbang.webserver.dto.SectorVO;
import com.gnbang.webserver.mapper.LocationMapper;

//searchController에서 사용
//JoinController에서 사용
@Service
public class LocationService {

	private final static Logger logger = LoggerFactory.getLogger(RoomService.class);
	
	@Autowired
	private LocationMapper locationMapper;
	
//검색화면 지도의 상단 지역 리스트
	//시 리스트를 가져옴
	public ArrayList<String> getSiList() {
		return  locationMapper.getSiList();
	}
	//시에 해당되는  군/구 의 리스트를 가져옴
	public ArrayList<String> getGunguList(String si) {
		return  locationMapper.getGunguList(si);
	}
	//시와 구에 해당되는  동과 주소코드를 가져옴
	public ArrayList<AddressCodeVO> getDongAndCodeList(String si, String gungu) {
		return  locationMapper.getDongAndCodeList(si, gungu);
	}

//방등록시 중개사화면의 상세검색 섹터리스트
	//섹터구 리스트를 가져옴
	public ArrayList<String> getSectorGuList() {
		return locationMapper.getSectorGuList();
	}
	//섹터구에 해당되는 섹터 동리스트를 가져옴
	public ArrayList<SectorVO> getsectorDongAndNoList(String sector_gu) {
		return locationMapper.getsectorDongAndNoList(sector_gu);
	}
}
