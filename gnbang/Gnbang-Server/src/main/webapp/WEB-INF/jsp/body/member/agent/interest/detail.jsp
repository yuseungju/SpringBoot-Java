<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
<!-- <body class="mypage sub"> -->
	<!--mypage 본문시작-->
	<div class="my_body cart">
		<div class="content_header my_header box folder_header">
			<div class="container">
				<div class="inner btn_wrap">
					<p class="desc" id ="folder_desc">${roomItemCartList.explain}</p>
					<p class="date">
						<span class="txt1" >폴더 생성일</span> <span class="txt2" id="create_date"></span>
						<br /> <span class="txt1" >최종 수정일</span> <span class="txt2" id="edit_date"></span>
					</p>
					<p class=" btn edit_cart_btn">
						<a href="#" title="폴더정보수정">정보수정</a>
					</p>
				</div>
			</div>
		</div>
		<div class="content_body">
			<h4 id ="folde_name">관심매물 - ${roomItemCartList.name}</h4>
			<div class="btn_wrap">
				<div class="all_check btn" onclick ="selectAllChk();">
					<input type="checkbox" id="checkAll"/><label for="checkAll"
						class="blind">모두선택</label>
				</div>
				<div class="btn" onclick="deleteSelectedInterestItems(); return false;">
					<a href="#">삭제</a>
				</div>
				<div class=" btn" onclick = "printSelectedInterests(); return false;">
					<a href="#" title="선택 관심매물내 매물 인쇄">인쇄</a>
				</div>
			</div>
			<div class="mm_list table_list">
				<div class="container">
					<div class="list_header">
						<p class="count" id = "search_count">관심매물 : 총 0개</p>
						<!--div class="sort opened" 소트목록 오픈된상태-->
						<div class="sort">
							<a href="#sort_list" class="sort_title" id="sort_title"
								onclick="sortBtnStateChange()">방정렬</a>
							<!--.sort_title 클릭되면 #sort_list 토클-->
							<div id="sort_list" class="dropdown">
								<ul class="drop_item">
									<li><a href="#"
										onclick="sortSearch('date_desc'); return false;"><span>최신등록순</span></a>
									</li>
									<li><a href="#"
										onclick="sortSearch('main_address, sub_address'); return false;"><span>번지수
												오름차순</span></a></li>
									<li><a href="#"
										onclick="sortSearch('stand_doposit_desc'); return false;"><span>기준가
												높은 순</span></a></li>
									<li><a href="#"
										onclick="sortSearch('stand_doposit_asc'); return false;"><span>기준가
												낮은 순</span></a></li>
									<li><a href="#"
										onclick="sortSearch('monthly_rent_desc'); return false;"><span>월세
												높은 순</span></a></li>
									<li><a href="#"
										onclick="sortSearch('monthly_rent_asc'); return false;"><span>월세
												낮은 순</span></a></li>
									<li><a href="#"
										onclick="sortSearch('deposit_desc'); return false;"><span>보증금
												높은 순</span></a></li>
									<li><a href="#"
										onclick="sortSearch('deposit_asc'); return false;"><span>보증금
												낮은 순</span></a></li>
									<li><a href="#"
										onclick="sortSearch('exclusive_area_desc'); return false;"><span>전용면적
												높은 순</span></a></li>
									<li><a href="#"
										onclick="sortSearch('exclusive_area_asc'); return false;"><span>전용면적
												낮은 순</span></a></li>
								</ul>
							</div>
							<!--sort_item마감-->
						</div>
						<!--sort마감-->
					</div>
					<table class="fixed board_table">
						<tbody id="cart_list">
						</tbody>
					</table>
				</div>
				<!--container마감-->
				<div class="page_wrap">
					<p class="paging">
						<a href="#" class="bor">&lt;<span class="blind">이전</span></a> <a
							href="#" class="current">1</a> <a href="#">2</a> <a href="#">3</a>
						<a href="#">4</a> <a href="#">5</a> <a href="#" class="bor"><span
							class="blind">다음</span>&gt;</a>
					</p>
				</div>
				<!--page_wrap마감 -->
			</div>
			<!--table_list--마감-->
			<div class="m_search_footer">
				<div class="btn col">
					<button class="m_sort">
						<span>정렬</span>
					</button>
				</div>
	
			</div>
		</div>
	</div>
	<!--my_body마감-->
	
	<!--------------------------------------------------------------------------->
	<!--정보클릭되면 body에 modal_opened클래스추가 modal.cart_modal 클래스에 show클래스 추가 -->
	<!--정보 닫기 버튼 클릭되면 body에 modal_opened클래스제거  modal클래스에 show클래스 제거 -->
	<!--------------------------------------------------------------------------->
	<div class="modal cart_modal">
		<div class="modal_table">
			<div class="modal_cell">
				<!--폴더정보수정폼시작-->
				<div class="modal_container cart_form" id="cart_form">
					<div class="modal_title_wrap">
						<div class="modal_title">폴더 정보 수정</div>
						<div class="modal_close close_btn">
							<a href="#content_wrap" title="폴더 정보수정 닫기"><span class="blind">폴더
									정보수정 닫기</span></a>
						</div>
					</div>
					<div class="modal_content_wrap">
						<div class="modal_content">
							<div class="form-control">
								<div class="text">
									<div class="row">
										<div class="inner first">
											<label for="customer">폴더명 :</label>
											<div class="input">
												<span> <input type="text" id="customer" value="${roomItemCartList.name}">
												</span>
												<p class="warning_txt">ex) 고객 폴더 사용시: 홍길동01012341234 / 날짜
													폴더 사용시:2017.01.08</p>
											</div>
										</div>
										<div class="inner">
											<label for="customer_desc">상세 설명: </label>
											<div class="input">
												<span> <input type="text" id="customer_desc" value="${roomItemCartList.explain}">
												</span>
											</div>
										</div>
									</div>
									<div class="submit btn">
										<div class="button">
											<span><button onclick ="modifyCartUser(); return false;" class="btn_submit">정보
													수정</button></span>
										</div>
									</div>
								</div>
								<!--text마감마감-->
								<!--row cust_make마감-->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--폴더생성모달종료-->
	<div class="overlay"></div>
	<div class="popup_wrap">
		<div class="popup_sort_list  popup" id="popup_sort_list">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">정렬</div>
					<div class="popup_close close_btn">
						<a href="#content_wrap" title="정렬 닫기"><span class="blind">정렬
								닫기</span></a>
					</div>
				</div>
				<!--popup_title_wrap마감-->
				<div class="popup_content_wrap">
					<div class="popup_content">
						<div class="row">
							<ul class="sort_item">
								<li class="t_border"><a href="#"
									onclick="sortSearch('date_desc'); return false;"><span>최신등록순</span></a>
								</li>
								<!--선택된 정렬방법에 on 추가-->
								<li class="on"><a href="#"
									onclick="sortSearch('main_address, sub_address'); return false;"><span>번지수
											오름차순</span></a></li>
								<li><a href="#"
									onclick="sortSearch('stand_doposit_desc'); return false;"><span>기준가
											높은 순</span></a></li>
								<li><a href="#"
									onclick="sortSearch('stand_doposit_asc'); return false;"><span>기준가
											낮은 순</span></a></li>
								<li><a href="#"
									onclick="sortSearch('monthly_rent_desc'); return false;"><span>월세
											높은 순</span></a></li>
								<li><a href="#"
									onclick="sortSearch('monthly_rent_asc'); return false;"><span>월세
											낮은 순</span></a></li>
								<li><a href="#"
									onclick="sortSearch('deposit_desc'); return false;"><span>보증금
											높은 순</span></a></li>
								<li><a href="#"
									onclick="sortSearch('deposit_asc'); return false;"><span>보증금
											낮은 순</span></a></li>
								<li><a href="#"
									onclick="sortSearch('exclusive_area_desc'); return false;"><span>전용면적
											높은 순</span></a></li>
								<li><a href="#"
									onclick="sortSearch('exclusive_area_asc'); return false;"><span>전용면적
											낮은 순</span></a></li>
							</ul>
						</div>
						<div class="row">
							<div class="button">
								<div class="btn close close_btn">
									<button>
										<span>취소</span>
									</button>
								</div>
								<div class="btn submit">
									<button>
										<span>정렬</span>
									</button>
								</div>
							</div>
						</div>
					</div>
					<!--popup_conntent마감-->
				</div>
				<!--popup_content_wrap마감-->
			</div>
			<!--container마감-->
		</div>
		<!--popup_room_write_agency마감-->
	</div>

