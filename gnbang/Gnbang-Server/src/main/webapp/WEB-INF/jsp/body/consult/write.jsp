<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
	
	<!-- <body class="consult sub"> -->
	<!--content_wrap-->
	<div id="content_wrap" class="clearfix">
		<div class="content">
			<div class="page">
				<div class="page_header">
					<h2>
						<span class="txt1">상담신청, </span><span class="txt2">방구해요</span>
					</h2>
				</div>
				<!--page_header마감-->
				<div class="panel">
					<div class="content_header consult_header">
						<div class="tip">
							<p>
								<img src="${pageContext.request.contextPath}/images/consult/help.png" alt="도와줘요. 강남방" />
							</p>
						</div>
						<div class="container">
							<div class="inner">
								<div class="pic">
									<p>
										<img src="${pageContext.request.contextPath}/images/consult/man.png" alt="중개사" />
									</p>
								</div>
								<div class="guide">
									<p class="tit">방을 찾고 있으신가요?</p>
									<p>
										그런데 어떻게 찾을지 모르시겠다면 <span class="txt1">강남방</span>에 <span
											class="txt2">상담신청</span>하세요
									</p>
									<p>강남방이 신청하신 내용에 딱 맞는 방을 찾아드립니다.</p>
								</div>
							</div>
	
						</div>
					</div>
					<!--consult_header마감-->
					<div class="content_body shadow">
						<h3 class="blind">상담신청 정보입력</h3>
						<div class="container section">
							<div class="row">
								<div class="col tbl">
									<div class="form_label  tc">
										<div class="pad">희망지역</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
	
											<div class="text">
												<div class="input">
													<span>		
													<label for="consult_search_input" class="blind">방검색</label> 
													<input type="text" id="consult_search_input"  autocomplete="off"
														placeholder="동,지하철역을 입력해주세요">
													</span>
												</div>
											</div>
										</div>
									</div>
	
								</div>
							</div>
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">희망거래종류</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
											<div class=" col5 mid_col2 box check">
												<div class="inner">
													<label> <span class="txt"> 매매 </span> <span
														class="input"> <input id="trade" name="trade_type" onclick="selectTradde(this)" type="checkbox" />
													</span>
													</label>
												</div>
											</div>
											<div class=" col5 mid_col2 box check">
												<div class="inner">
													<label> <span class="txt"> 전세 </span> <span
														class="input"> <input id="charter" name="trade_type" onclick="selectTradde(this)" type="checkbox" />
													</span>
													</label>
												</div>
											</div>
											<div class="col5 mid_col2 box check">
												<div class="inner">
													<label> <span class="txt"> 전월세 </span> <span
														class="input"> <input id="monthly_and_charter" name="trade_type" onclick="selectTradde(this)" type="checkbox" />
													</span>
													</label>
												</div>
											</div>
											<div class=" col5 mid_col2 box check">
												<div class="inner">
													<label> <span class="txt"> 월세 </span> <span
														class="input"> <input id="monthly" name="trade_type" onclick="selectTradde(this)" type="checkbox" />
													</span>
													</label>
												</div>
											</div>
											<div class="col5 mid_col2 box check last">
												<div class="inner">
													<label> <span class="txt"> 단기임대 </span> <span
														class="input"> <input id="short_lease" name="trade_type" onclick="selectTradde(this)" type="checkbox" />
													</span>
													</label>
												</div>
											</div>
	
										</div>
									</div>
	
								</div>
							</div>
							<!--희망거래종류row마감-->
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">희망가격</div>
									</div>
									<div class="form_group tc">
										<div class="pad" id="trade_price">
											<!-- 거래가입력창 동적 생성 -->
										</div>
									</div>
								</div>
							</div>
							<!--희망가격row마감-->
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">연락처</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
											<div class="text">
												<div class="input">
													<span><input type="text"
														placeholder="'-'없이 숫자만 입력해 주세요"></span>
												</div>
											</div>
										</div>
									</div>
	
								</div>
							</div>
							<!--연락처row마감-->
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">연락가능시간</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
											<div class="text">
												<div class="input">
													<span><input type="text"
														placeholder="상담가능한 시간을 입력해 주세요"></span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--연락처row마감-->
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">희망조건</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
											<div class="textarea">
												<textarea placeholder="희망 조건을 입력해 주세요"></textarea>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--연락처row마감-->
						</div>
						<!--container마감-->
	
					</div>
					<!--content_body마감-->
	
					<div class="row btn_wrap">
						<div class="button">
							<div class="btn close close_btn">
								<button>
									<span>취소</span>
								</button>
							</div>
							<div class="btn submit">
								<button onclick ="add();">
									<span>확인</span>
								</button>
							</div>
						</div>
					</div>
	
				</div>
				<!--panel마감-->
			</div>
			<!--page마감-->
	
		</div>
		<!--content마감-->
	</div>
	<!--content_wrap마감-->
	
