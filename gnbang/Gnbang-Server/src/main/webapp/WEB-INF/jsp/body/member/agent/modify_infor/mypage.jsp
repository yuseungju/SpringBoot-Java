<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="sec"
		uri="http://www.springframework.org/security/tags"%>
<%@ page import="com.gnbang.webserver.security.domain.*" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %> 
<%@ page import="org.springframework.security.core.userdetails.UserDetailsService" %> 


<!-- <body class="mypage sub"> -->	
	<div class="my_body">
			<div class="content_body">
				<div class="container section myinfo">
					<div class="row tbl profile">
						<div class="form_label tc m_hidden">
							<div class="pad">프로필</div>
						</div>
						<div class="form_group tc pos_rel">
							<div class="pad">
								<div class="profile_photo">
									<p class="pic" >
										<img id="preview"
											src="${pageContext.request.contextPath}/images/common/account_120.png"
											alt="중개사">
									</p>
								</div>
								<div class="button" onclick='document.all.uploadFile.click();'>
									<button>사진올리기</button>
								</div>
							</div>
						</div>
					</div>
					<div class="row tbl">
						<div class="form_label tc m_hidden">
							<div class="pad">이름</div>
						</div>
						<div class="form_group tc ">
							<div class="pad">
								<div class="">
									<sec:authentication property="principal.realname"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row tbl">
						<div class="form_label tc m_hidden">
							<div class="pad">이메일</div>
						</div>
						<div class="form_group tc">
							<div class="pad">
								<span id="agent_email"><sec:authentication property="principal.username"/></span>
							</div>
						</div>
					</div>
					<div class="row tbl sm_wrap">
						<div class="form_label tc">
							<div class="pad">휴대전화번호</div>
						</div>
						<div class="form_group tc">
							<div class="tbl2 pad">
								<div class="col2  tc2">
									<span id ="agent_phone">
										
									</span>
								</div>
								<div class="button tc2">
									<div class="input">
										<button class="phone_btn">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row tbl sm_wrap last">
						<div class="form_label tc ">
							<div class="pad">비밀번호</div>
						</div>
						<div class="form_group tc">
							<div class="pad mt">
								<div class="text ">
									<div class="input col2 mid_col1">
										<input type="password" id ="password">
									</div>
									<p class="warning_txt">비밀번호가 일치하지 않습니다.</p>
								</div>
							</div>
						</div>
					</div>
					<p class="leave_btn">
						<a href="#leave_form" onclick="secession()">회원탈퇴</a>
					</p>
				</div>
			</div>
			<!--content_body마감-->
			<div class="row btn_wrap mt">
				<p class="guide">수정사항이 있을 경우 현재 비밀번호를 입력해 주세요</p>
				<div class="button">
					<div class="btn close close_btn">
						<button type="reset" onclick ="cancle()">
							<span>취소</span>
						</button>
					</div>
					<div class="btn submit">
						<button type="submit" onclick="endModify()">
							<span>회원정보수정</span>
						</button>
					</div>
				</div>
			</div>
	</div>
	<!--my_body마감-->
	
	<!--------------------------------------------------------------------------->
    <!--전화번호 수정 클릭되면 body에 modal_opened클래스추가 modal.phone_modal 클래스에 show클래스 추가 -->
    <!--전화번호 수정 닫기 버튼 클릭되면 body에 modal_opened클래스제거  modal클래스에 show클래스 제거 -->
	<!--------------------------------------------------------------------------->
	<div class="modal phone_modal">
		<div class="modal_table">
			<div class="modal_cell">
				<!--휴대전화번호수정폼시작-->
				<div class="modal_container phone_form" id="phone_form">
					<div class="modal_title_wrap">
						<div class="modal_title">휴대전화번호 수정</div>
						<div class="modal_close close_btn">
							<a href="#content_wrap" title="휴대전화번호수정 닫기">
							<span class="blind">휴대전화번호수정 닫기</span></a>
						</div>
					</div>
					<div class="modal_content_wrap">
						<div class="modal_content">
							<div class="row">
								<div class="form_group">
									<!--label의 for속성의 input의 id값과 동일한 값을 주시면 되요 -->
									<label for="휴대전화 input의 아이디값" class="col_label">휴대전화번호</label>
									<div class="input text  fl col_mid">
										<span class=" form-control"> 
											<input type="text" class="bor_input" id ="new_phone" placeholder="'-'없이 숫자만 입력하세요" />
										</span>
									</div>
									<!-- #####<div class="input button col_sm fr">
										<span><button class="btn_auth">인증번호 전송</button></span>
									</div> #####-->
									<p class="warning_txt" id="phone_msg"> &nbsp; </p>
								</div>
	
								<div class="form_group">
									<!--label의 for속성의 input의 id값과 동일한 값을 주시면 되요 -->
									<!-- #####<label for="인증번호 input 의 id값" class="col_label">인증번호</label> #####-->
									<div class="input text col_wide fl">
										<span class="form-control">
											<!-- ##### <input type="text" class="bor_input" placeholder="인증번호를 입력해 주세요" /> #####-->
										</span>
									</div>
									<!--##### <p class="warning_txt">인증번호를 확인해주세요</p> #####-->
								</div>
								<div class="submit btn">
									<div class="button">
										<span><button type="button" class="btn_submit" onclick="checkPhoneAndUpdate(); return false;">확인</button></span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--번화번호수정모달종료-->
	<!--------------------------------------------------------------------------->
       <!--호원탈퇴 클릭되면 body에 modal_opened클래스추가 modal.phone_modal 클래스에 show클래스 추가 -->
       <!--회원탈퇴 닫기 버튼 클릭되면 body에 modal_opened클래스제거  modal클래스에 show클래스 제거 -->
	<!--------------------------------------------------------------------------->
	<div class="modal leave_modal" id ="secessionPopup">
		<div class="modal_table">
			<div class="modal_cell">
				<!--회원탈퇴시작-->
				<div class="modal_container leave_form" id="leave_form">
					<div class="modal_title_wrap">
						<div class="modal_title">회원탈퇴</div>
						<div class="modal_close close_btn">
							<a href="#content_wrap" title="회원탈퇴 닫기"><span class="blind">회원탈퇴
									닫기</span></a>
						</div>
					</div>
					<div class="modal_content_wrap">
						<div class="modal_content">
							<p class="bye">그동안 강남방 서비스를 이용해 주셔서 감사합니다.</p>
							<div class="row login_or_separator">
								<span class="or_text">&nbsp;</span>
								<hr>
							</div>
							<div class="guide">
								<p class="bye">회원 탈퇴 전 유의사항을 확인하세요.</p>
								<ul>
									<li>회원 탈퇴 시 회원님께서 보유하셨던 정보는 모두 삭제됩니다.</li>
									<li>회원 탈퇴 후 개인정보 , 포인트 등의 데이터는 복구되지 않습니다. 
										다시한번 신중히 고려해 주시기바랍니다</li>
								</ul>
							</div>
							<div class="row login_or_separator">
								<span class="or_text">&nbsp;</span>
								<hr>
							</div>
							<div class="row">
								<div class="label">
									<p class="input check">
										<span><input type="checkbox"  id ="agree_secession"/></span>
									</p>
									<p class="txt">
										<span>안내사항을 모두 확인하였으며, 이에 동의합니다.</span>
									</p>
								</div>
								<div class="submit btn">
									<div class="button">
										<span><button type="submit" class="btn_submit"  onclick="submitSecession()">확인</button></span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--회원탈퇴모달종료-->
	
	<!-- 파일업로드 기능 -->
	<form id="upload_file_frm" onsubmit="return false;">
	<input id="upload_file" type="file" name="uploadFile"  accept="image/*"  style='display: none;' onchange="selectUploadPhoto(this);" />
	</form>
	
						