<!-- 관심 매물내용가져오기 -->
<script>
	var interests;
	$(document).ready(function() {
		interests = getInterestInfro(value="${roomItemCartList.no}");
		setCartInfor(interests); 
	});
	//관심고객 폴더정보를 가져옴
	function getInterestInfro(no){
		var interest; 
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : "/api/room/agent/interest_detail?roomItemCartListNo="+ no/* +"&pg=" + pg */,
			async : false,//반드시 동기화 
			success : function(data) {//msg를 받는 것이 성공하면
				interest = data;
			},
			error : function(xhr, status, error) {
			}
		});
		return interest;
	}
	//관심고객 폴더 정보를 셋팅함
	function setCartInfor(data){
		//한고객의 관심매물이 존재하지않으면 종료
		if(data.interestCartUser.length < 1)
			return;
		
		//기본 화면 고객폴더 정보설정
		$("#create_date").text(data.interestCartUser[0].date);
		$("#edit_date").text(data.interestCartUser[0].date);
		$("#search_count").text("관심매물 : 총 "+data.allSearchCount+"개");
		
		//고객폴더에 존재하는 관심매물 정보
		$("#cart_list").empty();
		var str ="";
		var cart;
	 	for(var i = 0;  i< data.interestCartUser.length; i++){
			cart = data.interestCartUser[i];
			
 			var address='';
 			address+= cart.si+" ";// 시
 			address+= cart.gungu+" ";// 군 또는 구
 			address+= cart.dong+" ";// 동
 			if(cart.main_address != 0)
 				address+= cart.main_address;// 번지 처음
 			if(cart.sub_address != 0)
 				address+= "-" + cart.sub_address;// 번지 마지막
 			address+= " " + cart.last_address+" ";// 기타주소
		
			//거래 종류 설정
			var type ='';
		    if(0 != ((cart.type*1)&1)) 
		    	type +='매매,';
		    if((0 != ((cart.type*1)&2))   &&(0 != ((cart.type*1)&4)))
		    	type +='전월세,';
		    if(0 != ((cart.type*1)&2))
		    	type +='전세,';
		    if(0 != ((cart.type*1)&4))
		    	type +='월세,';
		    if(0 != ((cart.type*1)&8))
			    type +='단기임대,';
		    //방위치 설정
		    var kind;
			if(cart.rooftop == 1)
				kind = '옥탑방' ;
			else if (cart.semi_basement == 1)
				kind = '반지하' ;
			else if (cart.floor_no < 0)
				kind = '지하' ;
			else if (cart.floor_no > 0)
				kind = "지상("+cart.floor_no + "층 /" +cart.all_floor+"층)";

			//건물형태 설정
 			var buildingType="";
 			if(cart.apartment == 1)
 				buildingType = "아파트";
 			else if(cart.officetel == 1)
 				buildingType = "오피스텔";
 			else if(cart.house == 1)
 				buildingType = "주택";
 			else if(cart.normal_room == 1)
 				buildingType = "원룸";
 			else if(cart.shop == 1)
 				buildingType = "상가";
 			else if(cart.office == 1)
 				buildingType = "사무실";
 			else if(cart.building == 1)
 				buildingType = "건물";
 			else if(cart.event == 1)
 				buildingType = "이벤트";
 			else if(cart.land == 1)
 				buildingType = "땅";
 			else if(cart.full_option_room == 1)
 				buildingType = "플옵션";
 			
 			 //전세/월세/임대에 따라 거래가 설정
			//1매매/2전세/4월세/6전월세/8단기임대
		    var charter_deposit =  commaMoney(cart.charter_deposit);// 전세가
		    var sale_price = commaMoney(cart.sale_price);//매매가
			var deposit= commaMoney(cart.deposit);// 보증금
			var monthly_rent= commaMoney(cart.monthly_rent);//월세
			var maintenance_cost = cart.maintenance_cost/10000;
			maintenance_cost= commaMoney(maintenance_cost);//관리비
			var deposit_modify= commaMoney(cart.deposit_modify);//보증금협의가능
			var trade_price ='';
			if((cart.type&1) != 0){//매매이면
				//매매가표시
				trade_price =  sale_price ;
			}
			if((cart.type&2) != 0  && (cart.type&4) != 0){//전월세 이면
				//전세,보증금,월세,관리비 표시
				trade_price = charter_deposit +"/";
				trade_price += (deposit);
				if(deposit_modify == 1)
					trade_price += "(협의가능)";
				trade_price += ("/" + monthly_rent);
				trade_price += ("/" + maintenance_cost);
			}
			else if((cart.type&2) != 0){//전세이면(전월세에 포함)
				//전세가/관리비 표시
				trade_price = charter_deposit + "/" + maintenance_cost;
			}
			else if((cart.type&4) != 0){//월세이면(전월세에 포함)
				//보증금/월세/관리비 표시
				trade_price =  deposit + "/" +  monthly_rent + "/" + maintenance_cost;
				if(deposit_modify == 1)
					trade_price += "(보증급 협의가능)";
			}else if((cart.type&8) != 0){//단기임대이면(전월세, 월세에 포함)
				//보증금/월세 /관리비 표시
				trade_price = deposit +"/"+
				+  monthly_rent + "/" + maintenance_cost;
				if(deposit_modify == 1)
					trade_price += "(보증급 협의가능)";
			}
			
			//입주일 
			var move ="";
			if(cart.move_now == 1)
				move ="즉시";
			else if(cart.move_modify == 1)
				move ="조정가능";
			else
				move = cart.move_day;				

			//면적
			var leased_area = cart.leased_area + "m<sup>2</sup>";
			var exclusive_area = cart.exclusive_area + "m<sup>2</sup>";
			str+="<tr> ";
			str+="<td class=\"col_chk\"><input type=\"checkbox\"  class =\"select_delete\" value =\""+ i +"\" /></td>";
			str+="<td class=\"col_pic\" >";
			str+="		<div class=\"image_list\">";
			str+="			<div class=\"media_photo media_cover\">";
			str+="				<div class=\"media_cover\">";
			str+="						<img src=\"http://112.175.245.57" + cart.main_fake_url + "\" alt=\"2003번 방사진\"";
			str+="						class=\"img_responsive_height\" />";
			str+="				</div>";
			str+="			</div>";
			str+="		</div>";
			str+="</td>";
			str+="<td class=\"col_desc  m_no_col\">";
			str+="<a href=\"#\" onClick=\"detailShow("+cart.no+"); return false;\">";
			str+="		<div class=\"row\">";
			str+="			<p class=\"col_wide fl\">";
			str+="				<span class=\"addr\">" + address + "</span>";
			str+="			</p>";
			str+="		<p class=\"col_sm fl\">";
			str+="				<span class=\"tit\">구분</span> <span>" + type + "</span>";
			str+="			</p>";
			str+="			<p class=\"col_sm  fl\">";
			str+="				<span class=\"tit\">매물종류</span> <span>" + buildingType + "</span>";
			str+="			</p>";
			str+="			<p class=\"col_sm  fl\">";
			str+="				<span class=\"tit\">보/월/관</span> <span>" + trade_price + "</span>";
			str+="			</p>";
			str+="		</div>";
			str+="		<div class=\"row\">";
			str+="			<p class=\"col_sm  fl\">";
			str+="					<span class=\"tit\">층</span> <span>" + kind + "</span>";
			str+="			</p>";
			str+="			<p class=\"col_sm fl\">";
			str+="				<span class=\"tit\">면적</span> <span> "+leased_area+ "/"+ exclusive_area +"</span>";
			str+="			</p>";
			str+="			<p class=\"col_sm  fl\">";
			str+="				<span class=\"tit\">입주시기</span> <span>" + move + "</span>";
			str+="			</p>";
			str+="		</div>";
			str+="		<div class=\"row\">";
			str+="			<p class=\"col_sm  fl\">";
			str+="				<span class=\"tit\">매물번호</span> <span>"+cart.no+"</span>";
			str+="			</p>";
			str+="		</div>";
			str+="</a>";
			str+="</td>";
			str+="</tr>";
		} 
		$("#cart_list").append(str);
	}
	//금액을 천단위로 찍긴
	function commaMoney(str){
		var result_str = "";
		str +="";
		var first_index;
		for(var current_index = str.length; 0 < current_index; current_index-=3){
			if(current_index -3 < 0)
				first_index = 0;
			else
				first_index = current_index -3;
			result_str = str.substring(first_index, current_index) + result_str;
			if(first_index != 0)
				result_str = "," + result_str;
		}
		return result_str;
	}
	//방 상세보기로 팝업열기
	function detailShow(no){
		window.open("/room/"+no, "");
	}
	//선택한 관심고객폴더들을 삭제
	function deleteSelectedInterestItems(){
		if (confirm('선택한 폴더를 삭제하시겠습니까?')) {
			var select_delete_targets = document.getElementsByClassName("select_delete");
			for (i = 0; i < select_delete_targets.length; i++) {
				if(select_delete_targets[i].checked)
					deleteInterestItem(interests.interestCartUser[i].room_item_cart_no);
			} 
		} 
	}
	//고객폴더 번호에 맞는 고객폴더 삭제
	function deleteInterestItem(no){
		$.ajax({
		 	type : "DELETE",
	        url: "/api/room/agent/interest?no="+no,
	        async: false,
	        success: function(result) {
	        	window.location.reload(true);
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	        	alert('다시 시도해주세요.');
	        }
	    });
	}
 	//선택한 관심고객내 관심매물들을 인쇄페이지로 열어줌 
	function printSelectedInterests(){
	 	var win = window.open(); 
		self.focus(); 
		win.document.open();
		win.document.write('<html><head><title></title><style>');
		win.document.write('</style></haed><body>');
		var str = "";
		str += "<span style=\"font-weight:bold\">"+ "관심매물 목록" +"</span></br></br>";
		var select_delete_targets = document.getElementsByClassName("select_delete");
		for (i = 0; i < select_delete_targets.length; i++) {//선택만 고객폴더 만큼
			if(select_delete_targets[i].checked){
				var interest =  interests.interestCartUser[i];
				//주소설정
				var address='';
	 			address+= interest.si+" ";// 시
	 			address+= interest.gungu+" ";// 군 또는 구
	 			address+= interest.dong+" ";// 동
	 			if(interest.main_address != 0)
	 				address+= interest.main_address;// 번지 처음
	 			if(interest.sub_address != 0)
	 				address+= "-" + interest.sub_address;// 번지 마지막
	 			address+= " " + interest.last_address+" ";// 기타주소

				//거래 종류 설정
				var type ='';
			    if(0 != ((interest.type*1)&1)) 
			    	type +='매매,';
			    if((0 != ((interest.type*1)&2))   &&(0 != ((interest.type*1)&4)))
			    	type +='전월세,';
			    if(0 != ((interest.type*1)&2))
			    	type +='전세,';
			    if(0 != ((interest.type*1)&4))
			    	type +='월세,';
			    if(0 != ((interest.type*1)&8))
				    type +='단기임대,';
			    //방위치 설정
			    var kind;
				if(interest.rooftop == 1)
					kind = '옥탑방' ;
				else if (interest.semi_basement == 1)
					kind = '반지하' ;
				else if (interest.floor_no < 0)
					kind = '지하' ;
				else if (interest.floor_no > 0)
					kind = "지상("+interest.floor_no + "층 /" +interest.all_floor+"층)";

				//건물형태 설정
	 			var buildingType="";
	 			if(interest.apartment == 1)
	 				buildingType = "아파트";
	 			else if(interest.officetel == 1)
	 				buildingType = "오피스텔";
	 			else if(interest.house == 1)
	 				buildingType = "주택";
	 			else if(interest.normal_room == 1)
	 				buildingType = "원룸";
	 			else if(interest.shop == 1)
	 				buildingType = "상가";
	 			else if(interest.office == 1)
	 				buildingType = "사무실";
	 			else if(interest.building == 1)
	 				buildingType = "건물";
	 			else if(interest.event == 1)
	 				buildingType = "이벤트";
	 			else if(interest.land == 1)
	 				buildingType = "땅";
	 			else if(interest.full_option_room == 1)
	 				buildingType = "플옵션";
	 			
	 			 //전세/월세/임대에 따라 거래가 설정
				//1매매/2전세/4월세/6전월세/8단기임대
			    var charter_deposit =  commaMoney(interest.charter_deposit);// 전세가
			    var sale_price = commaMoney(interest.sale_price);//매매가
				var deposit= commaMoney(interest.deposit);// 보증금
				var monthly_rent= commaMoney(interest.monthly_rent);//월세
				var maintenance_cost = interest.maintenance_cost/10000;
				maintenance_cost= commaMoney(maintenance_cost);//관리비
				var deposit_modify= commaMoney(interest.deposit_modify);//보증금협의가능
				var trade_price ='';
				if((interest.type&1) != 0){//매매이면
					//매매가표시
					trade_price =  sale_price ;
				}
				if((interest.type&2) != 0  && (interest.type&4) != 0){//전월세 이면
					//전세,보증금,월세,관리비 표시
					trade_price = charter_deposit +"/";
					trade_price += (deposit);
					if(deposit_modify == 1)
						trade_price += "(협의가능)";
					trade_price += ("/" + monthly_rent);
					trade_price += ("/" + maintenance_cost);
				}
				else if((interest.type&2) != 0){//전세이면(전월세에 포함)
					//전세가/관리비 표시
					trade_price = charter_deposit + "/" + maintenance_cost;
				}
				else if((interest.type&4) != 0){//월세이면(전월세에 포함)
					//보증금/월세/관리비 표시
					trade_price =  deposit + "/" +  monthly_rent + "/" + maintenance_cost;
					if(deposit_modify == 1)
						trade_price += "(보증급 협의가능)";
				}else if((interest.type&8) != 0){//단기임대이면(전월세, 월세에 포함)
					//보증금/월세 /관리비 표시
					trade_price = deposit +"/"+
					+  monthly_rent + "/" + maintenance_cost;
					if(deposit_modify == 1)
						trade_price += "(보증급 협의가능)";
				}
				
				//입주일 
				var move ="";
				if(interest.move_now == 1)
					move ="즉시";
				else if(interest.move_modify == 1)
					move ="조정가능";
				else
					move = interest.move_day;				

				//면적
				var leased_area = interest.leased_area + "m<sup>2</sup>";
				var exclusive_area = interest.exclusive_area + "m<sup>2</sup>";
			
				//메인 사진
				var main_img = "<img src=\"http://112.175.245.57" + interest.main_fake_url + "\" alt=\" 방사진\"";

				str+="매물번호:" +  interest.no + "</br>";

				str += "<table border ='1'>";
				str+="<tr>";
				str+="  <td colspan='3'>" + "주소 : " + address +"</td>";
				str+="</tr>";
				
				str+="<tr>";
				str+="  <td>구분: " + type +"</td>";
				str+="  <td>매물종류: " + buildingType +"</td>";
				str+="  <td>보/월/관: " + trade_price +"</td>";
				str+="</tr>";

				str+="<tr>";
				str+="  <td>층: " + kind +"</td>";
				str+="  <td>면적: " + leased_area+ "/"+ exclusive_area +"</td>";
				str+="  <td>입주시기: " + move +"</td>";
				str+="</tr>";
				str+="</table>";
				str+='</br>';
			}
		} 
		if(str.length == 0)
			str ='선택한 관심매물이 없습니다.';
		win.document.write(str);
 		win.document.write('</body></html>');
		win.document.close();
		win.print();
		win.close(); 
	}		 
