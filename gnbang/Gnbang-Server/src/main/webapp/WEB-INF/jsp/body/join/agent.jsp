<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>

<!-- <body class="join"> -->	
	<!--content_wrap-->
	<div id="content_wrap" class="clearfix">
		<div class="content">
			<div class="page">
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
								<li class="col3 fl type2  "><a href="/join/lessor"
									title="임대인회원 가입"><span class="text">임대인회원</span></a><span
									class="bullet"></span></li>
								<li class="col3 fl type3 current  "><span class="text">중개사회원</span><span
									class="bullet"></span></li>
							</ul>
						</div>
					</div>
				</div>
				<!--join_header마감-->
	
	
				<form action="/join/agent" method="POST" name="joinForm" onsubmit ="return check();">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<div class="row form_group join_agent">
						<label class="radio1"> 
						<input type="radio"   checked="checked"
							name="radio_agent" id ="agent_gnb"/> <span class="txt">강남방부동산중개법인 중개사</span>
						</label> <label class="radio2"> 
						<input type="radio" 
							name="radio_agent" id ="agent_other"/> <span class="txt">협력중개사</span>
						</label>
						<div class="text">
							<p>회원 가입 후 등록증과 개설등록증을 팩스로 보내주시면 됩니다.</p>
							<p>FAX: 02-517-5161</p>
						</div>
					</div>
	
					<div class="join_body container">
						<div class="box" id="agent_infor_box" style="display: none">
							<p class="tit">중개사 정보</p>
							<div class="panel">
								<div class="row form_group">
									<label for="input_angency_name" class="col_label">중개사무소명</label>
									<div class="input text col_wide fl">
										<span class="form-control"><input type="text"
											class="bor_input" name="agent_name" id="input_angency_name" value="강남방부동산중개법인주식회사"
											placeholder="중개사무소명을 입력해주세요" /></span>
									</div>
								</div>
								<div class="row form_group">
									<label for="input_reg_number" class="col_label">사업자번호</label>
									<div class="input text col_wide fl">
										<span class="form-control"><input type="text"
											class="bor_input" name=agent_corporate_registration_number
											id="input_reg_number"  value ="1328634946" placeholder='"-"없이 숫자만 입력해 주세요' /></span>
									</div>
								</div>
								<div class="row form_group">
									<label for="input_angency_president" class="col_label">대표자명</label>
									<div class="input text col_wide fl">
										<span class="form-control"><input type="text"
											class="bor_input" name="agent_representative"
											id="input_angency_president" value ="김혜옥" placeholder="대표자 실명을 입력해주세요" /></span>
									</div>
								</div>
	
								<div class="row form_group">
									<label for="input_agency_addr" class="col_label">주소</label>
									<div class="input text col_wide fl">
										<span class="form-control"><input type="text"
											class="bor_input" name="agent_address" id="input_agency_addr" value="강남구 논현로152길 35, 2층 (신사동, Giogia빌딩)"
											placeholder="중개사무소 주소를 입력해주세요" /></span>
									</div>
								</div>
								<div class="row form_group">
									<label for="input_agency_tel" class="col_label">대표전화</label>
									<div class="input text col_wide fl">
										<span class="form-control"><input type="text"
											class="bor_input" name="agent_phone" id="input_agency_tel" value ="025175161"
											placeholder='"-"없이 숫자만 입력해 주세요' /></span>
									</div>
								</div>
							</div>
							<!--panel마감-->
						</div>
						<!--box 마감-->
						<div class="box">
							<div class="row e-join">
								<p class="tit">개인정보</p>
							</div>
							<div class="panel">
								<div class="row form_group">
									<label for="input_name" class="col_label">이름</label>
									<div class="input text col_mid fl">
										<span class="form-control"><input type="text"
											class="bor_input" name="name" id="input_name"
											placeholder="이름을 입력해주세요" /></span>
									</div>
									<div class="select col_sm fr ">
										<div class="inner">
											<label for="input_positon" class="col_label blind">직급/직책</label>
											<select id="input_positon">
												<option>직급/직책</option>
												<option>대표중개사</option>
												<option>소속중개사</option>
												<option>중개보조원</option>
											</select>
										</div>
									</div>
								</div>
								<div class="row form_group">
									<label for="input_email" class="col_label">이메일</label>
									<div class="input text  fl col_wide">
										<span class="form-control"><input type="text"
											class="bor_input" name="email" id="input_email"
											placeholder="example@email.com" /></span>
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
								<div class="row form_group">
									<label for="input_phone" class="col_label">전화번호</label>
									<div class="input text  fl col_mid">
										<span class="form-control"><input type="text"
											class="bor_input" name="phone" id="input_phone"
											placeholder='"-"없이 숫자만 입력해주세요' /></span>
									</div>
									<div class="input button col_sm fr">
										<!--##### <span><button type="button">인증번호전송</button></span> #####-->
									</div>
								</div>
								<div class="row form_group">
									<!--#####-##### <label for="input_collect" class="col_label">인증번호입력</label>
									<div class="input text  fl col_mid">
										<span class="form-control"><input type="text"
											class="bor_input" id="input_collect" placeholder="인증번호를 입력하세요" /></span>
										<p class="warning_txt">인증번호가 정확하지 않습니다.</p>
										<p class="warning_txt">인증되었습니다.</p>
									</div>
									<div class="input button col_sm fr">
										<span><button type="button">확인</button></span>
									</div> #####-#####-->
	
								</div>
							</div>
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
				<!--join_body container마감-->
				<div class="join_submit">
					<div class="button">
						<span><button type="submit">회원가입</button></span>
					</div>
				</div>
					<input type="hidden" id ="agent_level" name ="agent_level"/>
				<!--join_submit마감-->
				</form>
			</div>
		</div>
		<!--page--마감-->
	</div>
	<!--content마감-->

