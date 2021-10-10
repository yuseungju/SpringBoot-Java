<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>

	<div class="tabmenu">
		<div class="tabmenu">
            <div class="inner">
              <ul>
                <li class="item1" id="left_item1">
                  <a href="/search"><span>방찾기</span></a>
                </li>
                <!--  <li class="item2 longtext" id="left_item2">
                  <a href=""><span>지하철로찾기</span></a>
                </li>
                <li class="item3 longtext" id="left_item3">
                  <a href=""><span>테마로찾기</span></a>
                </li> -->
                <li class="item4" id="left_item4"> 
                  <a href="#" onclick ="toZzim(); return false;"><span>찜한방</span></a>
                </li>
                <li class="item5" id="left_item5">
                   <a href="#" onclick ="toRecent(); return false;"><span>내가본방</span></a>
                </li>
              </ul>
            </div>
       </div><!--//tabmenu-->
	</div>
	
<!-- 현재 메뉴 표시-->
<script>
	/* //좌측 메뉴의 선택 표시 */
	$(document).ready(function(){
		//메뉴 선택 초기화
		$("#left_item1").removeClass('current');
		$("#left_item2").removeClass('current');
		$("#left_item3").removeClass('current');
		$("#left_item4").removeClass('current');
		$("#left_item5").removeClass('current');
		setCurrentLeftMenu();//현재 메뉴 표시
	})
	//현재 메뉴 표시
	function setCurrentLeftMenu(){
		if('${selectPage}' == 'zzim')//찜 메뉴표시
			$("#left_item4").addClass('current');
		else if('${selectPage}' == 'recent')//최근 본방 메뉴표시
			$("#left_item5").addClass('current');
		else if('${selectPage}' == 'search')//기본 메뉴 검색 메인화면
			$("#left_item1").addClass('current');
	}
</script>
<!-- 로그인 확인후 이동 -->
<script>	
	function toZzim(){
		if(<%= request.isUserInRole("ROLE_AGENT") %> || <%= request.isUserInRole("ROLE_USER") %>
		|| <%= request.isUserInRole("ROLE_LESSOR") %>) //로그인했으면
			document.location.href="/room/zzim";//찜화면으로
		else
			alert('로그인이 필요한 메뉴입니다.')
	}
	function toRecent(){
		if(<%= request.isUserInRole("ROLE_AGENT") %> || <%= request.isUserInRole("ROLE_USER") %>
		|| <%= request.isUserInRole("ROLE_LESSOR") %>) //로그인했으면
			document.location.href="/room/recently";//찜화면으로
		else
			alert('로그인이 필요한 메뉴입니다.')
	}
</script>