</script>

<!-- 고객폴더수정 -->
<script>
	function modifyCartUser(){
		var cartUserData = {};
		cartUserData["no"] = "${roomItemCartList.no}";
		cartUserData["name"] =	$("#customer").val();
		cartUserData["explain"] =	$("#customer_desc").val();
		cartUserData["customer"] =	$("#customer").val();$("#customer_desc").val();
		$.ajax({
			type: 'PUT',
			url : "/api/room/agent/interest/client",
			contentType :"application/json; charset=utf-8",
			data: JSON.stringify(cartUserData), 
			async : false,
			success: function(){
	        	window.location.reload(true);
			},
			error: function(){
				alert('수정에 실패했습니다. 다시 시도해주세요');
			}
		});
	} 
</script>

<!-- 컴포넌트 상태변화 -->
<script>
	var all_check = false;
	function selectAllChk(){
		var select_delete_targets = document.getElementsByClassName("select_delete");
		if(all_check){//모두 체크된상태이면 전부 상태 해제
			for (i = 0; i < select_delete_targets.length; i++) 
				select_delete_targets[i].checked = false;
			all_check = false;
		}else {//모두 체크가 아닌 상태이면 모두 체크 상태로 
			for (i = 0; i < select_delete_targets.length; i++) 
				select_delete_targets[i].checked = true;
				all_check = true;
		}
	}
</script>




