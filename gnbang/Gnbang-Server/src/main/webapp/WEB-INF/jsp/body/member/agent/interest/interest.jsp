<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>

<!-- <body class="mypage sub"> -->	
	<div class="my_body cart">
		<div class="content_header my_header box">
			<div class="container">
				<div class="inner">
					<div class="guide">
						<ul>
							<li><strong>관심매물관리는 폴더에 담아둔 매물을 관리할 수 있는 페이지 입니다.</strong></li>
							<li>폴더명을 클릭하시면 해당 관심매물폴더에 담아 두신 매물을 관리 할 수 있습니다.</li>
							<li>[상세페이지],[방찾기] 화면에서 관심매물을 폴더에 담을 수 있습니다.</li>
							<li><strong>삭제</strong>: 선택하신 폴더를 삭제합니다.</li>
							<li><strong>인쇄</strong>: 선택하신 폴더 내 관심매물을 인쇄합니다.</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!--consult_header마감-->
	
		<div class="content_body ">
			<h4>관심매물폴더 목록</h4>
			<div class="btn_wrap">
				<div class="all_check btn">
					<input type="checkbox" id="checkAll" onclick ="selectAllChk();"/>
					<label for="checkAll" class="blind">모두선택</label>
				</div>
				<div class="btn" onclick="deleteSelectedFolders()">
					<a href="#" title="선택 관심매물 폴더 삭제">삭제</a>
				</div>
				<div class=" btn" onclick ="printSelectedFolders();">
					<a href="#" title="선택 관심매물내 매물 인쇄">인쇄</a>
				</div>
			</div>
			<div class="cart_list table_list">
				<div class="container">
					<div class="list_header">
						<div class="btn_wrap">
							<div class="btn add_cart_btn">
								<a href="#" title="폴더생성">+ 폴더생성</a>
							</div>
						</div>
					</div>
					<table class="fixed board_table">
						<thead>
							<tr class="m_hidden">
								<th class="col_chk">&nbsp;</th>
								<th class="cell2 " title="폴더명"><a
									href="mypage_agent_cart2.html">폴더명</a></th>
								<th class="cell3 " title="설명">매물설명</th>
								<th class="cell4 " title="매물수">매물수</th>
								<th class="cell5" title="작성일">작성일</th>
							</tr>
						</thead>
						<tbody id ="interest_folder">
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
		</div>
	</div>
	<!--my_body마감-->
	
	<div class="modal cart_modal">
		<div class="modal_table">
			<div class="modal_cell">
				<!--폴더생성폼시작-->
				<div class="modal_container cart_form" id="cart_form">
					<div class="modal_title_wrap">
						<div class="modal_title">폴더생성</div>
						<div class="modal_close close_btn">
							<a href="#content_wrap" title="폴더생성 닫기"><span class="blind">폴더생성
									닫기</span></a>
						</div>
					</div>
					<div class="modal_content_wrap" id="modal_content_wrap">
						<div class="modal_content">
							<div class="form-control">
								<div class="text">
									<div class="row">
										<div class="inner first">
											<label for="customer">폴더명 :</label>
											<div class="input">
												<span> <input type="text" id="customer"
													placeholder="폴더명을  입력해 주세요">
												</span>
												<p class="warning_txt">ex) 고객 폴더 사용시: 홍길동01012341234 / 날짜
													폴더 사용시:2017.01.08</p>
											</div>
										</div>
										<div class="inner">
											<label for="customer_desc">상세 설명: </label>
											<div class="input">
												<span> <input type="text" id="customer_desc"
													placeholder="설명을입력해주세요">
												</span>
											</div>
										</div>
									</div>
									<div class="submit btn">
										<div class="button">
											<span><button type="submit"  onclick ="createUser()" class="btn_submit">폴더생성</button></span>
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
	
