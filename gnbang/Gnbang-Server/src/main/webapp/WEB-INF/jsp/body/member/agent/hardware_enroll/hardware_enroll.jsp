<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!-- <body class="mypage sub"> -->
	<!--mypage 본문시작-->
	<div class="my_body">
		<div class="content_body">
			<div class="container section myinfo">
				<div class="row tbl sm_wrap newpassword">
					<div class="form_group tc">
						<div class="pad mt">
							<div id = "install_stage1" style ="display:block">
								<a href="${pageContext.request.contextPath}/application/중개사기능.exe">-> 중개사 업무기능 설치(클릭) </a><br><br>
								프로그램을 설치 <br>
								- 반드시 관리자 권한으로 실행하여 설치해주세요<br><br>
								<img height ="10dp" src="${pageContext.request.contextPath}/images/mypage/agent_application_explain.JPG"
								 style="max-width: 40%; height: auto;"> <br><br>
								<button onclick ="toInstallStage2(); return false;">다음 단계로</button>
							</div>
							<div id = "install_stage2" style ="display:none">
								기기등록<br><br>
								<div id = "install_stage2_div">
								    <!--  기기등록 내용 -->
								</div>
							</div>
							<div id = "install_complete" style ="display:none">
								등록완료<br><br>
								<div id = "install_complete_div">
								    <!--  기기완료 내용 -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>			
				
				
<!-- 기기등록 단계 -->	
	<script>
	$(document).ready(function() {
		var enrolled_mac_address = getEnrolledMacAddress();
		var current_connect_type = getcurrentConnectType();
		if(current_connect_type == 'pc'){
			if(0 < (enrolled_mac_address).length){//pc를 등록한적이 있으면
				current_mac_address = getClientMacAddress(null);
				if(current_mac_address != 'err'){//설치프로그램이 있으면
				 	var install_stage1 = document.getElementById("install_stage1");  
					install_stage1.style.display = 'none';  
				 	var install_stage2 = document.getElementById("install_stage2");  
					install_stage2.style.display = 'none';  
					var str ="";	
					str += "이미 등록한 pc가 있습니다.<br>";
					str += "등록된 pc가 아니면 기능이 제한됩니다.<br>";
					str += "pc: " + enrolled_mac_address + "<br>";
					$("#install_complete_div").empty();
					$("#install_complete_div").append(str);
				 	var install_complete = document.getElementById("install_complete");  
				 	install_complete.style.display = 'block';  
				}else if(current_mac_address == 'err'){//설치프로그램이 없으면
				 	var install_stage1 = document.getElementById("install_stage1");  
					install_stage1.style.display = 'block'; 
				}
			}
		}
	});
	var current_mac_address ="";
	function toInstallStage2(){
		getUUID();
		var enrolled_mac_address = getEnrolledMacAddress();
		var current_connect_type = getcurrentConnectType();
		if(current_connect_type == 'pc'){
			current_mac_address = getClientMacAddress(null);
			if(current_mac_address  == 'err'){//설치프로그램이 설치되지않았으면
				alert('프로그램이 제대로 설치되지않았습니다.');
			}else{//설치됐으면
				var enrolled_mac_address = getEnrolledMacAddress();
				if(enrolled_mac_address.length == 0){//사용기기 등록한적없으면
					var str ="";
					if(0 < current_mac_address.length){
						str += "현재 접속중인 PC 정보 <br>";
						str += current_mac_address + "<br>";
						str += "<input type =\"button\" onclick =\"enrollUsePC(\'"+current_mac_address+"\'); return false;\" value = \"현재 pc를 사용기기로 등록\"><br><br>";
						str += "중개사 주요 기능을 모두 사용하시려면, pc를 등록하여 사용해주세요.<br><br><br>";
						$("#install_stage2_div").empty();
						$("#install_stage2_div").append(str);
					}
					 var install_stage1 = document.getElementById("install_stage1");  
					install_stage1.style.display = 'none';  
					 var install_stage2 = document.getElementById("install_stage2");  
					install_stage2.style.display = 'block';  
				}else if(enrolled_mac_address != current_mac_address){//등록된 pc와 접속pc가 다르면
				 	var install_stage1 = document.getElementById("install_stage1");  
					install_stage1.style.display = 'none';  
				 	var install_stage2 = document.getElementById("install_stage2");  
					install_stage2.style.display = 'none';  
					var str ="";	
					str += "이미 등록한 pc가 있습니다.<br>";
					str += "등록된 pc가 아니면 기능이 제한됩니다.<br>";
					str += "pc: " + enrolled_mac_address + "<br>";
					$("#install_complete_div").empty();
					$("#install_complete_div").append(str);
				 	var install_complete = document.getElementById("install_complete");  
				 	install_complete.style.display = 'block';  
				}
			}
		}else if(current_connect_type == 'mobile'){
			/* <!-- 모바일 접속정보 -->
			<p>--mobile--<br></p>
			<c:if test="${currentConnectType eq 'mobile'}">
				모바일기기는 등록할 수 없습니다. <br>
				모바일의 경우 기능이 제한되니, 모든 기능을 이용하고 싶으시면 pc를 사용해주세요.
			</c:if>
			<c:if test="${currentConnectType ne 'mobile'}">
				현재 접속중인 모바일 : &nbsp; 없음<br>
			</c:if> */
		}
	}
	//사용기기를 등록한다.
	function enrollUsePC(mac_address){
		var  current_connect_type = getcurrentConnectType();
		if(current_connect_type == 'pc'){
			if (confirm('사용pc로 등록하시겠습니까? \n한번 등록된 pc는 수정후 변경할 수 없습니다.')) {
				jQuery.ajax({
					type : "PUT",  
					contentType: 'application/json; charset=utf-8',
				    async: false,
					url : "/api/member/agent/mac_address?mac_address="+ mac_address,
					success : function() {
						alert('pc가 등록되었습니다. 다시 로그인해주세요.');
					},
					error : function(xhr, status, error) {
						alert('다시 시도해주세요');
					}
				});
				logout();
			}
		}else if(current_connect_type == 'mobile'){
			
		}
	}
</script>
