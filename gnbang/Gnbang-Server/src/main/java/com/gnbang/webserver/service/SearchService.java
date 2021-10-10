package com.gnbang.webserver.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.gnbang.webserver.dto.AddressCodeVO;
import com.gnbang.webserver.dto.MetroVO;
import com.gnbang.webserver.dto.RoomItemVO;
import com.gnbang.webserver.service.SearchService;
import com.gnbang.webserver.service.function.RoomAddressFunction;
import com.gnbang.webserver.mapper.SearchMapper;
import com.gnbang.webserver.object.AutoWord;
import com.gnbang.webserver.object.SearchRoomSumary;

import java.util.Comparator;
//JoinController에서 사용
@Service
public class SearchService {

	private final static Logger logger = LoggerFactory.getLogger(SearchService.class);
	@Autowired
	private SearchMapper searchMapper;
	private int roomNumPerPage = 10;//방 검색시 한페이지에 보여지는 방의수

//*자동완성 또는 통합검색
	//input  : 검색창에서 검색중인 단어
	//output : 시/구/동 주소 관련 모든경우의 수를 고려한 자동검색단어(중복 데이터 존재)
	public ArrayList<AddressCodeVO> getAllAutoAddressCode(String searchWord){
		//전국지역 확대시
		/*logger.debug("getAllAutoAddressCode service function");
		//자동완성 결과 (시 ,구 ,동)를 string과 객체로 보관
		ArrayList<AddressCodeVO> addressWords = null;
		ArrayList<AddressCodeVO> addressTempCodes = null;
		
        String[] searchWords = searchWord.split(" ") ;
        int size = 0;//찾는 문장에서 단어의 개수
        for(int i=0; i < searchWords.length; i++){
        	if(searchWords[i].length() > 0)
        		size++;
        }
        if(size == 1){//입력단어의 수가 1개이면 시, 구, 동 에서 각각 찾는다.
        	//*동으로 검색해서 모든 주소를 가져온다.
        	addressWords =  searchMapper.getSameDong(searchWords[0]);//동으로 검색한 결과를 가져옴
        	addressTempCodes =  searchMapper.getSameGungu(searchWords[0]);//군으로 검색한 결과를 가져옴
            for(int a = 0; a < addressTempCodes.size(); a++){//받아온 군 검색결과까지 데이터를 삽입
            	addressWords.add(addressTempCodes.get(a));
            }
        	addressTempCodes =  searchMapper.getSameSi(searchWords[0]);//시로 검색한 결과를 가져옴 
            for(int a = 0; a<addressTempCodes.size(); a++){//받아온 시 검색결과까지 데이터를 삽입
            	addressWords.add(addressTempCodes.get(a));
            }
        } else if(size == 2){//입력단어의 수가2개이면 시/구, 구/동, 시/동 에서 각각 찾는다.
        	//동으로 검색해서 모든 주소를 가져온다.
        	addressWords =  searchMapper.getSameGunguDong(searchWords[0], searchWords[1]);//군/동으로 검색한 결과를 가져옴
        	addressTempCodes =  searchMapper.getSameSiGungu(searchWords[0], searchWords[1]);//시/군 으로 검색한 결과를 가져옴
            for(int a = 0; a < addressTempCodes.size(); a++){//시/군 으로 검색한 결과까지 데이터를 삽입
            	addressWords.add(addressTempCodes.get(a));
            }
        	addressTempCodes =  searchMapper.getSameSiDong(searchWords[0], searchWords[1]);//시/동 으로 검색한 결과를 가져옴 
            for(int a = 0; a<addressTempCodes.size(); a++){//받아온 시/동  검색결과까지 데이터를 삽입
            	addressWords.add(addressTempCodes.get(a));
            }
        } else if(size == 3){
        	addressWords =  searchMapper.getSameSiGunguDong(
        				searchWords[0], searchWords[1], searchWords[2]);//시/군/동으로 검색한 결과를 가져옴
        }
		return addressWords;*/
		
		//강남구 검색
		logger.debug("getAllAutoAddressCode service function");
		//자동완성 결과 (시 ,구 ,동)를 string과 객체로 보관
		ArrayList<AddressCodeVO> addressWords = new ArrayList<AddressCodeVO>();
		ArrayList<AddressCodeVO> addressTempCodes = new ArrayList<AddressCodeVO>();
		
        String[] searchWords = searchWord.split(" ") ;
        int size = 0;//찾는 문장에서 단어의 개수
        for(int i=0; i < searchWords.length; i++){
        	if(searchWords[i].length() > 0)
        		size++;
        }
        if(size == 1){//입력단어의 수가 1개이면 시, 구, 동 에서 각각 찾는다.
        	addressWords =  searchMapper.getSameSiGunguDong(
    				"서울", "강남", searchWords[0]);//시/군/동으로 검색한 결과를 가져옴
        	addressTempCodes =   searchMapper.getSameSiGunguDong(
    				"서울", "서초", searchWords[0]);//시/군/동으로 검색한 결과를 가져옴
            for(int a = 0; a<addressTempCodes.size(); a++){//받아온 시/동  검색결과까지 데이터를 삽입
            	addressWords.add(addressTempCodes.get(a));
            }
            addressTempCodes =   searchMapper.getSameSiGunguDong(
    				"서울", "송파", searchWords[0]);//시/군/동으로 검색한 결과를 가져옴
            for(int a = 0; a<addressTempCodes.size(); a++){//받아온 시/동  검색결과까지 데이터를 삽입
            	addressWords.add(addressTempCodes.get(a));
            }
        } else if(size == 2){//입력단어의 수가2개이면 시/구, 구/동, 시/동 에서 각각 찾는다.
        	addressWords =  searchMapper.getSameSiGunguDong(
    				"서울",  searchWords[0], searchWords[1]);//시/군/동으로 검색한 결과를 가져옴
        } else if(size == 3){
        	addressWords =  searchMapper.getSameSiGunguDong(
    				"서울", searchWords[1], searchWords[2]);//시/군/동으로 검색한 결과를 가져옴
        }
		return addressWords;
	}
		