<!-- 관심고객폴-->
<script>
	//관심고객폴더 가져오기
	var cartUserList = new Array();
	function setInterestFolder(){
		//관심고객폴더 폴더 정보를 가져와 설정 (room_item_cart)
		 var roomItemCartListNoList = new Array();
		 $.ajax({
			 	type : "GET",
				dataType : "json",
		        url: "/api/room/agent/interest/client",
		        async: false,
		        success: function(result) {
					for(var i = 0 ; i < result.cartUserList.length; i++){
						cartUserList[i] = 	result.cartUserList[i];
						roomItemCartListNoList[i]  = cartUserList[i].no;
					}
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        }
		    });
		
		 //관심고객폴더 폴더에 존재하는 매물수를 가져와 설정
		 $.ajax({
			 	type : "GET",
				dataType : "json",
		        url: "/api/room/agent/interest_counts?room_item_cart_list_no=" + JSON.stringify(roomItemCartListNoList),
		        async: false,
		        success: function(result) {
		        	//고객폴더 마다 등록매물 개수를 가져옴
					for(var i = 0 ; i < result.room_item_cart_counts.length; i++)
						 cartUserList[i].count = result.room_item_cart_counts[i];
					//고객폴더들의 리스트를 설정하여 보여줌
		        	for(var i = 0 ; i < cartUserList.length; i++){
						  var str ='';
				    		str +=" <tr>";
				    		str +="     <td class=\"col_chk\"><input type=\"checkbox\" / class =\"select_delete\" value =\""+ i +"\"></td>";
				    		str +="     <td class=\"cell2 m_no_col\"><a href=\"/member/agent/interest/detail?cart_list_no="+cartUserList[i].no+"\">"+cartUserList[i].name;+"</a></td>"; //폴더명
				    		str +="     <td class=\"cell3 m_no_col\">"+ cartUserList[i].explain +"</td>";//매물설명
				    		str +="     <td class=\"cell4 m_no_col\">"+ cartUserList[i].count +"</td>";//매물수
				    		str +="     <td class=\"cell5  m_no_col\">"+cartUserList[i].date+"</td>";//작성일
				    		str +=" </tr>";
				    		$("#interest_folder").append(str);
					}
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        }
		    });
	}
	setInterestFolder();

	//**********************************관심고객 추가 기능**************************************	
 	//중개사의 고객생성
	var client_no =-1;
	function createUser(){
		//고객생성정보 값 설정
		var data = {};
		data["explain"] = $("#customer_desc").val();
		data["name"] = $("#customer").val();
		data["client_no"] = client_no;
		
		if($("#customer_desc").val() == '' || $("#customer").val() ==''){
			alert('정보를 모두 입력해주세요.');
			return;
		}
		
		//설정된 고객정보값을 서버에 저장
		$.ajax({
			type :  'POST',
			dataType : "json",
			url : "/api/room/agent/interest/client" ,
			contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(data),
			async : false,
			success : function(data) {
				if(data){
					// 추가된 고객의 정보를 함께 가져와 뷰에 설정
					getCartUser();
					alert('등록되었습니다.');
		        	window.location.reload(true);
				}
				else
					alert('이미 등록된 연락처와 이름입니다.');
			},
			error : function(xhr, status, error) {
			}
		});
	}
	//고객명 자동완성 /기존고객여부확인
	function setAutoUserWord(id){
		$("#" + id).keyup(
				function(event) {
					client_no =-1;
					//값을 세팅
					currentWord = $("#" + id).val();
					if (!currentWord)//입력값이 없으면
						return;
					jQuery.ajax({
						type : "GET",
						dataType : "json",
						url : "/api/room/agent/interest/client_list?name=" + encodeURI(encodeURIComponent(currentWord)),
						async : false,
						success : function(data) {//msg를 받는 것이 성공하면
							autoWord = new Array();
							for (var i = 0; i < data.userList.length; i++)
								autoWord.unshift(data.userList[i].name + ""
										+ data.userList[i].phone);
							$("#" + id).autocomplete({
								source : autoWord, 
							    appendTo : $("#modal_content_wrap"), 
								select: function(event, ui) {
							        for (var i = 0; i < data.userList.length; i++){
							        	if(autoWord[data.userList.length - i -1] == ui.item.label){//선택한 단어와 가져왔던 자동완성이 일치하면
							        		//페이지 표시 초기화
							        		client_no = data.userList[i].no;
										    break;
							        	}
							        }
							        //autocomplete reset(prevent double clicked)
							        $("#customer").autocomplete({
										source : new Array()
									});
							    }
							});
						},
						error : function(xhr, status, error) {
						}
				});
		});
	}
	setAutoUserWord("customer");
