package com.gnbang.webserver.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.gnbang.webserver.dto.AddressCodeVO;
import com.gnbang.webserver.dto.MetroVO;
import com.gnbang.webserver.dto.RoomItemVO;
import com.gnbang.webserver.dto.SpecificRoomItemVO;
import com.gnbang.webserver.object.SearchRoomSumary;

public interface SearchMapper {
	/*****************************************자동완성 단어 get****************************************/
	//주소  (시)/(구)/(동)의 각각의 검색
	ArrayList<AddressCodeVO> getSameDong(@Param("dong") String dong);//입력값이랑 같은 동의 모든주소값을 가져온다.
	ArrayList<AddressCodeVO> getSameGungu(@Param("gungu") String gungu);//입력값이랑 같은 구의 모든주소값을 가져온다.
	ArrayList<AddressCodeVO> getSameSi(@Param("si") String si);//입력값이랑 같은 시의 모든주소값을 가져온다.
	//주소  (시,구)/(구,동)/(시,동) 각각의 검색
	ArrayList<AddressCodeVO> getSameGunguDong(@Param("gungu") String gungu,@Param("dong") String dong);//입력값이랑 같은 시의 모든주소값을 가져온다.
	ArrayList<AddressCodeVO> getSameSiGungu(@Param("si") String si,@Param("gungu") String gungu);//입력값이랑 같은 시의 모든주소값을 가져온다.
	ArrayList<AddressCodeVO> getSameSiDong(@Param("si") String si,@Param("dong") String dong);//입력값이랑 같은 시의 모든주소값을 가져온다.
	//주소  (시,구,동) 검색
	ArrayList<AddressCodeVO> getSameSiGunguDong(@Param("si") String si, @Param("gungu") String gungu,@Param("dong") String dong);//입력값이랑 같은 시구 동 의 모든주소값을 가져온다.
	
	//지하철역 검색
	ArrayList<MetroVO> getSameMetro(@Param("name") String name);//지하철역 이름에 포함되면 자동완성단어 get
	
	//매물 번지수 검색
	ArrayList<RoomItemVO> getSameRoomItemAboutBunji(@Param("main_address") String main_address, @Param("sub_address") String sub_address);//매물 번지수 앞과 뒤의 검색
	
	//매물번호 검색
	ArrayList<RoomItemVO> getSameRoomItemAboutNo(@Param("no") String no);//매물 번호로의 검색

	/*****************************************검색 ***********************************************/
	//섹터검색
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutFilterSection(@Param("sector_name") String sector_name ,@Param("userNo") Integer userNo, 
			@Param("pMap") HashMap<String, String> pMap, @Param("sort") String sort, @Param("pg") Integer pg ,  @Param("roomNumPerPage") Integer roomNumPerPage);//섹터이름을 통해 매물 방의 정보를 가져옴
	Integer getCountRoomAboutSection(@Param("sector_name") String sector_name ,@Param("userNo") Integer userNo, 
			@Param("pMap") HashMap<String, String> pMap);//섹터검색 결과수
	
	//주소검색
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutAddress(@Param("addressCode") long addressCode ,@Param("userNo") Integer userNo, 
			@Param("sort") String sort, @Param("pg") Integer pg, @Param("roomNumPerPage") Integer roomNumPerPage );//주소코드를 통해 매물 방의 정보를 가져옴
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutFilterAddress(@Param("addressCode") long addressCode ,@Param("userNo") Integer userNo, 
			@Param("pMap") HashMap<String, String> pMap, @Param("sort") String sort, @Param("pg") Integer pg ,  @Param("roomNumPerPage") Integer roomNumPerPage);
	Integer getCountRoomAboutAddress(@Param("addressCode") long addressCode ,@Param("userNo") Integer userNo, @Param("pMap") HashMap<String, String> pMap);//지도검색결과수

	//번지검색
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutFilterBunji(@Param("main_address") int main_address, @Param("sub_address") int sub_address, @Param("userNo") Integer userNo,
			@Param("pMap")  HashMap<String, String> mapAboutFilter, @Param("sort") String sort, @Param("pg") Integer pg ,  @Param("roomNumPerPage") Integer roomNumPerPage);//번지 검색결과
	Integer getCountRoomAboutBunji(@Param("main_address") int main_address, @Param("sub_address") int sub_address, @Param("userNo") Integer userNo,
			@Param("pMap")  HashMap<String, String> mapAboutFilter);//번지 검색결과수

	//지하철 번호검색
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutMetroNo(@Param("metroNo") Integer metroNo , @Param("userNo") Integer userNo, 
			@Param("sort") String sort,@Param("pg") Integer pg, @Param("roomNumPerPage") Integer roomNumPerPage);//지하철 번호를 통해 매물 방의 정보를 가져옴
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutFilterMetroNo(@Param("metroNo") Integer metroNo , @Param("userNo") Integer userNo,
			@Param("pMap") HashMap<String, String> pMap, @Param("sort") String sort,@Param("pg") Integer pg ,  @Param("roomNumPerPage") Integer roomNumPerPage);
	Integer getCountRoomAboutMetroNo(@Param("metroNo") Integer metroNo , @Param("userNo") Integer userNo, @Param("pMap") HashMap<String, String> pMap);//지하철코드검색 결과수
	Integer getMetroCodeAboutMetroName(String metroName);//지하철역이름으로 지하철역 코드 가져오기
	
	//지도검색
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutGeo(@Param("s") String s, @Param("w") String w,@Param("n") String n,@Param("e") String e, @Param("userNo") Integer userNo,
		 @Param("sort") String sort,  @Param("pg") Integer pg ,  @Param("roomNumPerPage") Integer roomNumPerPage);
	ArrayList<SearchRoomSumary> getSpecificRoomItemAboutFilterGeo(@Param("s") String s, @Param("w") String w,@Param("n") String n,@Param("e") String e,  @Param("userNo") Integer userNo,
			@Param("pMap") HashMap<String, String> pMap, @Param("sort") String sort,  @Param("pg") Integer pg ,  @Param("roomNumPerPage") Integer roomNumPerPage);
	Integer getCountRoomAboutGeo(@Param("s") String s, @Param("w") String w,@Param("n") String n,@Param("e") String e,
			@Param("userNo") Integer userNo, @Param("pMap") HashMap<String, String> pMap);//좌표범위검색 결과수

	//검색시에 가져올 추가 정보
	ArrayList<String> getFakeUrlList( @Param("no") Integer no);//매물번호에 맞는 사진 경로를 가져옴
	Integer getZzimNo( @Param("no") Integer no, @Param("loginNo") Integer loginNo);//회원의 매물번호에 맞는 찜번호를 가져옴

	
}