	//input  : 검색창에서 검색중인 단어
	//output : 지하철역 관련 자동 검색단어 
	private ArrayList<MetroVO> getAutoMetro(String searchWord) {
		logger.debug("getAutoAddressWord service function");
		ArrayList<MetroVO> stationWords = new ArrayList<MetroVO>();
        String[] searchWords = searchWord.split(" ");
        int size = 0;//찾는 문장에서 단어의 개수
        for(int i=0; i < searchWords.length; i++){
        	if(searchWords[i].length() > 0)
        		size++;
    		if(size != 1)//단어의 수가 2개이상이면 역 이름에서 찾지 않음
    			return stationWords;
        }
        stationWords =  searchMapper.getSameMetro(searchWords[0]);//역 이름으로 검색하여 최대 5개의 자동완성 단어를 얻음
		return stationWords;
	}

	//input  : 검색창에서 검색중인 단어
	//output : 번지수 관련 자동검색단어
	private ArrayList<RoomItemVO> getSameRoomItemAboutBunji(String searchWord) {
		logger.debug("getAutoBunji service function");
		ArrayList<RoomItemVO> roomWords = new ArrayList<RoomItemVO>();
		if(0 < searchWord.length())
			searchWord = searchWord.substring(1,searchWord.length());
        String[] searchWords = searchWord.split("-") ;
        int size = 0;//찾는 문장에서 단어의 개수
        //-를 기준으로 앞과 뒤의 숫자를 분리해서 번지수를 찾음 
        for(int i=0; i < searchWords.length; i++){
        	if(searchWords[i].length() > 0)
        		size++;
    		if(2 < size)//단어의 수가3개이상이면 역 이름에서 찾지 않음(번지는 '-' 를 기준 1또는 2개단어임)
    			return roomWords;
        }
        String main_address =searchWords[0];
        String sub_address = "";
        if(1 < searchWords.length)//번지수의 앞의값 뒤의값 모두 존재하면(형태 : 11 - 11)
        	sub_address = searchWords[1];//번지수 뒤의값 기본설정
        roomWords =  searchMapper.getSameRoomItemAboutBunji(main_address, sub_address);//번지 앞과 뒤자리로 최대 5개의 자동완성 단어를 찾음		logger.debug("contain getRoomItemBunji size: " + roomWords.size());
        return roomWords;
	}

	//input  : 검색창에서 검색중인 단어
	//output : 매물번호 관련 자동 검색단어 
	private ArrayList<RoomItemVO> getSameRoomItemAboutNo(String searchWord){
		logger.debug("getSameRoomItemAboutNo service function");
		ArrayList<RoomItemVO> roomWords = new ArrayList<RoomItemVO>();
        String[] searchWords = searchWord.split(" ") ;
        int size = 0;//찾는 문장에서 단어의 개수
        for(int i=0; i < searchWords.length; i++){
        	if(searchWords[i].length() > 0)
        		size++;
    		if(size != 1)//단어의 수가 2개이상이면 역 이름에서 찾지 않음
    			return roomWords;
        }
        roomWords =  searchMapper.getSameRoomItemAboutNo(searchWords[0]);//매물번호로 검색하여 최대 5개의 자동완성 단어를 얻음
		logger.debug("contain getRoomItemNum size: " + roomWords.size());
		return roomWords;
	}
	
