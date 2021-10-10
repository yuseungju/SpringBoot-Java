<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<!-- <body class="mypage sub"> -->
	<!--mypage 본문시작-->
	<div class="my_body">
		<div class="content_body">
			<div class="container section myinfo">
				<div class="row tbl sm_wrap">
					<div class="form_label tc ">
						<div class="pad">현재비밀번호</div>
					</div>
					<div class="form_group tc">
						<div class="pad mt">
							<div class="text ">
								<div class="input col2 mid_col1">
									<input type="password" id ="cur_password" placeholder="현재사용중인 비밀번호를 입력해 주세요">
								</div>
								<p class="warning_txt" id="cur_warning_txt"></p>

							</div>
						</div>
					</div>
				</div>
				<div class="row tbl sm_wrap newpassword">
					<div class="form_label tc">
						<div class="pad">새비밀번호</div>
					</div>
					<div class="form_group tc">
						<div class="pad mt">
							<div class="text ">
								<div class="input col2 mid_col1">
									<input type="password" id ="new_password1" placeholder="영문, 숫자 조합으로 7자 이상">
								</div>

							</div>
						</div>
					</div>
				</div>
				<div class="row tbl sm_wrap last">
					<div class="form_label tc">
						<div class="pad">새비밀번호 확인</div>
					</div>
					<div class="form_group tc">
						<div class="pad mt">
							<div class="text">
								<div class="input  col2 mid_col1">
									<input type="password" id ="new_password2" placeholder="다시한번 입력해주세요">
								</div>
								<p class="warning_txt" id ="new_warning_txt" ></p>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!--content_body마감-->
		<div class="row btn_wrap mt">
			<div class="button">
				<div class="btn close close_btn">
					<button type="reset">
						<span>취소</span>
					</button>
				</div>
				<div class="btn submit">
					<button type="submit" onclick="changePassword(); return false;">
						<span>비밀번호변경</span>
					</button>
				</div>
			</div>
		</div>
	</div>
	

<script>
//비밀번호를 변경
function changePassword(){
	//기존 비밀번호와 같은지 확인
	if(!isSamePassword()){//비밀번호 불일치의 경우
		document.getElementById("cur_warning_txt").innerHTML = "비밀번호가 일치하지 않습니다.";//비밀번호 틀림 문구출력
		return;
	}else{//비밀번호 일치의 경우
		document.getElementById("cur_warning_txt").innerHTML = "";//비밀번호 틀림 문구출력을 지움
	}
	//새비밀번호 입력확인
	if(!checkPassword())//새 비밀번호 입력형식 틀리면
		return;//비밀번호 수정 안하고 종료
	else//새 비밀 번호 입력형식이 맞으면
		updatePasswordAboutLoginNo($("#new_password1").val());//비밀번호 수정
}
</script>
<script>
//비밀번호 입력폼 확인
function checkPassword() {
	var checkDigitAlpha = /^.*(?=.{2,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	var checkLength = /^.*(?=.{7,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	var pwd = $("#new_password1").val();
	var pwd2 = $("#new_password2").val();
	if (!checkDigitAlpha.test(pwd)) {
		document.getElementById("new_warning_txt").innerHTML = "* 영문 숫자 혼합만 가능합니다.";
		return false;
	} else if (!checkLength.test(pwd)) {
		document.getElementById("new_warning_txt").innerHTML = "* 7~20자 이내로 가능합니다.";
		return false;
	} else if (pwd2 == "") {
		document.getElementById("new_warning_txt").innerHTML = "* 비밀번호 확인을 입력하세요.";
		return false;
	} else if (pwd != pwd2) {
		document.getElementById("new_warning_txt").innerHTML = "* 비밀번호와 비밀번호 확인이 다릅니다.";
		return false;
	}
	document.getElementById("new_warning_txt").innerHTML = "";
	return true;
}
</script>