<script>
	$(document).ready(function(){
		//회원의 프로필사진을 가져와 풀력
		setProfilePhoto('preview');
		//회원의 연락처를 가져와 연락처를 뷰에 설정
		$("#agent_phone").text(getPhoneAboutLoginNo());
		//휴대폰입력이 벗어나면 입력 표현체크후 메세지출력
		$('#new_phone').blur(function(){
			checkPhoneErrExpress($("#new_phone").val());
		});
	});
</script>
<!-- 탈퇴 -->
<script>
	//탈퇴 팝업보이기
	function secession(){
		$("#secessionPopup").addClass("show");
	}
	//탈퇴 완료
	function submitSecession(){
		if($('input:checkbox[id="agree_secession"]').is(":checked")){//동의 했으면 탈퇴
		    $.ajax({
		        type: 'PUT',
		        url: "/api/member/secession",
		        async: false,
		        success: function(result) {
		        	if(result)
						alert('탈퇴완료 되었습니다.');
		        	else
			            alert('다시 로그인 해주세요');
		        	document.location.href ="/logout";
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert('등록 실패 : 다시 시도해주세요');
		            document.location.href ="/logout";
		        }
		    });
		}else{//동의하지 않았으면 탈퇴안함
			alert('탈퇴에 동의하지 않았습니다.');
		}
	}
