<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>

	<!-- <body class="detail"> -->
	<!--모달 시작-->
	<!--로그인, 비밀번호 찾기가 클릭되면 body에 modal_opened클래스추가 modal.login_modal 클래스에 show클래스 추가 -->
	<!--로그인, 비밀번호 찾기가 닫기 버튼 클릭되면 body에 modal_opened클래스제거  modal클래스에 show클래스 제거 -->
	<div class="modal login_modal">
		<div class="modal_table">
			<div class="modal_cell">
				<!--로그인폼시작-->
				<div class="modal_container login_form" id="login_form">
					<div class="modal_title_wrap">
						<div class="modal_title">로그인</div>
						<div class="modal_close close_btn" onclick="loginPopUpClose()">
							<a href="#content_wrap" title="로그인 닫기"><span class="blind">로그인닫기</span></a>
						</div>
					</div>
					<div class="modal_content_wrap">
						<div class="modal_content">
							<div class="row social_button">
								<p class="tit">간단 로그인</p>
								<button class="btn icon_btn btn_facebook btn_block"
									type="submit" onclick="loginWithFacebook()">
									<span class="icon icon_facebook"></span> <span class="text">페이스북계정으로
										로그인</span>
								</button>
								<button class="btn icon_btn btn_kakao btn_block" type="submit"
									onclick="loginWithKakao()">
									<span class="icon icon_kakao"></span> <span class="text">카카오톡계정으로
										로그인</span>
								</button>
							</div>
							<div class="row login_or_separator">
								<span class="or_text">&nbsp;</span>
								<hr>
							</div>
							<form action="/" method="POST" onsubmit ="closePopUp()" id="security_login_form" name ="security_login_form">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
								<div class="row">
									<p class="tit">이메일로 로그인</p>
									<div class="form_group">
										<label for="input_email" class="col_label">이메일</label>
										<div class="input text  fl col_wide">
											<span class=" form-control"> <input type="text"
												class="bor_input" id="login_email" name="email" 
												placeholder="example@email.com" />
											</span>
										</div>

									</div>

									<div class="form_group">
										<label for="input_pwd" class="col_label">비밀번호</label>
										<div class="input text col_wide fl">
											<span class="form-control"> <input type="password"
												id="login_pwd" class="bor_input" name="password"
												placeholder="비밀번호를 입력해주세요" />
											</span>
										</div>
										<div class="label">
											<p class="input check">
												<span><input type="checkbox" /></span>
											</p>
											<p class="txt">
												<span>자동로그인</span>
											</p>
										</div>

									</div>
									<div class="submit btn">
										<div class="button">
											<span><button type="submit" class="btn_submit" onclick="security_login_pro(); return false;">로그인</button></span>
										</div>
									</div>
								</div>
							</form>
							<div class="row login_or_separator">
								<span class="or_text">&nbsp;</span>
								<hr>
							</div>
							<div class="row link">
								<p class="col2 fl link_pw">
									<a href="#" onClick="passwordPopUp(); return false;" class="fr">비밀번호
										찾기</a>
								</p>
								<p class="col2 fl link_join">
									<a href="/join/user" title="강남방회원가입" class="fl">회원 가입</a>
								</p>

							</div>
						</div>

					</div>
				</div>
				<div class="modal_container password_form" id="password_form" style="display:none;">
					<div class="modal_title_wrap">
						<div class="modal_title">비밀번호 찾기</div>
						<div class="modal_close close_btn" onclick="passwordPopUpClose()">
							<a href="#content_wrap" title="비밀번호찾기 닫기"><span class="blind">비밀번호찾기
									닫기</span></a>
						</div>
					</div>
					<div class="modal_content_wrap">
						<div class="modal_content">

							<div class="row">
								<p class="tit">비밀번호가 생각나지 않으세요?</p>
								<p class="txt">가입시 사용하신 이메일을 입력하시면 임시 비밀번호를 보내드립니다.</p>
								<div class="form_group">
									<label for="input_email" class="col_label">이메일</label>
									<div class="input text  fl col_wide">
										<span class=" form-control"> <input type="text"
											class="bor_input" id="find_email"
											placeholder="example@email.com" />
										</span>
									</div>

								</div>
								<div class="submit btn">
									<div class="button">
										<span><button type="submit" onclick ="findPassword()" class="btn_submit">확인</button></span>
									</div>
								</div>
							</div>

						</div>

					</div>
				</div>
			</div>

		</div>
	</div>

	<form name="joinFacebook" action="/join/facebook" method="POST">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type=hidden name="inforFacebook"
			id="inforFacebook" />
	</form>
	<form name="joinKakao" action="/join/kakao" method="POST">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type=hidden name="inforKakao"
			id="inforKakao" />
	</form>

