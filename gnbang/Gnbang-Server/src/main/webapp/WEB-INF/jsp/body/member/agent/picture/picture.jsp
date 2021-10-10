<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue"%>

	<!-- <body class="mypage sub"> -->
	<!--mypage 본문시작-->
	<div class="my_body my_mm_pic">
		<div class="content_header my_header box">
			<div class="container">
				<div class="inner">
					<div class="guide">
						<ul>
							<li>매물 사진 관리는 <strong>해당 매물의 사진 등록 최초 시간 기준 24시간 이내
							</strong>의 매물만 사진을 수정/삭제 할 수 있습니다.
							</li>
							<li><strong>1개의 매물 당 1명의 중개사만이 사진을 등록</strong>할 수 있습니다.</li>
							<li>본인이 등록한 매물 사진만 관리할 수 있습니다.</li>
							<li>등록된지 24시간이 지난 매물을 수정/삭제 하시려면 팀장님께 연락하시기 바랍니다.</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="content_body">
			<h4>사진 등록한 매물 목록</h4>
			<div class="btn_wrap">
				<span>Filter By :</span>
				<div class="q_filter" id="select_modifiable">
					<a href="#" onclick="modifiablePicture()"  title="사진 수정가능한 매물 보기">사진 수정가능 매물 보기</a>
				</div>
				<div class="q_filter on"id="select_all">
					<a href="#" onclick="allPicture()" title="사진등록한 매물 전체보기">전체보기</a>
				</div>
			</div>
			<div class="mm_list table_list">
				<div class="container">
					<div class="list_header">
						<p class="count" id ="searchCount">총 0개</p>
					</div>
					<table class="fixed board_table">
						<thead>
							<tr class="m_hidden">
								<th class="cell ">대표사진</th>
								<th class="col_desc ">매물정보</th>
								<th class="cell4 ">등록사진</th>
								<th class="cell5">사진등록일</th>
								<th class="cell6">&nbsp;</th>
							</tr>
						</thead>
						<tbody id ="room_table">
						</tbody>
					</table>
				</div>
				<!--container마감-->
				<div class="page_wrap">
					<p class="paging">
						<a href="#" onClick="posChangeSubmit('pre');" class="bor" id="pre_page">&lt;<span class="blind">이전</span></a> 
						<a href="#" onClick="posChangeSubmit('pos1');" class="current" id ="pos1">1</a>
						<a href="#" onClick="posChangeSubmit('pos2');" id ="pos2">2</a> 
						<a href="#" onClick="posChangeSubmit('pos3');" id ="pos3">3</a>
						<a href="#" onClick="posChangeSubmit('pos4');" id ="pos4">4</a> 
						<a href="#" onClick="posChangeSubmit('pos5');" id ="pos5">5</a> 
						<a href="#" onClick="posChangeSubmit('next');" class="bor" id="next_page"><span class="blind">다음</span>&gt;</a>
					</p>
				</div>
				<!--page_wrap마감 -->
			</div>
			<!--table_list--마감-->
		</div>
	</div>
	<!--my_body마감-->
	
<script>
	$(document).ready(function() { 
		//기본 url을 api/search 컨트롤러의 경로로 설정(ajax경로)
		agentSearchUrl = "/api/room/enroll_photo/search/agent";
		posChangeSubmit(1);//중개사가 등록한 방검색
	});
