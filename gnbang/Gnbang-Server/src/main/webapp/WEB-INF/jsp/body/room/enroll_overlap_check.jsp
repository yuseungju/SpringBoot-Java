<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
	
<!-- <body class="room sub agent"> -->
	<!--content_wrap-->
	<div id="content_wrap" class="clearfix">
		     <div class="content">
				<div class="page">
					<div class="page_header">
						<h2>
							<span>방등록</span>
						</h2>
					</div>
					<!--page_header마감-->
					<div class="content_header room_header">
						<div class="container">
							<div class="inner">
								<div class="pic">
									<p>
										<img  id="profile" src="${pageContext.request.contextPath}/images/common/account50_mint.png" alt="중개사" />
									</p>
									<p class="name">최은정님</p>
									<p class="desc">
										<strong class="txt1">100개</strong> 방 등록
									</p>
								</div>
								<div class="guide">
									<ul>
										<li><strong>정책.</strong></li>
										<li>정책</li>
										<li>정책.</li>
		
									</ul>
								</div>
							</div>
		
						</div>
					</div>
					<!--room_header마감-->
					<div class="panel">
						<!--content_body-->
						<div class="content_body bg shadow rwa">
							<h3 class="blind">방등록 1-주소중복확인</h3>
							<div class="step_section section">
								<ul class="step_wrap">
									<li class="step current "><span class="icon step1 "></span><span
										class="txt"><span class="list_num">1</span>주소중복확인</span></li>
									<li class="step "><span class="icon step3 "></span><span
										class="txt"><span class="list_num">2</span>정보입력</span></li>
									<li class="step "><span class="icon step4 "></span><span
										class="txt"><span class="list_num">3</span>방등록완료</span></li>
								</ul>
							</div>
							<div class="guide_section section m_hidden">
								<p>- 주소 중복 확인을 위해 주소를 입력해주세요</p>
								<p>- 이미 등록된 주소는 중복 등록 되지 않습니다.</p>
							</div>
							<div class="container section room_check">
								<!--주소-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">주소</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="text col_mid fl">
													<input type="text" id="first_address" disabled >
												</div>
												<div class="button col3 fr">
													<button type="button" id="search_address" onclick ="findeAddress()">주소검색</button>
												</div>
											</div>
										</div>
		
									</div>
								</div>
								<!--번지-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">번지</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="text">
					                                 <input type="text" id="second_address" disabled >
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--나머지주소-->
								<div class="row">
									<div class="col tbl last_address">
										<div class="form_label tc">
											<div class="pad">상세주소</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="text col2 fl last_input1">
													<input type="text" id="last_dong"><span class="txt" >동</span>
												</div>
												<div class="text col2 fl last_input2">
													<input type="text" id="last_ho"><span class="txt">호</span>
												</div>
												<div class="guide col2  mid_col1 tc2">
													<span>"동"이 없을 경우에는 "호"만 입력하세요</span>
												</div>
											</div>
		
										</div>
									</div>
								</div>
							</div>
						<!--container마감-->
						</div>
						<!--content_body마감-->
						<div id="btn_view">
		            		<div class="row btn_wrap mt" id="checkAddress">
		                         <div class="button">
		                             <div class="btn submit wide_btn">
		                                 <button onclick ="getSameAddress(); return false;">
		                                     <span>주소중복확인</span>
		                                 </button>
		                             </div>
		                         </div>
		               		</div>   
	               		</div>
					</div><!--panel마감-->
				</div><!--page마감-->
			</div><!--content마감-->
	</div><!--content_wrap마감-->
<script>
	$(document).ready(function(){
		 setProfilePhoto('profile');//프로필 사진 설정
		 //브라우저에서 뒤로가기를 했을경우 데이터 초기화필요
		 $("#last_dong").val('');
		 $("#last_ho").val('');
		 $("#first_address").val('');
		 $("#second_address").val('');
	});
