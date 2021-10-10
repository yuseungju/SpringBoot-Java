<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
									<p class="name"><sec:authentication property="principal.realname"/></p>
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
								
								<!--상세주소-->
		                        <div class="row" id = "last_address_view">
		                           <div class="col tbl last_address">
		                                 <div class="form_label tc"><div class="pad">상세주소</div></div>
		                                 <div class="form_group tc"><div class="pad">
		                                      <div class="text col3 last_input1 last_input">
		                                         <input type="text" id="last_address_dong"><span class="txt">동</span>
		                                      </div>
		                                      <div class="text col3 fl select last_input2 last_input">
		                                         <select id = "sel_floor">
		                                             <option>층선택</option>
		                                             <option>지하2</option>
		                                             <option>지하1</option>
		                                             <option>반지하</option>
		                                             <option>옥탑방</option>
													 <c:forEach var="floor_index" begin="1" end="40">
			                                              <option>${floor_index}층</option>
													 </c:forEach>
		                                         </select>
		                                      </div>
		                                      <div class="text check floor ">
		                                        <label > <input type="checkbox" id="last_address_all_floor" onclick="checkAllFloor()">층전체</label>
		                                      </div>
		                                      <div class="text  check building_w ">
		                                        <label > <input type="checkbox" id="last_address_all_building" onclick="checkAllBuilding()">건물전체</label>
		                                      </div>
		                                      <div class="text col3 last_input3 last_input">
		                                         <input type="text" id="last_address_ho"><span class="txt" >호</span>
		                                      </div>
		                                      <div class="guide  mid_col1 tc2">
		                                            <span>"동", "층"이 없을 경우에는 "호"만 입력하세요</span>
		                                        </div>
		                                   </div>
		                                   </div>
		                           </div>
		                        </div><!--상세주소마감-->
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
		 $("#last_address_dong").val('');
		 $("#last_address_ho").val('');
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
		 +  "new_address="+encodeURI(encodeURIComponent(postInformation.new_address));
		//방등록 입력폼으로 이동
		document.location.href ="/room/enroll/write"+sub_url;
	}
	//주소데이터 입력확인
	function checkInput(){
		//기본 주소 중복검사
		if($("#first_address").val() =='' || $("#second_address").val() ==''){
			alert('주소를 선택해주세요');
			return false;
		} 
		
       	if ($("#last_address_all_building").is(":checked")){//건물전체시
       		//동 층 호 에대해 아무 입력도 하지 않아야함
       	} else if ($("#last_address_all_floor").is(":checked")){//층전체시
    		if($("#sel_floor option:selected").text() == '층선택'){
    			alert('층을 선택해주세요');
    			return false;
    		}
    	} else{//특정방일경우(전체가 아닌경우)
    		if($("#last_address_ho").val() == ''){
    			alert("'호'를 입력해주세요");
    			return false;
    		}
    	}
		return true;
	}