	//input  : 검색창에서 검색중인 단어
	//output : 자동 검색단어 
	public ArrayList<AutoWord> getAutoWord(String searchWord, int autoWordNum) {
		logger.debug("getAutoWord service function");
		ArrayList<AutoWord> autoWordList = new ArrayList<AutoWord>();//자동완성 단어들의 정보들을 가짐
		//검색단어의 자료형  매물번호 또는 번지수의 형태인지 확인 
		boolean searchIsInt = true;
		try{
			Integer.parseInt(searchWord);
			searchIsInt = true;//숫자만 존재하면 매물번호 가능
		}catch (Exception e){ 
			searchIsInt = false;
		}
		/*if(searchIsInt){//검색단어가 숫자만일때
			//매물번호에서 유사 매물번호를 가져옴
			ArrayList<RoomItemVO> roomItemNoList = getSameRoomItemAboutNo(searchWord);
			if(roomItemNoList.size() != 0){
				for(int i=0; i< roomItemNoList.size() && autoWordList.size() < autoWordNum; i++)//시/군/동으로 얻은 주소데이터를 자동완성 단어에 추가
					autoWordList.add(new AutoWord(roomItemNoList.get(i).getNo()+"", " " ," (매물)" , roomItemNoList.get(i).getNo()+"" , "roomNo" ));
			}
		}*/
		if(searchWord.charAt(0) == '#'){//검색단어가 #으로 번지수 일때
			if(0 < searchWord.length())
				searchWord = searchWord.substring(1,searchWord.length());//#제외한 번지수
			//- 표시를 확인하고 번지수를 가져옴
			ArrayList<RoomItemVO> bunjiList = getSameRoomItemAboutBunji(searchWord);
			if(bunjiList.size() != 0){
				for(int i=0; i< bunjiList.size() && autoWordList.size() < autoWordNum; i++)//번지수로 얻은 번지수데이터를 자동완성 단어에 추가
					autoWordList.add(new AutoWord(bunjiList.get(i).getMain_address()+"-"+bunjiList.get(i).getSub_address(), 
							" "+ bunjiList.get(i).getLast_address()+" " ," (주소)" , bunjiList.get(i).getNo()+"" , "bunji" ));
			}
			if(autoWordNum <= autoWordList.size())//자동완성단어가 5개가 됐으면 결정
				return autoWordList;
		}
		if(!searchIsInt){ //검색단어가 문자열 일때
			//시/군/동에서 유사 주소를 가져옴
			ArrayList<AddressCodeVO> addressList =  getAllAutoAddressCode(searchWord);//주어진 검색문장을 포함하는 시/군/동 데이터들을 get
			if(addressList.size() != 0){
				for(int i=0; i< addressList.size() && autoWordList.size() < autoWordNum; i++){//시/군/동으로 얻은 주소데이터를 자동완성 단어에 추가
					autoWordList.add(new AutoWord(addressList.get(i).getSi(),
							addressList.get(i).getGungu(),addressList.get(i).getDong(),
							addressList.get(i).getCode()+"","addressCode"));
				}
			}
			//자동완성단어가 5개가 됐으면 결정
			if(autoWordNum <= autoWordList.size())
				return autoWordList;
			//지하철역에서 유사 지하철역 이름을 가져옴
			ArrayList<MetroVO> stationNameList = getAutoMetro(searchWord);//주어진 검색문장을 포함하는 지하철역 데이터들을 get
			if(stationNameList.size() != 0){
				for(int i=0; i< stationNameList.size(); i++)//시/군/동으로 얻은 주소데이터를 자동완성 단어에 추가
					autoWordList.add(new AutoWord(stationNameList.get(i).getName()+"", "" ,"" , stationNameList.get(i).getNo()+"" ,"metro"));
			}
		}
		return autoWordList;
	}
	
