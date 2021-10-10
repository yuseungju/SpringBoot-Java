<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!-- <body class="room sub agent"> -->
	 <!--content_wrap-->
	<div id="content_wrap" class="clearfix">
		<div class="content">
			<div class="page">
				<div class="page_header">
					<h2>
						<span>방등록</span>
					</h2>
				</div>
				<!--page_header마감-->
				<div class="content_header room_header">
					<div class="container">
						<div class="inner">
							<div class="pic">
								<p>
									<img id="profile" src="${pageContext.request.contextPath}/images/common/account_120.png"/>
								</p>
								<p class="name"><sec:authentication property="principal.realname"/></p>
								<p class="desc">
									<strong class="txt1">100개</strong> 방 등록
								</p>
							</div>
							<div class="guide">
								<ul>
									<li><strong>정책.</strong></li>
									<li>정책</li>
									<li>정책.</li>
	
								</ul>
							</div>
						</div>
	
					</div>
				</div>
				<!--room_header마감-->
				<div class="panel">
					<!--content_body-->
					<div class="content_body bg shadow rwa">
						<h3 class="blind">방등록 3-방등록 완료</h3>
						<div class="step_section section">
							<ul class="step_wrap">
								<li class="step  "><span class="icon step1 "></span><span
									class="txt"><span class="list_num">1</span>주소중복확인</span></li>
								<li class="step "><span class="icon step3 "></span><span
									class="txt"><span class="list_num">2</span>정보입력</span></li>
								<li class="step current"><span class="icon step4 "></span><span
									class="txt"><span class="list_num">3</span>방등록완료</span></li>
							</ul>
						</div>
						<h4 class="blind">방등록 결과</h4>
						<div class="container result guide_section section ">
							<p>감사합니다.</p>
							<p>주소 : 서울시 강남구 삼성동 50 123-446</p>
							<p>강남방에 방등록이 완료되었습니다..</p>
							<p class="strong">
								강남방 <span class="tel">02-568-2453</span>
							</p>
						</div>
					</div>
					<!--content_body마감-->
					<!--버튼-->
					<div class="row btn_wrap mt">
						<div class="button">
							<div class="btn close close_btn">
								<button onclick="location.href='/room/enroll' ">
									<span>메인으로 이동</span>
								</button>
							</div>
							<div class="btn submit">
								<button onclick="location.href='/member/mypage'">
									<span>마이페이지로 이동</span>
								</button>
							</div>
						</div>
					</div>
					<!--버튼 마감-->
				</div>
				<!--panel마감-->
			</div>
			<!--page마감-->
	
		</div>
		<!--content마감-->
	</div>
	<!--content_wrap마감-->
	
<script>
	$(document).ready(function() { 
		//프로필 사진 설정
		setProfilePhoto('profile');
	});
</script>
<!-- 뒤로가기 방지 -->
<script>
	 $(document).keydown(function(e){ //백스페이스 뒤로가기 방지
	    if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){       
	        if(e.keyCode === 8){   
	        return false;
	        }
	    }
	});
	document.oncontextmenu=function(){//우클릭 뒤로가기 방지
		return false;
	}
	history.pushState(null, null, location.href);//브라우저 버튼 뒤로가기 방지
	window.onpopstate = function(event) {
		history.go(1);
	}; 
</script>