</script>	
<!-- 전송 주소 데이터 -->
<script>
	var postInformation = {};//주소 데이터를 저장
	//모든 주소정보를 서버로 전송
	function toEnrollPage(){
		//url설정
		sub_url = 
		   "?last_address="+encodeURI(encodeURIComponent(postInformation.last_address))+"&" 
		 +  "main_address="+postInformation.main_address+"&" 
		 +  "sub_address="+postInformation.sub_address+"&" 
		 +  "lat="+postInformation.lat+"&" 
		 +  "lng="+postInformation.lng+"&" 
		 +  "si="+encodeURI(encodeURIComponent(postInformation.si))+"&" 
		 +  "gungu="+encodeURI(encodeURIComponent(postInformation.gungu))+"&" 
		 +  "dong="+encodeURI(encodeURIComponent(postInformation.dong))+"&" 
		 +  "roadAddress="+encodeURI(encodeURIComponent(postInformation.roadAddress));
		//방등록 입력폼으로 이동
		document.location.href ="/room/enroll/write"+sub_url;
	}
	//주소데이터 입력확인
	function checkInput(){
		if($("#first_address").val() =='' || $("#second_address").val() ==''){
			alert('주소를 선택해주세요');
			return false;
		}
		if($("#last_ho").val() ==''){
			alert("'호'를 입력해주세요");
			return false;
		}
		if (!(/^[0-9]+$/).test($("#last_ho").val())){
			alert("'동'과 '호'에는 숫자만 입력 가능합니다.");
			return false;
		}
		return true;
	}
