<%@ page language ="java" contentType="application/javascript; charset=UTF-8" pageEncoding="UTF-8"%>

//로그인 회원의 연락처를 가져옴 
//input * 
//process * 로그인 회원의 연락처를 찾는다.
//output * 결과에 따른 페이지이동 OR 로그인 회원 연락처(DB/ 연락처 : USER의 phone)
function getPhoneAboutLoginNo(){
	var out_date = "";
	$.ajax({
		   type : "GET",
	       url: "/api/member/phone",
	       async: false,
	       success: function(phone) {
	    	   out_date = phone;
	       },
	       error: function(jqXHR, textStatus, errorThrown) {
	      		alert('다시 로그인해주세요.');
	       		document.location.href="/";
	       }
	     });
	return out_date;
}
//로그인 회원의 연락처를 수정
//input *  phone: 입력 연락처(DB/ 연락처 : USER의 phone)
//process * 회원 연락처를 수정
//output * 결과에 따른 페이지이동
function updatePhoneAboutLoginNo(phone){
	$.ajax({
		type : "POST",
	    url: "/api/member/phone?phone=" + phone,
	    async: false,
	    success: function() {
        	window.location.reload();
	    },
	    error: function(jqXHR, textStatus, errorThrown) {
	   		alert('다시 로그인해주세요.');
	    	document.location.href="/";
	    }
	  });
}
//회원의 번호로 프로필 사진 경로를 가져온다.
//input *  user_no: 회원번호(db/ 회원번호 : ROOM_PHOTO의 user_no)
//process *
//output * 회원의 프로필 사진경로(db/ 사진경로: USER의 photo_url)
function getProfilePath(user_no){
	if (typeof user_no == "undefined") 
		user_no ="";
	var path ='';
	$.ajax({
		url:"/api/member/photo?user_no="+ user_no,
		type: "GET", 
      async: false,
      success: function (data) {
      	path = data;
      },
      error:function(request,status,error){
      }
	});
	return path;
}

//프로필 사진 경로를 가져와 img tag에 보여준다.
//input *  img_tag의 id
//process1 * 회원번호가 있으면 회원번호, 없으면 로그인한 회원의 번호를 가져옴(db/ 회원의 번호 : USER의 no)
//process2 * 회원번호의 프로필사진경로를 가져옴(db/ 프로필사진경로 : USER의 photo_url)
//process3 * 가져온 사진경로를 img 태그의 src에 설정
//output * 
function setProfilePhoto(contain_id, user_no){
	if (typeof user_no == "undefined") 
		user_no ="";
	var path = getProfilePath(user_no);
	if(10 < path.length)//프로필사진이 있으면 (존재하는 url의 길이는 최소 10을 넘는다.)
		$('#' + contain_id).attr('src' , "http://112.175.245.57" + path);
}

//로그인한 회원의 비밀번호가 입력 비밀번호와 같은지 확인
//input *  input_password: 입력 비밀번호(DB/ 입력비밀번호: USER의 password)
//process * 입력비밀번호와 현재 등록된 비밀번호를 비교하여 같은지 확인
//output * 결과에 따른 페이지이동 OR 일치여부값
function isSamePassword(input_password){
	//비밀번호 일치 여부확인
	var same = false;
	$.ajax({
	   type : "GET",
       url: "/api/member/check_password?password=" + input_password,
       async: false,
       success: function(check) {
       	if(check == -1){
       		same = false;
       	}else if(check == 0){
       		alert('다시 로그인해주세요.');
       		document.location.href="/";
       	}else{
       		same = true;
       	}
       },
       error: function(jqXHR, textStatus, errorThrown) {
      		alert('다시 로그인해주세요.');
       		document.location.href="/";
       }
     });
	 return same;
}
//회원의  비밀번호를 수정한다.
//input *  new_password: 새로 바꿀 비밀번호(DB/ 새비밀번호 : USER의 password)
//process * 비밀번호를 인코딩하여 수정한다.
//output * 결과에 따른 페이지이동
function updatePasswordAboutLoginNo(new_password){
	//비밀번호 수정
	$.ajax({
		type : "PUT",
		url : "/api/member/password?password=" + new_password,
		async : false,
		success : function(check) {
			if(check){
	       		alert('비밀번호 수정이 완료되었습니다.');
	       		document.location.href="/member/agent/mypage";
	       	}else{
	       		alert('다시 로그인해주세요.');
	       		document.location.href="/";
	       	}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert('다시 로그인해주세요.');
       		document.location.href="/";
		}
	});
}
//이메일에 대한  비밀번호를 수정한다.
//input *  target_email: 비밀번호 수정이 적용되는 이메일(db/  이메일 : USER의 email)
//input *  new_password: 새로 바꿀 비밀번호(db/ 새비밀번호 : USER의 password)
//process * 비밀번호를 인코딩하여 수정한다.
//output * 결과에 따른 페이지이동
function updatePasswordAboutEmail(target_email, new_password){
	if(typeof target_email != "undefined" &&  typeof new_password != "undefined" ){
		$.ajax({
			type : "PUT",
			url : "/api/member/password?email="+ target_email +"&password=" + new_password,
			async : false,
			success : function(check) {
				if(check){
		       		alert('비밀번호 수정이 완료되었습니다. 다시 로그인 해주세요.');
		       		document.location.href="/";
		       	}else{
		       		alert('다시 시도해주세요.');
		       		document.location.href="/";
		       	}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert('다시 시도해주세요. 서버연결불가');
		   		document.location.href="/";
			}
		});
	}
}