	//주소번지,매물번호,지역명,지하철역 이름으로 매물 검색
	public ArrayList<SearchRoomSumary> getSpecificRoomItemAboutSearchWord(String searchWord, Integer userNo, String p,String sort, Integer pg) {
		logger.debug("getSpecificRoomItemAboutSearchWord service function");
		ArrayList<SearchRoomSumary> searchRoomSumary = new ArrayList<SearchRoomSumary>();
		if(searchWord.charAt(0) == '#'){//1.번지
			//번지로 매물검색
			logger.debug("bunji search");
			//#표시를 확인하고 번지수를 가져옴
			ArrayList<RoomItemVO> bunjiList = getSameRoomItemAboutBunji(searchWord);
			ArrayList<SearchRoomSumary> tempList;
			if(bunjiList.size() != 0){
				tempList = getSpecificRoomItemAboutBunji(bunjiList.get(0).getMain_address(),bunjiList.get(0).getSub_address(),  userNo, p, sort, pg);
				for(int j=0; j< tempList.size(); j++)//하나의 검색어에 대한 검색 결과 만큼
					searchRoomSumary.add(tempList.get(j));//검색결과의 매물을 담음
			}
		} else if(searchWord.charAt(searchWord.length() - 1) == '역'){//2.지하철역
			//지하철역이름으로 매물검색
			logger.debug("station search");
			//지하철역에서 유사 지하철역 이름을 가져옴
			ArrayList<MetroVO> stationNameList = getAutoMetro(searchWord);//주어진 검색문장을 포함하는 지하철역 데이터들을 get
			ArrayList<SearchRoomSumary> tempList;
			if(stationNameList.size() != 0){
				int allSize = 0; 
				int firstItemIndex = 0;
				int tempSize = 0;
				for(int i=0; i< stationNameList.size();i++){//지역 검색어 목록수만큼
					tempSize = getCountRoomAboutMetroNo(stationNameList.get(i).getNo(), userNo, p);
					if(tempSize == 0)
						continue;
					if((pg-1) * 10 <= allSize){//가져오는 리스트들중에 처음이 아니면
						tempList = getSpecificRoomItemAboutMetroNo(stationNameList.get(i).getNo(), userNo, p, sort, 1);
						for(int a=0; a< tempList.size() && searchRoomSumary.size() < 10 ; a++)//0인덱스 부터 가져옴
							searchRoomSumary.add(tempList.get(a));//검색결과의 매물을 담음
					}else if((pg-1) * 10 <= allSize + tempSize){//가져오는 리스트들중에 처음이면
						for(int j = 1; j < tempSize && j < 10; j++){
							//페이지에 표시될 첫 매물의 인덱스를 계산
							if((allSize + j)%10 == 0){
								firstItemIndex = j;
								break;
							}
						}
						pg -= allSize/10;
						//매물정보를 가져옴
						if(firstItemIndex != 0){//가져올 첫 리스트에서의 인덱스가 0부터이면
							tempList = getSpecificRoomItemAboutMetroNo(stationNameList.get(i).getNo(), userNo, p, sort, pg - 1);
							for(int a=firstItemIndex; a< tempList.size() && searchRoomSumary.size() < 10 ; a++)//처음 표시할 인덱스부터 가져옴
								searchRoomSumary.add(tempList.get(a));//검색결과의 매물을 담음
						}
						ArrayList<SearchRoomSumary> tempList2 = getSpecificRoomItemAboutMetroNo(stationNameList.get(i).getNo(), userNo, p, sort, pg);
						for(int a=0; a< tempList2.size() && searchRoomSumary.size() < 10 ; a++)//처음 표시할 인덱스부터 가져옴
							searchRoomSumary.add(tempList2.get(a));//검색결과의 매물을 담음
					}
					if(searchRoomSumary.size() == 10)
						return searchRoomSumary;
					allSize += tempSize;
				}
			}
		} else{
			try{
				Integer.parseInt(searchWord);
			}catch (Exception e){ //3.지역명(문자열이면)
				//지역명으로 매물검색
				logger.debug("local search");
				ArrayList<AddressCodeVO> addressList =  getAllAutoAddressCode(searchWord);//주어진 검색문장을 포함하는 시/군/동 데이터들을 get
				ArrayList<SearchRoomSumary> tempList;
				if(addressList.size() != 0){
					int allSize = 0; 
					int firstItemIndex = 0;
					int tempSize = 0;
					for(int i=0; i< addressList.size();i++){//지역 검색어 목록수만큼
						tempSize = getCountRoomAboutAddress(addressList.get(i).getCode(), userNo, p);
						if(tempSize == 0)
							continue;
						if((pg-1) * 10 <= allSize){//가져오는 리스트들중에 처음이 아니면
							tempList = getSpecificRoomItemAboutAddress(addressList.get(i).getCode(), userNo, p, sort, 1);
							for(int a=0; a< tempList.size() && searchRoomSumary.size() < 10 ; a++)//0인덱스 부터 가져옴
								searchRoomSumary.add(tempList.get(a));//검색결과의 매물을 담음
						}else if((pg-1) * 10 <= allSize + tempSize){//가져오는 리스트들중에 처음이면
							for(int j = 1; j < tempSize && j < 10; j++){
								//페이지에 표시될 첫 매물의 인덱스를 계산
								if((allSize + j)%10 == 0){
									firstItemIndex = j;
									break;
								}
							}
							pg -= allSize/10;
							//매물정보를 가져옴
							if(firstItemIndex != 0){//가져올 첫 리스트에서의 인덱스가 0부터이면
								tempList = getSpecificRoomItemAboutAddress(addressList.get(i).getCode(), userNo, p, sort, pg - 1);
								for(int a=firstItemIndex; a< tempList.size() && searchRoomSumary.size() < 10 ; a++)//처음 표시할 인덱스부터 가져옴
									searchRoomSumary.add(tempList.get(a));//검색결과의 매물을 담음
							}
							ArrayList<SearchRoomSumary> tempList2 = getSpecificRoomItemAboutAddress(addressList.get(i).getCode(), userNo, p, sort, pg);
							for(int a=0; a< tempList2.size() && searchRoomSumary.size() < 10 ; a++)//처음 표시할 인덱스부터 가져옴
								searchRoomSumary.add(tempList2.get(a));//검색결과의 매물을 담음
						}
						if(searchRoomSumary.size() == 10)
							return searchRoomSumary;
						allSize += tempSize;
					}
				}
			}
		}
		return searchRoomSumary;
	}
//*매물을 검색
	//섹터이름으로 검색
	public ArrayList<SearchRoomSumary> getSpecificRoomItemAboutSector(String sector_name, int userNo, String p,
			String sort, Integer pg) {
		logger.debug("getSpecificRoomItemAboutSector service");
		if(sort.equals(""))
			sort ="photo desc, date desc";//사진 있는 매물을 먼저나오게 정렬
		else
			sort = sort + ",photo desc";//사진 있는 매물을 먼저나오게 정렬
		
		//매물정보를 가져옴
		ArrayList<SearchRoomSumary> searchRoomSumary;
		//검색
		searchRoomSumary = searchMapper.getSpecificRoomItemAboutFilterSection(sector_name, userNo, getMapAboutFilter(p), sort ,(pg-1)*roomNumPerPage , roomNumPerPage );
		//매물의 사진정보를 가져와 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setFake_url(searchMapper.getFakeUrlList(searchRoomSumary.get(a).getNo()));
		//매물의 찜 정보를 가져와 찜여부 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setZzim_no(searchMapper.getZzimNo(searchRoomSumary.get(a).getNo(), userNo));
		return searchRoomSumary;
	}
	//주소코드와 필터내용으로 매물 검색
	public ArrayList<SearchRoomSumary> getSpecificRoomItemAboutAddress(long addressCode , Integer userNo,  String p, String sort,  Integer pg) {
		logger.debug("getSpecificRoomItemAboutAddress service");
		if(sort.equals(""))
			sort ="photo desc, date desc";//사진 있는 매물을 먼저나오게 정렬
		else
			sort = sort + ",photo desc";//사진 있는 매물을 먼저나오게 정렬
		
		//매물정보를 가져옴
		ArrayList<SearchRoomSumary> searchRoomSumary;
		//검색
		searchRoomSumary = searchMapper.getSpecificRoomItemAboutFilterAddress(addressCode, userNo, getMapAboutFilter(p), sort ,(pg-1)*roomNumPerPage , roomNumPerPage );
		//매물의 사진정보를 가져와 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setFake_url(searchMapper.getFakeUrlList(searchRoomSumary.get(a).getNo()));
		//매물의 찜 정보를 가져와 찜여부 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setZzim_no(searchMapper.getZzimNo(searchRoomSumary.get(a).getNo(), userNo));
		return searchRoomSumary;
	}
	//번지수 앞과 뒤, 필터내용으로 매물 검색
	private ArrayList<SearchRoomSumary> getSpecificRoomItemAboutBunji(int main_address, int sub_address, Integer userNo,
			String p, String sort, Integer pg) {
		if(sort.equals(""))
			sort ="photo desc, date desc";//사진 있는 매물을 먼저나오게 정렬
		else
			sort = sort + ",photo desc";//사진 있는 매물을 먼저나오게 정렬
		
		ArrayList<SearchRoomSumary> searchRoomSumary;
		//검색
		searchRoomSumary = searchMapper.getSpecificRoomItemAboutFilterBunji(main_address, sub_address, userNo, getMapAboutFilter(p), sort , (pg-1)*roomNumPerPage , roomNumPerPage );
		//매물의 사진정보를 가져와 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setFake_url(searchMapper.getFakeUrlList(searchRoomSumary.get(a).getNo()));
		//매물의 찜 정보를 가져와 찜여부 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setZzim_no(searchMapper.getZzimNo(searchRoomSumary.get(a).getNo(), userNo));
		return searchRoomSumary;
	}
	//지하철코드와 필터내용으로 매물 검색
	public ArrayList<SearchRoomSumary> getSpecificRoomItemAboutMetroNo(Integer metroNo, Integer userNo,  String p, String sort, Integer pg) {
		logger.debug("getSpecificRoomItemAboutMetroNo service");
		if(sort.equals(""))
			sort ="photo desc, date desc";//사진 있는 매물을 먼저나오게 정렬
		else
			sort = sort + ",photo desc";//사진 있는 매물을 먼저나오게 정렬
		
		//매물정보를 가져옴
		ArrayList<SearchRoomSumary> searchRoomSumary;
		
		//검색
		searchRoomSumary = searchMapper.getSpecificRoomItemAboutFilterMetroNo(metroNo,userNo,  getMapAboutFilter(p), sort , (pg-1)*roomNumPerPage , roomNumPerPage );
		//매물의 사진정보를 가져와 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setFake_url(searchMapper.getFakeUrlList(searchRoomSumary.get(a).getNo()));
		//매물의 찜 정보를 가져와 찜여부 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setZzim_no(searchMapper.getZzimNo(searchRoomSumary.get(a).getNo(), userNo));
		return searchRoomSumary;
	}
	//지도위치와 필터내용으로 매물 검색
	public ArrayList<SearchRoomSumary> getSpecificRoomItemAboutGeo(
			String s, String w, String n, String e , Integer userNo,  String p, String sort,  Integer pg){
		if(sort.equals(""))
			sort ="photo desc, date desc";//사진 있는 매물을 먼저나오게 정렬
		else
			sort = sort + ",photo  desc";//사진 있는 매물을 먼저나오게 정렬
		
		ArrayList<SearchRoomSumary> searchRoomSumary;
		
		//검색
		searchRoomSumary = searchMapper.getSpecificRoomItemAboutFilterGeo(s,w,n,e, userNo, getMapAboutFilter(p), sort , (pg-1)*roomNumPerPage , roomNumPerPage );
		//매물의 사진정보를 가져와 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setFake_url(searchMapper.getFakeUrlList(searchRoomSumary.get(a).getNo()));
		//매물의 찜 정보를 가져와 찜여부 설정
		for(int a=0; a<searchRoomSumary.size(); a++)
			searchRoomSumary.get(a).setZzim_no(searchMapper.getZzimNo(searchRoomSumary.get(a).getNo(), userNo));
		return searchRoomSumary;
	}


//*검색결과수	
	//주소번지,매물번호,지역명,지하철역 이름으로 매물 검색한 결과수
	public int getCountRoomAboutSearchWord(String searchWord, int userNo, String p) {
		logger.debug("getSpecificRoomItemAboutSearchWord service function");
		int count = 0;
		if(searchWord.charAt(0) == '#'){//1.번지
			//번지로 매물검색
			logger.debug("bunji search");
			//#표시를 확인하고 번지수를 가져옴
			ArrayList<RoomItemVO> bunjiList = getSameRoomItemAboutBunji(searchWord);
			if(bunjiList.size() != 0)
				count = getCountRoomAboutBunji(bunjiList.get(0).getMain_address(),bunjiList.get(0).getSub_address(), userNo, p);
			
		} else if(searchWord.charAt(searchWord.length() - 1) == '역'){//2.지하철역
			//지하철역이름으로 매물검색
			logger.debug("station search");
			//지하철역에서 유사 지하철역 이름을 가져옴
			ArrayList<MetroVO> stationNameList = getAutoMetro(searchWord);//주어진 검색문장을 포함하는 지하철역 데이터들을 get
			if(stationNameList.size() != 0){
				for(int i=0; i< stationNameList.size();i++)//지하철역 이름 검색어 목록만큼
					count += getCountRoomAboutMetroNo(stationNameList.get(i).getNo(), userNo, p);
			}
		} else{
			try{
				Integer.parseInt(searchWord);
			}catch (Exception e){ //3.지역명(문자열이면)
				//지역명으로 매물검색
				logger.debug("local search");
				//시/군/동에서 유사 주소를 가져옴
				ArrayList<AddressCodeVO> addressList =  getAllAutoAddressCode(searchWord);//주어진 검색문장을 포함하는 시/군/동 데이터들을 get
				if(addressList.size() != 0){
					for(int i=0; i< addressList.size();i++)//시/군/동의 검색어 목록만큼
						count += getCountRoomAboutAddress(addressList.get(i).getCode(), userNo, p);
				}
			}
		}
		return count;
	}
	//섹션이름과 필터내용으로 매물 검색한 결과수
	public int getCountRoomAboutSector(String sector_name, int loginNo, String p) {
		int searchCount = 0;
		searchCount = searchMapper.getCountRoomAboutSection(sector_name, loginNo, getMapAboutFilter(p));
		return searchCount;
	}
	//주소코드와 필터내용으로 매물 검색한 결과수
	public int getCountRoomAboutAddress(long addressCode, int loginNo, String p) {
		int searchCount = 0;
		searchCount = searchMapper.getCountRoomAboutAddress(addressCode, loginNo, getMapAboutFilter(p));
		return searchCount;
	}
	//번지로 매물 검색한 결과수
	public int getCountRoomAboutBunji(int main_address, int sub_address, int userNo, String p) {
		logger.debug("getCountRoomAboutSearchWord service");
		int searchCount = 0;
		searchCount = searchMapper.getCountRoomAboutBunji(main_address, sub_address, userNo, getMapAboutFilter(p));
		return searchCount;
	}
	//지하철코드와 필터내용으로 매물 검색한 결과수
	public int getCountRoomAboutMetroNo(Integer metroNo, int loginNo, String p) {
		int searchCount = 0;
		searchCount = searchMapper.getCountRoomAboutMetroNo(metroNo, loginNo, getMapAboutFilter(p));
		return searchCount;
	}
	//지도위치와 필터내용으로 매물 검색한 결과수
	public int getCountRoomAboutGeo(String s, String w, String n, String e, int loginNo, String p) {
		logger.debug("getCountRoomAboutGeo");
		int searchCount = 0;
		searchCount = searchMapper.getCountRoomAboutGeo(s,w,n,e, loginNo, getMapAboutFilter(p));
		return searchCount;
	}
	
