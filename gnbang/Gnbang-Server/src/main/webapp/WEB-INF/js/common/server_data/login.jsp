<%@ page language ="java" contentType="application/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

/************************** script 로드 ***********************/
//쿠키 관련 js 로드
var script1 = document.createElement('script');
script1.src = "/js/common/simple_function/cookie.js";
document.head.appendChild(script1);

//카카오톡 사용 js 로드
var script2 = document.createElement('script');
script2.src = "//developers.kakao.com/sdk/js/kakao.min.js";
document.head.appendChild(script2);
script2.onload = function () {
	Kakao.init('<%=GlobalValue.kakaoApi%>');
};

/************************** 로그인 기본정보 ***********************/
//로그인 회원의 권한들을 문자열로 가져옴
//input * 
//process * 회원번호를 찾아 회원에 해당되는 권한들을 가져옴(DB/ 회원권한: ROLE_LIST의 role)
//output * 로그인한 회원들의 권한들
function login_roles(){
	var roles_out = [];
	$.ajax({
		type : "GET",
		url : "/api/login/roles",
		async : false,
        contentType: 'application/json; charset=utf-8',
		success : function(roles) {
			for(var i = 0 ; i < roles.length; i++)
				roles_out.push(roles[i]);
		},
		error : function(xhr, status, error) {
		}
	});
	return roles_out;
}

//로그인한 회원의 권한과 일치하는지 확인
//input * 비교할 권한(DB/ 회원권한: ROLE_LIST의 role)
//process * 1.회원번호를 찾아 회원에 해당되는 권한들을가져옴. 
//process * 2.가져온 권한에 입력된 권한이 속하는지 확인
//output * 로그인 회원의 권한일치여부
function has_roles(role){
	var is_role = false;
	$.ajax({
		type : "GET",
		url : "/api/login/roles",
		async : false,
      contentType: 'application/json; charset=utf-8',
		success : function(roles) {
			for(var i = 0 ; i < roles.length; i++){
				if(role == roles[i])
					is_role = true;
			}
		},
		error : function(xhr, status, error) {
		}
	});
	return is_role;
}

//접속한 기기의 종류를 가져온다.
//input * 
//process * 현재 접속한 기기의 종류를 찾음
//output *  접속 기기의 종류(pc, moibile ...)
function getcurrentConnectType(){
	var connect_type_out ='';
	$.ajax({
		type : "GET",
		url : "/api/member/connect_type",
		async : false,
		success : function(connect_type) {
			connect_type_out = connect_type;
		},
		error : function(xhr, status, error) {
		}
	});
	return connect_type_out;
}

//input * 
//process * 회원 번호를 찾아, 사용기기로 이미 등록돼있는 mac address를 가져옴
//output *  사용기기로 이미 등록돼있는 mac address
function getEnrolledMacAddress(){
	var mac_address_out ='';
	$.ajax({
		type : "GET",
		url : "/api/member/mac_address",
		async : false,
		success : function(mac_address) {
			mac_address_out = mac_address;
		},
		error : function(xhr, status, error) {
		}
	})
	return mac_address_out;
}

//페이지 이동없이 ajax를 통해 로그인 처리만 한다. 
//input *  email: 이메일(DB/ 이메일 : USER의 email)
//input *  password: 비밀번호(DB. 비밀번호 : USER의 password)
//process * 회원정보를 찾아 로그인 처리
//output * 로그인 세션정보 획득 및 유지
function security_login_ajax(email, password){
		//로그인 정보와 로그인 접근 form 
		var f = document.createElement("form");
		f.name = "temp";
	    var elem = document.createElement("input");
	    elem.setAttribute("type", "hidden");
	    elem.setAttribute("name", "email");
	    elem.setAttribute("value", email);
	    f.appendChild(elem);
	    var elem = document.createElement("input");
	    elem.setAttribute("type", "hidden");
	    elem.setAttribute("name", "password");
	    elem.setAttribute("value", password);
	    f.appendChild(elem);
		var fd = new FormData(f);
		$.ajax({
			url : "/security_login_process",
			type : "POST",
			data :  fd,
			enctype : 'multipart/form-data',
			processData : false,
			contentType : false,
			cache : false,
			async : false,
			success : function() {
				setClientPcToken();//중개사일경우 pc인증 절차를 수행
			},
			error : function(xhr, status, error) {
			}
		});
}