<!-- 희망지역선택 -->
<script>
	$(function() {
		consultAutoSet("consult_search_input");
	});
	//자동완성으로 지역명 또는 지하철역이름 선택
	function consultAutoSet(id){
		$("#"+id).keyup(
				function(event) {
					//값을 세팅
					currentWord = $("#"+id).val();
					if (!currentWord)//입력값이 없으면
						return;
					jQuery.ajax({
						type : "GET",
						dataType : "json",
						url : "/api/search/quick/autoword?searchWord=" + encodeURI(encodeURIComponent(currentWord)),
						async : false,
						success : function(data) {//msg를 받는 것이 성공하면
							autoWord = new Array();
							var infor = data.autoWordList;
							for (var i = 0; i < infor.length; i++)
								autoWord.unshift((infor[i].firstWord + " "
										+ infor[i].secondWord + " "
										+ infor[i].thirdWord).trim());
							
							$("#"+id).autocomplete({
								source : autoWord,
								select: function(event, ui) {
							        for (var i = 0; i < infor.length; i++){
							        	if(autoWord[infor.length - i -1] == ui.item.label){//선택한 단어와 가져왔던 자동완성이 일치하면
							        		//페이지 표시 초기화
							        		if(infor[i].kind == 'addressCode')
							        			formData["hope_location"] = infor[i].firstWord + " " + infor[i].secondWord + " " + infor[i].thirdWord;//구와 동이름만으로  지역명을 구분(시이름은 필요없음)
							        		else if(infor[i].kind == 'metro')
							        			formData["hope_location"] = infor[i].firstWord;
							        		
										    break;
							        	}
							        }
							        //autocomplete reset(prevent double clicked)
							        $("#"+id).autocomplete({
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
</script>
<!-- 상담신청 내용 최종등록 -->
<script>
	//상담내역을 추가
	var formData = [];
	function add(){
		alert(formData.hope_location);
	   /*  $.ajax({
	        type: 'POST',
	        url: "/api/consult",
	        contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(data),
	        async: false,
	        success: function() {
	        	alert('수정되었습니다.');
	        	document.location.href="/consult";
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert('수정 실패 : 다시 시도해주세요');
	        }
	    }); */
	}
</script>
<!-- //컴포넌트 상태변화 -->
<script>
	//거래종류 단일선택, 종류에맞게 거래가격의 입력창을 제공
	function selectTradde(target){
		//단일선택가능하도록 
	    var checkObj = document.getElementsByName("trade_type");
	    var select_chk = -1;
        for(select_chk=0; select_chk<checkObj.length; select_chk++){
            if(checkObj[select_chk] != target)//선택한 거래종류 체크박스이면
            	checkObj[select_chk].checked = false;
            else
            	break;
        } 
        if(select_chk == -1)//선택된 거래종류가없으면
        	return;
        //선택된 거래종류에 맞게 거래가 입력창 설정 
      	if(checkObj[select_chk].id == "trade"){
      		$("#trade_price").empty();
      		var str ='';
      		str+="<div class=\"row\">";
      		str+="	<div class=\"cols\">";
      		str+="		<div class=\"form_label2 fl\">";
      		str+="			<label>보증금</label>";
      		str+="		</div>";
      		str+="		<div class=\"form_group2\">";
      		str+="			<div class=\"col2 text fl\">";
      		str+="				<div class=\"inner\">";
      		str+="					<div class=\"input\">";
      		str+="						<span> <input type=\"text\" id=\"despositmin\"";
      		str+="							placeholder=\"보증금최소가\" />";
      		str+="						</span>";
      		str+="					</div>";
      		str+="					<div class=\"txt\">~</div>";
      		str+="				</div>";
      		str+="			</div>";
      		str+="			<div class=\"col2 text fl\">";
      		str+="				<div class=\"inner\">";
      		str+="					<div class=\"input\">";
      		str+="						<span> <input type=\"text\" id=\"despositmax\"";
      		str+="							placeholder=\"보증금최고가\" />";
      		str+="						</span>";
      		str+="					</div>";
      		str+="					<div class=\"txt\">만원</div>";
      		str+="				</div>";
      		str+="			</div>";
      		str+="";
      		str+="		</div>";
      		str+="	</div>";
      		str+="</div>    ";
			$("#trade_price").append(str);
      	}
	}
</script>
	
	