</script>
<!-- 수정 -->
<script>
	//***************프로필사진********************
	//프로필 사진 변경
	function selectUploadPhoto(obj){
		if(obj.value =='')//사진찾기 -> 사진 선택을 안하고 취소했으면
			return;
		addPhotoView();//사진미리보기 적용
	}
	//이미지 컨테이터(뷰)출력
	function addPhotoView(){
		//미리보기 섬네일
		var upload = document.getElementById('upload_file');
		var	holder = document.getElementById('preview');
		var file = upload.files[0], reader = new FileReader();
		reader.onload = function(event) {
			var img = new Image();
			img.src = event.target.result;
			holder.src = reader.result;
		};
		reader.readAsDataURL(file);
	}
	//프로필 사진 선택된사진으로 변경
	function modifyPhoto(){//사진하나를 서버에 임시 업로드
		var fd = new FormData($("#upload_file_frm")[0]);
		$.ajax({
			url:"/api/member/photo",
			type: "POST",
			data: fd,  
			enctype: 'multipart/form-data',
	        processData: false,
	        contentType: false,
	        cache: false,
	        async: false,
	        success: function (data) {
	        	if(data.err == "ErrExtension"){
    				alert('프로필 사진은 jpg만 지원합니다.');
    				return false;
	        	}else if(data.err == "ErrSize"){
    				alert('프로필 사진은  10MB를 초과했습니다.');
    				return false;
	        	}else if(data.err == "ErrLogin"){
    				alert('다시 로그인해주세요.');
    				document.location.href ="/";
    				return false;
	        	}
	        	alert('수정완료');
	        	window.location.reload();
				return true;
	        },
	        error:function(request,status,error){
	            alert('등록 실패');//서버에러
	        }
		});
	}
</script>
<!-- 수정 -->
<script>
	//**************수정 적용 여부 선택******************
	//수정 취소
	function cancle(){
		$("#password").val("");
	}
	//수정완료
	function endModify(){
		 if(!isSamePassword($("#password").val()))//비밀번호 불일치할경우
			return;//회원정보 수정안함
		 //회원정보수정
		 var chcek_photo =  modifyPhoto();//사진수정
		 if(!chcek_photo)//사진수정이 실패하면
			 return;//다른 정보도 수정하지 않음
	}
</script>
<!-- 연락처 수정 -->
<script>
	//기존 휴대폰 번호와 같은지 확인하고, 기존과 다르면 수정
	function checkPhoneAndUpdate(){
		var phone = $("#new_phone").val();
		if(checkPhoneErrExpress(phone))//번호를 제대로 입력했으면 
			updatePhoneAboutLoginNo(phone);//번호 업데이트
	}
	//번호입력이 제대로됐는지 확인
	function checkPhoneErrExpress(phone){
		if (phone == '' || !(/^[0-9]+$/).test(phone)) {//숫자가아니거나 입력하지않았으면
			document.getElementById("phone_msg").innerHTML = '휴대전화 번호 형식에 맞게 입력해 주세요.';
			return false;
		}else if(phone == getPhoneAboutLoginNo()){
			document.getElementById("phone_msg").innerHTML = '현재 등록된 휴대전화 정보와 동일합니다.';
			return false;
		}else {
			document.getElementById("phone_msg").innerHTML = "&nbsp;";
			return true;
		}
	}
</script>



