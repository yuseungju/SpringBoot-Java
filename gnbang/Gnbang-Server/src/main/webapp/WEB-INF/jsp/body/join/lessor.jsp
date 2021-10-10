<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>

<!-- <body class="join"> -->
	<!--content_wrap-->
	<div id="content_wrap" class="clearfix">
		<div class="content">
			<div class="page">
				<form action="/join/lessor" method="POST" name="joinForm">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<div class="join_header">
						<h2>
							<span class="txt2">회원가입</span>
						</h2>
						<div class="row">
							<div class="container">
								<h3 class="blind">회원 형태별 가입</h3>
								<ul class="member_category ">
									<li class="col3 fl type1  "><a href="/join/user"
										title="일반회원 가입"><span class="text">일반회원</span></a><span
										class="bullet"></span></li>
									<li class="col3 fl type2  current"><span class="text">임대인회원</span><span
										class="bullet"></span></li>
									<li class="col3 fl type3  "><a href="/join/agent"
										title="중개사회원가입"><span class="text">중개사회원</span></a><span
										class="bullet"></span></li>
								</ul>
							</div>
						</div>
					</div>
					<!--join_header마감-->
					<div class="join_body container">
						<div class="box">
							<div class="panel horizon_padding">
								<div class="row form_group">
									<label for="input_name" class="col_label">이름</label>
									<div class="input text col_wide fl">
										<span class="form-control"><input type="text"
											class="bor_input" name="name" id="input_name"
											placeholder="이름을 입력해주세요" /></span>
									</div>
								</div>
								<div class="row form_group">
									<label for="input_email" class="col_label">이메일</label>
									<div class="input text  fl col_mid">
										<span class="form-control"><input type="text"
											class="bor_input" name="email" id="input_email"
											placeholder="example@email.com" /></span>
									</div>
									<div class="input button col_sm fr">
										<span><button type="button" onclick="emailSend()">이메일인증</button></span>
									</div>
								</div>
								<div class="row form_group">
									<label for="input_collect" class="col_label">인증번호입력</label>
									<div class="input text  fl col_mid">
										<span class="form-control"><input type="text"
											class="bor_input" id="input_collect" placeholder="인증번호를 입력하세요" /></span>
										<p class="warning_txt" id="warning_txt"></p>
									</div>
									<div class="input button col_sm fr">
										<span><button type="button" onclick="checkEmail()">확인</button></span>
									</div>
	
								</div>
								<div class="row form_group">
									<label for="input_pwd" class="col_label">비밀번호</label>
									<div class="input text col_wide fl">
										<span class="form-control"><input type="password"
											name="password" id="input_pwd" class="bor_input"
											onchange="checkPassword(this)"
											placeholder="영문,숫자 조합 7자 이상으로 입력해주세요" /></span>
	
									</div>
								</div>
								<div class="row form_group">
									<label for="input_pwd2" class="col_label">비밀번호 재확인</label>
									<div class="input text col_wide fl">
										<span class="form-control"><input type="password"
											class="bor_input" id="input_pwd2"
											onchange="checkPassword(this)" placeholder="다시한번 입력해주세요" /></span>
										<p class="warning_txt" id="msg_pwd"></p>
									</div>
								</div>
							</div>
							<!--pannel마감-->
						</div>
						<!--box마감-->
						<div class="join_agree  panel  ">
							<div class="row form_group agree_all">
								<div class="label">
									<p class="txt">
										<span>이용약관 및 개인 정보 수집 및 이용에 모두 동의합니다.</span>
									</p>
									<p class="input check">
										<span><input type="checkbox" id="check0" /></span>
									</p>
								</div>
							</div>
							<div class="row form_group ">
								<div class="label">
									<span class="txt">이용약관 동의 <strong>(필수)</strong> <a
										href="https://docs.google.com/document/d/1sKZIrlO4hUGqKiEv-Mi0FCz0FPVaogrs-6DV9u6E-Cs/pub" target="_blank">약관보기</a>
									</span> <span class="input check"><input type="checkbox"
										id="check1" /></span>
								</div>
							</div>
							<div class="row form_group ">
								<div class="label">
									<span class="txt">개인정보 수집 및 이용 동의 <strong>(필수)</strong> <a
										href="https://docs.google.com/document/d/1XS4DE4EmBNzG8bJG5-vCnMcogfqnc2JjwDYIO0PbOAw/pub" target="_blank">약관보기</a>
									</span> <span class="input check"><input type="checkbox"
										id="check2" /></span>
								</div>
							</div>
							<div class="row form_group ">
								<div class="label">
									<span class="txt">위치 기반 서비스 약관 동의<strong>(필수)</strong> <a
										href="https://docs.google.com/document/d/1cqZrXZbCX1HzBa7ppnin8lcY1I7UWwW1tDZPmgQNrmk/pub" target="_blank">약관보기</a>
									</span> <span class="input check"><input type="checkbox"
										id="check3" /></span>
								</div>
							</div>
						</div>
					</div>
				</form>
				<!--join_body container마감-->
				<div class="join_submit">
					<div class="button">
						<span><button type="submit" onclick="check()">회원가입</button></span>
					</div>
				</div>
				<!--join_submit마감-->
			</div>
			<!--page--마감-->
		</div>
		<!--content마감-->
	</div>
	



