<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
	<sec:authorize access="hasRole('ROLE_AGENT')">
		<div class="agent_cart" id="agent_cart">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">관심매물담기</div>
					<div class="popup_close close_btn" >
						<a href="#content_wrap" title="관심매물닫기"><span class="blind">관심매물닫기</span></a>
					</div>
				</div>
				<!--popup_title_wrap마감-->
				<div class="popup_content_wrap">
					<div class="popup_content">
						<div class="ac_body">
							<div class="row cust_make">
								<div class="ac_label">
									<p class="tit">새로운 고객생성</p>
								</div>
								<div class="text">
									<div class="row">
										<div class="inner">
											<label for="customer">폴더명 :</label>
											<div class="input">
												<span> <input type="text" id="customer"
													placeholder="고객명전화번호를입력해주세요" />
												</span>
												<p class="desc">ex) 고객 폴더 사용시: 홍길동01012341234  /  날짜 폴더 사용시:2017.01.08</p>
											</div>
										</div>
										<div class="inner">
											<label for="customer_desc">상세 설명: </label>
											<div class="input">
												<span> <input type="text" id="customer_desc"
													placeholder="설명을입력해주세요" />
												</span>
											</div>
										</div>
									</div>
	
									<div class="btn">
										<p>
											<button onclick ="createUser()">
												<span>폴더생성</span>
											</button>
										</p>
									</div>
								</div>
								<!--text마감마감-->
							</div>
							<!--row cust_make마감-->
	
							<div class="row cust_list">
								<div class="inner">
									<div class="ac_label">
										<p class="tit">고객선택</p>
									</div>
									<div class="check_list">
										<ul class="row " id ="cart_item_list">
										</ul>
										<div class="btn" id="btn_addItem">
											<p>
												<button onclick ="addSelectItem()">
													<span>선택매물담기</span>
												</button>
											</p>
										</div>
										<<div class="btn" id="btn_addItem">
											<p>
												<button onclick ="print_interest()">
													<span>인쇄출력</span>
												</button>
											</p>
										</div> 
										<!--btn마감-->
									</div>
									<!--check_list마감-->
								</div>
							</div>
							<!--row cust_list마감-->
						</div>
						<!--ac_body마감-->
					</div>
					<!--popup_conntent마감-->
				</div>
				<!--popup_content_wrap마감-->
			</div>
			<!--container마감-->
		</div>
	</sec:authorize>
 
