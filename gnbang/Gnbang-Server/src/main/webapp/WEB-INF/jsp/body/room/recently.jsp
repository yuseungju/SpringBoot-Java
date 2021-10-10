<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sec:authentication var="principal" property="principal" />

     <!-- 필터추가 단추를 누를경우  filter_opened 클래스추가-->
     <div class="sidebar">
          <div class="sidebar_inner">
              <!--div class="sidebar filter_opened"-->
              <div class="side_header">
                <p class="count">
                  <strong id="search_type_name">강남구 최신방</strong><strong id ="allSearchCount">총 0개</strong>
                </p>
                <!--div class="sort opened" 소트목록 오픈된상태-->
                <div class="sort">
                  <a href="#sort_list" class="sort_title" id ="sort_title" onclick ="sortBtnStateChange()" >방정렬</a>
                  <!--.sort_title 클릭되면 #sort_list 토클-->
                  <div id="sort_list" class="dropdown">
                    <ul class="drop_item">
                      <li>
                        <a href="#" onclick="sortSearch('date_desc'); return false;"><span>최신등록순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('main_address, sub_address'); return false;"><span>번지수 오름차순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('stand_doposit_desc'); return false;"><span>기준가 높은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('stand_doposit_asc'); return false;"><span>기준가 낮은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('monthly_rent_desc'); return false;"><span>월세 높은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('monthly_rent_asc'); return false;"><span>월세 낮은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('deposit_desc'); return false;"><span>보증금 높은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('deposit_asc'); return false;"><span>보증금 낮은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('exclusive_area_desc'); return false;"><span>전용면적 높은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('exclusive_area_asc'); return false;"><span>전용면적 낮은 순</span></a>
                      </li>
                    </ul>
                  </div><!--sort_item마감-->
                </div><!--sort_list마감-->
              </div><!--side_heade마감r-->
              
             <!--s_result-->
             <div class="filter_app">
                  </div>
		              <div class="s_result">
		                <div class="page_wrap">
		                
		                <p class="paging" id ="paging">
		                <a href="#" onClick="posChangeSubmit('pre'); return false;" class="bor" id="pre_page"><span class="blind">이전</span>&lt;</a>
		                   <a href="#" onClick="posChangeSubmit('pos1'); return false;" class="current" id ="pos1">1</a>
		                   <a href="#" onClick="posChangeSubmit('pos2'); return false;" id ="pos2">2</a>
		                   <a href="#" onClick="posChangeSubmit('pos3'); return false;" id ="pos3">3</a>
		                   <a href="#" onClick="posChangeSubmit('pos4'); return false;" id ="pos4">4</a>
		                   <a href="#" onClick="posChangeSubmit('pos5'); return false;" id ="pos5">5</a>
		                   <a href="#" onClick="posChangeSubmit('next'); return false;" class="bor" id="next_page"><span class="blind">다음</span>&gt;</a>
		                </p>
		              </div><!--page_wrap마감 -->
	              </div><!--s_result마감-->
	          </div><!--sidebar_inner-->
	     </div><!--sidebar마감-->
	<div class="btn_agent_cart">
		<sec:authorize access="hasRole('ROLE_AGENT')">
			<a href="#agent_cart" title="관심매물창보기"> <span class="blind">관심매물메뉴</span></a>
		</sec:authorize>
	</div>
	