//**********************************삭제***************************************
	//선택한 관심고객폴더들을 삭제
	function deleteSelectedFolders(){
		if (confirm('선택한 폴더를 삭제하시겠습니까?')) {
			var select_delete_targets = document.getElementsByClassName("select_delete");
			for (i = 0; i < select_delete_targets.length; i++) {
				if(select_delete_targets[i].checked)
					deleteFolder(cartUserList[i].no);
			} 
		} 
	}
	//고객폴더 번호에 맞는 고객폴더 삭제
	function deleteFolder(no){
		var data = {};
		data["no"] = no;//관심고객폴더의 번호를 설정
		data["user_no"] = -1;//어느 중개사에게도 고객폴더를 할당하지않도록 함
		$.ajax({
		 	type : "PUT",
	        url: "/api/room/agent/interest/client_agent_no",
	        async: false,
			contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(data),
	        success: function(result) {
	        	window.location.reload(true);
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	        	alert('다시 시도해주세요.');
	        }
	    });
	}
//**********************************인쇄***************************************
	//체크한 관심매물 폴더 정보들을 인쇄
	function printSelectedFolders(){
	 	var win = window.open(); 
		self.focus(); 
		win.document.open();
		win.document.write('<html><head><title></title><style>');
		win.document.write('</style></haed><body>');
		var str = "";
		var select_delete_targets = document.getElementsByClassName("select_delete");
		for (i = 0; i < select_delete_targets.length; i++) {//선택만 고객폴더 만큼
			if(select_delete_targets[i].checked){
				var client_no = cartUserList[select_delete_targets[i].value].no;//고객번호
				var client_name = cartUserList[select_delete_targets[i].value].name;//고객이름
				var carts = getCarts(client_no);//관심매물 리스트를 가져옴
				str += "<span style=\"font-weight:bold\">"+ client_name +"</span></br>";
				for(var j = 0; j < carts.interestCartUser.length; j++){//고객폴더에 있는 관심매물 수만큼
					var cart = carts.interestCartUser[j];
					
					//주소설정
					var address='';
		 			address+= cart.si+" ";// 시
		 			address+= cart.gungu+" ";// 군 또는 구
		 			address+= cart.dong+" ";// 동
			 		if(cart.sub_address != 0)
		 				address+= cart.main_address;// 번지 처음
			 		if(cart.sub_address != 0)
		 				address+= "-"+ cart.sub_address;// 번지 마지막
		 			if(cart.last_address != "")
		 				address+= " "+cart.last_address+" ";// 기타주소
				
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
				
					//메인 사진
					var main_img = "<img src=\"http://112.175.245.57" + cart.main_fake_url + "\" alt=\" 방사진\"";

					str+="매물번호:" +  cart.no + "</br>";

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
				str+='</br>';
				str+='</br>';
			}
		} 
		if(str.length == 0)
			str ='선택한 고객폴더가 없습니다.';
		win.document.write(str);
 		win.document.write('</body></html>');
		win.document.close();
		win.print();
		win.close(); 
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
	//관심고객 폴더 하나에 대한 상세 정보를 가져옴
	function getCarts(no){
		var carts;
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : "/api/room/agent/interest_detail?roomItemCartListNo="+ no/* +"&pg=" + pg */,
			async : false,//반드시 동기화
			success : function(data) {//msg를 받는 것이 성공하면
				carts = data;
			},
			error : function(xhr, status, error) {
			}
		});
		return carts;
	}
</script>

<!-- 컴포넌트 상태변화 -->
<script>
	//체크박스 전체선택 클릭
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