</script>
<!-- 중개사의 방검색 -->
<script>
	var agentSearchUrl = '';//전체경로
	var num_per_page = 10;//페이지당 방 출력 개수
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
		 if(currentBlock*num_per_page*5 + num_per_page*0 < all_count)//page 1을  표시해야되면
			 pos1.style.display ='inline-block';  
		 if(currentBlock*num_per_page*5 + num_per_page*1 < all_count)//page 2을  표시해야되면
			 pos2.style.display ='inline-block'; 
		 if(currentBlock*num_per_page*5 + num_per_page*2 < all_count)//page 3을  표시해야되면
			 pos3.style.display ='inline-block';  
		 if(currentBlock*num_per_page*5 + num_per_page*3 < all_count)//page 4을  표시해야되면
			 pos4.style.display ='inline-block';  
		 if(currentBlock*num_per_page*5 + num_per_page*4 < all_count)//page 5을  표시해야되면
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
		 if((currentBlock+1)*num_per_page*5 < all_count){//다음 화살표를 표시해야되면
		      next_page.style.display = 'inline-block';  
		 }
	}
	
	//******************검색할 페이지로 페이지상태를 변경하고 검색******************
	function posChangeSubmit(pos){
		setCurrentPage(pos);//현재페이지 설정
		search(agentSearchUrl + "?picture_modifiable=" + picture_modifiable, currentPg);
		setPageIndex(currentBlock);//페이지 인덱스 표시 설정 (이전, 1 ~ 5 ,다음 버튼)
	}
	//******************중개사의 방 검색******************
	function search(url, pg){
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : url+"&pg=" + pg,
			async : false,//총 검색개수를 받아온 이후 다음 절차수행, 반드시 동기 false로
			success : function(data) {//msg를 받는 것이 성공하면
				setInfor(data);
				all_count = data.allSearchCount;
			},
			error : function(xhr, status, error) {
			}
		});
	}
	function setInfor(data){ 
		var str ='';
		$("#room_table").empty();
		for(var room_index= 0; room_index <data.roomList.length; room_index++){
			var infor = data.roomList[room_index];
			
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
		    
		   //주소값 설정
			var address = '';
			address = infor.si +"시 " +  infor.gungu +" " +  infor.dong +" ";/* 
			if(infor.main_address != null && infor.main_address != 0 && infor.sub_address != null && infor.sub_address != 0)
				address+= (infor.main_address +"-" + infor.sub_address +" "); */
			if(infor.main_address != 0)
 				address+= infor.main_address;// 번지 처음
	 		if(infor.sub_address != 0)
 				address+= "-"+ infor.sub_address;// 번지 마지막
			if(infor.last_address != null && infor.last_address != '' )
				address+= " "+infor.last_address; 
		
			var room_type;
			if(infor.apartment == 1)
				room_type = '아파트';
			else if(infor.officetel)
				room_type = '오피스텔';
			else if(infor.house == 1)
				room_type = '주택';
			else if(infor.normal_room == 1)
				room_type = '원룸';
			else if(infor.shop == 1)
				room_type = '상가';
			else if(infor.office == 1)
				room_type = '사무실';
			else if(infor.building == 1)
				room_type = '건물';
			else if(infor.event == 1)
				room_type = '이벤트';
			else if(infor.land == 1)
				room_type = '땅';
			
	
			var main_fake_url = "${pageContext.request.contextPath}/images/common/pic_base.jpg";
			var min_enroll_date =  9999;
			var date_char;	
			var enroll_date;
			var enroll_date_index = 0;
			var modifiable =  infor.modifiable;
			//사진등록 날짜중 가장오래된 날짜와   메인사진경로 설정
			if(0 < infor.fake_url.length){
				//메인사진경로 설정
				main_fake_url = "http://112.175.245.57" + infor.fake_url[0];
				//사진등록 날짜중 가장오래된 날짜설정
				min_enroll_date =  9999;
				enroll_date = '';
				for(var a = 0; a < infor.photoEnrollDate.length; a++){
					enroll_date ='';
					for(var b = 0; b < infor.photoEnrollDate[a].length; b++){
						date_char = infor.photoEnrollDate[a].charAt(b);
						if(isNaN(date_char) == false && date_char != ' ' ) //숫자이면
							enroll_date += date_char;
					}
					//가장오래된 날짜값 찾기
					if(enroll_date < min_enroll_date){
						min_enroll_date = enroll_date;
						enroll_date_index = a;
					}
				}
				min_enroll_date = infor.photoEnrollDate[enroll_date_index];
			}
			if(min_enroll_date == 9999)
				min_enroll_date = '없음';
			var photo_num = infor.photoEnrollDate.length;//사진 개수 설정
			var modifiable = infor.modifiable;//수정가능여부

			
			str += "<tr>";
			str += "	<td class=\"col_pic\">";
			str += "		<div class=\"image_list\">";
			str += "			<div class=\"media_photo media_cover\">";
			str += "			<div class=\"media_cover\">";
			str += "					<img src=\"" + main_fake_url + "\" alt=\"2003번 방사진\"";
			str += "						class=\"img_responsive_height\" />";
			str += "				</div>";
			str += "			</div>";
			str += "		</div>";
			str += "	</td>";
			str += "	<td class=\"col_desc  m_no_col\">";
			str += "		<div class=\"row\">";
			str += "			<p class=\"col_wide fl\">";
			str += "				<span class=\"addr\">" + address + "</span>";
			str += "			</p>";
			str += "			<p class=\"col2 sm_col1  mid_col1 fl\">";
			str += "				<span class=\"tit\">구분</span> <span>" + type + "</span>";
			str += "			</p>";
			str += "			<p class=\"col2 sm_col1 mid_col1 fl\">";
			str += "				<span class=\"tit\">매물종류</span> <span>" + room_type + "</span>";
			str += "			</p>";
			str += "		</div>";
			str += "		<div class=\"row\">";
			str += "			<p class=\"col2 sm_col1 mid_col1 fl\">";
			str += "				<span class=\"tit\">매물번호</span> <span>"+ no +"</span>";
			str += "			</p>";
			str += "		</div>";
			str += "	</td>";
			str += "	<td class=\"cell4 m_no_col\"><p class=\"m_tit\">" + photo_num + "</p></td>";
			str += "	<td class=\"cell5 m_no_col\"><p class=\"m_tit\"> " + min_enroll_date + "</p></td>";
			str += "	<td class=\"col_btn m_no_col\">";
			if(modifiable){//사진이 수정 가능하면
				str += "		<p class=\"btn edit_btn\">";
				str += "			<a href=\"/member/agent/picture/modify?no="+ no +"\">사진수정</a>";
				str += "		</p>";
			}else{
				str += "		<p class=\"btn no_edit_btn\">";
				str += "			<a>사진수정</a>";
				str += "		</p>";
			}
			str += "		<p class=\"btn copy_btn\">";
			str += "			<a href=\""+"/room/"+no+"\" target=\"_blank\">상세보기</a>";
			str += "		</p>";
			str += "	</td>";
			str += "</tr>";
		}
		$("#room_table").append(str);
		
		//방 검색결과 수 적용
		$("#searchCount").empty();
		$("#searchCount").append("총   " + data.allSearchCount + "개"); 
	
	}
</script>

<!-- 전체 또는 사진수정가능매물선택 이벤트 -->
<script>
	var picture_modifiable = false;
	function modifiablePicture(){
		$("#select_all").removeClass("on");
		$("#select_modifiable").addClass("on");
		picture_modifiable =  true;//수정가능한 사진을 가지는 매물만
		//페이지초기화
		posChangeSubmit(1);//검색
	}
	function allPicture(){
		$("#select_modifiable").removeClass("on");
		$("#select_all").addClass("on");
		picture_modifiable =  false;//수정가능여부를 따지지 않음
		//페이지초기화
		posChangeSubmit(1);//검색
	}
</script>
