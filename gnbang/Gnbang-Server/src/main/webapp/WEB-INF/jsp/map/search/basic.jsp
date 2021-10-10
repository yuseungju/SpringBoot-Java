<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>

	<div class="map_search">
		<div class="inner">
			<div class="location">
				<div class="loc_view">
					<div class="province addr fl">
						<a class="txt" id="si_text" href="#" onclick ="showSi(); return false;"> </a>
						<div class="" id ="siList">
							<ul id="si_ul" class="si_ul" >
								<!-- ajax 시 정보 리스트로 셋팅 -->
							</ul>
						</div>
					</div>
					<div class="count addr fl">
						<a class="txt" id="gungu_text" href="#" onclick ="showGungu(); return false;">  </a>
						<div class="" id ="gunguList">
							<ul id="gungu_ul" class="gungu_ul">
								<!-- ajax 구/군  정보 리스트로 셋팅 -->
							</ul>
						</div>
					</div>
					<div class="town addr fl">
						<a class="txt" id="dong_text" href="#" onclick ="showDong(); return false;"> </a>
						<div class="" id ="dongList">
							<ul id="dong_ul" class="dong_ul">
								<!-- ajax 동 정보 리스트로 셋팅 -->
							</ul>
						</div>
					</div>
				</div>
				<div class="province addr fl">	
					<div>
						지도 이동시 검색 <input type ="checkbox" id ="moveSearch_chk"/>
					</div>
				</div>
				<!--.province .count .town 클릭시 드롭다운 목록-->
			</div>
			<!--location마감-->
			<div id="map" class="map" ></div>
		</div>
		<!--inner마감-->
	</div>
	<!--map_search마감-->
<!-- 시/구/동  리스트박스  클릭시 검색 -->	
<script>
	var si='';
	var gungu='';
	var dong='';
	var local_code ='';
	//*******************지역 클릭시의 리스트 셋팅 설정 ************************
	$(function() {
		 //시 리스트 셋팅 고정
		 init();
		 $('.si_li').click(function(){//시를 선택
	        si =$(this).text();//선택한 시 값 보관
   		   	setGunguList(si);// 군/구 리스트 가져와서 셋팅
   		   	dong ="읍/면/동";
   		 	setSelectAddress();//선택한 시/군/동의 값 보이기
	        hideAll();//모든리스트와 상단 이름 감추기
	        showGungu();//구리스트 보이기
	        
		});
		 $(document).on("click",".gungu_li",function(){
		 	gungu =$(this).text(); //선택한  구값 보관

   			setDongList(si,gungu);// 동/주소코드 리스트 가져와서 셋팅
	        setSelectAddress();//선택한 시/군/동의 값 보이기
	        hideAll();//모든리스트와 상단 이름 감추기
	        showDong();//동리스트 보이기
		});
		 $(document).on("click",".dong_li",function(){
	        dong=$(this).text();
	        searchAboutDongCode($(this).attr('id'), dong);//지역코드로 검색 
	        setSelectAddress();//선택한 시/군/동의 값 보이기
	        $("#moveSearch_chk").prop('checked', false);//지도움직임으로 검색체크 끄기
	        hideAll();//모든리스트와 상단 이름 감추기
		});
	});
	//*******************주소 코드로 검색(동 선택시)************************
	function searchAboutDongCode(code){
		//alert("mainUrl change to addr/ full url : "+searchUrl + "/"+filterUrl + "/"+sortUrl);
		beforeSearchUrl = searchUrl;
		searchUrl  = "/api/search/address?addr="+code;
		$("#search_type_name").text(gungu +" " + dong +" " + "최신방");//검색 종류  출력recently
		posChangeSubmit(1);//검색
		expressMap("local", dong);
	}
	
	//*******************ajax:  주소 목록 리스트 셋팅***********************
	//시 리스트 set
	function setSiList(){
		si="서울특별시";
		/* //시 리스트 가져오기
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : "/api/location/address",
			async : false,
			success : function(data) {
				//시 리스트 셋팅
				$("#si_ul").empty();
				for(var i = 0; i < data.siList.length; i++){
	    		     $("#si_ul").append("<li class=\"si_li\"><a href=\"#\">" +
	    		    		data.siList[i] + "</a></li>");
	    		    if(i==0)
	    		    	si=data.siList[0];
				}
			},
			error : function(xhr, status, error) {
			}
		}) */
	}
	//구 리스트 set
	function setGunguList(si){
		 $("#gungu_ul").empty();
		 $("#gungu_ul").append("<li class=\"gungu_li\"><a href=\"#\">" +
		    	"강남구" + "</a></li>");
		 $("#gungu_ul").append("<li class=\"gungu_li\"><a href=\"#\">" +
				 "서초구"+ "</a></li>");
		 $("#gungu_ul").append("<li class=\"gungu_li\"><a href=\"#\">" +
				 "송파구" + "</a></li>");
		 gungu = "강남구";
		/* //구 리스트 셋팅, 구 선택 값설정
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : "/api/location/address?si="+encodeURI(encodeURIComponent(si)), 
			async : false,
			success : function(data) {
				//구 리스트 셋팅
				$("#gungu_ul").empty();
				for(var i = 0; i < data.gunguList.length; i++){
	    		     $("#gungu_ul").append("<li class=\"gungu_li\"><a href=\"#\">" +
	    		    		data.gunguList[i] + "</a></li>");
	    		     if(i==0)
		    		    	gungu=data.gunguList[0];
				}
			},
			error : function(xhr, status, error) {
			}
		}) */
	}
	//동 리스트 셋팅, 동 선택 값설정
	function setDongList(si,gungu){
		//동과 코드 리스트 가져오기
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : "/api/location/address?si="+encodeURI(encodeURIComponent(si))+"&gungu="+encodeURI(encodeURIComponent(gungu)),
			async : false,
			success : function(data) {
				//동과 코드 리스트 셋팅
				$("#dong_ul").empty();
				for(var i = 0; i < data.addressList.length; i++){
	    		     $("#dong_ul").append("<li id=\""+data.addressList[i].code+"\" class=\"dong_li\"><a href=\"#\">" +
	    		    		data.addressList[i].dong + "</a></li>");
	    		     if(i==0)
		    		    	dong=data.addressList[0].dong;
				}
			},
			error : function(xhr, status, error) {
			}
		})
	}
	
	//***************지역 이름 클릭시  리스트 및 선택한 주소값 보이기/감추기 이벤트******************
	function hideAll(){//초기화 : 선택한값들 감추기, 시/구/동의 리스트 비우기
		 $("#siList").removeClass("loc_list");//시 리스트 감추기
		 $("#gunguList").removeClass("loc_list");//군/구 리스트 감추기
		 $("#dongList").removeClass("loc_list");//동 리스트 감추기
	}
	function setSelectAddress(){//현재 선택한 값들(시/구/동) 보이기
         document.getElementById("si_text").innerHTML  = si;//현재 선택한 '시' 의 값 설정
         document.getElementById("gungu_text").innerHTML  = gungu;//현재 선택한 '군/구' 의 값 설정
         document.getElementById("dong_text").innerHTML  = dong;//현재 선택한 동의 값 설정
	}
	function init(){
		si = '서울';
		setSiList();
		setGunguList(si);// 군/구 리스트 가져와서 셋팅
		setDongList(si,gungu);// 군/구 리스트 가져와서 셋팅
		dong ="읍/면/동";
	 	setSelectAddress();//선택한 시/군/동의 값 보이기
        hideAll();//모든리스트와 상단 이름 감추기
	}
/* 	function showSi() {
		 $("#dongList").removeClass("loc_list");
		 $("#gunguList").removeClass("loc_list");
		if($("#siList").hasClass("loc_list")) 
			 $("#siList").removeClass("loc_list");
		else
			 $("#siList").addClass("loc_list");
	} */
	function showGungu() {
		 $("#siList").removeClass("loc_list");
		 $("#dongList").removeClass("loc_list");
		if($("#gunguList").hasClass("loc_list")) 
			 $("#gunguList").removeClass("loc_list");
		else
			 $("#gunguList").addClass("loc_list");
	}
	function showDong() {
		 $("#siList").removeClass("loc_list");
		 $("#gunguList").removeClass("loc_list");
		if($("#dongList").hasClass("loc_list")) 
			 $("#dongList").removeClass("loc_list");
		else
			 $("#dongList").addClass("loc_list");
	}
