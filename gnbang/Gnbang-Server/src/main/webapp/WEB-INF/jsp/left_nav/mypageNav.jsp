<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

	<div class="my_sidebar box fl">
		<ul class="lnb">
			<li id="select_mypage"><a href="/member/mypage"> <span>회원정보
						수정</span></a></li>
			<li id="select_password" ><a href="/member/agent/password/modify"> <span>비밀번호 변경</span></a></li>
			<li id="select_interest" ><a href="/member/agent/interest"><span>관심매물관리</span></a></li>
			<li id="select_picture" ><a href="/member/agent/picture"><span>매물사진관리</span></a></li>
			<li id="select_mypoint" ><a href="/member/agent/password/modify"><span>포인트 조회</span></a></li>
			<li id="select_manage_room" ><a href="/member/agent/password/modify"><span>방등록 관리</span></a></li>
			<li id="select_zzim"  class="/member/agent/password/modify"><a href="/room/zzim"><span>찜한방 </span></a></li>
			<li id="select_recent"  class="last"><a href="/room/recently"><span>내가 본 방</span></a></li>
		</ul>
	</div>
	
<!-- 현재 메뉴표시 -->
<script>
	/* //좌측 메뉴의 선택 표시 */
	$(document).ready(function(){
		//전체 클래스삭제
		$("#select_mypage").removeClass('first current');
		$("#select_password").removeClass('current');
		$("#select_interest").removeClass('current');
		$("#select_picture").removeClass('current');
		$("#select_mypoint").removeClass('current');
		$("#select_manage_room").removeClass('current');
		$("#select_zzim").removeClass('current');
		$("#select_recent").removeClass('current');
		setCurrentMenu();//현재 메뉴 표시
	})
	//현재 메뉴 표시
	function setCurrentMenu(){
		//선택메뉴만 클래스 추가
		if('${selectPage}' == 'password')
			$("#select_password").addClass('first current');
		else if('${selectPage}' == 'mypage')
			$("#select_mypage").addClass('first current');
		else if('${selectPage}' == 'interest')
			$("#select_interest").addClass('first current');
		else if('${selectPage}' == 'picture')
			$("#select_picture").addClass('first current');
		else if('${selectPage}' == 'interest_detail')
			$("#select_interest").addClass('first current');
	}
</script>