	//지하철역의 이름으로 지하철여그이 코드를 가져옴
	public int getMetroCodeAboutMetroName(String metroName) {
		logger.debug("getCountRoomAboutGeo");
		int metroCode = 0;
		metroCode = searchMapper.getMetroCodeAboutMetroName(metroName);
		return metroCode;
	}
	
	private  HashMap<String , String>  getMapAboutFilter(String p){
		if(p.length() == 0)
			p =":::::0:999999999:0:999999999:0:999999999:0:999999999"
					+ "::::::::::2017::::::::::::0:999999999:0:999999999"
					+ "::::::::::::::::::::::::::::";
		String[] filterSprit = p.split(":", -1);
	    ArrayList<String> arr = new ArrayList<String>();
        for(int a=0; a< filterSprit.length;a++){
    		   arr.add(filterSprit[a]);
        }
        HashMap<String , String> pMap = new HashMap<String , String>();

        //거래종류
        pMap.put("trade", arr.get(FILTER_SETTING.TRADE.filterNo));//매매         
		pMap.put("charter",arr.get(FILTER_SETTING.CHARTER.filterNo) );//전세
        pMap.put("monthly_and_charter", arr.get(FILTER_SETTING.MONTHLY_AND_CHARTER.filterNo));//전월세
        pMap.put("monthly",arr.get(FILTER_SETTING.MONTYLY.filterNo));//월세
        pMap.put("short_lease", arr.get(FILTER_SETTING.SHORT_LEASE.filterNo));//단기 임대

        //금액
        pMap.put("depositmin", arr.get(FILTER_SETTING.DEPOSITMIN.filterNo));//보증금 최소
        pMap.put("depositmax", arr.get(FILTER_SETTING.DEPOSITMAX.filterNo));//보증금 최대
        pMap.put("monthmin", arr.get(FILTER_SETTING.MONTHMIN.filterNo));//월세 최소
        pMap.put("monthmax", arr.get(FILTER_SETTING.MONTHMAX.filterNo));//월세 최대
        pMap.put("chartermin",arr.get(FILTER_SETTING.CHARTERMIN.filterNo));//전세 최소
        pMap.put("chartermax", arr.get(FILTER_SETTING.CHARTERMAX.filterNo));//전세 최대
        pMap.put("standardmin", arr.get(FILTER_SETTING.STANDARDMIN.filterNo));//기준가 최소
        pMap.put("standardmax", arr.get(FILTER_SETTING.STANDARDMAX.filterNo));//기준가 최대
        
        //건물형태
        pMap.put("apartment", arr.get(FILTER_SETTING.APARTMENT.filterNo));//아파트
        pMap.put("officetel", arr.get(FILTER_SETTING.OFFICETEL.filterNo));//오피스텔
        pMap.put("house", arr.get(FILTER_SETTING.HOUSE.filterNo));//주택
        pMap.put("normal_room",arr.get(FILTER_SETTING.NORMAL_ROOM.filterNo));//원룸
        pMap.put("shop", arr.get(FILTER_SETTING.SHOP.filterNo));//상가
        pMap.put("office", arr.get(FILTER_SETTING.OFFICE.filterNo));//사무실
        pMap.put("building", arr.get(FILTER_SETTING.BUILDING.filterNo));//건물
		pMap.put("redevelopment",  arr.get(FILTER_SETTING.REDEVELOPMENT.filterNo));//재개발
        pMap.put("event", arr.get(FILTER_SETTING.EVENT.filterNo));//이벤트
        
        //준공년도와 번지수
        pMap.put("built", arr.get(FILTER_SETTING.BUILT.filterNo));//준공년도
        pMap.put("address", arr.get(FILTER_SETTING.ADDRESS.filterNo));//번지
        
        //방 형태 room_type로 매칭 
        pMap.put("open_room", arr.get(FILTER_SETTING.OPEN_ROOM.filterNo));//오픈형
        pMap.put("part_room", arr.get(FILTER_SETTING.PART_ROOM.filterNo));//분리형
        pMap.put("duplex_room", arr.get(FILTER_SETTING.DUPLEX_ROOM.filterNo));//복층형
        
  		//룸개수 room_count
        pMap.put("one_room",arr.get(FILTER_SETTING.OND_ROOM.filterNo));//1룸
        pMap.put("two_room",arr.get(FILTER_SETTING.TRO_ROOM.filterNo));//2룸
        pMap.put("three_room",arr.get(FILTER_SETTING.THREE_ROOM.filterNo));//3룸
        		
  		//방위치
        pMap.put("up_ground", arr.get(FILTER_SETTING.UP_GROUND.filterNo));//지상
        pMap.put("under_ground", arr.get(FILTER_SETTING.UNDER_GROUND.filterNo));//지하
        pMap.put("semi_basement", arr.get(FILTER_SETTING.SEMI_BASEMENT.filterNo));//반지하
        pMap.put("rooftop", arr.get(FILTER_SETTING.ROOFTOP.filterNo));//옥탑방
        
  		//면적
        pMap.put("exclusive_area_min", arr.get(FILTER_SETTING.EXCLUSIVE_AREA_MIN.filterNo));//전용면적 최소
        pMap.put("exclusive_area_max", arr.get(FILTER_SETTING.EXCLUSIVE_AREA_MAX.filterNo));//전용면적 최대
        pMap.put("leased_area_min", arr.get(FILTER_SETTING.LEASED_AREA_MIN.filterNo));//공급면적 최소
        pMap.put("leased_area_max", arr.get(FILTER_SETTING.LEASED_AREA_MAX.filterNo));//공급면적 최대
        
  		//옵션
        pMap.put("full_option_room", arr.get(FILTER_SETTING.FULL_OPTION_ROOM.filterNo));//풀옵션 최대
        pMap.put("airconditioner", arr.get(FILTER_SETTING.AIRCONDITIONER.filterNo));//에어컨
        pMap.put("refrigerator", arr.get(FILTER_SETTING.REFRIGERATO.filterNo));//냉장고
        pMap.put("washer", arr.get(FILTER_SETTING.WASHER.filterNo));//세탁기 
        pMap.put("tv", arr.get(FILTER_SETTING.TV.filterNo));//tv 
        pMap.put("microwave", arr.get(FILTER_SETTING.MICROWAVE.filterNo));//전자레인지  
        pMap.put("induction", arr.get(FILTER_SETTING.INDUCTION.filterNo));//인덕션 
        pMap.put("sink", arr.get(FILTER_SETTING.SINK.filterNo));//싱크대 
        pMap.put("gasrange", arr.get(FILTER_SETTING.GASRANGE.filterNo));//가스레인지 
        pMap.put("sofa", arr.get(FILTER_SETTING.SOFA.filterNo));//소파 
        pMap.put("bed", arr.get(FILTER_SETTING.BED.filterNo));//침대 
        pMap.put("built_in_closet", arr.get(FILTER_SETTING.BUILT_IN_CLOSET.filterNo));//붙박이장 
        pMap.put("dressing_table", arr.get(FILTER_SETTING.DRESSING_TABLE.filterNo));//화장대 
        pMap.put("veranda", arr.get(FILTER_SETTING.VERANDA.filterNo));//베란다 
        pMap.put("shoe_closet", arr.get(FILTER_SETTING.SHOE_CLOSET.filterNo));//신발장 
        pMap.put("door_security", arr.get(FILTER_SETTING.DOOR_SECURITY.filterNo));//현관보안 
        pMap.put("cctv", arr.get(FILTER_SETTING.CCTV.filterNo));//cctv 
        pMap.put("number_key", arr.get(FILTER_SETTING.NUMBER_KEY.filterNo));//자동번호키 
        
  		//기타옵션
        pMap.put("elevator", arr.get(FILTER_SETTING.ELEVATOR.filterNo));//엘리베이터 
        pMap.put("parking", arr.get(FILTER_SETTING.PARKING.filterNo));//주차가능 
        pMap.put("animal", arr.get(FILTER_SETTING.ANIMAL.filterNo));//반려동물 
        pMap.put("empty", arr.get(FILTER_SETTING.EMPTY.filterNo));//공실 
        pMap.put("sale", arr.get(FILTER_SETTING.SALE.filterNo));//매물 
        
  		//resource 영상 유무
        pMap.put("pic_keep", arr.get(FILTER_SETTING.PIC_KEEP.filterNo));//사진있음 
        pMap.put("pic_none", arr.get(FILTER_SETTING.PIC_NONE.filterNo));//사진없음 
        pMap.put("movie_keep", arr.get(FILTER_SETTING.MOVIE_KEEP.filterNo));//동영상있음 
        pMap.put("movie_none", arr.get(FILTER_SETTING.MOVIE_NONE.filterNo));//동영상없음 
        
        
     // logger.debug("filter information -- >");
	 // Set key = pMap.keySet();
	 // for (Iterator iterator = key.iterator(); iterator.hasNext();) {
      //     String keyName = (String) iterator.next();
      //     String valueName = (String) pMap.get(keyName);
      //    logger.debug(keyName +" = " +valueName);
	 // }
	  return pMap;
	}
	