</script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=af637caf9dd27d7d6f35e3c10c842759&libraries=clusterer,services"></script>
<script>
	var event_possible = true;//이벤트 처리가능/무시 여부
	//*****************지도 생성 ********************************
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(37.5061, 127.04), // 지도의 중심좌표
	        level: 6, // 지도의 확대 레벨
	        disableDoubleClick: true//더블클릭 이벤트 막기
	    };
	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	/*************************지도 확대 축소영역 범위지정***********************/
	//지도에 기본제공되는 전체스크롤 막기
	$('#map').on({
	    'mousewheel': function(e) {
	        if (e.target.id == 'el') return;
	        e.preventDefault();
	    }
	});
	//지도영역에서의 마우스 위치
	var over_state = "out";
	daum.maps.event.addListener(map, 'mouseover', function() {
		over_state = "in";
	});
	daum.maps.event.addListener(map, 'mouseout', function() {
		over_state = "out";
	});
	//확대 축소 범위지정
    var delta = 0;
    window.addEventListener('DOMMouseScroll', wheel, false);
	window.onmousewheel = document.onmousewheel = wheel;
	map.setZoomable(false);
	function wheel(event){
	    if (!event) event = window.event;
	    if (event.wheelDelta) {
	        delta = event.wheelDelta/120;
	        if (window.opera) delta = -delta;
	    } 
	    else if (event.detail) delta = -event.detail/3;
		if( over_state =="in"){//마우스가 지도안에 있을때
			if(isEffectivenessAboutTokenAndRole()){//중개사 로그인시에
				map.setZoomable(true);//확대 축소 범위 무제한
			} else if(delta < 0){//휠 아래로/지도축소시
				map.setZoomable(true);//확대 축소 범위 무제한
		    } else if(delta > 0){//휠 위래/지도확대시
		    	if (4 < map.getLevel()){
					map.setZoomable(true);//확대가능
		    	}else{//250m축적부터는  더 이상 확대 불가
			        map.setLevel(4);//100m로
		    		map.setZoomable(false);
		    	}
		    }	
		}
	}
	
	//*****************지도 이벤트 검색*********************************************	
	//지도 이벤트 백그라운드 처리를 위한 js생성 함수
	function getScriptPath(foo){ return window.URL.createObjectURL(new Blob([foo.toString().match(/^\s*function\s*\(\s*\)\s*\{(([\s\S](?!\}$))*[\s\S])/)[1]],{type:'text/javascript'})); }
	//지도 이벤트 백그라운드 처리되는 내용 (web worker생성)
	var worker = new Worker(getScriptPath(function(){//스레드 발생(중복 발생 불가, 한번만 추가가능하고 여러번 사용시 차례대로 대기)
	    self.addEventListener('message', function(message) {
	            self.postMessage(message.data);
	    }, false);
	}));
	//지도에서의 모든이벤트의 처리(스레드 하나 추가)
	worker.addEventListener('message', function(message) {
		if(message.data.event_type == 'showedMapSearch'){//지도 드래그나 줌 변경시
			//지하철역 인근을 원으로 반경표시 초기화
			if(typeof(metro_circle) != "undefined" && 4 < map.getLevel())//지하철 검색표시가 존재하고 지도축적 100m이상이면 
				metro_circle.setMap(null);
			//보여지는 지도 영역에서 검색
			showLocal();//검색한 지역의 지역명 표시
			reDrawMap();//검색 하는 위치에 맞게 클러스터 재설정
			if($("#moveSearch_chk").is(":checked")){//"지도 이동시 검색"  기능을 선택했으면
				showedMapSearch();//현재 보여지는 지도영역 검색
			}
		}else if(message.data.event_type == 'clickPolygonEvent'){//섹션영역을 클릭하면
			clickPolygonEvent(message.data.index1);
		}else if(message.data.event_type == 'clickSectionClusterEvent'){//섹션클러스터을 클릭하면
			clickSectionClusterEvent(message.data.index1);
		}else if(message.data.event_type == 'clickSectionCountEvent'){//섹션 클러스터 숫자를 클릭하면
			clickSectionCountEvent(message.data.index1);
		}else if(message.data.event_type == 'clickLocationClusterEvent'){//인접 클러스터 클릭하면
			clickLocationClusterEvent(message.data.index1, message.data.index2);
		}else if(message.data.event_type == 'clickLocationCountEvent'){//인접 클러스터숫자 클릭하면
			clickLocationCountEvent(message.data.index1, message.data.index2);
		}else if(message.data.event_type == 'clickStationEvent'){//지하철역 아이콘을 클릭하면
			clickStationEvent(message.data.index1);
		}
	}, false);
	//이벤트 종류마다 발생하는 이벤트 발생 순서 번호
	var event_changed_num = 0;
	var event_click_num = 0;
	//지도에서 발생하는 모든 이벤트 백그라운드로 처리
	function mapEventHandler(event_type, index1, index2){
		var kind; 
		//드래그나 줌이벤트 일경우
		var now_event_changed_num;
		if('showedMapSearch' == event_type){
			now_event_changed_num = event_changed_num++;//해당 드래그 또는 줌 이벤트의 번호를 지정
			kind ='move';
		}
		//클릭일 경우 
		var now_event_click_num;
		if('clickPolygonEvent' == event_type 
			|| 'clickSectionClusterEvent' == event_type
			|| 'clickSectionCountEvent' == event_type
			|| 'clickLocationClusterEvent' == event_type
			|| 'clickLocationCountEvent' == event_type
			|| 'clickStationEvent' == event_type
			){
			//클릭 이벤트들중 가장 최근이벤트가 아니면 실행안함
			kind ='click';
			now_event_click_num = event_click_num++;//해당 클릭 이벤트의 번호를 지정
		}
		//0.4초를 기다린후 가장최근이벤트 하나만 실행
		setTimeout(function(){
			//드래그 또는 줌 이벤트면
			if(kind == 'move'){
				//드래그나 줌이벤트중 가장 최근이벤트가 아니면 실행안함
				if(event_changed_num -1 != now_event_changed_num)
					return;
			}
			//클릭이면
			if(kind == 'click'){
				//클릭 이벤트들중 가장 최근이벤트가 아니면 실행안함
				if(event_click_num -1 != now_event_click_num)
					return;
			}
			var message = [];
			message["event_type"] = event_type;
			message["index1"] = index1;
			message["index2"] = index2;
			worker.postMessage(message); //이벤트함수 실행
		}, 200);
	}
	
	//마우스로 지도 이동을 완료시켰을 때  이벤트 
	daum.maps.event.addListener(map, 'dragend', function (){mapEventHandler('showedMapSearch', 0, 0);});
	// 휠 이벤트
	daum.maps.event.addListener(map, 'zoom_changed', function (){mapEventHandler('showedMapSearch', 0, 0);});
	
	//이미지 마우스 오버시 해당 정도 표시(지도포인트에 표시)
	var room_custom_overlay;
	$(document).on('mouseenter', '.row_inner.shadow_gray', function(){
		//마우스 오버한 매물의 위치를 설정
		var index = $(".row_inner.shadow_gray").index($(this));
		var position =  new daum.maps.LatLng(specific_room_item[index].lat, specific_room_item[index].lng);
		//마우스 오버한 매물의 위치에 매물표시를 그림
		var content = document.createElement('div');
		var width = 40;
		var heigth = 40;
		var html ="";
		html += "<div align=\"center\">";
		html +=    "<img src= \"${pageContext.request.contextPath}/images/map/room.png\" width = \""+width+"\"  height=\""+heigth+"\"/><br>";
		html += "</div>";
		content.innerHTML = html;
		//매물 표시 그리기
		if((typeof room_custom_overlay !== "undefined"))
			room_custom_overlay.setMap(null);//매물 표시지우기
		room_custom_overlay = new daum.maps.CustomOverlay({
		    map: map,
		    position: position,
		    content: content   
		});
	});
 	$(document).on('mouseleave', '.row_inner.shadow_gray', function(){
		var index = $(".row_inner.shadow_gray").index($(this));
		room_custom_overlay.setMap(null);//매물 표시지우기
	}); 
	
	//현재 보여지는 지도영역 검색
	function showedMapSearch(){
		var center = map.getCenter(); // 지도의 현재 중심좌표를 얻어옵니다.
	    var level = map.getLevel(); // 지도의 현재 레벨을 얻어옵니다.
	    var bounds = map.getBounds();  // 지도의 현재 영역을 얻어옵니다.
	    var swLatLng = bounds.getSouthWest(); // 영역의 남서쪽 좌표를 얻어옵니다.
	    var neLatLng = bounds.getNorthEast();  // 영역의 북동쪽 좌표를 얻어옵니다.
	
	    //지도좌표로  검색
		beforeSearchUrl = searchUrl;
		searchUrl ="/api/search/geo?s="+swLatLng.getLat() + "&w="+  swLatLng.getLng() +"&n="+ neLatLng.getLat()+"&e="+ neLatLng.getLng();
		posChangeSubmit(1);
		expressMap("geo", "");//검색한지역에 대해 결과 표현 
	}
	//**************************지하철 아이콘 검색************************************
	var stations = [
			{	  
			    name : '논현역',
			    position : new daum.maps.LatLng(37.51120343283703, 127.02165440557044)
			},
			{	  
			    name : '학동역',
			    position : new daum.maps.LatLng(37.51434752232154, 127.03190304841186)
			},
			{	  
			    name : '신논현역',
			    position : new daum.maps.LatLng(37.504812840848416, 127.02549342823067)
			},
			{
			    name : '강남구청역',		
			    position : new daum.maps.LatLng(37.51721350024949, 127.04131082698626)	
			},
			{
				name : '강남역',
			    position : new daum.maps.LatLng(37.498083647347194, 127.02800178194782)
			},
			{
				name : '신사역',
			    position : new daum.maps.LatLng(37.51643664311692, 127.02031202309556)
			},
			{
				name : '압구정역',
			    position : new daum.maps.LatLng(37.527391145935226, 127.02856873907587)
			},
			{
				name : '언주역',
			    position : new daum.maps.LatLng(37.50733360991586, 127.03397219323992)
			},
			{
				name : '역삼역',
			    position : new daum.maps.LatLng(37.50067271815973, 127.0364708548764)
			},
			{
				name : '양재역',
			    position : new daum.maps.LatLng(37.484574310062385, 127.03416586396881)
			},
			{
				name : '매봉역',
			    position : new daum.maps.LatLng(37.48693800745544, 127.04671303054216)
			},
			{
				name : '도곡역',
			    position : new daum.maps.LatLng(37.49097440608505, 127.05549913576135)
			},
			{
				name : '대치역',
			    position : new daum.maps.LatLng(37.49449534565928, 127.0632047065308)
			},
			{
				name : '학여울역',
			    position : new daum.maps.LatLng(37.496883973894555, 127.07116778452769)
			},
			{
				name : '한티역',
			    position : new daum.maps.LatLng(37.4962842508521, 127.0529110926891)
			},
			{
				name : '선릉역',
			    position : new daum.maps.LatLng(37.504495802946145, 127.04896290264801)
			},
			{
				name : '삼성역',
			    position : new daum.maps.LatLng(37.50882131470371, 127.0630264815774)
			},
			{
				name : '봉은사역',
			    position : new daum.maps.LatLng(37.51425394514398, 127.06023485538262)
			
			},
			{
				name : '삼성중앙역',
			    position : new daum.maps.LatLng(37.51295986514389, 127.0530446811957)
			},
			{
				name : '선정릉역',
			    position : new daum.maps.LatLng(37.51093094806047, 127.0436284102363)
			},
			{
				name : '청담역',
			    position : new daum.maps.LatLng(37.51945395048241, 127.05371880505851)
			}
	];
	var station_overlay = [];
	//지하철역 아이콘을 지하철역 위에 그리기 
	function recreateStationImg(){
		//지하철 아이콘 초기화
		for(var i = 0; i < station_overlay.length; i++)
			station_overlay[i].setMap(null); 
		station_overlay = [];
		// 지하철아이콘 그리기
		var heigth = 0;
		var font_size = 0;
		if(map.getLevel() <= 4){
			heigth = 45;
			font_size = 3;
		}else if(4 < map.getLevel() && map.getLevel() <= 6){
			heigth = 30;
			font_size = 1;
		}else{
			return;
		}
		var width = heigth;
		for(var i = 0; i < stations.length; i++){
			var content = document.createElement('div');
			var html ="";
			html += "<div align=\"center\">";
			html +=    "<img src= \"${pageContext.request.contextPath}/images/map/station.png\" width = \""+width+"\"  height=\""+heigth+"\"/><br>";
			html += 	  "<font color=\"#4346ff\" size="+font_size+">" + stations[i].name + "</font>";
			html += "</div>";
			content.innerHTML = html;
			var position =  stations[i].position;
			var customOverlay = new daum.maps.CustomOverlay({
			    map: map,
			    position: position,
			    content: content   
			});
			station_overlay.push(customOverlay);
		}
		setClickStationEvents(station_overlay);
	}
	recreateStationImg();
	//지하철역 모든아이콘의 이벤트들을 설정
	var station_index = -1;
	function setClickStationEvents(station_overlay){
		for(var i = 0; i < station_overlay.length; i++){
			station_overlay[i].getContent().index = i;
			station_overlay[i].getContent().addEventListener('click', 
					function (mouseEvent){mapEventHandler('clickStationEvent', this.index, 0);});
		}
	}
	//지하철역아이콘을 클릭할때의 이벤트 
	function clickStationEvent(index){
		if(station_index == index){
			//지하철 검색취소(기본 검색으로)
			beforeSearchUrl = searchUrl;
			searchUrl = "/api/search/geo?s="+37.45049693760036 +"&w="+126.98951220288383 +"&n="+ 37.57353330485798+"&e="+ 127.13511634995348;
			posChangeSubmit(1);//검색
			expressMap("allLocation", "");
			station_index = -1;
		}else{
			var station_name = stations[index].name;//클릭된 지하철역의 이름
			var metroNo;//검색할 지하철역의 번호(클릭된 지하철역 해당)
			//지하철역 검색을 위한 지하철역 코드를 가져옴
			 $.ajax({
					type : "GET",
					url : "/api/search/metro_no?metro_name=" + station_name,
			        contentType: 'application/json; charset=utf-8',
			        async: false,
					success : function(data) {
						metroNo = data.metro_no;//현재 선택한 '시' 의 값 설정
					},
					error : function(xhr, status, error) {
					}
			 });
			//지하철역 인근 매물 검색
			beforeSearchUrl = searchUrl;
			searchUrl  = "/api/search/metro?metro_no=" + metroNo;
			posChangeSubmit(1);//검색
			expressMap("metro", station_name);
			station_index = index;
		}
	} 
	//****************************검색 종류에 따라 지도 위치 및 검색정보 표시*************************************
	//검색종류에 따라 출력 검색이름(-> 000최신방)과 섹션영역,클러스터선택 상태 설정
	function expressMap(type, name){
		 //name: 지역이름 또는 지하철역  이름 /type: 지역인지 지하철역이지의 종류 구분 
		 //지하철역 인근을 원으로 반경표시 초기화
		if(typeof(metro_circle) != "undefined")
			metro_circle.setMap(null);
		 //섹션 검색도형 및 클러스터 표시 초기화 
		if(type != 'section' && type != 'location'){
			//클릭해제
			setClickPolygonState(false, -1);//클릭한 도형 전부해제
			setClickSectionClusterState(false, -1);//클릭 클러스터 해제
		} else if(type != 'section'){ 
			setClickSectionClusterState(false, -1);//클릭 섹션별 클러스터  표시해제
		} else if(type != 'location'){ 
			setClickLocationClusterState(false, -1, -1);//클릭 인근위치별 클러스터 표시 해제 
		} 
		 
		//검색종류에 따라 매물수와 검색종류 표시
		if(type == 'metro'){
			// 장소 검색 객체를 생성합니다
			var ps = new daum.maps.services.Places();
			// 키워드로 장소를 검색합니다.
			ps.keywordSearch(name, placesSearchCB); 
			// 키워드 검색 완료 시 호출되는 콜백함수 입니다
			function placesSearchCB(status, data, pagination) {
			    if (status === daum.maps.services.Status.OK) {
			        //지정된 영역좌표 내에 있는 역의 자표 지정 
			        var lat;
			        var lng;
			    	for(var i = 0; i < data.places.length; i++){
			    		if(37 <= data.places[i].latitude 
			    				&& data.places[i].latitude < 38 
			    				&& 127 < data.places[i].longitude){//강남구 근처의 좌표영역 내에 있으면
				    		lat = data.places[i].latitude;
				    		lng = data.places[i].longitude;
				    		break;
			    		}
			    	}
			    	// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        var bounds = new daum.maps.LatLngBounds();
			        // alert(data.places[0].latitude +"/"+  data.places[0].longitude);
			        //지도위치이동
					bounds.extend(new daum.maps.LatLng(lat, lng));
					//지도에 원으로 반경 표시
					drawMetroCircle(lat, lng);
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			        map.setBounds(bounds);
			      	//지도 축적 변경
			        map.setLevel(4);//100m로확대
			    } 
			}
			$("#search_type_name").text(name  +" 인근 최신방");//검색 종류  출력
		} else if(type == 'local'){
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new daum.maps.services.Geocoder();
			// 주소로 좌표를 검색합니다
			geocoder.addr2coord(
					name,
					function(status, result) {
						// 정상적으로 검색이 완료됐으면 
						if (status === daum.maps.services.Status.OK) {
							var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
							map.setCenter(coords);
					      	//지도 축적 변경
					        map.setLevel(5);
						}
					}
			);
			$("#search_type_name").text(name  +" 인근 최신방");//검색 종류  출력
			addSectionClick(name);//동에 맞는 섹션 선택상태로
		} else if(type == 'geo'){
			$("#search_type_name").text("이지역 최신방");//검색 종류  출력 
		} else if(type == 'allLocation'){ //모든 영역 검색
			$("#search_type_name").text("강남구 최신방");//검색 종류  출력
		} else if(type == 'bunji'){ 
			$("#search_type_name").text(name + '번지');//섹션 이름 출력
		} else if(type == 'section'){ 
	 		var area_kor = name;
	 		area_kor = area_kor.replace( "apgujeong", "압구정");
	 		area_kor = area_kor.replace( "banpo", "반포");
	 		area_kor = area_kor.replace( "cheongdam", "청담");
	 		area_kor = area_kor.replace( "daechi", "대치");
	 		area_kor = area_kor.replace( "dogok", "도곡");
	 		area_kor = area_kor.replace( "jamwon", "잠원");
	 		area_kor = area_kor.replace( "nonhyeon", "논현");
	 		area_kor = area_kor.replace( "samsung", "삼성");
	 		area_kor = area_kor.replace( "seocho", "서초");
	 		area_kor = area_kor.replace( "sinsa", "신사");
	 		area_kor = area_kor.replace( "yeoksam", "역삼");
			$("#search_type_name").text(area_kor);//섹션 이름 출력
		} else if(type == 'location'){ 
			$("#search_type_name").text('해당 위치');//섹션 이름 출력
		}
		else{}
	}
	//지하철역 근처 원 반경 표시
	var metro_circle;
	function drawMetroCircle(lat,lng){	
		metro_circle = new daum.maps.Circle({
		    center : new daum.maps.LatLng(lat, lng),  // 원의 중심좌표 입니다 
		    radius: 500, // 500m반경의 원
		    strokeWeight: 5, // 선의 두께
		    strokeColor: '#75B8FA', // 선의 색깔
		    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명
		    strokeStyle: 'dashed', // 선의 스타일 
		    fillColor: '#CFE7FF', // 채우기 색깔
		    fillOpacity: 0.2  // 채우기 불투명도
		}); 
		// 지도에 원 그리기
		metro_circle.setMap(map); 
	}
	//현재 지도에서 보여지는 지역정보를 가져와 지도 상단 리스트에 표시
	function showLocal(){
		var center = map.getCenter(); 
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : "https://apis.daum.net/local/geo/coord2addr?apikey=<%=GlobalValue.mapApi%>"
					+ "&longitude="+center.getLng()+"&latitude="+center.getLat()+"&inputCoordSystem=WGS84&output=json",
			async : false,
			dataType : "jsonp",
			success : function(data) {//msg를 받는 것이 성공하면
				//현재 검색한 위치의 지역명을 지도상단에 표시
		        document.getElementById("si_text").innerHTML  = data.name1;//현재 선택한 '시' 의 값 설정
		        document.getElementById("gungu_text").innerHTML  = data.name2;//현재 선택한 '군/구' 의 값 설정
		        document.getElementById("dong_text").innerHTML  = data.name3;//현재 선택한 동의 값 설정
			},
			error : function(xhr, status, error) {
			}
		});
	}
	
	//*****************섹션 검색 ********************************	
	// 지도에 폴리곤으로 표시할 영역데이터 배열입니다 
	var areas = [
			{	  
			  name : 'nonhyeon1',
			  dong : '논현동',
			  path : [
			       new daum.maps.LatLng(37.516194, 127.019481),
			       new daum.maps.LatLng(37.5197, 127.028085),
			       new daum.maps.LatLng(37.513964, 127.030682),
			       new daum.maps.LatLng(37.511139, 127.021283),
			       new daum.maps.LatLng(37.516194, 127.019481)
			  ]
			},
			{
			  name : 'nonhyeon2',
			  dong : '논현동',
			  path : [
			       new daum.maps.LatLng(37.5197, 127.028085),
			       new daum.maps.LatLng(37.521453, 127.03375),
			       new daum.maps.LatLng(37.518219, 127.035209),
			       new daum.maps.LatLng(37.515394, 127.035295),
			       new daum.maps.LatLng(37.513964, 127.030682),
			       new daum.maps.LatLng(37.5197, 127.028085)
			  ]
			},
			{
			  name : 'nonhyeon3',
			  dong : '논현동',
			  path : [
			       new daum.maps.LatLng(37.521453, 127.03375),
			       new daum.maps.LatLng(37.523103, 127.039072),
			       new daum.maps.LatLng(37.517266, 127.041282),
			       new daum.maps.LatLng(37.515394, 127.035295),
			       new daum.maps.LatLng(37.518219, 127.035209),
			       new daum.maps.LatLng(37.521453, 127.03375)
			  ]		
			},
			{
			  name : 'nonhyeon4',
			  dong : '논현동',
			  path : [
			       new daum.maps.LatLng(37.511122, 127.021369),
			       new daum.maps.LatLng(37.513981, 127.030703),
			       new daum.maps.LatLng(37.507343, 127.033793),
			       new daum.maps.LatLng(37.504432, 127.024437),
			       new daum.maps.LatLng(37.511122, 127.021369)
			  ]		
			},
			{
			  name : 'nonhyeon5',
			  dong : '논현동',
			  path : [
			       new daum.maps.LatLng(37.513981, 127.030703),
			       new daum.maps.LatLng(37.51536, 127.035316),
			       new daum.maps.LatLng(37.511768, 127.035789),
			       new daum.maps.LatLng(37.508705, 127.038449),
			       new daum.maps.LatLng(37.507343, 127.033793),
			       new daum.maps.LatLng(37.513981, 127.030703)
			  ]		
			},
			{
			  name : 'nonhyeon6',
			  dong : '논현동',
			  path : [
			       new daum.maps.LatLng(37.51536, 127.035316),
			       new daum.maps.LatLng(37.517181, 127.041217),
			       new daum.maps.LatLng(37.510271, 127.043835),
			       new daum.maps.LatLng(37.508705, 127.038449),
			       new daum.maps.LatLng(37.511768, 127.035789),
			       new daum.maps.LatLng(37.51536, 127.035316)
			  ]		
			},
			{
			  name : 'sinsa1',
			  dong : '신사동',
			  path : [
			       new daum.maps.LatLng(37.521776, 127.017696),
			       new daum.maps.LatLng(37.527256, 127.028296),
			       new daum.maps.LatLng(37.519768, 127.028168),
			       new daum.maps.LatLng(37.516194, 127.01937),
			       new daum.maps.LatLng(37.521776, 127.017696)
			  ]		
			},
			{
			  name : 'apgujeong1',
			  dong : '압구정동',
			  path : [
			       new daum.maps.LatLng(37.527256, 127.028296),
			       new daum.maps.LatLng(37.529162, 127.033707),
			       new daum.maps.LatLng(37.523869, 127.033063),
			       new daum.maps.LatLng(37.521538, 127.033814),
			       new daum.maps.LatLng(37.519768, 127.028168),
			       new daum.maps.LatLng(37.527256, 127.028296)
			  ]		
			},
			{
			  name : 'apgujeong2',
			  dong : '압구정동',
			  path : [
			       new daum.maps.LatLng(37.529162, 127.033707),
			       new daum.maps.LatLng(37.5278, 127.040638),
			       new daum.maps.LatLng(37.523103, 127.039072),
			       new daum.maps.LatLng(37.521538, 127.033814),
			       new daum.maps.LatLng(37.523869, 127.033063),
			       new daum.maps.LatLng(37.529162, 127.033707)
			  ]		
			},
			{
			  name : 'cheongdam1',
			  dong : '청담동',
			  path : [
			       new daum.maps.LatLng(37.523103, 127.039072),
			       new daum.maps.LatLng(37.524193, 127.047333),
			       new daum.maps.LatLng(37.518866, 127.050251),
			       new daum.maps.LatLng(37.517181, 127.041239),
			       new daum.maps.LatLng(37.523103, 127.039072)
			  ]		
			},
			{
			  name : 'cheongdam2',
			  dong : '청담동',
			  path : [
			       new daum.maps.LatLng(37.524193, 127.047333),
			       new daum.maps.LatLng(37.525043, 127.054328),
			       new daum.maps.LatLng(37.519989, 127.056838),
			       new daum.maps.LatLng(37.518866, 127.050251),
			       new daum.maps.LatLng(37.524193, 127.047333)
			  ]		
			},
			{
			  name : 'cheongdam3',
			  dong : '청담동',
			  path : [
			       new daum.maps.LatLng(37.523103, 127.039072),
			       new daum.maps.LatLng(37.530523, 127.041582),
			       new daum.maps.LatLng(37.527171, 127.054285), 
			       new daum.maps.LatLng(37.525043, 127.054328),
			       new daum.maps.LatLng(37.523103, 127.039072)
			  ]		
			},
			{
			  name : 'samsung1',
			  dong : '삼성동',
			  path : [
			       new daum.maps.LatLng(37.517181, 127.041196),
			       new daum.maps.LatLng(37.518849, 127.05023),
			       new daum.maps.LatLng(37.513045, 127.053277),
			       new daum.maps.LatLng(37.510271, 127.043835),
			       new daum.maps.LatLng(37.517181, 127.041196)
			  ]		
			},
			{
			  name : 'samsung2',
			  dong : '삼성동',
			  path : [
			       new daum.maps.LatLng(37.518849, 127.05023),
			       new daum.maps.LatLng(37.520023, 127.056774),
			       new daum.maps.LatLng(37.514102, 127.060229),
			       new daum.maps.LatLng(37.513045, 127.053277),
			       new daum.maps.LatLng(37.518849, 127.05023)
			  ]		
			},
			{
			  name : 'samsung3',
			  dong : '삼성동',
			  path : [
			       new daum.maps.LatLng(37.52004, 127.056881),
			       new daum.maps.LatLng(37.521657, 127.061559),
			       new daum.maps.LatLng(37.516057, 127.066516),
			       new daum.maps.LatLng(37.510015, 127.067503),
			       new daum.maps.LatLng(37.50879, 127.063233),
			       new daum.maps.LatLng(37.52004, 127.056881)
			  ]		
			},
			{
			  name : 'samsung4',
			  dong : '삼성동',
			  path : [
			       new daum.maps.LatLng(37.510271, 127.043835),
			       new daum.maps.LatLng(37.513028, 127.053277),
			       new daum.maps.LatLng(37.506934, 127.05656),
			       new daum.maps.LatLng(37.504568, 127.048899),
			       new daum.maps.LatLng(37.506594, 127.047762),
			       new daum.maps.LatLng(37.508653, 127.044629),
			       new daum.maps.LatLng(37.510271, 127.043835)
			  ]		
			},
			{
			  name : 'samsung5',
			  dong : '삼성동',
			  path : [
			       new daum.maps.LatLng(37.513028, 127.053277),
			       new daum.maps.LatLng(37.514151, 127.060207),
			       new daum.maps.LatLng(37.508892, 127.063169),
			       new daum.maps.LatLng(37.506934, 127.05656),
			       new daum.maps.LatLng(37.513028, 127.053277)
			  ]		
			},
			{
			  name : 'yeoksam1',
			  dong : '역삼동',
			  path : [
			       new daum.maps.LatLng(37.504432, 127.024416),
			       new daum.maps.LatLng(37.507309, 127.033836),
			       new daum.maps.LatLng(37.500857, 127.03684),
			       new daum.maps.LatLng(37.49798, 127.027613),
			       new daum.maps.LatLng(37.504432, 127.024416)
			  ]		
			},
			{
			  name : 'yeoksam2',
			  dong : '역삼동',
			  path : [
			       new daum.maps.LatLng(37.507309, 127.033836),
			       new daum.maps.LatLng(37.508722, 127.038492),
			       new daum.maps.LatLng(37.505709, 127.041282),
			       new daum.maps.LatLng(37.502679, 127.042741),
			       new daum.maps.LatLng(37.500857, 127.03684), 
			       new daum.maps.LatLng(37.507309, 127.033836)
			  ]		
			},
			{
			  name : 'yeoksam3',
			  dong : '역삼동',
			  path : [
			       new daum.maps.LatLng(37.508722, 127.038492),
			       new daum.maps.LatLng(37.510271, 127.043835),
			       new daum.maps.LatLng(37.508653, 127.044629),
			       new daum.maps.LatLng(37.506594, 127.047762),
			       new daum.maps.LatLng(37.504585, 127.048942),
			       new daum.maps.LatLng(37.502679, 127.042741),
			       new daum.maps.LatLng(37.505709, 127.041282),
			       new daum.maps.LatLng(37.508722, 127.038492)
			  ]		
			},
			{
			  name : 'yeoksam4',
			  dong : '역삼동',
			  path : [
			       new daum.maps.LatLng(37.502628, 127.042741),
			       new daum.maps.LatLng(37.504584, 127.048942),
			       new daum.maps.LatLng(37.496295, 127.052804),
			       new daum.maps.LatLng(37.49432, 127.04671), 
			       new daum.maps.LatLng(37.502628, 127.042741)
			  ]		
			},
			{
			  name : 'yeoksam5',
			  dong : '역삼동',
			  path : [
			       new daum.maps.LatLng(37.500789, 127.036904),
			       new daum.maps.LatLng(37.502628, 127.042741),
			       new daum.maps.LatLng(37.49432, 127.04671),
			       new daum.maps.LatLng(37.492532, 127.040853), 
			       new daum.maps.LatLng(37.500789, 127.036904)
			  ]		
			},
			{
			  name : 'yeoksam6',
			  dong : '역삼동',
			  path : [
			       new daum.maps.LatLng(37.49798, 127.027635),
			       new daum.maps.LatLng(37.500789, 127.036904),
			       new daum.maps.LatLng(37.492532, 127.040853),
			       new daum.maps.LatLng(37.489672, 127.031583),
			       new daum.maps.LatLng(37.49798, 127.027635)
			  ]		
			},
			{
			  name : 'daechi1',
			  dong : '대치동',
			  path : [
			       new daum.maps.LatLng(37.5045, 127.048964),
			       new daum.maps.LatLng(37.5069, 127.056624),
			       new daum.maps.LatLng(37.498882, 127.060873),
			       new daum.maps.LatLng(37.496295, 127.052869),
			       new daum.maps.LatLng(37.5045, 127.048964)
			  ]		
			},
			{
			  name : 'daechi2',
			  dong : '대치동',
			  path : [
			       new daum.maps.LatLng(37.5069, 127.056624),
			       new daum.maps.LatLng(37.50879, 127.063083),
			       new daum.maps.LatLng(37.500976, 127.067353),
			       new daum.maps.LatLng(37.498882, 127.060873), 
			       new daum.maps.LatLng(37.5069, 127.056624)
			  ]		
			},
			{
			  name : 'dogok1',
			  dong : '도곡동',
			  path : [
			       new daum.maps.LatLng(37.489519, 127.031669),
			       new daum.maps.LatLng(37.496244, 127.052847),
			       new daum.maps.LatLng(37.488378, 127.056238),
			       new daum.maps.LatLng(37.481108, 127.044178),
			       new daum.maps.LatLng(37.47496, 127.038685),
			       new daum.maps.LatLng(37.48012, 127.038106),
			       new daum.maps.LatLng(37.484581, 127.033986),
			       new daum.maps.LatLng(37.489519, 127.031669)
			  ]		
			},
			{
			  name : 'jamwon1',
			  dong : '잠원동',
			  path : [
			       new daum.maps.LatLng(37.521823, 127.017869),
			       new daum.maps.LatLng(37.514743, 127.015380),
			       new daum.maps.LatLng(37.509466, 127.016110),
			       new daum.maps.LatLng(37.511100, 127.021260),
			       new daum.maps.LatLng(37.521823, 127.017869)
			  ]		
			},
			{
			  name : 'banpo1',
			  dong : '반포동',
			  path : [
			       new daum.maps.LatLng(37.509466, 127.016110),
			       new daum.maps.LatLng(37.511100, 127.021260),
			       new daum.maps.LatLng(37.504394, 127.024521),
			       new daum.maps.LatLng(37.502964, 127.018685),
			       new daum.maps.LatLng(37.509466, 127.016110)
			  ]		
			},
			{
			  name : 'seocho1',
			  dong : '서초동',
			  path : [
			       new daum.maps.LatLng(37.504394, 127.024521),
			       new daum.maps.LatLng(37.502964, 127.018685),
			       new daum.maps.LatLng(37.495950, 127.021260),
			       new daum.maps.LatLng(37.497891, 127.027654),
			       new daum.maps.LatLng(37.504394, 127.024521)
			  ]		
			},
			{
			  name : 'seocho2',
			  dong : '서초동',
			  path : [
			       new daum.maps.LatLng(37.495940, 127.021260),
			       new daum.maps.LatLng(37.497891, 127.027654),
			       new daum.maps.LatLng(37.489514, 127.031688),
			       new daum.maps.LatLng(37.487335, 127.024478),
			       new daum.maps.LatLng(37.495940, 127.021260)
			  ]		
			},
			{
			  name : 'seocho3',
			  dong : '서초동',
			  path : [
			       new daum.maps.LatLng(37.489514, 127.031688),
			       new daum.maps.LatLng(37.487335, 127.024478),
			       new daum.maps.LatLng(37.483385, 127.025980),
			       new daum.maps.LatLng(37.483385, 127.025980),
			       new daum.maps.LatLng(37.484543, 127.034048)
			  ]		
			}
	]
	
	//인덱스에 맞는 섹터를 검색함
	function searchSection(index){
		//선택 섹션 검색
		beforeSearchUrl = searchUrl;
		searchUrl  = "/api/search/sector?sector_name="+areas[index].name; 
		posChangeSubmit(1);//검색
		expressMap("section", areas[index].name);
	}	//섹션에해당되는 매물 수를 설정함 
	
	//****************************섹션 도형****************************************
	function setSectionCount(){
		var names = []; 
		for(var i = 0; i < areas.length; i++)//섹션 수만큼
			names.push(areas[i].name);
		var searchCountUrl  = "/api/search/all_sector_count?"+ "sector_names=" + JSON.stringify(names); 
		var url = searchCountUrl + filterUrl ;
		//관심매물을 서버에 저장
		 $.ajax({
				type : "GET",
				url : url,
		        contentType: 'application/json; charset=utf-8',
		        async: false,
				success : function(data) {
					for(var i = 0; i < areas.length; i++){
						areas[i].count =  data.sector_counts[i];//섹션별 개수 저장
					}
				},
				error : function(xhr, status, error) {
				}
		 });
	} 
	setSectionCount();
	
	//기본도형 섹션별 생성 
	var basic_polygons = [];
	function createBasicPolygons(areas){
    	// 지도에 섹션 기본 영역을 폴리곤으로 표시합니다 
    	for (var i = 0, len = areas.length; i < len; i++){
			var polygon = new daum.maps.Polygon({
		        map: map, // 다각형을 표시할 지도 객체
		        path: areas[i].path,
		        strokeWeight: 3,
		        strokeColor: '#45ECCB',//기본 도형(선택안된 섹션)색
		        strokeOpacity: 1,
		        fillColor: '#45ECCB',//기본 도형(선택안된 섹션)배경색
		        fillOpacity: 0.0000001
		    });
			basic_polygons.push(polygon);
    	}
	}
	createBasicPolygons(areas);
	//선택시의 도형 섹션별 생성 
	var click_polygon_index = [];//클릭된 섹션별 도형과 섹션별 클러스터들
	var select_polygons = [];
	function createSelectPolygons(areas){
    	// 지도에 섹션 선택 영역을 폴리곤으로 표시합니다 
    	for (var i = 0; i < areas.length; i++){
			var polygon = new daum.maps.Polygon({
		        map: map, // 다각형을 표시할 지도 객체
		        path: areas[i].path,
		        strokeWeight: 3,
		        strokeColor: '#FF5C89',//선택 도형(선택된 섹션)색
		        strokeOpacity: 0.0000001,
		        fillColor: '#FF5C89',//선택 도형(선택된 섹션)배경색
		        fillOpacity: 0.000001
		    });
			select_polygons.push(polygon);
    	}
    	for(var i = 0 ; i < click_polygon_index.length; i++){//클릭된 섹션영역의 수만큼 섹션클릭상태로
    		select_section_clusters[click_polygon_index[i]].setOptions({fillOpacity:  0.2});
	    	select_section_clusters[click_polygon_index[i]].setOptions({strokeOpacity: 1});
    	}
	}
	createSelectPolygons(areas);
	var event_click_num = 0;//클릭 이벤트의 최근 인덱스
	//기본도형 섹션별 이벤트설정
	function setClickPolygonEvents(polygons){
		for(var i = 0; i < polygons.length; i++){
			polygons[i].index = i;
			daum.maps.event.addListener(polygons[i], 'click', 
					function (mouseEvent){mapEventHandler('clickPolygonEvent', this.index, 0);});
		}
	}
	//기본도형 각 섹션별 클릭 이벤트 
	function clickPolygonEvent(index){
		var now_event_num = event_click_num++;
		(function(index) {  
			setTimeout(function(){
				if(event_click_num -1 != now_event_num)//최근 발생한 이벤트가아니면 실행안함
					return;
				var clicked = 0;
				var clickedNum = 0;
				for(var i = 0 ; i < click_polygon_index.length; i++){//클릭된 섹션영역의 수만큼 
		    		if(click_polygon_index[i] == index)//클릭된인덱스와 도형의 인덱스가 같으면
		    			clicked++;//클릭된상태로
		    		clickedNum++;
		    	}
				if(clicked == 1 && clickedNum == 1){//섹션영역 하나 선택된 상태에서 클릭되면
					//클릭된 상태에서 클릭
					if(5 < map.getLevel()){//500m이상  
						//클릭해제
						setClickPolygonState(false, index);//클릭한 도형 전부해제
						setClickSectionClusterState(false, index);//클릭 클러스터 해제
					} else if(map.getLevel() == 5){//250m 
						//클릭해제
						setClickPolygonState(false, index);//클릭한 도형 전부해제
						setClickSectionClusterState(false, index);//클릭 클러스터 해제
					} else if(map.getLevel() <= 4 ){//100m
						//클릭해제
						setClickPolygonState(false, index);//클릭한 도형 전부해제
						setClickSectionClusterState(false, index);//클릭 클러스터 해제
					}
					//섹션 검색취소(기본 검색으로)
					beforeSearchUrl = searchUrl;
					searchUrl = "/api/search/geo?s="+37.45049693760036 +"&w="+126.98951220288383 +"&n="+ 37.57353330485798+"&e="+ 127.13511634995348;
					posChangeSubmit(1);//검색
					expressMap("allLocation", "");
				} else {//클릭이 안됐거나 , 하나 이상의 영역이 선택된 상태에서 클릭 되면 
					if(5 < map.getLevel()){//500m이상  
						//클릭상태로
						setClickPolygonState(true, index);//클릭한 도형만 표시 
						setClickSectionClusterState(true, index);//클릭 클러스터 선택만 표시 
						//250m으로 확대
				        map.setCenter(getCenterOfPoints(areas[index].path));
				        map.setLevel(5);
					} else if(map.getLevel() == 5){//250m 
						setClickPolygonState(true, index);//클릭한 도형만 표시 
						setClickSectionClusterState(true, index);//클릭 클러스터 선택만 표시 
						//100m으로 확대
				        //map.setCenter(getCenterOfPoints(areas[index].path));
					} else if(map.getLevel() <= 4) {
						//클릭상태로
						setClickPolygonState(true, index);//클릭한 도형만 표시 
						setClickSectionClusterState(true, index);//클릭 클러스터 선택만 표시 
						//250m으로
				        map.setCenter(getCenterOfPoints(areas[index].path));
					}
					//선택 섹션 검색
					searchSection(index);
				}
			}, 200);
		 }(index));
	}
	
	setClickPolygonEvents(basic_polygons);//기본도형 이벤트 설정
	setClickPolygonEvents(select_polygons);//기본도형 이벤트 설정
	//도형 표시 선택 또는 미선택으로
	function setClickPolygonState(show, select_index){
		//도형 선택된 상태 모두 해제
		for(var i = 0; i < select_polygons.length; i++){
			select_polygons[i].setOptions({fillOpacity:  0.00000001});//클릭 배경 색상 투명도
	        select_polygons[i].setOptions({strokeOpacity: 0.0000001});
		}
		click_polygon_index = [];
		//선택한 도형 클릭상태로
		if(show){
			select_polygons[select_index].setOptions({fillOpacity:  0.2});//클릭 배경 색상 투명도
	        select_polygons[select_index].setOptions({strokeOpacity: 1});
	        click_polygon_index.push(select_index);
		}
	}
	//동이름과 일치하는 도형 표시 다중선택
	function addSectionClick(dong){// 상태 모두 해제
		for(var i = 0; i < select_polygons.length; i++){
			//섹션 영역 클릭상태 초기화
			select_polygons[i].setOptions({fillOpacity:  0.00000001});//클릭 배경 색상 투명도
	        select_polygons[i].setOptions({strokeOpacity: 0.0000001});
			//섹션 클러스터 선택상태 초기화
			select_section_clusters[i].setOptions({fillOpacity:  0.00000001});//클릭 배경 색상 투명도
			select_section_clusters[i].setOptions({strokeOpacity: 0.0000001});
		}
		click_polygon_index = [];
		for(var i = 0; i < areas.length; i++){//섹션의 수만큼
			if(dong == areas[i].dong){//검색한 동이름과 일치하는 섹션이면
				//섹션 영역 선택상태로
				select_polygons[i].setOptions({fillOpacity:  0.2});//클릭 배경 색상 투명도
		        select_polygons[i].setOptions({strokeOpacity: 1});
				//섹션 클러스터 선택상태로
		        select_section_clusters[i].setOptions({fillOpacity:  0.2});
		    	select_section_clusters[i].setOptions({strokeOpacity: 1});
	    		//섹션영역 선택상태 저장
		        click_polygon_index.push(i);
			}
		}
	}
	//***************** 클러스터(섹터별)  ********************************	
	//클러스터 섹션별 생성 
	var section_count_overlay = [];
	var basic_section_clusters = [];
	function createBasicSectionClusters(areas){
		//이미 생성되어 있으면 생성안함
		if(basic_section_clusters.length != 0)
			return;
    	// 지도에 섹션 기본 영역을 클러스터로 표시합니다 
    	for (var i = 0, len = areas.length; i < len; i++){
    		var position = getCenterOfPoints(areas[i].path);
    		var circle = new daum.maps.Circle({
    		    center : position,  // 원의 중심좌표 입니다 
    		    radius: 100, // 100m반경의 원
    		    strokeWeight: 5, // 선의 두께
    		    strokeColor: '#45ECCB', // 선의 색깔
    		    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명
    		    fillColor: '#45ECCB', // 채우기 색깔
    		    fillOpacity: 0.2  // 채우기 불투명도
    		}); 
    		// 지도에 원 그리기
    		circle.setMap(map); 
    		basic_section_clusters.push(circle);
    	}
	}
	createBasicSectionClusters(areas);
	//선택 클러스터 섹션별 생성 
	var select_section_clusters = [];
	function createSelectSectionClusters(areas){
		//이미 생성되어 있으면 생성안함
		if(select_section_clusters.length != 0)
			return;
    	// 지도에 섹션 선택 영역을 클러스터로 표시합니다 
    	for (var i = 0, len = areas.length; i < len; i++){
    		var position = getCenterOfPoints(areas[i].path);
    		circle = new daum.maps.Circle({
    		    center : position,  // 원의 중심좌표 입니다 
    		    radius: 100, // 100m반경의 원
    		    strokeWeight: 5, // 선의 두께
    		    strokeColor: '#FF5C89', // 선의 색깔
    		    strokeOpacity: 0.000000001, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명
    		    fillColor: '#FF5C89', // 채우기 색깔
    		    fillOpacity: 0.00000001 // 채우기 불투명도
    		}); 
    		// 지도에 원 그리기
    		circle.setMap(map); 
    		select_section_clusters.push(circle);
    		
    		// 지도에 섹션 검색 개수 그리기 
    		var content = document.createElement('div');
    		content.innerHTML = areas[i].count;
    		var customOverlay = new daum.maps.CustomOverlay({
    		    map: map,
    		    position: position,
    		    content: content   
    		})
    		section_count_overlay.push(customOverlay); 
    	} 
    	for(var i = 0 ; i < click_polygon_index.length; i++){//클릭된 섹션영역의 수만큼 섹션클릭상태로
    		select_section_clusters[click_polygon_index[i]].setOptions({fillOpacity:  0.2});
	    	select_section_clusters[click_polygon_index[i]].setOptions({strokeOpacity: 1});
    	}
	}
	createSelectSectionClusters(areas);
	//섹션별 묶은 클러스터를 보이지 않게한다.
	function removeSectionCluster(){
		//섹션 클러스터 도형 삭제
		for(var i = 0; i < basic_section_clusters.length; i++)
			basic_section_clusters[i].setMap(null);
		for(var i = 0; i < select_section_clusters.length; i++)
			select_section_clusters[i].setMap(null);
		for(var i = 0; i < section_count_overlay.length; i++)
    		section_count_overlay[i].setMap(null); 
    	
		//섹션클러스터 값 초기화
		select_section_clusters = [];//섹션클러스터 선택 표현 초기화
		basic_section_clusters = [];//섹션클러스터 기본 표현 초기화
		section_count_overlay = [];//섹션별 개수 표현 초기화
	}
	//섹터 클러스터들의 클릭 이벤트 설정
	function setClickSectionClusterEvents(clusters){
		for(var i = 0; i < clusters.length; i++){
			clusters[i].index = i;
			daum.maps.event.addListener(clusters[i], 'click',
					function (mouseEvent){mapEventHandler('clickSectionClusterEvent', this.index, 0);}); 
		}
	}
	//섹터별 클러스터 클릭 이벤트
	function clickSectionClusterEvent(index){
		var now_event_num = event_click_num++;
		(function(index) {  
			setTimeout(function(){
				if(event_click_num -1 != now_event_num)//최근 발생한 이벤트가아니면 실행안함
					return;
				var clicked = 0;
				var clickedNum = 0;
				for(var i = 0 ; i < click_polygon_index.length; i++){//클릭된 섹션영역의 수만큼 
		    		if(click_polygon_index[i] == index)//클릭된인덱스와 도형의 인덱스가 같으면
		    			clicked++;//클릭된상태로
		    		clickedNum++;
		    	}
				if(clicked == 1 && clickedNum == 1){//섹션영역 하나 선택된 상태에서 클릭되면
					//클릭된 상태에서 클릭
					if(5 < map.getLevel()){//500m이상  
						//클릭해제
						setClickPolygonState(false, index);//클릭한 도형 전부해제
						setClickSectionClusterState(false, index);//클릭 클러스터 해제
					} else if(map.getLevel() == 5){//250m 
						setClickPolygonState(true, index);//클릭한 도형만 표시 
						setClickSectionClusterState(true, index);//클릭 클러스터 선택만 표시 
						//100m으로 확대
				        map.setCenter( getCenterOfPoints(areas[index].path));
				        map.setLevel(4);
					} 
					//섹션 검색취소(기본 검색으로)
					beforeSearchUrl = searchUrl;
					searchUrl = "/api/search/geo?s="+37.45049693760036 +"&w="+126.98951220288383 +"&n="+ 37.57353330485798+"&e="+ 127.13511634995348;
					posChangeSubmit(1);//검색
					expressMap("allLocation", "");
				} else{//클릭이 안됐거나 , 하나 이상의 영역이 선택된 상태에서 클릭 되면 
					//클릭안된 상태에서 클릭 
					if(5 < map.getLevel()){//500m이상  
						//클릭상태로
						setClickPolygonState(true, index);//클릭한 도형만 표시 
						setClickSectionClusterState(true, index);//클릭 클러스터 선택만 표시 
						//250m으로 확대
				        map.setCenter(getCenterOfPoints(areas[index].path));
				        map.setLevel(5);
					} else if(map.getLevel() == 5){//250m 
						setClickPolygonState(true, index);//클릭한 도형만 표시 
						setClickSectionClusterState(true, index);//클릭 클러스터 선택만 표시 
						//100m으로 확대
				        map.setCenter( getCenterOfPoints(areas[index].path));
				        map.setLevel(4);
					}
					//선택 섹션 검색
					searchSection(index);
				}
			}, 200);
		 }(index));
	}
	
	//섹터별 클러스터의 숫자들 클릭 이벤트 설정
	function setClickSectionCountEvents(section_count_overlay){
		for(var i = 0; i < section_count_overlay.length; i++){
			section_count_overlay[i].getContent().index = i;
			section_count_overlay[i].getContent().addEventListener('click', 
					function (mouseEvent){mapEventHandler('clickSectionCountEvent', this.index, 0);});
		}
	}
	//섹터별 클러스터의 숫자 클릭 이벤트 
	function clickSectionCountEvent(index){
		var now_event_num = event_click_num++;
		(function(index) {  
			setTimeout(function(){
				if(event_click_num -1 != now_event_num)//최근 발생한 이벤트가아니면 실행안함
					return;
				var clicked = 0;
				var clickedNum = 0;
				for(var i = 0 ; i < click_polygon_index.length; i++){//클릭된 섹션영역의 수만큼 
		    		if(click_polygon_index[i] == index)//클릭된인덱스와 도형의 인덱스가 같으면
		    			clicked++;//클릭된상태로
		    		clickedNum++;
		    	}
				if(clicked == 1 && clickedNum == 1){//섹션영역 하나 선택된 상태에서 클릭되면
					//클릭된 상태에서 클릭
					if(5 < map.getLevel()){//500m이상  
						//클릭해제
						setClickPolygonState(false, index);//클릭한 도형 전부해제
						setClickSectionClusterState(false, index);//클릭 클러스터 해제
					} else if(map.getLevel() == 5){//250m 
						setClickPolygonState(true, index);//클릭한 도형만 표시 
						setClickSectionClusterState(true, index);//클릭 클러스터 선택만 표시 
						//100m으로 확대
				        map.setCenter(getCenterOfPoints(areas[index].path));
				        map.setLevel(4);
						//선택 섹션 검색
						searchSection(index); 
					} 
					//섹션 검색취소(기본 검색으로)
					beforeSearchUrl = searchUrl;
					searchUrl = "/api/search/geo?s="+37.45049693760036 +"&w="+126.98951220288383 +"&n="+ 37.57353330485798+"&e="+ 127.13511634995348;
					posChangeSubmit(1);//검색
					expressMap("allLocation", "");
				} else{//클릭이 안됐거나 , 하나 이상의 영역이 선택된 상태에서 클릭 되면 
					//클릭안된 상태에서 클릭 
					if(5 < map.getLevel()){//500m이상  
						//클릭상태로
						setClickPolygonState(true, index);//클릭한 도형만 표시 
						setClickSectionClusterState(true, index);//클릭 클러스터 선택만 표시 
						//250m으로 확대
				        map.setCenter(getCenterOfPoints(areas[index].path));
				        map.setLevel(5);
					} else if(map.getLevel() == 5){//250m 
						setClickPolygonState(true, index);//클릭한 도형만 표시 
						setClickSectionClusterState(true, index);//클릭 클러스터 선택만 표시 
						//100m으로 확대
				        map.setCenter( getCenterOfPoints(areas[index].path));
				        map.setLevel(4);
					}
					//선택 섹션 검색
					searchSection(index);
				}
			}, 200);
		 }(index));
	}
	
	setClickSectionClusterEvents(basic_section_clusters);//기본도형 이벤트 설정
	setClickSectionClusterEvents(select_section_clusters);//기본도형 이벤트 설정
	setClickSectionCountEvents(section_count_overlay);//기본도형 이벤트 설정
	//선택클러스터를 표시하거나 표시해제상태로
	function setClickSectionClusterState(show, select_index){
		if(select_section_clusters.length == 0)//클러스터가 존재하지 않으면
			return;// 클러스터의 표시 상태를 변경하지않고 종료
		for(var i = 0; i < select_section_clusters.length; i++){
			select_section_clusters[i].setOptions({fillOpacity:  0.00000001});//클릭 배경 색상 투명도
			select_section_clusters[i].setOptions({strokeOpacity: 0.0000001});
		}
		if(show){//선택도형을 표시하려면
			select_section_clusters[select_index].setOptions({fillOpacity:  0.2});//클릭 배경 색상 투명도
			select_section_clusters[select_index].setOptions({strokeOpacity: 1});
		}
	} 

	//***************** 클러스터(인근위치별)  ********************************
	
	//인접클러스터들의 거리 단위
	var width_step = 0.004;//클러스터 좌우 좌표 간격
	var height_step = 0.003;//클러스터 상하 좌표 간격
	
	//지도의 모든 영역(매물이 존재하는 전체영역)
	var all_bottom_location = 37.47496;//지도상 최 하단 좌표
	var all_top_location =  37.530523;//지도상 최 상단 좌표
	var all_left_location = 127.015380;// 지도의 최 좌단 좌표
	var all_right_location = 127.067503;//지도의 최 우단 좌표 

	//지도 전체영역 클러스터의 위치중 현재 보여지는 클러스터의 범위, 인접클러스터의 매물수 배열 전체중에서의 인덱스 범위
	var current_location_index_max_i = -1;
	var current_location_index_min_i = -1;
	var current_location_index_max_j = -1;
	var current_location_index_min_j = -1;

	//단위별로 끊은 지도영역 좌표(현재 보이는 영역)
	var result_bottom_location;
	var result_top_location;
	var result_left_location;
	var result_right_location;

	//현재 보이는 영역에서 범위
	var s = new Array();
	var w = new Array();
	var n = new Array();
	var e = new Array();
	
	//인근 위치별 매물 수를 얻는다.
	function getLocationAreas(){
		//지도영역 좌표 설정(현재 보이는 영역)
		var bounds = map.getBounds();  // 지도의 현재 영역을 얻어옵니다.
	    var swLatLng = bounds.getSouthWest(); // 영역의 남서쪽 좌표를 얻어옵니다.
	    var neLatLng = bounds.getNorthEast();  // 영역의 북동쪽 좌표를 얻어옵니다.
		var bottom_location = swLatLng.getLat();//클러스터들의이 표시되는 지도상의 최 하단 좌표
		var top_location =  neLatLng.getLat();//클러스터들의이 표시되는 지도상의 최 상단 좌표
		var left_location = swLatLng.getLng();//클러스터들의이 표시되는 지도상의 최 좌단 좌표
		var right_location = neLatLng.getLng();//클러스터들의이 표시되는 지도상의 최 우단 좌표  
	
		//현재 보여지는 좌표가 속하는 인덱스 초기화
		current_location_index_min_i = - 1;
		current_location_index_min_j = - 1;
		current_location_index_max_i = - 1;
		current_location_index_max_j = - 1;
		
		//전체 영역중 현재 보여지는 좌표가 속하는 인덱스와 좌표값을 설정
		for(var i = 0, height = all_bottom_location; height < all_top_location; height += height_step, i++){//지도좌표 아래 에서 위 범위까지
			if(height < bottom_location || top_location < height)
				continue;
			if(current_location_index_min_i == -1){
				current_location_index_min_i = i;
				result_bottom_location = height;
			}
			current_location_index_max_i = i;
			result_top_location = height;
			for(var j = 0, width = all_left_location; width < all_right_location; width += width_step, j++){//지도좌표 죄측 에서 우측 범위까지
				if(width < left_location || right_location < width)
					continue;
				if(current_location_index_min_j == -1){
					current_location_index_min_j = j;
					result_left_location = width;
				}
				current_location_index_max_j = j;
				result_right_location = width;
			}
		}
		
		//보이는 범위에서 바로인접한 영역까지 포함(인접영역이 보이는/보이지않는영역으로 쪼개질때 모두포함)
		result_bottom_location -=height_step;
		result_top_location +=height_step;
		result_right_location +=width_step;
		result_left_location -=width_step;
		//전체 지도범위를 벗어날경우 범위를 조정
		if(result_bottom_location < all_bottom_location)
			result_bottom_location = all_bottom_location;
		if(result_left_location < all_left_location)
			result_left_location = all_left_location;
		if(all_right_location < result_right_location)
			result_right_location = all_right_location;
		if(all_top_location < result_top_location)
			result_top_location = all_top_location;
		
		//보여지는 지도영역을 정해진 단위별로 나누어서 저장
		var locationAreas = new Array();//인근 위치별 표시되는 클러스터들
		for(var i = 0, height = result_bottom_location; height < result_top_location; height += height_step, i++){//지도좌표 아래 에서 위 범위까지
			locationAreas[i] = new Array();
			for(var j = 0, width = result_left_location; width < result_right_location; width += width_step, j++){//지도좌표 죄측 에서 우측 범위까지	
				//보여지는 지도영역에서 클러스터의 각 범위를 설정해준다.
				locationAreas[i][j] = {
				  path : [//각범위설정
				       new daum.maps.LatLng(height, width),
				       new daum.maps.LatLng(height, width + width_step),
				       new daum.maps.LatLng(height + height_step, width + width_step),
				       new daum.maps.LatLng(height + height_step, width)
				  ]
				};
			}
		}
		return locationAreas;
	}
	//인접 위치별 매물수를 초기화 한다.
	var location_counts = new Array();
	function initLocationCount(){
		location_counts = new Array();
		for(var i = 0, height = all_bottom_location - height_step; height < all_top_location + height_step; height += height_step, i++){//모든 지도좌표 아래 에서 위 범위까지
			location_counts[i] = new Array();
			for(var j = 0, width = all_left_location - width_step; width < all_right_location + width_step; width += width_step, j++){//지도좌표 죄측 에서 우측 범위까지
				location_counts[i][j] = -1;
			}
		}
	}
	//인접위치별 매물수를 설정한다(수가 설정되지 않은 영역만 가져옴)
	function setAllLocationCount(locationAreas){
		//매물수가 존재하지않는경우(한번도 매물수를 가져오지 않은 경우에만) 
		if(location_counts.length == 0)
			initLocationCount();
		var search = new Array();//해당 좌표를 db로부터 검색할지의 여부
		s = new Array();
		w = new Array();
		n = new Array();
		e = new Array();
		for(var i = 0; i < locationAreas.length; i++){
			s[i] = new Array();
			w[i] = new Array();
			n[i] = new Array();
			e[i] = new Array();
			search[i] = new Array();
			for(var j = 0; j < locationAreas[i].length; j++){
				if(location_counts[current_location_index_min_i + i][current_location_index_min_j + j] != -1)//매물수를 찾아온적인 없는 영역이면
					search[i][j] = false;
				else
					search[i][j] = true;
				s[i][j] = locationAreas[i][j].path[0].ib;//아래
				w[i][j] = locationAreas[i][j].path[0].hb;//좌측
				n[i][j] = locationAreas[i][j].path[2].ib;//위
				e[i][j] = locationAreas[i][j].path[2].hb;//우측
			}
		}
		var searchCountUrl = "/api/search/all_geo_count?"
				+ "s=" +JSON.stringify(s) + "&w=" +JSON.stringify(w)
					+ "&n=" +JSON.stringify(n) + "&e=" +JSON.stringify(e)
						+ "&search=" +JSON.stringify(search);
		var url = searchCountUrl + filterUrl;
		//관심매물을 서버에 저장
		 $.ajax({
				type : "GET",
				url : url,
		        contentType: 'application/json; charset=utf-8',
		        async: false,
				success : function(data) {
					for(var i = 0; i < data.geo_counts.length; i++){
						for(var j = 0; j < data.geo_counts[i].length; j++){
							if(location_counts[current_location_index_min_i + i][current_location_index_min_j + j] == -1)//매물수를 찾아온적인 없는 영역이면
								location_counts[current_location_index_min_i + i][current_location_index_min_j + j] = data.geo_counts[i][j];
						}
					}
				},
				error : function(xhr, status, error) {
				}
		 });
		return location_counts;
	} 
	
	//클러스터 인근위치별 생성 
	var location_count_overlay =  new Array();//인근위치별 매물수 오버레이
	var basic_location_clusters = new Array();//인근 위치별 도형클러스터
	function createBasicLocationClusters(areas){
		//현재 보여지는 지도영역의 범위를 가져옴
		var locationAreas = getLocationAreas();
		//현재 보여지는 지도영역의 범위별로 개수를 가져옴(서버로부터, 이미 존재하는 매물수는 찾지 않는다.)
		setAllLocationCount(locationAreas);
	
		//보여지는 지도범위내에 인접 위치별로 개수를 묶는 클러스터 그리기
		for(var i = 0, height = result_bottom_location; height < result_top_location; height += height_step, i++){//지도좌표 아래 에서 위 범위까지
			location_count_overlay[i] = new Array();
			basic_location_clusters[i] = new Array();
			for(var j = 0, width = result_left_location; width < result_right_location; width += width_step, j++){//지도좌표 죄측 에서 우측 범위까지	
				var position = getCenterOfPoints(locationAreas[i][j].path);
				var circle = new daum.maps.Circle({
	    		    center : position, // 원의 중심좌표 입니다 
	    		    radius: 50, // 100m반경의 원
	    		    strokeWeight: 3, // 선의 두께
	    		    strokeColor: '#226622', // 선의 색깔
	    		    strokeOpacity: 0.000001, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명
	    		    fillColor: '#45ECCB', // 채우기 색깔
	    		    fillOpacity: 0.7  // 채우기 불투명도
	    		}); 
	    		// 지도에 원 그리기
	    		//if(0 < location_counts[current_location_index_min_i + i][current_location_index_min_j + j])
		    		circle.setMap(map); 
	    		basic_location_clusters[i][j] = circle;
	    		// 지도에 섹션 검색 개수 그리기 
	    		var content = document.createElement('div');
	    		// 지도에 섹션 검색 개수 그리기 
	    		var content = document.createElement('div');
				var html ="";
				html += "<div align=\"center\">";
				html += 	  "<font color=\"#ffffff\" size="+3+">" + location_counts[current_location_index_min_i + i][current_location_index_min_j + j] + "</font>";
				html += "</div>";
				content.innerHTML = html;
	    		//if(0 < location_counts[current_location_index_min_i + i][current_location_index_min_j + j])
	    		//	content.innerHTML = location_counts[current_location_index_min_i + i][current_location_index_min_j + j];
	    		var customOverlay = new daum.maps.CustomOverlay({
	    		    map: map,
	    		    position: position,
	    		    content: content   
	    		})
	    		location_count_overlay[i][j] = customOverlay;
			}
		}
	}
	//인근위치별 묶은 클러스터를 보이지 않게한다.
	function removeLocationCluster(){
		//인근위치별 클러스터 도형 삭제
		for(var i = 0; i < basic_location_clusters.length; i++)
			for(var j = 0; j < basic_location_clusters[i].length; j++)
				basic_location_clusters[i][j].setMap(null);
		for(var i = 0; i < location_count_overlay.length; i++){
			for(var j = 0; j < location_count_overlay[i].length; j++)
				location_count_overlay[i][j].setMap(null); 
		}
		//인근위치별 클러스터 값 초기화
		basic_location_clusters = new Array();
		location_count_overlay = new Array();
		//선택된 인근위치별 클러스터 인덱스 초기화
		click_location_cluster_index_i = -1;
		click_location_cluster_index_j = -1;
	}
	//인근위치별 클러스터 이벤트 설정
	var	click_location_cluster_index_i = -1;
	var	click_location_cluster_index_j = -1;
	function setClickLocationClusterEvents(clusters){
		for(var i = 0; i < clusters.length; i++){
			for(var j = 0; j < clusters[i].length; j++){//모든 인접 클러스터의 수만큼
				clusters[i][j].index_i = i;
				clusters[i][j].index_j = j;
				daum.maps.event.addListener(clusters[i][j], 'click', 
						function (mouseEvent){mapEventHandler('clickLocationClusterEvent', this.index_i, this.index_j);});//모든 도형 클릭이벤트
			}
		}
	}
	//인근위치별 클러스터 클릭 이벤트 
	function clickLocationClusterEvent(index_i, index_j){
		var now_event_num = event_click_num++;
		(function(index_i, index_j) {  
			setTimeout(function(){
				if(event_click_num -1 != now_event_num)//최근 발생한 이벤트가아니면 실행안함
					return;	
				if(click_location_cluster_index_i == index_i &&
						click_location_cluster_index_j == index_j){//위치별 클러스터 이미 선택되어있으면 취소
					if(map.getLevel() <= 4){//100m  
						setClickLocationClusterState(false, index_i, index_j);//클릭 클러스터의 색지우기
						//선택된 섹션으로 재검색
						if(click_polygon_index.length != 0){//선택된 섹션이 있으면
							searchSection(click_polygon_index[0]);//인접클러스터를 검색하기전 섹션검색을  다시 처리
						} else{
							//전체 검색(검색 초기 상태로)
							beforeSearchUrl = searchUrl;
							searchUrl = "/api/search/geo?s="+37.45049693760036 +"&w="+126.98951220288383 +"&n="+ 37.57353330485798+"&e="+ 127.13511634995348;
							posChangeSubmit(1);//검색
							expressMap("allLocation", "");
						}
					}
				} else{
					//클릭안된 상태에서 클릭 
					if(map.getLevel() <= 4){//100m 
						//클릭 상태 로 설정
						setClickLocationClusterState(true, index_i, index_j);//클릭 클러스터의 클릭 색상 적용
						//선택 클러스터 검색
						beforeSearchUrl = searchUrl;
						searchUrl = "/api/search/geo?s="+s[index_i][index_j] +"&w="+ w[index_i][index_j] +"&n="+ n[index_i][index_j]+"&e="+ e[index_i][index_j];//해당 위치별 클러스터 영역(선택한)으로 검색
						posChangeSubmit(1);//검색
						expressMap("location", "");
					}
				}
			}, 200);
		 }(index_i, index_j));
	}

	//인근 위치별로 묶음 클러스터의 매물숫자표현들 이벤트 설정
	function setClickLocationCountEvents(location_count_overlay){
		for(var i = 0; i < location_count_overlay.length; i++){
			for(var j = 0; j < location_count_overlay[i].length; j++){
				location_count_overlay[i][j].getContent().index_i = i;
				location_count_overlay[i][j].getContent().index_j = j;
				location_count_overlay[i][j].getContent().addEventListener('click',
						function (mouseEvent){mapEventHandler('clickLocationCountEvent', this.index_i, this.index_j);});//모든 도형 클릭이벤트
			}
		}
	}
	//인근 위치별로 묶음 클러스터의 매물숫자표현의 클릭 이벤트 
	function clickLocationCountEvent(index_i, index_j){
		var now_event_num = event_click_num++;
		(function(index_i, index_j) {  
			setTimeout(function(){
				if(event_click_num -1 != now_event_num)//최근 발생한 이벤트가아니면 실행안함
					return;	
				if(click_location_cluster_index_i == index_i &&
						click_location_cluster_index_j == index_j){//위치별 클러스터 이미 선택되어있으면 취소
					if(map.getLevel() <= 4){//100m  
						setClickLocationClusterState(false, index_i, index_j);//클릭 클러스터의 색지우기
						//선택된 섹션으로 재검색
						if(click_polygon_index.length != 0){//선택된 섹션이 있으면
							searchSection(click_polygon_index[0]);//인접클러스터를 검색하기전 섹션검색을  다시 처리
						} else{
							//전체 검색(검색 초기 상태로)
							beforeSearchUrl = searchUrl;
							searchUrl = "/api/search/geo?s="+37.45049693760036 +"&w="+126.98951220288383 +"&n="+ 37.57353330485798+"&e="+ 127.13511634995348;
							posChangeSubmit(1);//검색
							expressMap("allLocation", "");
						}
					}
				}  else{
					//클릭안된 상태에서 클릭 
					if(map.getLevel() <= 4){//100m 
						//클릭 상태 로 설정
						setClickLocationClusterState(true,  index_i, index_j);//클릭 클러스터의 색변화
						//선택 클러스터 검색
						beforeSearchUrl = searchUrl;
						searchUrl = "/api/search/geo?s="+s[index_i][index_j] +"&w="+ w[index_i][index_j] +"&n="+ n[index_i][index_j]+"&e="+ e[index_i][index_j];//해당 위치별 클러스터 영역(선택한)으로 검색
						posChangeSubmit(1);//검색
						expressMap("location", "");
					}
				}
			}, 200);
		 }(index_i, index_j));
	}
	//선택클러스터를 표시하거나 표시해제상태로
	function setClickLocationClusterState(show, select_index_i, select_index_j){
		if(basic_location_clusters.length == 0)//클러스터가 존재하지 않으면
			return;// 클러스터의 표시 상태를 변경하지않고 종료
		if(click_location_cluster_index_i != -1){//클릭된 도형이 존재하면
			for(var i = 0; i < basic_location_clusters.length; i++){
				for(var  j = 0; j < basic_location_clusters[i].length; j++)
					basic_location_clusters[i][j].setOptions({strokeOpacity: 0.000001});
			}
			click_location_cluster_index_i = -1;
			click_location_cluster_index_j = -1;
		}
		if(show){//선택도형을 표시하려면
			basic_location_clusters[select_index_i][select_index_j].setOptions({strokeOpacity: 1});
			click_location_cluster_index_i = select_index_i;
			click_location_cluster_index_j = select_index_j;
		}
	} 
	//***************** 클러스터(인근위치별/섹터별 공통) 상태********************************	
	//클러스터의 보여지는 모습과 개수표현을 설정
	function reDrawMap(){
		removeSectionCluster();//인근 섹터별 클러스터 제거(도형만제거 인덱스는 보관)
		removeLocationCluster();//인근 위치별 클러스터 제거(도형만제거 인덱스는 보관)
		//지도 축적에 따라 클러스터표시를 생성(인덱스에 맞게 클릭된 상태의 도형 적용)
		if(5 <= map.getLevel()){//500m이상  
			//섹션끼리 클러스터를 묶음
			createBasicSectionClusters(areas);//섹션 클러스터 기본상태 생성
			createSelectSectionClusters(areas);//섹션 클러스터 선택상태일때 생성
			setClickSectionClusterEvents(basic_section_clusters);//기본 섹션 클러스터 이벤트 설정
			setClickSectionClusterEvents(select_section_clusters);//섹션 클러스터 설정
			setClickSectionCountEvents(section_count_overlay);//기본도형 숫자 이벤트 설정
		}
		else if(map.getLevel() <= 4){//100m  
			//인접한 매물별로 클러스터를 묶음
			createBasicLocationClusters(areas);//기본 인근위치 클러스터 설정
			setClickLocationClusterEvents(basic_location_clusters);//기본도형 이벤트 설정
			setClickLocationCountEvents(location_count_overlay);//기본도형 숫자 이벤트 설정
		}
		recreateStationImg();//지하철역 아이콘 다시그리기
	}
	//좌표들의 중간지점 위치를 가져옴 (섹션의 꼭지점으로 섹션개수를 표시할 중심 좌표를 찾는다.)
	function getCenterOfPoints(points){
		var lat,lng;
		var maxLat = -1;
		var maxLng = -1;
		var minLat = 999;
		var minLng = 999;
		for(var i = 0; i < points.length; i++){
			if(maxLng < points[i].hb)
				maxLng = points[i].hb;
			if(points[i].hb < minLng)
				minLng = points[i].hb;
			if(maxLat < points[i].ib)
				maxLat = points[i].ib;
			if(points[i].ib < minLat)
				minLat = points[i].ib;
		}
		lat = (maxLat + minLat)/2;
		lng = (maxLng + minLng)/2;
		return (new daum.maps.LatLng(lat, lng));
	}
</script>