<script>
	searchUrl='';//검색 메인 url(지도위치/ 매물번호/ 지하철번호의 정보포함)
	sortUrl = '';//정렬
	var location_type='';//표시될 지도 검색 기준(지역명, 지하철역이름)
	var location_name='';//표시될 지도 위치
	$(document).ready(function() {
		//검색
		searchUrl = "/api/room/recently/geo?s="+37.45049693760036 +"&w="+126.98951220288383 +"&n="+ 37.57353330485798+"&e="+ 127.13511634995348;
		$("#search_type_name").text("최근본방");//검색 종류  출력
		posChangeSubmit(1);
	});
	
	//*******************************paging***************************
	var currentPg = 1;
	var currentBlock =0; 
	var nextPage = false;
	function setCurrentPage(pos){
		//currentBlock값 변경 
		if(pos == 'pre'){
			if(0 < currentBlock){
				currentBlock--;
				currentPg = (currentBlock)*5 + 1;
			}
			pos = 'pos1';
		} else if(pos == 'next'){
			currentBlock++;
			currentPg = currentBlock*5 + 1;
			pos = 'pos1';
		}
		//currentpg 값 변경
		if(pos == 'pos1' || pos == 'pos2' || 
				pos == 'pos3' || pos == 'pos4' || 
					pos == 'pos5' ){//페이지 버튼으로 페이지 변경시
			$("#"+pos).addClass("current");//현재 페이지 클릭표시 설정
			currentPg = currentBlock*5 + pos.substring(3)*1;//block를 통해 상대적으로 페이지를 구함
		}else{//원하는 페이지를 숫자로 입력받으면
			currentPg = pos;
			currentBlock = (pos-1)/5;
		}
	}
	var all_count = 0;
	function setPageIndex(currentBlock){
		 //이전 화살표 표시 설정
	 	 var pre_page = document.getElementById("pre_page");  
	 	 pre_page.style.display = 'none';  
		 if(0 < currentBlock){//이전 화살표를 표시해야되면
			   pre_page.style.display = 'inline-block';  
		 }
		 //페이지 버튼 페이지값 셋팅
		 $("#pos1").text(currentBlock*5 + 1);
		 $("#pos2").text(currentBlock*5 + 2);
		 $("#pos3").text(currentBlock*5 + 3);
		 $("#pos4").text(currentBlock*5 + 4);
		 $("#pos5").text(currentBlock*5 + 5);
	 	 var pos1 = document.getElementById("pos1"); 
	 	 var pos2 = document.getElementById("pos2");  
	 	 var pos3 = document.getElementById("pos3");  
	 	 var pos4 = document.getElementById("pos4");  
	 	 var pos5 = document.getElementById("pos5"); 
		 pos1.style.display ='none';  
		 pos2.style.display ='none';   
		 pos3.style.display ='none';  
		 pos4.style.display ='none';   
		 pos5.style.display ='none';  
		  if(currentBlock*10*5 + 10*0 < all_count)//page 1을  표시해야되면
			 pos1.style.display ='inline-block';  
		 if(currentBlock*10*5 + 10*1 < all_count)//page 2을  표시해야되면
			 pos2.style.display ='inline-block'; 
		 if(currentBlock*10*5 + 10*2 < all_count)//page 3을  표시해야되면
			 pos3.style.display ='inline-block';  
		 if(currentBlock*10*5 + 10*3 < all_count)//page 4을  표시해야되면
			 pos4.style.display ='inline-block';  
		 if(currentBlock*10*5 + 10*4 < all_count)//page 5을  표시해야되면
			 pos5.style.display ='inline-block';   
		 
		 //페이지 클릭 초기화
		 $("#pos1").removeClass("current");
		 $("#pos2").removeClass("current");
		 $("#pos3").removeClass("current");
		 $("#pos4").removeClass("current");
		 $("#pos5").removeClass("current");
		 //현재 페이지 클릭표시 설정
		 $("#pos"+ ((currentPg-1)%5 + 1)).addClass("current");
		 //다음 화살표 표시 설정
		 var next_page = document.getElementById("next_page");  
	     next_page.style.display = 'none'; 
		 if((currentBlock+1)*10*5 < all_count){//다음 화살표를 표시해야되면
		      next_page.style.display = 'inline-block';  
		 }
	}
	
	//******************검색할 페이지로 페이지상태를 변경하고 검색******************
	function posChangeSubmit(pos){
		setCurrentPage(pos);//현재페이지 설정
		search(searchUrl +sortUrl, currentPg);
		setPageIndex(currentBlock);//페이지 인덱스 표시 설정 (이전, 1 ~ 5 ,다음 버튼)
	}
	
	//**********************검색할 페이지와 url을 통해 방 검색************
	var specific_room_item ='';//검색된 매물들의 정보를 가짐
	function search(url, pg){
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : url+"&pg=" + pg,
			async : false,//총 개수를 가져온 이후 다른 처리를 해야함, 반드시 false
			success : function(data) {//msg를 받는 것이 성공하면
				setInfor(data);
				specific_room_item = data.roomList;
				all_count = data.allSearchCount;
			},
			error : function(xhr, status, error) {
			}
		});
	}

	//***********************방 상세보기로 이동 **********************
	function detailShow(no){
		window.open("/room/"+no, "");
	}
	
	//***********************검색한 데이터를 뷰에 세팅******************
	function setInfor(data){ 
/* 		//마커표시할 데이터 초기화
		marker_address = [];//상세주소를 제외한 모든주소
		marker_detail_address = [];//상세주소
		markerLat = [];
		markerLng = [];
	 */
		//뷰 설정데이터
		var str;
		$(".row.col2.odd").empty();
		str ="";
		//뷰설정
		for(var a= 0; a < data.roomList.length ; a++){
			var  infor = data.roomList[a];
			var  gungu_dong =  data.roomList[a].gungu +' ' + data.roomList[a].dong;
		    var kind;
		    //방위치 설정
			if(infor.rooftop == 1)
				kind = '옥탑방' ;
			else if (infor.semi_basement == 1)
				kind = '반지하' ;
			else if (infor.floor_no < 0)
				kind = '지하' ;
			else if (infor.floor_no > 0)
				kind = "("+infor.floor_no + "층 /" +infor.all_floor+"층)";
		    
		    //매물번호설정
			var no =  infor.no;

		    //거래 종류 설정
			var type ='';
		    if(0 != (infor.type&1)) 
		    	type +='매매,';
		    if((infor.type&2) != 0  && (infor.type&4) != 0)
		    	type +='전월세,';
		    if((infor.type&2) != 0)
		    	type +='전세,';
		    if((infor.type&4) != 0)
		    	type +='월세,';
		    if((infor.type&8) != 0)
			    type +='단기임대,';

		    //전세/월세/임대에 따라 거래가 설정
			//1매매/2전세/4월세/6전월세/8단기임대
		    var charter_deposit =  commaMoney(infor.charter_deposit);// 전세가
		    var sale_price = commaMoney(infor.sale_price);//매매가
			var deposit= commaMoney(infor.deposit);// 보증금
			var monthly_rent= commaMoney(infor.monthly_rent);//월세
			var maintenance_cost = infor.maintenance_cost/10000;
			maintenance_cost= commaMoney(maintenance_cost);//관리비
			var deposit_modify= commaMoney(infor.deposit_modify);//보증금협의가능
			var trade_price ='';
			if((infor.type&1) != 0){//매매이면
				//매매가표시
				trade_price = "<span class=\"deposit\"> "+ sale_price + "</span>";
			}
			if((infor.type&2) != 0  && (infor.type&4) != 0){//전월세 이면
				//전세,보증금,월세,관리비 표시
				trade_price = "<span class=\"deposit\"> "+ charter_deposit + "</span>" + "<span class=\"bar\">/</span>";
				trade_price += ("<span class=\"month\">" + deposit);
				if(deposit_modify == 1)
					trade_price += "(협의가능)";
				trade_price += ("/" + monthly_rent);
				trade_price += ("/" + maintenance_cost+ "</span>");
			}
			else if((infor.type&2) != 0){//전세이면(전월세에 포함)
				//전세가/관리비 표시
				trade_price = "<span class=\"deposit\"> "+ charter_deposit + "/" + maintenance_cost + "</span>";
			}
			else if((infor.type&4) != 0){//월세이면(전월세에 포함)
				//보증금/월세/관리비 표시
				trade_price = "<span class=\"deposit\"> "+ deposit + "</span>"+
				"<span class=\"bar\">/</span>"+
				"<span class=\"month\">" +  monthly_rent + "/" + maintenance_cost  + "</span>";
				if(deposit_modify == 1)
					trade_price += "(보증급 협의가능)";
			}else if((infor.type&8) != 0){//단기임대이면(전월세, 월세에 포함)
				//보증금/월세 /관리비 표시
				trade_price = "<span class=\"deposit\"> "+ deposit + "</span>"+
				"<span class=\"bar\">/</span>"+
				"<span class=\"month\">" +  monthly_rent + "/" + maintenance_cost  +"</span>";
				if(deposit_modify == 1)
					trade_price += "(보증급 협의가능)";
			}
			
		    //추천 및 급 설정
			var recommend ="";
 			if(infor.recommend == 1){
				recommend += "    <p class=\"recommend on\" >";
				recommend += "      <!--추천매물일때 클래스 on추가-->";
				recommend += "      <span class=\"txt\">추천</span>";
				recommend += "     </p>";
			}	
 			var urgent_sale ="";
 			if(infor.urgent_sale == 1){
 				urgent_sale += "     <p class=\"urgent  on\">";
 			    urgent_sale += "       <!--급매물일때 클래스 on추가-->";
 			    urgent_sale += "<span class=\"txt\">급</span>";
 			    urgent_sale += "     </p>";
			}
 			
 			var zzim ='';
 			if(infor.zzim_no != 0)
 	 			zzim += "<div class=\"fav fav_check\" id=\"zzim"+a+"\">";
 	 		else
 	 	 		zzim += "<div class=\"fav\" id=\"zzim"+a+"\">";
 			zzim += "  <!--찜하기를 선택했을때  fav_check 클래스 추가-->";
 			zzim += "	<p class=\"btn_fav_check\"  onclick =\"delZzim("+no+" , "+a+")\">";
 			zzim += "    	<span class=\"blind\" >찜하기</span>";
 			zzim += "    </p>";
 			zzim += "    <p class=\"btn_fav_uncheck\"   onclick =\"addZzim("+no+", "+a+")\">";
 			zzim += "    	 <span class=\"blind\" >찜하기취소</span>";
 			zzim += "    </p>";
 			zzim += "</div><!-- fav마감-->";
 			//옵션 첫번빼 설정 
			var option1 = "";
 			if(infor.empty == 1)
 				option1 += "<span>공실</span>";
 			if(infor.animal == 1)
 				option1 += "<span>반려동물</span> ";
 			if(infor.parking)
 				option1 += "<span>주차가능</span> ";
 			if(infor.digital_doorlock == 1)
 				option1 += "<span>현관도어락</span>  ";
 			if(infor.elevator == 1)
 				option1 += "<span>엘리베이터</span>  ";
 			if(infor.room_type == 1)
 				option1 += "<span>오픈형</span>  ";
 			else if(infor.room_type == 2)
 		 		option1 += "<span>분리형</span>  ";
 	 		else if(infor.room_type == 3)
 	 		 	option1 += "<span>복층형</span>  ";
 	 		else if(infor.room_type == 4)
 	 		 	option1 += "<span>사무용</span>  ";
 	 		else if(infor.room_type == 5)
 	 		 	option1 += "<span>주거용</span>  ";
 	 	 	else if(infor.room_type == 6)
 	 	 		 option1 += "<span>일부층사용</span>  ";
 	 	 	else if(infor.room_type == 7)
 	 	 	 	option1 += "<span>전층사용</span>  ";
			else if(infor.room_type == 8)
 	 	 	 	 option1 += "<span>원룸원거실</span>  ";
 	 	 	else if(infor.room_type == 9)
 	 	 	 	 option1 += "<span>세미분리</span>  ";	
 	 	 	
 			if(infor.empty == 1)
 				option1 += "<span>공실</span>  ";
 			if(infor.veranda == 1)
 				option1 += "<span>베란다</span>  ";
 			if(option1 == '')
 				option1 = "<span>옵션 해당사항 없음</span>";
 				
 			//옵션 두번째 설정
 			var option2="";
 			if(infor.airconditioner == 1)
 				option2 += "<span>에어컨,</span>  ";
 			if(infor.refrigerator == 1)
 	 			option2 += "<span>냉장고,</span>  ";
 	 		if(infor.washer == 1)
 	 	 		option2 += "<span>세탁기,</span>  ";
 	 	 	if(infor.tv == 1)
 	 	 	 	option2 += "<span>tv,</span>  ";
 	 	  	if(infor.microwave == 1)
 	 	 	 	option2 += "<span>전자레인지,</span>  ";
 	 	 	if(infor.induction == 1)
 	 	 	 	option2 += "<span>인덕션,</span>  ";
 	 	 	if(infor.gasrange == 1)
 	 	 	 	option2 += "<gasrange>가스레인지,</span>  ";
 	 	 	if(infor.bed == 1)
 	 	 	 	 option2 += "<span>침대,</span>  "; 	
 	 	 	if(infor.built_in_closet == 1)
 	 	 	 	 option2 += "<span>붙박이장,</span>  "; 	 	
 	 		if(infor.closet == 1)
 	  	 	 	 option2 += "<span>옷장,</span>  "; 	 	
 	  		if(infor.dressing_table == 1)
 	  	  		 option2 += "<span>화장대,</span>  "; 	
			if(infor.other_option.indexOf("식탁") != -1)
				option2 +='식탁,';
			if(infor.other_option.indexOf("쇼파") != -1)
				option2 +='쇼파,';
			if(infor.other_option.indexOf("싱크대") != -1)
				option2 +='싱크대,';
 		 	 	 	 		 	 					
			if(option2 =='')
				option2 ='가구 해당사항 없음';
	 	 	 	
 			//방수 설정
 			var room_cnt = " ";
 			if(1 <= infor.room_count){
 				room_cnt = infor.room_count + ' 룸';
 			}else if(infor.room_count_onepointfive == 1){
 				room_cnt = ' 1.5룸';
 			}
 			
 			//건물형태 설정
 			var buildingType="";
 			if(infor.apartment == 1)
 				buildingType = "아파트";
 			else if(infor.officetel == 1)
 				buildingType = "오피스텔";
 			else if(infor.house == 1)
 				buildingType = "주택";
 			else if(infor.normal_room == 1)
 				buildingType = "원룸";
 			else if(infor.shop == 1)
 				buildingType = "상가";
 			else if(infor.office == 1)
 				buildingType = "사무실";
 			else if(infor.building == 1)
 				buildingType = "건물";
 			else if(infor.event == 1)
 				buildingType = "이벤트";
 			else if(infor.land == 1)
 				buildingType = "땅";
 			else if(infor.full_option_room == 1)
 				buildingType = "플옵션";
 			buildingType += room_cnt;
			
			str += "<div class=\"row col2 odd\">";
			str += "<div class=\"row_inner shadow_gray\">";
			str += "  <div class=\"ribbon \">";
			str +=	recommend;
		    str += "   </div><!-- ribbon마감-->";
			str +=	urgent_sale;
			if(<%= request.isUserInRole("ROLE_ADMIN") || request.isUserInRole("ROLE_SUPER") || 
					request.isUserInRole("ROLE_AGENT") ||  request.isUserInRole("ROLE_USER")  
					|| request.isUserInRole("ROLE_LESSOR")%>)//중개사, 일반,임대인로그인 경우만 zzim여부표시
		    	str += zzim;
	        str += "<div class=\"thum  image_list\">";
	        str += "   <div class=\"inner\">";
	        str += "    <ul class=\"thum_list\">";
	        str += "      <li>";
	        str += " <a href=\"#\" onClick=\"detailShow("+no+"); return false;\" class=\"media_photo media_cover\" value =\""+no+"\">";
	        str += "        <div class=\"media_cover\">";
	        if (typeof(infor.fake_url[0]) == "undefined")//사진등록이 안되었으면 기본이미지로 설정
	            str += "<img src=\"" + "${pageContext.request.contextPath}/images/common/pic_base.jpg" +"\" alt=\"샘플집\" class=\"res_height\"/>";
	        else//사진등록이 됐으면 이미지의 첫번쨰로 대표이미지 설정
	        	str += "<img src=\"" + "http://112.175.245.57"+infor.fake_url[0] +"\" alt=\"샘플집\" class=\"res_height\" />";
	        str += "          </div></a>";
			str += "        </li>";
	        str += "      </ul>";
	        str += "    </div><!-- inner마감-->";
	        str += " </div><!-- thum마감-->";
	        str += "      <div class=\"info_grounp\">";
	        str += "        <div class=\"inner\">";
	        str += "         <div class=\"info1 info\">";
	        str += "           <a href=\"#\" onClick=\"detailShow("+no+"); return false;\">";
	        str += "            <p class=\"address  fl\">";
	        str += "            <span>"+gungu_dong+"</span>";
	        str += "           </p>";
	        str += "           <p class=\"floor fl\">";
	        str += 	 kind;
	        str += "          </p>";
	        str += "        </a>";
	        str += "     </div><!-- info1마감-->"; 
	        str += "      <div class=\"info2 info\">";  
	        str += "         <a href=\"#\" onClick=\"detailShow("+no+"); return false;\"><p class=\"no fl\">";
	        str += "        	  <span class=\"txt\">매물번호:</span><span class=\"num\">"+no+"</span>";
	        str += "        	</p></a>";
	        str += "      </div> <!-- info2마감-->";
	        str += "    <div class=\"info3 info\">";
	        str += "       <a href=\"#\" onClick=\"detailShow("+no+"); return false;\"><p class=\"tradetype btn fl\">";
	        str += "      	  <span> " + type + "</span>";
	        str += "      	</p>";
	        str += "     	<p class=\"buldingtype btn fl\">";
	        str += "     	  <span>" + buildingType + "</span>";
	        str += "       	</p>";
	        str += "      	<p class=\"price fl\">";
	        str += trade_price;
	        str += "       	</p></a>";
	        str += " <!--agent_check 중개사만 표시 매물담기-->";

			if(<%= request.isUserInRole("ROLE_AGENT") %>){//중개사 로그인 경우만
		        str += "     <div class=\"agent_check\">";
		        str += "       <div class=\"input\"><input type=\"checkbox\" value=\"" + no + "\" name=\"interest_room_no\" /> </div><!-- input마감-->";
		        str += "     </div><!-- agent_check마감-->";
			}
	        str += "     </div>";
	        str += "         <!-- info3마감-->";
	        str += "         <div class=\"info4 info\">";
	        str += "             <a href=\"#\" onClick=\"detailShow("+no+"); return false;\"><p class=\"option\">";
	        str +=   option1;
	        str += "          	</p></a>";
	        str += " </div><!-- info4마감-->";
	        str += "   <div class=\"info5 info\">";
	        str += "         <a href=\"#\" onClick=\"detailShow("+no+"); return false;\"><p>";
	        str +=   option2;
	        str += "        	</p></a>";
	        str += "       </div><!-- info5마감-->";
	        str += "      </div><!-- inner마감-->";
	        str += "      </div><!-- info_group마감-->";
	        str += "      </div><!-- row_inner마감-->";
	        str += "      </div><!-- row col2 odd마감-->";
	        
/* 			//지도에 보여 지는 마커 (클러스터된) 추가
			var marker_address_str ='';
			var marker_detail_address_str='';
			marker_address_str += ("매물번호:" + no + " <br>");
			marker_address_str += ("위치:" + infor.si+ " " + infor.gungu +" " +  infor.dong + " <br>");
			marker_address_str += ("번지:" + infor.main_address + "-" + infor.sub_address    + "<br>");
			marker_detail_address_str += ("상세주소:" + infor.last_address + " <br>");
			
			marker_address.push(marker_address_str);
			marker_detail_address.push(marker_detail_address_str);
 			markerLat.push(infor.lat);
 			markerLng.push(infor.lng); */
		}
		//setMarkers(markerLat, markerLng, marker_address, marker_detail_address);
		
		$(".s_result").prepend(str);
		
		$("#allSearchCount").text(data.allSearchCount+'개');
	}
	function commaMoney(str){
		return str;
	}
