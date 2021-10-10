package com.gnbang.webserver.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gnbang.webserver.dto.AddressCodeVO;
import com.gnbang.webserver.dto.SectorVO;

public interface LocationMapper {
	//검색화면 지도의 상단 지역 리스트
	ArrayList<String> getSiList();//모든 '시' 리스트들을 가져온다.
	ArrayList<String> getGunguList(String si);//'시' 이름과 같은 '구' 값들을 get
	ArrayList<AddressCodeVO> getDongAndCodeList(@Param("si") String si, @Param("gungu") String gungu);//시와 군의 정보로 주소의 모든값을 가져옴
	
	//방등록시 중개사화면의 상세검색 섹터리스트
	ArrayList<String> getSectorGuList();//섹터 구리스트를 가져옴
	ArrayList<SectorVO> getsectorDongAndNoList(@Param("gu") String gu);//섹터구에 해당되는 섹터 동리스트를 가져옴
}