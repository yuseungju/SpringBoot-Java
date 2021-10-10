package com.gnbang.webserver.controller.api;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnbang.webserver.object.AutoWord;
import com.gnbang.webserver.object.SearchRoomSumary;
import com.gnbang.webserver.security.domain.MyRoleAndTokenService;
import com.gnbang.webserver.security.domain.MyUser;
import com.gnbang.webserver.service.SearchService;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/api/search")
public class APISearchController{

	private final static Logger logger = LoggerFactory.getLogger(APISearchController.class);

	@Autowired
	private SearchService searchService;
	@Autowired
	private  MyRoleAndTokenService myRoleAndTokenService;
	
	public APISearchController() {
		logger.info("SearchController initialize");
	}

	@RequestMapping(value = { "" }, method = RequestMethod.GET)
	public String search(Model model) {
		logger.debug("GET api/search called");
		return "search.search";
	}
	
	// input : 섹터이름
	// output : 섹터 범위에 포함되는 방들
	@RequestMapping(value = { "/sector" }, method = RequestMethod.GET)
	@ResponseBody
	public JSONObject sector(Model model, 
			@RequestParam("sector_name") String sector_name ,
			@RequestParam(value="p",required=false, defaultValue="") String p ,
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@CookieValue(value ="pc_token", required = false)  String clientToken) {
		logger.debug("GET api/search/sector called");
	
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
		
		ArrayList<SearchRoomSumary> roomList = searchService.getSpecificRoomItemAboutSector(sector_name,loginNo,p,sort,pg);
		myRoleAndTokenService.limitSearchRoomSumaryListAboutRole(roomList, clientToken);
		int allSearchCount = searchService.getCountRoomAboutSector(sector_name,loginNo,p);
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roomList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allSearchCount", allSearchCount);
		map.put("roomList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	// input : 섹터이름
	// output : 섹터 범위에 포함되는 방들의 수
	@RequestMapping(value = { "/all_sector_count" }, method = RequestMethod.GET)
	@ResponseBody
	public JSONObject sectorCount(Model model, 	@RequestParam("sector_names") String  sector_names,
			@RequestParam(value="p",required=false, defaultValue="") String p) {
		logger.debug("GET api/search/all_sector_count called");
		
		ArrayList<String> sectorNames = new Gson().fromJson(sector_names, new TypeToken<ArrayList<String>>(){}.getType());
		
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
		
		ArrayList<Integer> sector_counts = new ArrayList<Integer>();//섹터별 매물수
		for(int a=0; a<sectorNames.size(); a++)
			sector_counts.add(searchService.getCountRoomAboutSector(sectorNames.get(a),loginNo,p));
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sector_counts", sector_counts);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	// input : 섹터이름
	// output : 섹터 범위에 포함되는 방들의 수
	@RequestMapping(value = { "/all_geo_count" }, method = RequestMethod.GET)
	@ResponseBody
	public JSONObject geoCount(Model model, 
			@RequestParam("s") String s, @RequestParam("w") String w, 
			@RequestParam("n") String n, @RequestParam("e") String e,
			@RequestParam("search") String search,
			@RequestParam(value="p",required=false, defaultValue="") String p) {
		logger.debug("GET api/search/all_geo_count called");
		ArrayList<ArrayList<String>> sList = getListFromString(s);
		ArrayList<ArrayList<String>> wList = getListFromString(w);
		ArrayList<ArrayList<String>> nList = getListFromString(n);
		ArrayList<ArrayList<String>> eList = getListFromString(e);
		ArrayList<ArrayList<String>> searchList = getListFromString(search);
        
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
		ArrayList<ArrayList<Integer>> geo_counts = new ArrayList<ArrayList<Integer>>();//섹터별 매물수
		for(int a=0; a<sList.size(); a++){
			geo_counts.add(new ArrayList<Integer>());
			for(int b=0; b<sList.get(a).size(); b++){
				if(Boolean.valueOf(searchList.get(a).get(b))){
					geo_counts.get(a).add(searchService.getCountRoomAboutGeo(sList.get(a).get(b), wList.get(a).get(b), 
							nList.get(a).get(b), eList.get(a).get(b), loginNo, p));
				}else{
					geo_counts.get(a).add(-1);
				}
			}
		}
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("geo_counts", geo_counts);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	//input :  string [[, ,..],[, ,..],[, ,..] ....]
	//process : 문자열로된 이차원 배열을 이중 리스트로 생성
	//ouput :  ArrayList<ArrayList<String>>					
	private ArrayList<ArrayList<String>> getListFromString(String str){
		ArrayList<ArrayList<String>> List = new ArrayList<ArrayList<String>>();
		JSONArray array1 = new JSONArray();
        array1.element(str);
        for(int i = 0; i < array1.getJSONArray(0).size(); i++){
            JSONArray array2 = new JSONArray();
            array2.element(array1.getJSONArray(0).getString(i));
            List.add(new ArrayList<String>());
            for(int j = 0; j < array2.getJSONArray(0).size(); j++){
            	List.get(i).add(array2.getJSONArray(0).getString(j));
            }
        }
        return List;
	}
	// input : 지도 북서와 동남 좌표
	// output : 지도좌표 범위에 포함되는 방들
	@RequestMapping(value = { "/geo" }, method = RequestMethod.GET)
	@ResponseBody
	public JSONObject geo(Model model, 
			@RequestParam("s") String s ,@RequestParam("w") String w,
			@RequestParam("n") String n,@RequestParam("e") String e, 
			@RequestParam(value="p",required=false, defaultValue="") String p ,
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@CookieValue(value ="pc_token", required = false)  String clientToken) {
		logger.debug("GET api/search/geo(s,w,n,e,p,sort,pg) called");
		
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
		ArrayList<SearchRoomSumary> roomList = searchService.getSpecificRoomItemAboutGeo(s,w,n,e,loginNo,p,sort,pg);
		myRoleAndTokenService.limitSearchRoomSumaryListAboutRole(roomList, clientToken);
		int allSearchCount = searchService.getCountRoomAboutGeo(s,w,n,e,loginNo,p);
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roomList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allSearchCount", allSearchCount);
		map.put("roomList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
		
	// input : 주소코드
	// output : 주소코드를 가지는 방들
	@RequestMapping(value = "/address", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject address(Model model, @RequestParam("addr") long addressCode ,
			@RequestParam(value="p",required=false, defaultValue="") String p ,
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@CookieValue(value ="pc_token", required = false)  String clientToken)  {
		logger.debug("GET api/search/address called");
		
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
				
		ArrayList<SearchRoomSumary> roomList = searchService.getSpecificRoomItemAboutAddress(addressCode,loginNo,p,sort,pg);
		myRoleAndTokenService.limitSearchRoomSumaryListAboutRole(roomList, clientToken);
		int allSearchCount = searchService.getCountRoomAboutAddress(addressCode,loginNo,p);
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roomList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allSearchCount", allSearchCount);
		map.put("roomList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}

	// input : 지하철 번호
	// output : 지하철 번호를가지는 방들
	@RequestMapping(value = "/metro", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject metro(Model model,@RequestParam("metro_no") Integer metroNo,
			@RequestParam(value="p",required=false, defaultValue="") String p ,
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@CookieValue(value ="pc_token", required = false)  String clientToken)  {
		logger.debug("GET api/search/metro called");
		
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
				
		ArrayList<SearchRoomSumary> roomList = searchService.getSpecificRoomItemAboutMetroNo(metroNo,loginNo,p,sort,pg);//(페이징수만큼) 검색결과가져오기
		myRoleAndTokenService.limitSearchRoomSumaryListAboutRole(roomList, clientToken);
		int allSearchCount = searchService.getCountRoomAboutMetroNo(metroNo,loginNo,p);//검색결과수(전체수)
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roomList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allSearchCount", allSearchCount);
		map.put("roomList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}

	// input : 지하철 번호
	// output : 지하철 번호를가지는 방들
	@RequestMapping(value = "/metro_no", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject metroCode(Model model, @RequestParam("metro_name") String metroName)  {
		logger.debug("GET api/search/metro_no called");
		
		int metroNo = searchService.getMetroCodeAboutMetroName(metroName);
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("metro_no", metroNo);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	
	// input : 입력단어
	// process : 입력단어와 일치하는 단어들을 찾음
	// output : 자동 완성 단어5개
	@RequestMapping(value = "/quick/autoword", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject quickAutoword(Model model, @RequestParam("searchWord") String searchWord) {
		logger.debug("GET api/search/quick. called");
		try {
			searchWord = URLDecoder.decode(searchWord,"UTF-8");
		} catch (Exception e) {
		}
		
		// 자동완성 목록 주소값들을 획득
		ArrayList<AutoWord> autoWords = searchService.getAutoWord(searchWord, 90);

		// 자동완성 목록 주소값들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(autoWords);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("autoWordList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}

	// input : 입력단어
	// process : 입력단어와 일치하는 단어들을 찾고 검색을 함
	// output : 입력단어의 형태에 따라서 찾은 매물 결과
	@RequestMapping(value = "/quick/integration", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject searchIntegration(Model model, @RequestParam("searchWord") String searchWord ,
			@RequestParam(value="p",required=false, defaultValue="") String p ,
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@CookieValue(value ="pc_token", required = false)  String clientToken) {
		logger.debug("GET api/search/quick/integration. called");
		
		try {
			searchWord = URLDecoder.decode(searchWord,"UTF-8");
		} catch (Exception e) {
		}
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
		
		ArrayList<SearchRoomSumary> roomList = searchService.getSpecificRoomItemAboutSearchWord(searchWord,loginNo,p,sort,pg);
		myRoleAndTokenService.limitSearchRoomSumaryListAboutRole(roomList, clientToken);
		int allSearchCount = searchService.getCountRoomAboutSearchWord(searchWord,loginNo,p);
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roomList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allSearchCount", allSearchCount);
		map.put("roomList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
}
