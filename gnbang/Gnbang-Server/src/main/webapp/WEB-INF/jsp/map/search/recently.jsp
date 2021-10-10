<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>

	<div class="map_search">
		<div class="inner">
				<div class="location">
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


<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=<%=GlobalValue.mapApi%>&libraries=clusterer,services"></script>
<script>
	//*****************지도 생성 ********************************
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(37.5061, 127.063), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	    };
	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
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
	
	//*****************지도 이벤트 검색********************************	
	//마우스로 지도 이동을 완료시켰을 때  이벤트 
	daum.maps.event.addListener(map, 'dragend', function() {   
		if(!$("#moveSearch_chk").is(":checked")){//"지도 이동시 검색"  기능을 선택하지 않았으면
			return;
		}
		
	    var center = map.getCenter(); // 지도의 현재 중심좌표를 얻어옵니다.
	    var level = map.getLevel(); // 지도의 현재 레벨을 얻어옵니다.
	    var mapTypeId = map.getMapTypeId(); // 지도타입을 얻어옵니다.
	    var bounds = map.getBounds();  // 지도의 현재 영역을 얻어옵니다.
	    var swLatLng = bounds.getSouthWest(); // 영역의 남서쪽 좌표를 얻어옵니다.
	    var neLatLng = bounds.getNorthEast();  // 영역의 북동쪽 좌표를 얻어옵니다.
	
	    //지도좌표로  검색
		searchUrl ="/api/room/recently/geo?s="+swLatLng.getLat() + "&w="+  swLatLng.getLng() +"&n="+ neLatLng.getLat()+"&e="+ neLatLng.getLng();
		$("#search_type_name").text("이지역 최신방");//검색 종류  출력
		posChangeSubmit(1);
	});
	
	/* //*****************마커 표시 클러스터사용********************************	
    var clusterer = new daum.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 3// 클러스터 할 최소 지도 레벨 
    }); 
	var marker_address = [];//상세주소를 제외한 모든주소
	var marker_detail_address = [];//상세주소
	var markerLat = [];
	var markerLng = [];
	//검색된 방들의 모든 마커들을 지도에 보여줌
	function setMarkers(markerLat,markerLng,marker_address, marker_detail_address){
		//마커와 클러스터 지도표시 초기화
		markerList = new Array();
		infowindow = new Array();
	    clusterer.clear();
		for(var a =0; a< markerLat.length; a++)
			setMarker(markerLat[a], markerLng[a], a , marker_address[a] + marker_detail_address[a]);
	}
	// 마커가 지도 위에 표시되도록 설정
	var markerList = new Array();
	var infowindow = new Array();
	function setMarker(lat,lng,index,roomInfro){
	    markerList.push( new daum.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position : new daum.maps.LatLng(lat, lng)
	    }));
	    // 마커에 표시할 인포윈도우를 생성
	    infowindow.push(new daum.maps.InfoWindow({
	        content: roomInfro// 인포윈도우에 표시할 내용
	    }));
	     
	    // daum.maps.event.addListener(markerList[index], 'mouseover', makeOverListener(map, markerList[index], infowindow[index]));
	    //daum.maps.event.addListener(markerList[index], 'mouseout', makeOutListener(infowindow[index])); 
	 
	    // 클러스터러에 마커들을 추가
	    clusterer.addMarkers(markerList);
	} 
	//이미지 마우스 오버시 해당 정도 표시(지도포인트에 표시)
	$(document).on('mouseenter', '.media_photo.media_cover', function(){
		// showInforInMapPoint($(this).attr('value')); 
		showInforInMapPoint($(".media_photo.media_cover").index($(this)));
	});
	$(document).on('mouseleave', '.media_photo.media_cover', function(){
		closeInforInMapPoint($(".media_photo.media_cover").index($(this)));
	});
	//인포윈도우 마우스 이벤트
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}
	//인포윈도우 마우스 이벤트/ 인포윈도우를 닫는 클로저를 만드는 함수
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
	//인덱스에 해당하는 마커에 정보표시
	function showInforInMapPoint(index){
		 infowindow[index].open(map, markerList[index]);
	}
	//마커위의 정보표시 끄기
	function closeInforInMapPoint(index){
		 infowindow[index].close();
	} */
</script>