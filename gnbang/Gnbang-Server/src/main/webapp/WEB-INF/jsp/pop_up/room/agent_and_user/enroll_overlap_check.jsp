<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>	

<!-- 주소찾기 팝업 설정 -->
<div class="modal post" id="post">
	<div class="modal_table">
		<div class="modal_cell">
			<div class="modal_container">
				<div class="modal_title_wrap">
					<div class="modal_title">주소검색</div>
					<div class="modal_close close_btn">
						<a href="#layer" title="로그인 닫기" id="btnCloseLayer"><span
							class="blind">로그인닫기</span></a>
					</div>
				</div>
				<div id="layer" style="-webkit-overflow-scrolling: touch;"></div>
				
			</div>
		</div>
	</div>
</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=<%=GlobalValue.mapApi%>&libraries=services"></script>
<script src="js/h5utils.js"></script>
<script>
	// 우편번호 찾기 화면을 넣을 element
	var element_layer = document.getElementById('layer');
	var geocoder = new daum.maps.services.Geocoder();//지도 좌표를 가져오기위함
	//우편번호 닫기
	function closeDaumPostcode() {
	     // iframe을 넣은 element를 안보이게 한다.
	     element_layer.style.display = 'none';
	     body.removeClass('modal_opened');
	     post.removeClass('show');
	}
	// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
	// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
	// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
	/* function initLayerPosition(){
		$(document).width();
	    var width = 500; //우편번호서비스가 들어갈 element의 width
	    var height = 600; //우편번호서비스가 들어갈 element의 height
	    var borderWidth = 5; //샘플에서 사용하는 border의 두께
	
	    // 위에서 선언한 값들을 실제 element에 넣는다.
	    element_layer.style.width = width + 'px';
	    element_layer.style.height = height + 'px';
	    element_layer.style.border = borderWidth + 'px solid';
	    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	    element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	    element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
	} */
</script>



<!-- 주소데이터 추출 및 설정   -->
<script>
	var body =$('body');
	var post =$('#post');
    var last_address_building_name='';//상세주소에서 건물이름에 해당
	function findeAddress(){   
		body.addClass('modal_opened');
   		post.addClass('show');
		new daum.Postcode({
	        oncomplete: function(data) {
                body.removeClass('modal_opened');
                post.removeClass('show');
	            //시/군구/동의 내용 보관
	        	var si;
	        	var gungu;
	        	var dong;
	            element_layer.style.display = 'none';
	                si = data.sido;
	                gungu = data.sigungu;
	            if(data.hname.length != 0)//행정동이 존재할경우 행정동설정(행정동: 동+숫자)
	            	dong = data.hname;
	            else if(data.bname1.length == 0)
	            	dong = data.bname2;
	            else 
	            	dong = data.bname1 + " "+ data.bname2 ;
	            
	            postInformation["si"] = si;
	            postInformation["gungu"] = gungu;
	            postInformation["dong"] = dong;
	            postInformation["new_address"] = data.roadAddress;
	            last_address_building_name = data.buildingName;
	            	
	            //번지수포함하는 주소설정
	            var jibun ='';
	            if(data.jibunAddress.length == 0)
	            	jibun = data.autoJibunAddress;
	            else
	            	jibun = data.jibunAddress;
	            jibun = setSubAndMain(jibun);

				//위도와 경도 데이터 보관
	            geocoder.addr2coord(data.address, function(status, result) {
                    if (status === daum.maps.services.Status.OK) {
        	            postInformation["lat"] = result.addr[0].lat;
        	            postInformation["lng"] = result.addr[0].lng;
        	          /*   setMetro(result.addr[0].lat, result.addr[0].lng); */
                    }
                });
				
				//입력폼에서의 주소 셋팅 
	            var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R')  // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;
                else  // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== '')
                        extraAddr += data.bname;
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== '')
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
                document.getElementById('first_address').value = fullAddr;// 주소 정보를 해당 필드에 넣는다.
                document.getElementById('second_address').value = jibun;// 주소 정보를 해당 필드에 넣는다.
                document.getElementById('address3').focus();//상세주소 필드로 이동한다.
	        },
	        width : '100%',
	        height : '100%'
	    }).embed(element_layer);
	
	    // iframe을 넣은 element를 보이게 한다.
	    element_layer.style.display = 'block';
	    // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	    //initLayerPosition();
	}
	//번지수를 분리 추출하여 설정
	function setSubAndMain(src_address){
		//번지수의 마지막 데이터 를 추출
		var sub_address = src_address.substr(src_address.lastIndexOf('-')+1);
		if(isNaN(parseInt(sub_address))){//subaddress가 존재하면(subaddress 추출시 - 문자 이후 숫자)
			sub_address ="0";
		}
        postInformation["sub_address"] = sub_address;//번지수 마지막 데이터 설정
        //번지수 앞을 추출
        var main_address =  src_address.replace("-"+ sub_address,"");
		main_address = main_address.substring(main_address.lastIndexOf(' ') +1);
        postInformation["main_address"] = main_address;//번지수 앞 설정
        return main_address +"-" + sub_address;
	}
	<%-- //인근 지하철역 정보 설정
	function setMetro(lat , lng){
		var code =  "SW8";
		var  information = '' ;
		var tempData= [];
		jQuery
		.ajax({
			type : "GET",
			dataType : "json",
			url : "https://apis.daum.net/local/v1/search/category.json?apikey=<%=GlobalValue.mapApi%>&location="
					+lat+","+lng+"&radius=500&code="+code+"&sort=2" + "&count=10" ,
			async : false,
			dataType : "jsonp",
			success : function(data) {//msg를 받는 것이 성공하면
				//중복되는 역과 호선 제거  ex)강남역1호선, 강남역 2호선  -->  강남역
				var current;
				var before;
				for(var i=0; i < data.channel.item.length; i++){
					current = (data.channel.item[i].title).substring(0, (data.channel.item[i].title).lastIndexOf(' '));
					if(i == 0){
						tempData.push(current);
						before = current;
					}else {
						if(before != current){
							tempData.push(current);
							before = current;
						}
					}
				}
				//정리된 지하철역 이름만 저장
				for(var i =0; i < tempData.length; i++)
					 postInformation["metro"+i] = tempData[i];
			},
			error : function(xhr, status, error) {
			}
		});
	}  --%>

	
</script>   
			