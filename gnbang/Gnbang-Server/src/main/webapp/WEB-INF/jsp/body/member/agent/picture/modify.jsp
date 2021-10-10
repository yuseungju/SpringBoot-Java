<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>

<!-- <body class="mypage sub"> -->	
	<!--mypage 본문시작-->
	<div class="my_body my_mm_pic">
		<div class="content_header my_header box">
			<div class="container">
				<div class="inner">
					<div class="guide">
						<ul>
							<li><strong>첫번째 사진이 대표사진</strong>으로 지정되오니 첫번째 사진을 신중히 선택하세요</li>
							<li>사진은 총 15개 등록 가능합니다.</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="content_body">
			<h4>1234 매물 사진</h4>
			<div class="btn_wrap">
				<div class="all_check group">
					<input type="checkbox" name="checkAll" onclick="checkAllImg();"/><label for="checkAll"
						class="blind">모두선택</label>
				</div>
				<div class="btn_wrap_i group">
					<a class="btn btn_front" href="#" onclick="upToTop(); return false;" title="맨위로">
					<span class="blind">맨위로</span></a> 
					<a class="btn btn_forward" href="#" onclick ="upToNear(); return false;" title="위로">
					<span class="blind">위로</span></a>
					<a class="btn btn_backward" href="#" onclick ="downToNear(); return false;" title="아래로">
					<span class="blind">아래로</span></a> 
					<a class="btn btn_back" href="#"  onclick="downToBottom(); return false;" title="맨아래로">
					<span class="blind">맨아래로</span></a>
				</div>
				<div class="btn btn_save group">
					<a href="#" title="순서 변경 저장" onclick ="updatePhotoOrder(); return false;"><span>순서 변경 저장</span></a>
				</div>
				<div class="btn btn_del group">
					<a href="#" onclick="deleteSelectedPhotos(); return false;" title="사진 삭제"><span>사진 삭제</span></a>
				</div>
			</div>
			<div class="mm_list table_list">
				<div class="container">
					<div class="list_header">
						<div class="btn_wrap">
							<div class="btn btn_pic_add">
								<a href="#" title="사진추가"><span>+ 사진추가</span></a>
							</div>
						</div>
					</div>
					<table class="fixed board_table">
						<thead>
							<tr class="m_hidden">
								<th class="col_chk">&nbsp;</th>
								<th class="cell">사진</th>
								<th class="cell_b">&nbsp;</th>
							</tr>
						</thead>
						<tbody id="room_table">
						</tbody>
					</table>
				</div>
				<!--container마감-->
	
			</div>
			<!--table_list--마감-->
			<div class="m_mmpic_footer">
				<div class="m_btn_wrap">
					<div class="all_check group">
						<input type="checkbox" name="checkAll" onclick="checkAllImg();"><label for="checkAll"
							class="blind">모두선택</label>
					</div>
					<div class="btn_wrap_i group">
						<a class="btn btn_front" href="#" onclick="upToTop(); return false;" title="맨위로">
						<span class="blind">맨위로</span></a> 
						<a class="btn btn_forward" href="#" onclick ="upToNear(); return false;" title="위로">
						<span class="blind">위로</span></a>
						<a class="btn btn_backward" href="#" onclick ="downToNear(); return false;" title="아래로">
						<span class="blind">아래로</span></a> 
						<a class="btn btn_back" href="#"  onclick="downToBottom(); return false;" title="맨아래로">
						<span class="blind">맨아래로</span></a>
					</div>
					<div class="btn m_btn_save group">
						<a href="#" title="순서 변경 저장" onclick ="updatePhotoOrder(); return false;"><span>순서변경<br />저장
						</span></a>
					</div>
					<div class="btn m_btn_del group">
						<a href="#" onclick="deleteSelectedPhotos();" title="사진 삭제"><span>사진<br />삭제
						</span></a>
					</div>
				</div>
				<div class="m_btn_wrap">
					<div class="btn btn_pic_add">
						<a href="#" title="사진추가"><span class="blind">사진추가</span></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--my_body마감-->
	
		
	<div class="overlay"></div>
	<div class="popup_wrap">
		<div class="popup_pic_add popup" id="popup_pic_add"
			style="display: table;">
			<div class="popup_cell">
				<div class="container">
					<div class="popup_title_wrap">
						<div class="popup_title">사진추가</div>
						<div class="popup_close close_btn">
							<span class="blind">닫기</span>
						</div>
					</div>
					<div class="popup_content_wrap">
						<div class="popup_content">
							<div class="row">
								<div class="guide">
									<ol>
										<li>사진 1장당 10MB까지 등록 가능합니다.</li>
										<li>사진은 최소 5장 이상 등록하셔야 합니다.</li>
										<li>사진은 총 16장 까지 등록 가능합니다.</li>
										<li>개인정보, 중개사 정보 등 매물과 관련 없는 정보가 포함된 사진은 삭제 처리됩니다.</li>
										<li>등록한 사진이 보이지 않을 경우 <strong>새로고침</strong> 단추를 클릭 하세요.
										</li>
									</ol>
									<div class="reload">
										<p class="btn">
											<button onclick="reset_photo_ul()">
												<span>새로고침</span>
											</button>
										</p>
									</div>
								</div>
							</div>
							<div class="row box">
								<form id="enrollForm" method ="POST">
									<ul id="photo_ul">
										<!-- 
												 html생성 공간( 추가되는 사진 ) 
										 !-->	
										<li class="pic_list col4 mid_col4 sm_col2" id="photo_add_li">
											<div class="pic" onclick='document.all.uploadFile.click();'>
												<div class="media_cover">
													<a href="#" class="btn_up"><span class="blind">사진추가</span></a>
												</div>
											</div>
										</li>
									</ul>
								</form>
							</div>
							<div class="row">
								<div class="button">
									<div class="btn close close_btn">
										<button>
											<span>취소</span>
										</button>
									</div>
									<div class="btn submit">
										<button onclick ="uploadAllPhoto(); return false;">
											<span>사진올리기</span>
										</button>
									</div>
								</div>
							</div>
						</div>
						<!--popup_content마감-->
					</div>
					<!--popup_content_wrap마감-->
				</div>
			</div>
		</div>
	</div>
	
	<!-- 파일업로드 기능 -->
	<form id="upload_file_frm" onsubmit="return false;">
	<input id="upload_file" type="file" name="uploadFile"  accept="image/*"  style='display: none;' onchange="selectUploadPhoto(this);" />
	</form>
	<!-- 사진 최종등록이 완료동안 보여질 로딩바 -->
	<div id="loading" class="">                               
       <img class="loading_img" src="${pageContext.request.contextPath}/images/common/loading.gif" alt="사진업로드 중 입니다. 잠시 기다려주세요 "/>
    </div>
	<script>
	$(document).ready(function() {
		setPhoto(getRoomPhoto('${roomNo}'));
	});
	</script>
	
	<!-- 사진출력-->
	<script>
	//매물에 등록된 사진들의 경로를 가져온다
	var displayed_photo_list = [];
	//사진 경로로 사진을 출력한다
	function setPhoto(photo_list){
		displayed_photo_list = photo_list;//현제 보여지는 사진들의 정보를 저장
		var str = '';
		var photo_url;
		var photo_no;
		$("#room_table").empty();
		for(var i =0 ; i< photo_list.length; i++ ){
			photo_url = "http://112.175.245.57" + photo_list[i].fake_url;
			photo_no = photo_list[i].no;
			str+="<tr>";
			str+="<td class=\"col_chk\"><input type=\"checkbox\"";
			if(photo_list[i].checked)
				str+=" checked ";
			str+=" name = \"check_img\" value = \""+ photo_no +"\"></td>";
			str+="<td class=\"col_pic2\">";
			str+="	<div class=\"image_list\">";
			str+="		<div class=\"media_photo media_cover\">";
			str+="			<div class=\"media_cover\">";
			str+="				<img src=\""+ photo_url +"\" alt=\"2003번 방사진\"";
			str+="					class=\"img_responsive_height\" />";
			str+="			</div>";
			str+="		</div>";
			str+="	</div>";
			str+="</td>";
			str+="<td class=\"cell_b\">&nbsp;</td>";
			str+="</tr>";
		}
		$("#room_table").append(str);
	}
	</script>
	<!-- 체크박스 상태 -->
	<script>
		//체크된 사진의  url과 인덱스를 가져온다.
		function getPictureCheckedBox(){
			var checkedBox = [];
			for(var i =0; i < $("input[name=check_img]").length; i++){
				var obj = new Object();
				var checkUser = document.getElementsByName("check_img");
				if(checkUser[i].checked){
					obj["no"]  = $("input[name=check_img]:eq(" + i + ")").val();
					obj["index"]  = i;
					checkedBox.push(obj);
				}
			} 
			return checkedBox;
		}
		//모든 사진의 url과 인덱스를 가져온다.
		function getPictureCheckBox(){
			var checkedBox = [];
			for(var i =0; i < $("input[name=check_img]").length; i++){
				var obj = new Object();
				obj["no"]  = $("input[name=check_img]:eq(" + i + ")").val();
				obj["index"]  = i;
				checkedBox.push(obj);
			} 
			return checkedBox;
		}
	</script>
	<!-- 사진 위치 변경 -->
	<script>
	//사진순서 화면에 보여지는 순서로 수정처리
	function updatePhotoOrder(){
		var data;
		for(var i = 0; i< displayed_photo_list.length; i++){
			data = {};
			data["no"] = displayed_photo_list[i].no;
			data["order"] = i;
			jQuery.ajax({
				type : "PUT",  
				contentType: 'application/json; charset=utf-8',
		        data: JSON.stringify(data),
				url : "/api/room/photo",
				async : false,
				success : function() {
				},
				error : function(xhr, status, error) {
				}
			});
		}
		window.location.reload(true);
	}
	//사진을 맨위로
	function upToTop(){
		//보여지는 사진정보와 체크상태를 가져옴
		var checked_picture_list = getPictureCheckedBox();//체크된사진의 경로와 인덱스를 가져옴
		//체크된 상태 설정
		for(var i = 0; i < displayed_photo_list.length; i++)
			displayed_photo_list[i].checked = false;
		for(var i = 0; i < checked_picture_list.length; i++)
			displayed_photo_list[checked_picture_list[i].index].checked = true;
		//사진을 하나씩 뒤로 이동
		var temp;
		for(var i = 1; i <  displayed_photo_list.length; i++){
			if(displayed_photo_list[i].checked){//체크된 사진이면
				for(var j = i; 0 < j; j--){//현재 인덱스에서 맨앞 인덱스까지
					if(!displayed_photo_list[j-1].checked){//바로 체크된 사진 바로 뒤의 사진이 체크되지않았으면
						//사진인덱스, 경로, 체크상태 교환
						temp = displayed_photo_list[j-1];
						displayed_photo_list[j-1] = displayed_photo_list[j];
						displayed_photo_list[j] = temp;
					}
				}
			}
		}
		//사진이 보여지는 위치를 재설정
		setPhoto(displayed_photo_list);
	}
	//사진을 한칸위로
	function upToNear(){
		//보여지는 사진정보와 체크상태를 가져옴
		var checked_picture_list = getPictureCheckedBox();//체크된사진의 경로와 인덱스를 가져옴
		//체크된 상태 설정
		for(var i = 0; i < displayed_photo_list.length; i++)
			displayed_photo_list[i].checked = false;
		for(var i = 0; i < checked_picture_list.length; i++)
			displayed_photo_list[checked_picture_list[i].index].checked = true;
		//사진을 하나씩 뒤로 이동
		var temp;
		for(i = 1; i <  displayed_photo_list.length; i++){
			if(displayed_photo_list[i].checked){//체크된 사진이면
				if(!displayed_photo_list[i-1].checked){//바로 체크된 사진 바로 뒤의 사진이 체크되지않았으면
					//사진인덱스, 경로, 체크상태 교환
					temp = displayed_photo_list[i-1];
					displayed_photo_list[i-1] = displayed_photo_list[i];
					displayed_photo_list[i] = temp;
				}
			}
		}
		//사진이 보여지는 위치를 재설정
		setPhoto(displayed_photo_list);
	}
	//사진을 맨아래로
	function downToBottom(){
		//보여지는 사진정보와 체크상태를 가져옴
		var checked_picture_list = getPictureCheckedBox();//체크된사진의 경로와 인덱스를 가져옴
		//체크된 상태 설정
		for(var i = 0; i < displayed_photo_list.length; i++)
			displayed_photo_list[i].checked = false;
		for(var i = 0; i < checked_picture_list.length; i++)
			displayed_photo_list[checked_picture_list[i].index].checked = true;
		//사진을 하나씩 뒤로 이동
		var temp;
		for(i = displayed_photo_list.length-2; 0 <= i; i--){
			if(displayed_photo_list[i].checked){//체크된 사진이면
				for(var j = i; j < displayed_photo_list.length -1; j++){//현재 인덱스에서 맨뒤 인덱스까지
					if(!displayed_photo_list[j+1].checked){//바로 체크된 사진 바로 뒤의 사진이 체크되지않았으면
						//사진인덱스, 경로, 체크상태 교환
						temp = displayed_photo_list[j+1];
						displayed_photo_list[j+1] = displayed_photo_list[j];
						displayed_photo_list[j] = temp;
					}
				}
			}
		}
		//사진이 보여지는 위치를 재설정
		setPhoto(displayed_photo_list);
	}
	//사진을 한칸아래로
	function downToNear(){ 
		//보여지는 사진정보와 체크상태를 가져옴
		var checked_picture_list = getPictureCheckedBox();//체크된사진의 경로와 인덱스를 가져옴
		//체크된 상태 설정
		for(var i = 0; i < displayed_photo_list.length; i++)
			displayed_photo_list[i].checked = false;
		for(var i = 0; i < checked_picture_list.length; i++)
			displayed_photo_list[checked_picture_list[i].index].checked = true;
		//사진을 하나씩 뒤로 이동
		var temp;
		for(i = displayed_photo_list.length-2; 0 <= i; i--){
			if(displayed_photo_list[i].checked){//체크된 사진이면
				if(!displayed_photo_list[i+1].checked){//바로 체크된 사진 바로 뒤의 사진이 체크되지않았으면
					//사진인덱스, 경로, 체크상태 교환
					temp = displayed_photo_list[i+1];
					displayed_photo_list[i+1] = displayed_photo_list[i];
					displayed_photo_list[i] = temp;
				}
			}
		}
		//사진이 보여지는 위치를 재설정
		setPhoto(displayed_photo_list);
	}
	</script>
	
	<!-- 사진 삭제-->
	<script>
		function deleteSelectedPhotos(){
			if (!confirm("선택한 사진을 삭제 하시겠습니까?"))
				return;
			var checked_picture_list = getPictureCheckedBox();//체크된사진의 경로와 인덱스를 가져옴
			for(var i = 0; i < checked_picture_list.length; i++){
				var photo_no = checked_picture_list[i].no;
				jQuery.ajax({
					type : "DELETE",  
					url : "/api/room/photo?photo_no="+photo_no,
					async : false,
					success : function() {
					},
					error : function(xhr, status, error) {
					}
				});
			}
			window.location.reload(true);
		}
	</script>
	
	<!-- 사진추가  -->
	<script>
		/*************************파일 업로드 데이터 설정************************************/
		 var temp_enroll_num = 0;//임시등록 성공 수
		 var photo_cnt = 0;//사진 고유번호 
		 var photo_li_id = [];//뷰에보여지는 사진만큼만 할당된 id
		 var photo_temp_url = [];//업로드 또는 취소했을때, 등록했던 이미지의 모든 임시경로(업로드 했던만큼)
		 var upload = document.getElementById('upload_file');
		 var allready_num =  getRoomPhotoCount("${room.no}");
		 function selectUploadPhoto(obj){
			if(obj.value =='')//사진찾기 -> 사진 선택을 안하고 취소했으면
				return;
			if(16 <= allready_num + photo_li_id.length){
				alert('사진은 16개 까지만 등록가능합니다.');
				return;
			}
			addPhotoView();//사진뷰 생성
			uploadTempPhoto(photo_cnt);//업로드
			//파일 폼 상태 초기화
			$('#upload_file').val('');
			photo_cnt++; 
		};
		//등록된 사진의 개수를 가져온다.
		function getRoomPhotoCount(room_no) {
			var room_cnt = 0;
			$.ajax({
				type : "GET",
				dataType : "json",
					url: "/api/room/photo_count?room_no="  + room_no,
					async: false,//필수 등록이전 방의 수를 확인하기위해 동기화시켜야함
					success: function(data) {
					room_cnt = data;
				},
			      error: function(jqXHR, textStatus, errorThrown) {
					room_cnt = 9999;//에러시에 방사진 추가 못하도록 함
				}
			});
			return room_cnt;
		}
		//이미지 컨테이터(뷰)출력
		function addPhotoView(){
			var str ="";
			str+=" <li class=\"pic_list col4 mid_col4 sm_col2\" id= \"li_"+ photo_cnt + "\">";
			str+=" <input type =\"text\" value=\"\" name =\"file_name\" style='display: none;'/>";
			str+=" <div class=\"pic\">";
			str+=" 		<div class=\"media_cover media_photo\">";
			str+=" 			<img src=\"\" id= \"preview_"+ photo_cnt + "\" alt=\"상세사진4\" />";
			str+=" 		</div>";
			str+=" 		<div class=\"btn_del\">";
			str+=" 			<a href=\"#\" onclick=\"remove("+ photo_cnt + "); return false;\" alt=\"사진삭제하기\"><span class=\"blind\">사진삭제</span></a>";
			str+=" 		</div>";
			str+=" 	</div>";
			str+=" </li>";
			photo_li_id.push(photo_cnt);//사진하나의  id저장
			$("#photo_add_li").before(str);//사진(뷰) 하나추가
			
			//미리보기 섬네일
			var upload = document.getElementById('upload_file');
			var	holder = document.getElementById('preview_' + photo_cnt);
			var file = upload.files[0], reader = new FileReader();
			reader.onload = function(event) {
				var img = new Image();
				img.src = event.target.result;
				holder.src = reader.result;
			};
			reader.readAsDataURL(file);
		}
		//사진 선택 지우기(뷰에서만)
		function remove(target_photo_cnt){
			$("#li_" + target_photo_cnt).remove();
			photo_li_id.splice(photo_li_id.indexOf(target_photo_cnt),1);
		}
		//모든 사진지우기(뷰에서만)
		function reset_photo_ul(){
			//이미지 (뷰) 초기화
			for(var i = 0; i < photo_li_id.length; i++)
				$("#li_" + photo_li_id[i]).remove();
			//파일 폼 상태 초기화
			$('#upload_file').val('');
			photo_li_id = [];//파일폼인덱스 초기화
		}
		//사진하나를 서버에 임시 업로드
		function uploadTempPhoto(target_photo_cnt){
			var fd = new FormData($("#upload_file_frm")[0]);
			photo_temp_url.push(target_photo_cnt);
			$.ajax({
				url:"/api/room/enroll/temp_photo",
				type: "POST",
				data: fd,  
				enctype: 'multipart/form-data',
		        processData: false,
		        contentType: false,
		        cache: false,
		        async: true,
		        success: function (data) {
		        	if(data.tempPath == "ErrExtension"){
	    				alert('jpg만 지원합니다.');
	    				remove(target_photo_cnt);
		        	}else if(data.tempPath == "ErrSize"){
	    				alert('10MB를 초과했습니다.');
	    				remove(target_photo_cnt);
		        	}else if(data.tempPath == "ErrLogin"){
	    				alert('다시 로그인해주세요.');
	    				remove(target_photo_cnt);
	    				document.location.href ="/";
		        	}else{
	    				photo_temp_url.splice(target_photo_cnt, 1, data.tempPath); 
	    				temp_enroll_num++;
		        	}
		        },
		        error:function(request,status,error){
		            alert('등록 실패');//서버에러
		        }
			});
		}
		//사진모두를 서버에  업로드(파일경로저장 , ftp업로드, 강남방서버 업로드)
		var upload_lock = 0;
		function uploadAllPhoto(){
			if(upload_lock == 1){
				alert('잠시 기다려주세요.');
				return;
			}
			upload_lock = 1;
			if(photo_li_id.length < 1){
				upload_lock = 0;
				alert('사진을 선택해주세요.');
				return;
			}
			
			//임시업로드로 클릭한 이미지들중 현재 보여지는이미지들의 개수를 구함(형식, 용량제한등의 임시 이미지들 제외한 개수)
			var realTempPhotoLength = 0;
			for(var i = 0; i < photo_temp_url.length; i++){
				if(10 < photo_temp_url[i].length)
					realTempPhotoLength ++;
			}
			//등록할 이미지의 수와 임시로등록된이미지의수가 다르면 종료(임시업로드 처리중에있으면)
			if (temp_enroll_num != realTempPhotoLength) {
				upload_lock = 0;
				alert('사진을 찾고있습니다. 잠시후 다시 시도해주세요');
				return;
			}
			$("#loading").addClass("add_pic");
			var path_data = [];
			for(var i = 0; i < photo_li_id.length; i++)
				path_data.push(photo_temp_url[photo_li_id[i]]);//선택된사진들의(뷰에 보여지는) 경로만 데이터로지정
				//사진 최종 등록 (서버와 ftp)
				$.ajax({
		        type: 'POST',
		        url: "/api/room/"+"${roomNo}"+"/photo",
		        contentType: 'application/json; charset=utf-8',
		        data: JSON.stringify(path_data),
		        async: true,
		        success: function(result) {
		        	if(result){
		    			upload_lock = 0;
		        		alert('등록이 완료되었습니다.');
		        		$("#loading").removeClass("add_pic");
		    	       	window.location.reload();//성공시에 뷰 새로고침
		        	}else {
		    			upload_lock = 0;
		        		alert('다시 로그인해주세요.');		
		        		$("#loading").removeClass("add_pic");
		        		document.location.href = "/";//초기화면
		        	}
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        	document.location.reload();
					upload_lock = 0;
		            alert('등록 실패 : 다시 시도해주세요');
		    		$("#loading").removeClass("add_pic");
		        }
		    });
		}
	</script>
	<!-- 컴포넌트 상태변화 -->
	<script>
		var check_all = true;
		function checkAllImg(){
			// 체크 박스 모두 체크
			if(check_all){
				$("input[name=check_img]:checkbox").each(function() {
					 this.checked = true;
				});
				check_all = false;
			}
			else{
				$("input[name=check_img]:checkbox").each(function() {
					 this.checked = false;
				});
				check_all = true;
			}
		}
	</script>