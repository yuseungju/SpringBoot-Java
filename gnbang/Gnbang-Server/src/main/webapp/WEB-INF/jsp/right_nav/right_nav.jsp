<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
	<div class="side_nav" id="side_nav">
		<div class="container">
			<sec:authorize access="isAnonymous()">
				<ul class="profile sidenav_list">
					<li class="d1  pic"><span><img 
							 alt="프로필사진" /></span></li>
					<li class="d1 text"><a href="#" onClick="loginPopUp(); return false;"><span class="txt1">로그인</span></a>
						<a href="/join/user"><span class="txt1">회원가입</span></a></li>
				</ul>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<ul class="profile sidenav_list">
					<li class="d1 pic"><span><img 
							src="${pageContext.request.contextPath}/images/common/account50_mint.png" alt="프로필사진" /></span></li>
					<li class="d1 text"><a href="/member/mypage"><span class="txt1">
					<sec:authentication property="principal.realname" /></span></a></li>
				</ul>
			</sec:authorize>
			<ul class="gnb sidenav_list">
				<li class="d1"><a href="/search"><span class="txt">방찾기</span></a></li>
				<li class="d1"><a href="/room/enroll"><span class="txt">방등록</span></a></li>
			<!-- 	<li class="d1 consult"><a href="/consult"><span class="txt1">
				상담신청:</span><span class="txt">방구해요</span></a></li> -->
			</ul>
			<sec:authorize access="isAuthenticated()">
				<ul class="util sidenav_list">
						<li class="d1"><a href="/room/zzim"><span class="txt">찜한방</span></a></li>
						<li class="d1"><a href="/room/recently"><span class="txt">내가본방</span></a></li>
						<li class="d1"><a href="/member/mypage"><span class="txt">마이페이지</span></a></li>
				</ul>
			</sec:authorize>
				<ul class="util2 sidenav_list">
					<li class="d1"><a href="#"><span class="txt">공지사항</span></a></li>
					<li class="d1"><a href="#"><span class="txt">자주하는 질문</span></a>
					</li>
					<li class="d1"><a href="#"><span class="txt">이용안내</span></a></li>
					<sec:authorize access="isAnonymous()">
						<li class="d1"> <a href="#" onClick="loginPopUp(); return false;"><span class="txt">로그인</span></a></li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li class="d1"><a href="#"  onClick="logout(); return false;"><span class="txt1">로그아웃</span></a></li>
					</sec:authorize>
			</ul>
			<a href="#content_wrap" id="sidenav_close" class="sidenav_close"><span
				class="blind">메뉴닫기</span></a>
		</div>
	</div>
	<!--nav마감-->
	