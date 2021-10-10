<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<!-- <body class="join"> -->
	<div id="content_wrap" class="clearfix">
		<div class="content">
			<div class="page">
				<div class="join_header">
					<h2>
						<span class="txt1">비밀번호변경</span>
					</h2>
				</div>
				<!--join_header마감-->
				<div class="join_body container">
					<div class="box">
						<div class="panel">
							<div class="row form_group">
								<label for="input_newpwd" class="col_label">새비밀번호</label>
								<div class="input text col_wide fl">
									<span class="form-control"><input type="password"
										id="input_newpwd" class="bor_input"
										placeholder="영문,숫자 조합 7자 이상으로 입력해주세요"></span>
	
								</div>
							</div>
							<div class="row form_group">
								<label for="input_newpwd2" class="col_label">비밀번호 재확인</label>
								<div class="input text col_wide fl">
									<span class="form-control"><input type="password"
										class="bor_input" id="input_newpwd2" placeholder="다시한번 입력해주세요"></span>
									<p class="warning_txt" id ="warning_txt"></p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="btn_wrap pwd">
					<div class="button ">
						<div class="btn close close_btn">
							<button type="reset">
								<span>취소</span>
							</button>
						</div>
						<div class="btn submit ">
							<button type="submit" onclick ="changePassword()">
								<span>비밀번호변경</span>
							</button>
						</div>
					</div>
				</div>
			</div>
			<!--page마감-->
		</div>
		<!--content마감-->
	</div>
	<!--content_wrap마감-->
	
<script>
function changePassword(){
	//새비밀번호 입력확인
	if(!checkPassword())//비밀번호 입력형식 틀리면
		return;
	//비밀번호 수정
	updatePasswordAboutEmail('${email}', $("#input_newpwd").val());
}
</script>	
<script>
//비밀번호 입력폼 확인
function checkPassword() {
	var checkDigitAlpha = /^.*(?=.{2,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	var checkLength = /^.*(?=.{7,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	var pwd = $("#input_newpwd").val();
	var pwd2 = $("#input_newpwd2").val();
	if (!checkDigitAlpha.test(pwd)) {
		document.getElementById("warning_txt").innerHTML = "* 영문 숫자 혼합만 가능합니다.";
		return false;
	} else if (!checkLength.test(pwd)) {
		document.getElementById("warning_txt").innerHTML = "* 7~20자 이내로 가능합니다.";
		return false;
	} else if (pwd2 == "") {
		document.getElementById("warning_txt").innerHTML = "* 비밀번호 확인을 입력하세요.";
		return false;
	} else if (pwd != pwd2) {
		document.getElementById("warning_txt").innerHTML = "* 비밀번호와 비밀번호 확인이 다릅니다.";
		return false;
	}
	document.getElementById("warning_txt").innerHTML = "";
	return true;
}
</script>
	