</script>
<!-- 중복여부를 확인후 적절한 뷰를 보여줌-->
<script>
	function getSameAddress(){
        //입력사항 확인
		if(!checkInput())
			return
		//마지막주소설정
		var last_address ='';
	 	if ($("#last_address_all_building").is(":checked")){//건물전체시
    		//동
    		if($("#last_address_dong").val() != "")
    			last_address +=  ($("#last_address_dong").val() +"동 ");
    		last_address+= "전체 "
       	} else if ($("#last_address_all_floor").is(":checked")){//층전체시
    		//동
    		if($("#last_address_dong").val() != "")
    			last_address +=  ($("#last_address_dong").val() +"동 ");
    		//층
    		if($("#sel_floor option:selected").text() != "층선택")
    			last_address +=  ($("#sel_floor option:selected").text() + " ");
    		last_address+= "전체 "
       	} else{
    		//동
    		if($("#last_address_dong").val() != "")
    			last_address +=  ($("#last_address_dong").val() +"동 ");
    		//층
    		if($("#sel_floor option:selected").text() != "층선택")
    			last_address +=  ($("#sel_floor option:selected").text() + " ");
    		//호
    		if($("#last_address_ho").val() != "")
    			last_address +=  ($("#last_address_ho").val() +"호 ");
       	}
	 	
        postInformation["last_address"] = last_address_building_name + " "+ last_address;
        
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
					setNextImpossible(result.sameAddress);
			},
			error : function(xhr, status, error) {
			}
		});
	}
	function setInputAddress(){
		//상세주소 입력뷰 설정
		$("#last_address_view").empty();
		var str = '';
		str+="<div class=\"col tbl last_address\">";
		str+="      <div class=\"form_label tc\"><div class=\"pad\">상세주소</div></div>";
		str+="      <div class=\"form_group tc\"><div class=\"pad\">";
		str+="           <div class=\"text col3 last_input1 last_input\">";
		str+="              <input type=\"text\" id=\"last_address_dong\"><span class=\"txt\">동</span>";
		str+="           </div>";
		str+="           <div class=\"text col3 fl select last_input2 last_input\">";
		str+="              <select id = \"sel_floor\">";
		str+="                  <option>층선택</option>";
		str+="                  <option>지하2</option>";
		str+="                  <option>지하1</option>";
		str+="                  <option>반지하</option>";
		str+="                  <option>옥탑방</option>";
					   for(var floor_index = 1; floor_index <= 40; floor_index++)
		str+="                  <option>"+ floor_index +"층</option>";
		str+="              </select>";
		str+="           </div>";
		str+="  <div class=\"text check floor \">";
		str+="  <label > <input type=\"checkbox\" id=\"last_address_all_floor\" onclick=\"checkAllFloor()\">층전체</label>";
		str+="  </div>";
		str+=" <div class=\"text  check building_w \">";
		str+="    <label > <input type=\"checkbox\" id=\"last_address_all_building\" onclick=\"checkAllBuilding()\">건물전체</label>";
		str+="  </div>";
		str+="           <div class=\"text col3 last_input3 last_input\">";
		str+="              <input type=\"text\" id=\"last_address_ho\"><span class=\"txt\" >호</span>";
		str+="          </div>";
		str+="          <div class=\"guide  mid_col1 tc2\">";
		str+="                 <span>\"동\", \"층\"이 없을 경우에는 \"호\"만 입력하세요</span>";
		str+="             </div>";
		str+="        </div>";
		str+="        </div>";
		str+="</div>";
		$("#last_address_view").append(str);
		
		//주소중복확인 버튼 화면 설정
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
		document.getElementById("search_address").style.display='block';//주소검색버튼 누를수 있게 보여주기
	}
	function setNextPossible(){

		$("#last_address_view").empty();
		var str ='';
		str+="<div class=\"col tbl last_address\">";
		str+="<div class=\"form_label tc\"><div class=\"pad\">상세주소</div></div>";
		str+=" <div class=\"form_group tc\">";
		str+="	<div class=\"pad\">";
		str+="		<div class=\"text\">";
		str+="            <input type=\"text\" value =\""+postInformation.last_address+"\" disabled >";
		str+="		</div>";
		str+="	</div>";
		str+="</div>";
		str+="</div>";
		$("#last_address_view").append(str);
		
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
		document.getElementById("search_address").style.display='none';//주소검색버튼 못하게 숨기기
	}
	function setNextImpossible(same_address){
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
		for(var i=0; i< same_address.length; i++){
			str+="				<tr>																		  ";
			str+="					<td class=\"col_addr\">" + postInformation.si 
			+ " " + postInformation.gungu + " " + postInformation.dong 
			+ " " + postInformation.main_address + "-" + postInformation.sub_address 
			+ " " + same_address[i].last_address +
					 "  	</td>														 ";
			str+="					<td class=\"col_mm_num\" title=\"매물번호\">"+ same_address[i].no +"	      ";
			str+="					</th>																	  ";
			str+="					<td class=\"col_res\">등록불가능(주소중복)</td>							      ";
			str+="																							  ";
			str+="				</tr>																		  ";
		}
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
<script>
	//층 전체, 건물전체선택시 컴포넌트 상태변화
	function checkAllBuilding(){//전체건물 선택시
		if($("#last_address_all_building").is(":checked")){//체크상태인경우
			// 체크박스 상태변화
			$("#last_address_all_floor").prop("checked", false);
			//전체건물이므로  층, 호 정보를 지운다.
			$("#sel_floor option:eq(0)").prop("selected", true);
			$("#last_address_ho").val('');
			//층입력 불가, 호 입력불가
			document.getElementById('sel_floor').disabled = true;
			document.getElementById('last_address_ho').disabled = true;
		}else{//전체건물 선택 해제시
			//모두 활성화
			document.getElementById('sel_floor').disabled = false;
			document.getElementById('last_address_ho').disabled = false;
		}
	}
	function checkAllFloor(){//전체층 선택시
		if($("#last_address_all_floor").is(":checked")){//체크상태인경우
			// 체크박스 상태변화
			$("#last_address_all_building").prop("checked", false);
			//전체층이므로  동, 호 정보를 지운다.
			$("#last_address_ho").val('');
			//호 입력 불가, 층 입력가능
			document.getElementById('sel_floor').disabled = false;
			document.getElementById('last_address_ho').disabled = true;
		}else{//전체층 선택 해제시
			//모두 활성화
			document.getElementById('sel_floor').disabled = false;
			document.getElementById('last_address_ho').disabled = false;
		}
	}
</script>