<!-- 로그인 팝업 및 처리  -->
<script>
	/************************** login handle ***********************/
	function security_login_pro(){
		closePopUp();
		var email =  document.security_login_form.email.value;
		var password = document.security_login_form.password.value;
		security_login_ajax(email, password);//로그인 처리
		if(0 < login_roles().length)
			window.location.reload();
		else
			alert('로그인에 실패했습니다. 회원정보를 다시 확인해주세요.');
	}
	function closePopUp(){
		loginPopUpClose();
		passwordPopUpClose();
	}
	function loginPopUp(){
		//로그인팝업창만 열기
		$('body').removeClass('nav_opened').addClass('modal_opened');
   		$('.modal.login_modal').addClass('show').find('#login_form').show().end().find('#password_form').hide();
	}
	function loginPopUpClose() {
		//로그인팝업창 닫기
		$("body").removeClass("modal_opened");
		$(".modal.login_modal").removeClass("show");
	}
	function passwordPopUp() {
		//비밀번호 찾기창 열기
		$('body').removeClass('nav_opened').addClass('modal_opened');
   		$('.modal.login_modal').addClass('show').find('#password_form').show().end().find('#login_form').hide();
	}
	function passwordPopUpClose() {
		//비밀번호 찾기창 닫기
		$("body").removeClass("modal_opened");
		$(".modal.login_modal").removeClass("show");
	}
	//로그인 여부확인후 로그인되지않았으면 로그인창 띄우기, 로그인 여부값 반환(onfocus에서 사용)
	function check_login_and_popup(obj){
		if(typeof obj != "undefined")//this로 호출한 tag의 obj가 존재하면
			obj.blur();//만얀 onfocus에서 호출했으면, 해당 이벤트가 계속되지않도록 focus를 없앤다.
		if(login_roles().length <= 0){//로그인된 상태가 아니면(어떤 회원 권한도 없으면)
			loginPopUp();//로그인 팝업열기
			return false;
		}
		return true;
	}	
</script>

<script>
function findPassword(){
	//존재하는 이메일인지 확인
	var check_overlap = false;
	$.ajax({
		type : "GET",
		url : "/api/login/email_overlap?email="+ $("#find_email").val(),
		async : false,
		success : function(overlap) {
			if(overlap)//입력한 이메일이 존재하면
				check_overlap = true;
			else
				alert('이메일이 존재하지않습니다.');
		},
		error : function(jqXHR, textStatus, errorThrown) {
		}
	});
	if(!check_overlap)//이메일이 존재하지않으면 
		return;
	
	//이메일로 비밀번호 새창의 링크보내기
	$.ajax({
		type : "GET",
		url : "/api/email/password_link?email="+ $("#find_email").val(),
		async : false,
		success : function(check) {
			if(check)
				alert('전송되었습니다. email을 확인해주세요.');
			else
				alert('다시 시도해주세요.');
	   		document.location.href="/";
		},
		error : function(jqXHR, textStatus, errorThrown) {
		}
	});
}
</script>