	private static enum FILTER_SETTING {
		//거래 종류
		TRADE(0),//매매
		CHARTER(1), //전세
		MONTHLY_AND_CHARTER(2), //전월세
		MONTYLY(3),//월세
		SHORT_LEASE(4), //단기임대
		
	     //금액
		DEPOSITMIN(5),//보증금 최소
		DEPOSITMAX(6),//보증금 최대
		MONTHMIN(7),//월세 최소
		MONTHMAX(8),//월세 최대
		CHARTERMIN(9),//전세 최소
		CHARTERMAX(10),//전세 최대
		STANDARDMIN(11),//기준가 최소
		STANDARDMAX(12),//기준가 최대
	    		
		//건물형태
		APARTMENT(13),//아파트
		OFFICETEL(14),//이벤트
		HOUSE(15),//주택
		NORMAL_ROOM(16),//원룸
		SHOP(17),//상가
		OFFICE(18),//오피스텔
		BUILDING(19),//건물
		REDEVELOPMENT(20),//재개발
		EVENT(21),//이벤트
		
		BUILT(22),//준공년도 
		ADDRESS(23),//번지
		 
		//방 형태 room_type로 매칭 
		OPEN_ROOM(24),//오픈형
		PART_ROOM(25),//분리형
		DUPLEX_ROOM(26),//복층형
		