<script>
	/************************** 입력사항확인 ***********************/
	function checkPassword(obj) {
		var checkDigitAlpha = /^.*(?=.{2,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		var checkLength = /^.*(?=.{7,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		var pwd = $("#input_pwd").val();
		var pwd2 = $("#input_pwd2").val();
		if (!checkDigitAlpha.test(pwd)) {
			document.getElementById("msg_pwd").innerHTML = "* 영문 숫자 혼합만 가능합니다.";
			return false;
		} else if (!checkLength.test(pwd)) {
			document.getElementById("msg_pwd").innerHTML = "* 7~20자 이내로 가능합니다.";
			return false;
		} else if (pwd2 == "") {
			document.getElementById("msg_pwd").innerHTML = "* 비밀번호 확인을 입력하세요.";
			return false;
		} else if (pwd != pwd2) {
			document.getElementById("msg_pwd").innerHTML = "* 비밀번호와 비밀번호 확인이 다릅니다.";
			return false;
		}
		document.getElementById("msg_pwd").innerHTML = "";
		return true;
	}
	function check() {
		if ($("#input_name").val() == '') {
			alert('id를 입력해 주세요')
			return false;
		} else if (code == -1 || !checkEmailCode) {
			alert('email 인증이 필요합니다.')
			return false;
		} else if (checkedEmail != $("#input_email").val()) {
			alert('email을 다시 인증 해주세요.')
			checkedEmail = '';
			code = -1;
			checkEmailCode = false;
			return false;
		}
		//입력 형식 확인
		if (!checkPassword())//비밀 번호 확인
			return false;
		//약관동의 체크박스 여부 확인
		var check1 = $('input:checkbox[id="check1"]').is(":checked");
		var check2 = $('input:checkbox[id="check2"]').is(":checked");
		var check3 = $('input:checkbox[id="check3"]').is(":checked");
		if (check1 == "") {
			alert('이용약관에 동의 하지 않았습니다.');
			return false;
		} else if (check2 == "") {
			alert('개인정보 수집 및 이용 동의 하지 않았습니다.');
			return false;
		} else if (check3 == "") {
			alert('위치 기반 서비스 약관에 동의 하지 않았습니다.');
			return false;
		}
		document.joinForm.submit();
		return true;
	}
	$(document).ready(function() {
		//이용 약관 전체 체크 및 해제
		$("#check0").change(function() {
			if ($("#check0").is(":checked")) {
				$("#check0").prop("checked", true);
				$("#check1").prop("checked", true);
				$("#check2").prop("checked", true);
				$("#check3").prop("checked", true);
			} else {
				$("#check0").prop("checked", false);
				$("#check1").prop("checked", false);
				$("#check2").prop("checked", false);
				$("#check3").prop("checked", false);
			}
		});
	});
	/************************** 이메일 형식확인***********************/
	function checkEmailForm(email) {
		var checkEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		if (email == "") {
			alert('email을 입력해주세요.');
			return false;
		} else if(isOverlapEmail(email)){
			alert('이미 가입된 이메일입니다.');
			return false;
		} else if (!checkEmail.test(email)) {
			alert('올바르지 않은 email형식입니다.');
			return false;
		}
		return true;
	}

	/************************** 이메일 인증 ***********************/
	var code = -1;
	var checkEmailCode = false;
	var checkedEmail = '';
	function emailSend() {
		var email = $("#input_email").val();
		if (!checkEmailForm(email))
			return;
		alert('인증번호 발송 완료');
		jQuery.ajax({
			type : "GET",
			url : "/api/email/code?email=" + email,
			async : false,
			success : function(data, status) {//msg를 받는 것이 성공하면
				/* alert(data); */
				code = data;
			},
			error : function(xhr, status, error) {
			}
		});
	}
	function checkEmail() {
		if ($("#input_collect").val() == code) {
			alert('인증완료');
			checkedEmail = $("#input_email").val();
			document.getElementById("warning_txt").innerHTML = "";
			checkEmailCode = true;
			return true;
		} else {
			document.getElementById("warning_txt").innerHTML = "인증번호가 정확하지 않습니다.";
			document.getElementById("input_collect").innerHTML = "";
			checkEmailCode = false;
			return false;
		}
	}
	//이메일 중복체크
	function isOverlapEmail(email){
		var check = false;
		 $.ajax({
			 	type : "GET",
				dataType : "json",
		        url: "/api/login/email_overlap?email="+email,
		        async: false,//동기방식 호출
		        success: function(result) {
		        	if(result)
		        		check = true;
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        	check = true;
		        }
		    });
			return check;
	   }
</script>