/************************** 기기인증 ***********************/
//맥주소인증후의 토큰값이 유효한지확인
//input *  client의 인증 token
//process * 서버의 db로 등록된 토큰값과 클라이언트의 토큰값이 일치하는지 확인한다. 기기종류에 맞는 토큰값비교(DB. 서버토큰 : USER_AGENT의  pc_token 또는 mobile_token)
//output * 토큰일치여부
function isEffectivenessAboutTokenAndRole(){
	var out_data = false;
	$.ajax({
		type : "GET",
		url : "/api/member/agent/token_effectiveness?type=" + getCookie("currentConnectType"),
		async : false,
		success : function(check) {
			if(check)
				out_data = true;
		},
		error : function(jqXHR, textStatus, errorThrown) {
		}
	});
	return out_data;
}

//서버에 저장된 유효한 pc토큰을 가져온다.
//input *  
//process * 회원 번호를 찾아 pc접속시의 인증토큰값을 가져옴(DB. 서버토큰 : USER_AGENT의  pc_token)
//output * pc토큰(DB. 서버토큰 : USER_AGENT의  pc_token)
function getPcToken(){
	var out_data = "";
	$.ajax({
		type : "GET",
		url : "/api/member/agent/pc_token",
		async : false,
		success : function(check) {
			out_data = check;
		},
		error : function(jqXHR, textStatus, errorThrown) {
			out_data ="";
		}
	});
	return out_data;
}

//중개사의 맥주소를 가져온다.
//input *  
//process * 중개사의 pc에서 실행하고 있는 웹api로 부터 mac address를 획득
//output * 중개사 pc의 mac address
function getClientMacAddress(successFunc) {
	var out_data = 'err';
	try {  
		 $.ajax({
			async : false,
	        url: "http://localhost:49151/client_macaddress",
			success : function(data) {//msg를 받는 것이 성공하면
				out_data = data;
				if(null != successFunc)
					successFunc();
			},
			error : function(xhr, status, error) {
			}
	    });
	} catch (exception) { }
	return out_data;
} 

//중개사의 pc 맥주소 인증토큰을 설정
//input *  
//process1 * 맥주소인증이 되면 토큰을 생성하여 서버의 pc토큰(DB. 서버토큰 : USER_AGENT의  pc_token)과 클라이언트 쿠키의 pc토큰을 같은값으로 설정
//process2 * 맥주소인증이 안되면 상황에 맞는 페이지안내 및 이동
//output *  
function setClientPcToken(){
	//로그인이후 하드웨어인증관련 설정
	if(has_roles("ROLE_AGENT")){//중개사 이면
   		document.location.href="/member/agent/hardware_enroll";
		current_connect_type = getcurrentConnectType();//회원이 접속한 연결 기기 종류를 가져옴
		enrolled_mac_address = getEnrolledMacAddress();//회원의 등록된 맥주소를 가져옴
		if(current_connect_type == 'pc'){
			setCookie("currentConnectType", "pc", 1);
			//프로그램이 설치안됐으면(중개사 웹프로그램과의 통신에러)
			var current_mac_address = getClientMacAddress(null);
			if(isEffectivenessAboutTokenAndRole()){//이전에 인증한 토큰이 쿠키에 존재하고, 다른pc에서 인증하지않아 db에 있는 토큰값과 일치하면 
				//인증할 필요없이 바로 사용가능
		   		document.location.href="/";
			}else if(current_mac_address == 'err'){//설치프로그램에 대한 접근에러시, 그리고 전에 해당pc로 인증한적이 없으면(해당pc와 토큰일치값도없으면)
				alert('중개사 업무 기능을 이용하기위해서는 pc인증 프로그램을 설치해야 됩니다.');
		   		document.location.href="/member/agent/hardware_enroll";
			}else if((enrolled_mac_address).length == 0){//등록된 맥주소가 없으면 
		   		alert('중개사 업무 기능을 이용하기위해서는 pc를 인증해야 합니다.');
		   		document.location.href="/member/agent/hardware_enroll";
			}else if(enrolled_mac_address != current_mac_address){
		   		alert('인증된 pc로 로그인하지 않으면 기능이 제한될 수 있습니다.');
			}else{
				alert('중개사의 업무를 시작합니다. pc인증 성공');
				var pc_token = getUUID();
				setCookie("pc_token", pc_token , 1);//쿠키(사용자)에 토큰 저장
				jQuery.ajax({
					type : "PUT",  
					contentType: 'application/json; charset=utf-8',
				    async: false,
					url : "/api/member/agent/pc_token?pc_token=" + pc_token,
					success : function() {
					},
					error : function(xhr, status, error) {
					}
				});
			}
		}else if(current_connect_type == 'mobile'){
			setCookie("currentConnectType", "mobile", 1);
		}
	}
	return;
}