		//룸개수 room_count
		OND_ROOM(27),
		TRO_ROOM(28),
		THREE_ROOM(29),
					
		//방위치
		UP_GROUND(30),//지상
		UNDER_GROUND(31),//지하
		SEMI_BASEMENT(32),//반지하
		ROOFTOP(33),//옥탑방

		//면적
        EXCLUSIVE_AREA_MIN(34),//전용면적 최소
        EXCLUSIVE_AREA_MAX(35),//전용면적 최대
        LEASED_AREA_MIN(36),//공급면적 최소
        LEASED_AREA_MAX(37),//공급면적 최대
		
		//옵션
		FULL_OPTION_ROOM(38),//풀옵션
		AIRCONDITIONER(39),//에어컨 
		REFRIGERATO(40),//냉장고 
		WASHER(41),//세탁기 
		TV(42),//tv 
		MICROWAVE(43),//전자레인지 
		INDUCTION(44),//인덕션 
		SINK(45),//싱크대 
		GASRANGE(46),//가스레인지 
		SOFA(47),//소파 
		BED(48),//침대 
		BUILT_IN_CLOSET(49),//붙박이장 
		DRESSING_TABLE(50),//화장대 
		VERANDA(51),//베란다 
		SHOE_CLOSET(52),//신발장 

		//기타옵션
		DOOR_SECURITY(53),//현관보안 
		CCTV(54),//cctv 
		NUMBER_KEY(55),//자동번호키 
		ELEVATOR(56),//엘리베이터 
		PARKING(57),//주차가능 
		ANIMAL(58),//반려동물 
		EMPTY(59),//공실 
		SALE(60),//매물 
			
		//resource  유무
		PIC_KEEP(61),//사진있음
		PIC_NONE(62),//사진없음
		MOVIE_KEEP(63),//동영상있음
		MOVIE_NONE(64); //동영상없음		

		private int filterNo;

	    private FILTER_SETTING(int filterNo){
	        this.filterNo = filterNo;
	    }

	    public int getFilterName(){
	        return filterNo;
	    }
	}



}
