package com.gnbang.webserver.controller;

import java.net.URLDecoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnbang.webserver.service.SearchService;

@Controller
@RequestMapping("/search")
public class SearchController {

	private final static Logger logger = LoggerFactory.getLogger(SearchController.class);

	@Autowired
	private SearchService searchService;
	
	public SearchController() {
		logger.info("SearchController initialize");
	}

	@RequestMapping(value = { "" }, method = RequestMethod.GET)
	public String search(Model model) {
		logger.debug("search called");
		//죄측, 상단의  선택 메뉴  css
		model.addAttribute("selectPage", "search");
		return "search.search";
	}

	/*// input : 지도 북서와 동남 좌표
	// output : 지도좌표 범위에 포함되는 방들
	@RequestMapping(value = { "/geo" }, method = RequestMethod.GET)
	public String geo(Model model, 
			@RequestParam("s") String s ,@RequestParam("w") String w,
			@RequestParam("n") String n,@RequestParam("e") String e, 
			@RequestParam(value="p",required=false, defaultValue="") String p ,
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg) {
		
		logger.debug("search/geo(s,w,n,e,p,sort,pg) called");
		
		//로그인한 회원의 번호획득
		int loginNo =  -1;
		try{ MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){ }
		
		ArrayList<SearchRoomSumary> roomList = searchService.getSpecificRoomItemAboutGeo(s,w,n,e,loginNo,p,sort,pg);
		logger.debug("findRoom of geo result size: " + roomList.size());
		
		// 방정보 들을 js에 보내기 위한 json 변환 과정
		JSONArray jsonArray = JSONArray.fromObject(roomList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomList", jsonArray);
		JSONObject jsonObject = JSONObject.fromObject(map);
		logger.debug("roomList json:  " + jsonObject);
		return "search.search";
	}*/
		
	// input : 주소코드
	// output : 주소코드를 가지는 방들
	@RequestMapping(value = "/address", method = RequestMethod.GET)
	public String address(Model model, @RequestParam("addr") long addressCode ,
			@RequestParam(value="p",required=false, defaultValue="") String p ,
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@RequestParam(value = "location_name", required = false , defaultValue="") String location_name
			)  {
		logger.debug("search/address called");

		//뷰에서 재사용할 url 지정
		model.addAttribute("url", "/api/search/address?addr=" + addressCode);
		model.addAttribute("location_name", location_name);
		model.addAttribute("location_type", "local");
		//죄측 선택 메뉴  css
		model.addAttribute("selectPage", "search");
		return "search.search";
	}

	// input : 지하철 번호
	// output : 지하철 번호를가지는 방들
	@RequestMapping(value = "/metro", method = RequestMethod.GET)
	public String metro(Model model,@RequestParam("metro_no") String metroNo,
			@RequestParam(value="p",required=false, defaultValue="") String p ,
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "sc", required = false, defaultValue="")  String sc ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg,
			@RequestParam(value = "location_name", required = false , defaultValue="") String location_name)  {
		logger.debug("search/metro called");
		
		//뷰에서 재사용할 url 지정
		model.addAttribute("url", "/api/search/metro?metro_no=" + metroNo);
		model.addAttribute("location_name", location_name);
		model.addAttribute("location_type", "metro");
		//죄측 선택 메뉴  css
		model.addAttribute("selectPage", "search");
		return "search.search";
	}
	
	// input : 입력단어
	// process : 입력단어와 일치하는 단어들을 찾고 검색을 함
	// output : 입력단어의 형태에 따라서 찾은 매물 결과
	@RequestMapping(value = "/quick/integration", method = RequestMethod.GET)
	@ResponseBody
	public String searchIntegration(Model model, @RequestParam("searchWord") String searchWord ,
			@RequestParam(value="p",required=false, defaultValue="") String p ,
			@RequestParam(value = "sort", required = false, defaultValue="")  String sort ,
			@RequestParam(value = "pg", required = false , defaultValue="1") Integer pg) {
		logger.debug("GET search/quick/integration. called");
		try {
			searchWord = URLDecoder.decode(searchWord,"UTF-8");
		} catch (Exception e) {
		}
		//뷰에서 재사용할 url 지정
		model.addAttribute("url", "api/search/quick/integration"+ searchWord);
		model.addAttribute("location_name", searchWord);
		model.addAttribute("location_type", "integration");
		return "search.search";
	}
}