</script>
<script>
//************************찜하기**************************
	//찜추가
	function addZzim(no, row){
		//alert(no);
		//alert(row);
		$("#zzim"+row).addClass("fav_check");
	 	$.ajax({
			 	type : "PUT",
		        url: "/api/room/"+no+"/zzim",
		        async: false,
		        success: function() {
		        	//setComment(1);
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        }
		 }); 
	}
	//찜취소
	function delZzim(no, row){
		//alert(no);
		//alert(row);
		$("#zzim"+row).removeClass("fav_check");
		//alert('찜취소!');
	 	$.ajax({
			 	type : "DELETE",
		        url: "/api/room/"+no+"/zzim",
		        async: false,
		        success: function() {
		        	//setComment(4);
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        }
		 }); 
	}
</script>
<script>
//************************컴포넌트 상태변화*******************
	//방정렬 드롭다운 열기/닫기
	function sortBtnStateChange(){
		if($(".sort").hasClass("opened")) {
			 $(".sort").removeClass("opened");
		}else{
			 $(".sort").addClass("opened");	
			 document.getElementById("sort_title").innerHTML = "방정렬";
		}
	}
</script>
<!-- 정렬기능 -->
<script>
    //***********************정렬 기능*******************
 	function sortSearch(kind){
		if(kind == 'date_desc'){
			sortUrl = '&sort=sri.date desc';
			document.getElementById("sort_title").innerHTML = "최신등록순";
		}
		else if(kind == 'main_address, sub_address'){
			sortUrl = '&sort=main_address, sub_address asc';
			document.getElementById("sort_title").innerHTML = "번지수 오름차순";
		}
		else if(kind == 'stand_doposit_desc'){
			sortUrl = '&sort=standard_deposit desc';
			document.getElementById("sort_title").innerHTML = "기준가 높은 순";
		}
		else if(kind == 'stand_doposit_asc'){
			sortUrl = '&sort=standard_deposit asc';
			document.getElementById("sort_title").innerHTML = "기준가 낮은 순 ";
		}
		else if(kind == 'monthly_rent_desc'){
			sortUrl = '&sort=monthly_rent desc';
			document.getElementById("sort_title").innerHTML = "월세 높은 순";
		}
		else if(kind == 'monthly_rent_asc'){
			sortUrl = '&sort=monthly_rent asc';
			document.getElementById("sort_title").innerHTML = "월세 낮은 순";
		}
		else if(kind == 'deposit_desc'){
			sortUrl = '&sort=deposit desc';
			document.getElementById("sort_title").innerHTML = "보증금 높은 순";
		}
		else if(kind == 'deposit_asc'){
			sortUrl = '&sort=deposit asc';
			document.getElementById("sort_title").innerHTML = "보증금 낮은 순";
		}
		else if(kind == 'exclusive_area_desc'){
			sortUrl = '&sort=exclusive_area desc';
			document.getElementById("sort_title").innerHTML = "전용면적 높은 순";
		}
		else if(kind == 'exclusive_area_asc'){
			sortUrl = '&sort=exclusive_area asc';
			document.getElementById("sort_title").innerHTML = "전용면적 낮은 순";
		}
		if($(".sort").hasClass("opened")) 
			 $(".sort").removeClass("opened");//정렬 드롭박스 숨기기

		//페이지초기화
		posChangeSubmit(1);
	}
</script>     