<script>
	/************************** 입력사항확인 ***********************/
	function checkPassword(obj) {
		//비밀번호 입력확인
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
	function check() {//회원가입 완료버튼시 체크
		//중개사무소 명 입력 값  확인
		if ( $("#input_angency_name").val()== '') {
			alert('중개사무소명을 입력해 주세요.')
			return false;
		}else if($("#agent_other").is(":checked") //협력중개사 체크시
				&& $("#input_angency_name").val()=='강남방'){//중개사무소명을 강남방으로 입력시
			alert("강남방부동산중객법인 중개사만 '강남방'이름을 사용하실 수 있습니다.");
		} 
		 
		//사업자번호 입력 값  확인
		if ( $("#input_reg_number").val()== '') {
			alert('사업자 번호를 입력해 주세요.')
			return false;
		}else if (!(/^[0-9]+$/).test($("#input_reg_number").val())) {
			alert('사업자 번호는 숫자만 가능합니다.')
			return false;
		}
		//대표자명 입력 값  확인
		if ( $("#input_angency_president").val()== '') {
			alert('대표자명을 입력해 주세요.')
			return false;
		}
		//주소 입력 값  확인
		if ( $("#input_agency_addr").val()== '') {
			alert('주소를 입력해 주세요.')
			return false;
		}
		//대표전화 입력 값  확인
		if ( $("#input_agency_tel").val()== '') {
			alert('대표전화를 입력해 주세요.')
			return false;
		}else if (!(/^[0-9]+$/).test($("#input_agency_tel").val())) {
			alert('대표전화는 숫자만 가능합니다.')
			return false;
		}
		//이름입력 값  확인
		if ( $("#input_name").val()== '') {
			alert('이름을 입력해 주세요')
			return false;
		}
		//직급/직책 선택확인 
		var level = $("#input_positon option").index($("#input_positon option:selected"));
		if(level == 0){
			alert('직급/직책을 선택해주세요.')
			return false;
		}
		//이메일 확인
		if(!checkEmailForm($("#input_email").val())){//이메일 확인 팝업
			return false;
		}
		//전화번호 값  확인
		if ($("#input_phone").val()== '') {
			alert('전화번호를 입력해 주세요.')
			return false;
		} else if (!(/^[0-9]+$/).test($("#input_phone").val())) {
			alert('전화번호는 숫자만 가능합니다.')
			return false;
		}
		
		//입력 형식 확인
		if (!checkPassword()){//비밀 번호 확인
			alert('비밀번호 입력을 확인해주세요.');
			return false;
		}
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
		
		//직책 직급 값 설정
		$("#agent_level").val($("#input_positon option").index($("#input_positon option:selected")) -1);
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
 	function checkEmailForm(email){
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
<!-- 라디오버튼 체크 이벤트 -->
<script>
	var agent_type ="gnb";
	$("input[name=radio_agent]").click(function() {
		 var agent_infor_box = document.getElementById("agent_infor_box");  // 호출된 id값을 변수로
		
		 if($("#agent_gnb").is(":checked"))//강남방 부동산 중개사 선택시
			 agent_type = 'gnb';
		 else if($("#agent_other").is(":checked"))//협력중개사 선택시
			 agent_type = 'other';
		 
		 if(agent_type == 'gnb'){ 
			 $("#input_angency_name").val('강남방부동산중개법인주식회사');
			 $("#input_reg_number").val('1328634946');
			 $("#input_angency_president").val('김혜옥');
			 $("#input_agency_addr").val('강남구 논현로152길 35, 2층 (신사동, Giogia빌딩)');
			 $("#input_agency_tel").val('025175161');
			 agent_infor_box.style.display = 'none';  
		 }else if(agent_type == 'other'){
			 $("#input_angency_name").val('');
			 $("#input_reg_number").val('');
			 $("#input_angency_president").val('');
			 $("#input_agency_addr").val('');
			 $("#input_agency_tel").val('');
			 agent_infor_box.style.display = '';  
		 }
	});
</script>