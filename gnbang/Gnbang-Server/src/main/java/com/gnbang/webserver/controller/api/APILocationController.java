package com.gnbang.webserver.controller.api;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnbang.webserver.dto.AddressCodeVO;
import com.gnbang.webserver.dto.SectorVO;
import com.gnbang.webserver.service.LocationService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//시/군/구/동에 대한 리스트를 가져옴
//섹터구/섹터동에 대한 리스트를 가져옴
@Controller
@RequestMapping("/api/location")
public class APILocationController {

	private final static Logger logger = LoggerFactory.getLogger(APILocationController.class);

	@Autowired
	private LocationService locationService;
	
	public APILocationController() {
		logger.info("LocationController initialize");
	}

	// 시/군/구 에대한 값들을 get
	@RequestMapping(value = "/address", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getAddressAttribueList(Model model, @RequestParam(value="si",required=false) String si, 
			@RequestParam(value="gungu",required=false) String gungu) {
		logger.debug("GET  api/location/address");
		//인코딩된 한글 파라미터값 디코딩
		logger.debug("parameter si :" + si);
		logger.debug("parameter gungu" + gungu);
		try {
			si = URLDecoder.decode(si,"UTF-8");
		} catch (Exception e) {
		}try {
			gungu = URLDecoder.decode(gungu,"UTF-8");
		} catch (Exception e) {
		}
		logger.debug("after decode si :" + si);
		logger.debug("after decode gungu" + gungu);
		
		//들어온 파라미터 값에 따라 원하는 결과리스트를 가져옴
		Map<String, Object> map = new HashMap<String, Object>();
		if(si == null && gungu == null){//시와 군에대한 정보가 없으면
			// 시에 해당되는 모든 값들을 획득
			ArrayList<String> siList = locationService.getSiList();
			logger.debug("result si size:  " + siList.size());
			// 시에 해당되는 모든 값들을 js에 보내기 위해 json 변환 과정
			JSONArray jsonArray = JSONArray.fromObject(siList);
			map.put("siList", jsonArray);
		}else if(gungu == null){//시에 대한 정보만 있으면
			//시에 해당되는  군/구 값들을 획득
			ArrayList<String> gunguList = locationService.getGunguList(si);
			logger.debug("result gunguList size:  " + gunguList.size());
			// 시에 해당하는 군/구 값들을 js에 보내기 위해 json 변환 과정
			JSONArray jsonArray = JSONArray.fromObject(gunguList);
			map.put("gunguList", jsonArray);
		}else{//시와 군에대한 정보가 있으면
			//시와 군에 속하는 동정보들 과 주소코드를 가져옴
			ArrayList<AddressCodeVO> dongAndCodeList = locationService.getDongAndCodeList(si,gungu);
			logger.debug("result dongAndCodeList size:  " + dongAndCodeList.size());
			// 군 시에 해당되는 모든 동의 값들을 js에 보내기 위해 json 변환 과정
			JSONArray jsonArray = JSONArray.fromObject(dongAndCodeList);
			map.put("addressList", jsonArray);
		} 
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	
	// 섹터구/섹터동 에대한 값들을 get
	@RequestMapping(value = "/sector", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getSectorAttribueList(Model model,
			@RequestParam(value="sector_gu",required=false) String sector_gu) {
		logger.debug("GET  api/location/sector");
		logger.debug("parameter sector_gu :" + sector_gu);
		try {
			sector_gu = URLDecoder.decode(sector_gu,"UTF-8");
		} catch (Exception e) {
		}
		logger.debug("after decode sector_gu" + sector_gu);

		//들어온 파라미터 값에 따라 원하는 결과리스트를 가져옴
		Map<String, Object> map = new HashMap<String, Object>();
		 if(sector_gu == null){//섹터구를 정해주는 값이 없으면
			//섹터구를 가져온다
			ArrayList<String> gunguList = locationService.getSectorGuList();
			logger.debug("result sectorGuList size:  " + gunguList.size());
			// 섹터구 이름 값들을 js에 보내기 위해 json 변환 과정
			JSONArray jsonArray = JSONArray.fromObject(gunguList);
			map.put("sectorGuList", jsonArray);
			
		}else{//섹터구를 정해주는 값이 있으면
			//섹터구에 대한동보로 섹터 동에대한 정보(동번호, 동이름)을 가져옴
			ArrayList<SectorVO> dongAndCodeList = locationService.getsectorDongAndNoList(sector_gu);
			logger.debug("result sectorDongAndNoList size:  " + dongAndCodeList.size());
			// 섹터동번호, 섹터동이름 값들을 js에 보내기 위해 json 변환 과정
			JSONArray jsonArray = JSONArray.fromObject(dongAndCodeList);
			map.put("sectorDongList", jsonArray);
		} 
		JSONObject jsonObject = JSONObject.fromObject(map);
		logger.debug("\n");
		return jsonObject;
	}
}