<!-- 관심매물담기 (폴더담기) -->
<script>
//***************************** 주기능 : 매물담기*******************
	$(document).ready(function(){
		 setAutoUserWord("customer");//자동완성설정
		 getCartUser();//중개사의 고객
	});
	//중개사의 고객생성
	var client_no =-1;
	function createUser(){
		//고객생성정보 값 설정
		var data = {};
		data["explain"] = $("#customer_desc").val();
		data["name"] = $("#customer").val();
		data["client_no"] = client_no;
		
		if($("#customer_desc").val() == '' || $("#customer").val() ==''){
			alert('정보를 보두 입력	해주세요.');
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
				}
				else
					alert('이미 등록된 연락처와 이름입니다.');
					
			},
			error : function(xhr, status, error) {
			}
		});
	}
	//한 중개사의 고객 정보들을 서버로부터 get
	function getCartUser(){
		//한 중개사의 고객리스트를 가져옴
		 $.ajax({
			 	type : "GET",
				dataType : "json",
		        url: "/api/room/agent/interest/client",
		        async: false,
		        success: function(result) {
		        	//한 중개사의 고객리스트를 모두가져와 고객리스트로 뷰에 셋팅
		        	setCartUser(result);
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        }
		    });
	  //  $("#comment_input").load(window.location.href+" #comment_input");
	}
	function setCartUser(data){
	 	//고객들의 정보를 뷰에 셋팅
		var str='';
		var  infor;
		
		str='';
		//한 중개사의 모든 고객의 정보를 추가(관심 매물추가하는 팝업, 고객선택리스트)
		$("#cart_item_list").empty();
		
		for(var a = 0; a < data.cartUserList.length ; a++){
			infor = data.cartUserList[a];
			str+="	<li>";
			str+="	    <div>";
			str+="		    <label> <span> <input type=\"checkbox\"  value =\""+ infor.no +"\" name=\"checkCartUser\"/>";
			str+="		        </span> <span class=\"txt\"> "+ infor.name +" </span>";
			str+="          </label>";
			str+="      </div>";
			str+="  </li> ";
		} 
		$("#cart_item_list").append(str);
		
	}
	//관심매물추가 기능에서(고객을 선택한 이후) 관심매물을 추가해주는 기능
	function addSelectItem(){
		var request_num = 0;
		var response_num = 0;
		//매물 다중선택시 여러 매물의번호를 설정
		var room_no = [];
		var select_room_no;
		for(var i =0; i < $("input[name=interest_room_no]").length; i++){//선택한 매물수만큼
			var checkRoom = document.getElementsByName("interest_room_no");
			if(checkRoom[i].checked){
				select_room_no = $("input[name=interest_room_no]:eq(" + i + ")").val();
				//고객(=날짜폴더)을 다중으로 선택시 여러고객의 번호를 설정
				var cart_no = [];
				for(var j =0; j < $("input[name=checkCartUser]").length; j++){//선택한 고객들의 관심매물 추가
					var checkUser = document.getElementsByName("checkCartUser");
					if(checkUser[j].checked){
						request_num++;//요청수 증가
						cart_no.push($("input[name=checkCartUser]:eq(" + j + ")").val());
						//관심매물을 서버에 저장
						 $.ajax({
								type : "PUT",
						        url: "/api/room/"+ select_room_no +"/agent/interest",
						        contentType: 'application/json; charset=utf-8',
						        data: JSON.stringify(cart_no),
						        async: false,
								success : function(data) {
								},
								error : function(xhr, status, error) {
								}
						 });
					}
				}
			}
		}
		if (request_num == 0)
			alert('관심 매물과 폴더명을 선택해주세요.');
		else
			alert('등록되었습니다. 이미 등록한 고객의 경우는 등록되지 않습니다.');
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
								source : autoWord,/* 
							    appendTo : $("#cust_make"), */
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
	//****************************관심매물 내용 출력***************************
	function print_interest(){
		 $.ajax({
			 	type : "GET",
				dataType : "json",
		        url: "/api/room/agent/interest",
		        async: false,
		        success: function(result) {
			        var str ='';
			        str += " <table border ='1'>";
			        str += " <tr>";
				    str += " <p> 관심 매물 정보 page"+1+"</p>";
			        str += "<th>폴더명</th> <th>매물번호</th> <th>주소</th>  <th>설명</th> <th>등록일</th>";
			        str += " </tr>";

					for(var i = 0 ; i < result.interestCartUser.length; i++){
						//관심매물정보 설정
						var type ='';
				    	if(result.interestCartUser[i].semi_basement == 1)
				    		type ='반지하';
				    	else if(result.interestCartUser[i].floor_no == -1)
				    		type ='지하';
				    	else 
				    		type = result.interestCartUser[i].floor_no+'/'+result.interestCartUser[i].all_floor;
				    	var date = result.interestCartUser[i].date;
				    	var detail = result.interestCartUser[i].explain;
				    	var folder = result.interestCartUser[i].name;
				    	var no =  result.interestCartUser[i].room_item_no;
				    	var address='';
				    	address+= result.interestCartUser[i].si+" ";// 시
				    	address+= result.interestCartUser[i].gungu+" ";// 군 또는 구
				    	address+= result.interestCartUser[i].dong+" ";// 동
				    	if(result.interestCartUser[i].main_address != "")
				    		address+= result.interestCartUser[i].main_address+"-";// 번지 처음
					    if(result.interestCartUser[i].sub_address != "")
				    		address+= result.interestCartUser[i].sub_address+" <br>";// 번지 마지막
						if(result.interestCartUser[i].last_address != "")
				    		address+= result.interestCartUser[i].last_address+" ";// 기타주소
			 			
			 		   //관심매물정보 인쇄페이지에 적용
					   str += " <tr>";
					   str += " <td>"+ folder + "</td>";
					   str += " <td>"+ no + "</td>";
					   str += " <td>"+ address + "</td>";
					   str += " <td>"+ detail + "</td>";
					   str += " <td>"+ date + "</td>";
					   str += " </tr>";
					   if(0 < i && i % 15 == 0){
						    str += " </table>";
						    str += " <table border ='1'>";
						    str += " <p style=\"page-break-before: always;\"> 관심 매물 정보 page"+(i/15+1)+" </p>";
					        str += " <th>매물번호</th> <th>주소</th> <th>폴더명</th> <th>설명</th> <th>등록일</th>";
					   }
					}
					
				    str += " </table>";
				    win = window.open();
				    self.focus();
				    win.document.open();
				    win.document.write('<'+'html'+'><'+'head'+'><'+'style'+'>');
				    win.document.write('body, td { font-family: Verdana; font-size: 10pt;}');
				    win.document.write('<'+'/'+'style'+'><'+'/'+'head'+'><'+'body'+'>');
				    win.document.write(str);
				    win.document.write('<'+'/'+'body'+'><'+'/'+'html'+'>');
				    win.document.close();
				    win.print();
				    win.close();
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        }
		    });
	}
</script>	
	