//uuid를 획득
function  getUUID(){
    var dt = new Date().getTime();
    var uuid = 'xxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (dt + Math.random()*16)%16 | 0;
        dt = Math.floor(dt/16);
        return (c=='x' ? r :(r&0x3|0x8)).toString(16);
    });
    return uuid;
}

<!-- 카카오톡 로그인 -->
/************************** Kakao login***********************/
// 사용할 앱의 JavaScript 키를 설정해 주세요.
function loginWithKakao() {
    // 로그인 창을 띄웁니다.
    Kakao.Auth.login({
  	  success: function(authObj) {
  	        // 로그인 성공시, API를 호출합니다.
  	        Kakao.API.request({
  	          url: '/v1/user/me',
  	          success: function(response) {
  	        	 $('#inforKakao').val(JSON.stringify(response));//컨트롤러로 넘겨줌
				document.joinKakao.submit();
  	          },
  	          fail: function(error) {
  	          }
  	        });
  	      },
  	      fail: function(err) {
  	      }
    });
};

// 카카오 로그아웃버튼생성
function KKlogout() {
	// 로그인 창을 띄웁니다.
	Kakao.Auth.logout(function(obj) {
		if (obj == true) {
		} else {
		}
	});
}
	
<!-- 페이스북로그인 -->
/************************** facebook  login***********************/
function statusChangeCallback(response) {
	console.log('statusChangeCallback');
	console.log(response);
	if(response.status === 'connected') {
		FB.api('/me', function(response) {
			$('#inforFacebook').val(JSON.stringify(response));//컨트롤러로 넘겨줌
		});
	}else if(response.status === 'not_authorized'){
	  // 페이스북에는 로그인 했으나, 앱에는 로그인이 되어있지 않다.
	}else{
	  // 페이스북에 로그인이 되어있지 않다. 따라서, 앱에 로그인이 되어있는지 여부가 불확실하다.
	}
}
function checkLoginState() {
	FB.getLoginStatus(function(response) {
		statusChangeCallback(response);
	});
}
window.fbAsyncInit = function() {
	FB.init({
		appId      : '<%=GlobalValue.facebookApi%>',
		cookie     : true,  // 쿠키가 세션을 참조할 수 있도록 허용
		xfbml      : true,  // 소셜 플러그인이 있으면 처리
		version    : 'v2.1' // 버전 2.1 사용
	});
	FB.getLoginStatus(function(response) {
		statusChangeCallback(response);
	});
};
  
// 비동기적 호출
(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) 
		return;
	js = d.createElement(s); js.id = id;
	js.src = "//connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
  
 //로그인 처리
function loginWithFacebook(){
	FB.login(function(){
		FB.getLoginStatus(function(){
			FB.getLoginStatus(function(response) {
				statusChangeCallback(response);
					setTimeout(function() {
						if($('#inforFacebook').val() !="")
					document.joinFacebook.submit();
				}, 1000);
			});
		});
	}, {scope: 'public_profile'});
}

<!-- 전체 로그아웃  -->
/************************** facebook logout ***********************/
window.fbAsyncInit = function() {
	FB.init({
		appId : '<%=GlobalValue.facebookApi%>',
		cookie : true, // 쿠키가 세션을 참조할 수 있도록 허용
		xfbml : true, // 소셜 플러그인이 있으면 처리
		version : 'v2.1' // 버전 2.1 사용
	});
	FB.getLoginStatus(function(response) {
		statusChangeCallback(response);
	});
};
// SDK를 비동기적으로 호출
(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id))
		return;
	js = d.createElement(s);
	js.id = id;
	js.src = "//connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
function FBlogout() {
	FB.logout(function(response) {
	});
}

/************************** All Logout***********************/
function logout() {
	KKlogout();
	FBlogout();
	alert("로그아웃 되었습니다.");
	setTimeout(function() {
		location.href = "/logout/gnbang"
	}, 1000);
}