</script>
<!-- 중복여부를 확인후 적절한 뷰를 보여줌-->
<script>
	function getSameAddress(){setNextImpossible();
        //입력사항 확인
		if(!checkInput())
			return false;
		//마지막주소설정
		var last_address ='';
		if($("#last_dong").val() != "")
			last_address +=  ($("#last_dong").val() +"동 ");
		last_address +=  ($("#last_ho").val() +"호");
        postInformation["last_address"] = last_address;
        //주소중복 확인
		jQuery.ajax({
			type : "GET",
			url : "/api/room/enroll/address",
	        async: false,
	        data: postInformation,
			success : function(result) {//########결과값을 boolean값으로 바꾸고 , 풀주소 요소에셋팅
				if(result.sameAddress.length == 0)
					setNextPossible();
				else
					setNextImpossible();
			},
			error : function(xhr, status, error) {
			}
		});
	}
	function setInputAddress(){
		$("#btn_view").empty();
		var str = '';
		str+="	<div class=\"row btn_wrap mt\" id=\"checkAddress\">								 	 ";
		str+="		<div class=\"button\">															 ";
		str+="			<div class=\"btn submit wide_btn\">											 ";
		str+="				 <button onclick =\"getSameAddress(); return false;\">					 ";
		str+="					 <span>주소중복확인</span>												 ";
		str+="				 </button>																 ";
		str+="			</div>																		 ";
		str+="		</div>																			 ";
		str+="	</div>																			 	 ";
		$("#btn_view").append(str);
		document.getElementById('last_dong').disabled = false;//상세주소 입력 할수있게 다시설정
		document.getElementById('last_ho').disabled = false;//상세주소 입력 할수있게 다시설정
		document.getElementById('search_address').disabled = false;//주소검색버튼 누를수 있게 다시설정
	}
	function setNextPossible(){
		//주소 선택뷰에서 일부 다른 뷰로 , focus를 옮김
		$("#btn_view").empty();
		var str = '';
		str+="	<div class=\"check_result r_ok section table_list\">						 ";
		str+="		<table class=\"fixed board_table\">										 ";
		str+="			<thead>																 ";
		str+="				<tr>															 ";
		str+="					<th class=\"col_addr\" title=\"주소\">주소</th>				 ";
		str+="					<th class=\"col_res\" title=\"상태\">상태</th>					 ";
		str+="				</tr>															 ";
		str+="			</thead>															 ";
		str+="			<tbody>																 ";
		str+="				<tr>															 ";
		str+="					<td class=\"col_addr\">" + postInformation.si 
				+ " " + postInformation.gungu + " " + postInformation.dong 
				+ " " + postInformation.main_address + "-" + postInformation.sub_address 
				+" " + postInformation.last_address +
						 "  	</td>														 ";
		str+="					<td class=\"col_res\">등록가능</td>							 ";
		str+="																				 ";
		str+="				</tr>															 ";
		str+="			</tbody>															 ";
		str+="		</table>																 ";
		str+="		<div class=\"guide_section section\">									 ";
		str+="			<p>- 등록가능한 주소입니다.</p>												 ";
		str+="			<p>- 방등록을 하시려면 다음 버튼을 클릭해 주세요.</p>				 				 ";
		str+="		</div>																	 ";
		str+="	</div>																		 ";
		str+="	<div class=\"row btn_wrap mt\">												 ";
		str+="		<div class=\"button\">													 ";
		str+="			<div class=\"btn close close_btn\">									 ";
		str+="				<button onclick=\"setInputAddress()\">							 ";
		str+="					<span>이전</span>											 	 ";
		str+="				</button>														 ";
		str+="			</div>																 ";
		str+="			<div class=\"btn submit\">											 ";
		str+="				<button onclick=\"toEnrollPage()\" type=\"submit\">				 ";
		str+="					<span>다음</span>											 	 ";
		str+="				</button>														 ";
		str+="			</div>																 ";
		str+="		</div>																	 ";
		str+="	</div>																		 ";
		$("#btn_view").append(str);
		document.getElementById('last_dong').disabled = true;//상세주소 입력 못하게 막기
		document.getElementById('last_ho').disabled = true;//상세주소 입력 못하게 막기
		document.getElementById('search_address').disabled = true;//주소검색버튼 못하게 막기
	}
	function setNextImpossible(){
		//유사주소가 있을경우 출력
		$("#btn_view").empty();
		var str = '';
		str+="	<div class=\"check_result r_reject section table_list\">								  ";
		str+="		<table class=\"fixed board_table\">													  ";
		str+="			<thead>																			  ";
		str+="				<tr>																		  ";
		str+="					<th class=\"col_addr\" title=\"주소\">주소</th>							  ";
		str+="					<th class=\"col_mm_num\" title=\"매물번호\">매물번호</th>				          ";
		str+="					<th class=\"col_res\" title=\"상태\">상태</th>							 	  ";
		str+="				</tr>																		  ";
		str+="			</thead>																		  ";
		str+="			<tbody>																			  ";
		str+="				<tr>																		  ";
		str+="					<td class=\"col_addr\">" + postInformation.si 
		+ " " + postInformation.gungu + " " + postInformation.dong 
		+ " " + postInformation.main_address + "-" + postInformation.sub_address 
		+ " " + postInformation.last_address +
				 "  	</td>														 ";
		str+="					<td class=\"col_mm_num\" title=\"매물번호\">매물번호					  		  ";
		str+="					</th>																	  ";
		str+="					<td class=\"col_res\">등록불가능(주소중복)</td>							      ";
		str+="																							  ";
		str+="				</tr>																		  ";
		str+="			</tbody>																		  ";
		str+="		</table>																			  ";
		str+="		<div class=\"guide_section section\">												  ";
		str+="			<p>- 회원님이 등록하시려는 방은 이미 등록 된 방입니다.</p>										  ";
		str+="			<p>- 매물로 등록하기 위한 더 자세한 사항을 강남방에 문의 주시기 바랍니다.</p>	  						  ";
		str+="			<p class=\"strong\">															  ";
		str+="				강남방 <span class=\"tel\">02-568-2453</span>								 	  ";
		str+="			</p>																			  ";
		str+="		</div>																				  ";
		str+="	</div>																					  ";
		str+="	<div class=\"row btn_wrap mt\">															  ";
		str+="		<div class=\"button\">																  ";
		str+="			<div class=\"btn close close_btn\">												  ";
		str+="				<button onclick =\"setInputAddress()\" >																	  ";
		str+="					<span>새주소 확인</span>												  	  ";
		str+="				</button>																	  ";
		str+="			</div>																			  ";
		str+="			<div class=\"btn submit\">														  ";
		str+="				<button onclick =\"toHome(); return false;\">																	  ";
		str+="					<span>홈으로 가기</span>												  	  ";
		str+="				</button>																	  ";
		str+="			</div>																			  ";
		str+="		</div>																				  ";
		str+="	</div>																					  ";
		$("#btn_view").append(str);
	}
	//홈으로 가기
	function toHome(){
		document.location.href = "/room/enroll/agent/";
	}
	
</script>

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
	            postInformation["roadAddress"] = data.roadAddress;
	            
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


<!-- 프로필사진 -->
<script>
	//프로필 사진 경로가져오기
	function setProfilePhoto(contain_id){
		var path ='';
		$.ajax({
			url:"/api/member/photo",
			type: "GET", 
	        async: false,
	        success: function (data) {
	        	path = data;
	        },
	        error:function(request,status,error){
	        }
		});
		if(10 < path.length);//프로필사진이 있으면 (존재하는 url의 길이는 최소 10을 넘는다.)
			$('#' + contain_id).attr('src' , "http://112.175.245.57" + path);
		
	}
</script>