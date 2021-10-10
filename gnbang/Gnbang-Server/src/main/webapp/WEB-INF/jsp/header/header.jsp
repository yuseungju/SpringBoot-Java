<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
	<!--header-->
	<div id="header">
		<div class="header_inner ">
			<div class="logo fl">
				<h1> 
					<a href="/"><span class=""><img src="${pageContext.request.contextPath}/images/common/logo.jpg" alt="강남방:강남에서 방구할 때 강남방" /></span></a>
				</h1>
			</div>
			<!--gnb_wrap -->
			<div class="gnb_wrap fr">
				<div id="nav" class="fl">
                    <ul class="gnb" >
                      <!--현재페이지에 current클래스 추가-->
                        <!--li class="fl d1 current"-->
                        <li class="fl d1" id="head_item1">
                            <a href="/search"><span class="txt">매물검색</span></a>
                        </li>
				 		<sec:authorize access="hasRole('ROLE_AGENT')">
	                        <li class="fl d1" id="head_item2">
	                         <a href="#" onclick="toEnroll(); return false;"><span class="txt">매물등록</span></a>
	                        </li>
                        </sec:authorize>
                        <!-- <li class="fl d1 consult" id="head_item3">
                        /consult<a href="/"><span class="txt1"><span class="blind">상담신청</span></span><span class="txt">방구해요</span></a>
                        </li> -->
                    </ul>
                </div><!--nav마감-->

				<sec:authorize access="isAnonymous()">
					<!--로그아웃상태에서 보여지는 .top_menu-->
					 <div class="top_menu fl show_logout">
                            <ul>
                                <li class="npl fl d1" id="head_item4">
                                    <a href="/join/user"><span class="txt">회원가입</span></a>
                                </li>
                                <li class="fl d1 login">
                                    <a href="#" onClick="loginPopUp(); return false;"><span class="txt">로그인</span></a>
                                </li>
                            </ul>
                      </div>
				</sec:authorize>
				<!--로그아웃상태에서 보여지는 .top_menu 마감-->

				<!--로그인상태에서 보여지는 .top_menu-->
				<sec:authorize access="isAuthenticated()">
					<div class="top_menu fl show_login">
						<ul>
							<li class="login_con class  npl last  fl d1"><a href=""><span
									class="profile fl"><img id ="header_profile"  onerror="this.src='${pageContext.request.contextPath}/images/common/account30.png'"
										src="${pageContext.request.contextPath}/images/common/account30.png"
										alt="프로필사진" /></span><span class="txt fl"><sec:authentication
											property="principal.realname" /></span></a>
								<div class="d2_wrap">
									<ul class="d2">
										<li><a href="/room/zzim"><span>찜한방</span></a></li>
										<li><a href="/room/recently"><span>내가본방</span></a></li>
										<li class="my"><a href="/member/mypage"><span>마이페이지</span></a></li>
										<li class="logout"><a href="#"
											onClick="logout(); return false;"><span>로그아웃</span></a></li>
									</ul>
								</div></li>
						</ul>
					</div>
				</sec:authorize>
				<!--top_menu마감-->
			</div>
			<!--gnb_wrap마감 -->
			<!--search_form_wrap-->
			<div class="search_form_wrap">
				<div class="inner">
					<div class="search_bar fl">
						<div class="search_text fl">
							<label for="search_input" class="blind">방검색</label> 
							<input
								type="text" id="search_input"  autocomplete="off" 
								placeholder="동,지하철역, 매물번호를 입력해주세요" onkeypress="if(event.keyCode==13) {searchIntegrationAboutId('search_input');}"/>
						</div>
						<div class="search_btn fl">
							<button value="검색" onclick ="searchIntegrationAboutId('search_input')">
								<span class="sbicon"></span>
							</button>
						</div>
					</div>
				</div>
			</div>
			<!--search_form_wrap 마감-->
			<!--m_gnb_wrap -->
			<!--p class="m_search_btn  m_btn fl open"일경우 닫기버튼 표시-->
			<div class="m_gnb_wrap opened fr" id="mobile_search_text">
				<p class="m_search_btn  m_btn fl">
					<a href="#m_search_form_wrap" class="show_search" title="통합검색보기"><span
						class="blind">통합검색보기</span></a> <a href="#" class="close_search"
						title="통합검색닫기"><span class="blind">통합검색닫기</span></a>
				</p>
				<p class="m_search_btn  m_btn fl">
					<span class="blind">통합검색닫기</span>
				</p>
				<p class="m_menu  m_btn fl">
					<a href="#side_nav" title="메뉴보기"><span class="blind">메뉴보기</span></a>
				</p>
			</div>
			<!--search_form_wrap-->
			<!--  div class="m_search search_form_wrap opened_search" 표시-->
			<div class="m_search search_form_wrap opened_search">
				<div class="inner">
					<div class="search_bar fl">
						<div class="search_text fl">
							<label for="m_search_input"  class="blind">방검색</label> <input
								type="text" id="m_search_input"   onkeypress="if(event.keyCode==13) {searchIntegrationAboutId('m_search_input');}"
								placeholder="동,지하철역, 매물번호를 입력해주세요">
						</div>
						<div class="search_btn fl">
							<button onclick ="searchIntegrationAboutId('m_search_input')" value="검색">
								<span class="sbicon"></span>
							</button>
						</div>
					</div>
				</div>
			</div>
			<!--search_form_wrap 마감-->

		</div>
		<!--header_inner마감-->
	</div>
	<!--header마감-->
<script>
	//방등록페이지로
	function toEnroll(){
		if(<%=request.isUserInRole("ROLE_AGENT") %> || <%=request.isUserInRole("ROLE_USER") %> )//중개사 또는 일반회원로그인시에
			document.location.href = "/room/enroll";
		else
			alert('회원만 사용가능합니다.');
	}
</script>
<script>
/* //상단 메뉴의 선택 표시 */
	$(document).ready(function(){
		//메뉴 선택 초기화
		if('${selectPage}' != ''){//찜 메뉴표시
			$("#head_item1").removeClass('current');
			$("#head_item2").removeClass('current');
			$("#head_item3").removeClass('current');
			$("#head_item4").removeClass('current');
		}
		setCurrentHeadMenu();//현재 메뉴 표시
		setProfilePhoto("header_profile");
	})
	//현재 메뉴 표시
	function setCurrentHeadMenu(){
		if('${selectPage}' == 'search')//방검색 메뉴 선택시
			$("#head_item1").addClass('current');
		else if('${selectPage}' == 'enroll')//방등록 메뉴 선택시
			$("#head_item2").addClass('current');
		else if('${selectPage}' == 'consult')//방구해요 메뉴 선택시
			$("#head_item3").addClass('current');
		else if('${selectPage}' == 'join')//가입 메뉴 선택시
			$("#head_item4").addClass('current');
	}
</script>

<!-- 검색바 자동완성 기능 -->
<script>
	$(document).ready(function(){
		autoSet("search_input");
		autoSet("m_search_input");
	})
	/************************** auto complete ***********************/
	var filterUrl ='';//상세검색 체크url
	var sortUrl = '';//정렬
	var searchUrl='';//검색 메인 url(지도위치/ 매물번호/ 지하철번호의 정보포함)
	var beforeSearchUrl='';//이전 검색 메인 url(지도위치/ 매물번호/ 지하철번호의 정보포함)
	function autoSet(id){
		$("#"+id).keyup(
				function(event) {
					//값을 세팅
					currentWord = $("#"+id).val();
					if (!currentWord)//입력값이 없으면
						return;
					jQuery.ajax({
						type : "GET",
						dataType : "json",
						url : "/api/search/quick/autoword?searchWord=" + encodeURI(encodeURIComponent(currentWord)),
						async : false,
						success : function(data) {//msg를 받는 것이 성공하면
							autoWord = new Array();
							var infor = data.autoWordList;
							for (var i = 0; i < infor.length; i++)
								autoWord.unshift((infor[i].firstWord + " "
										+ infor[i].secondWord + " "
										+ infor[i].thirdWord).trim());
							
							$("#"+id).autocomplete({
								source : autoWord,
								select: function(event, ui) {
							        for (var i = 0; i < infor.length; i++){
							        	if(autoWord[infor.length - i -1] == ui.item.label){//선택한 단어와 가져왔던 자동완성이 일치하면
							        		//페이지 표시 초기화
							        		if(infor[i].kind == 'addressCode'){
												var local_name = infor[i].secondWord + " " + infor[i].thirdWord;//구와 동이름만으로  지역명을 구분(시이름은 필요없음)
							        			if(searchUrl != ''){//검색메인화면->검색메인화면(ajax호출)
							        				beforeSearchUrl = searchUrl;
							        				searchUrl = "/api/search/address?addr="+infor[i].code;
							        				posChangeSubmit(1);//검색
							        				expressMap("local" , infor[i].thirdWord);
							        				showLocal();//검색한 지역의 지역명 표시
							        			}else {//현재 화면->검색메인화면(새 페이지 호출)
								        			location.href = "/search/address?addr="+infor[i].code + filterUrl + sortUrl + "&location_name=" + local_name;
								        		}
							        		}else if(infor[i].kind == 'roomNo'){//방 상세보기 페이지 이동시
								        		window.open("/room/"+infor[i].code);
							        		}else if(infor[i].kind == 'bunji'){//매물 번지수 페이지 이동시
							        			//번지수 검색에 대한 자동완성은 없음(중개사만 아는 기능)
							        		}else if(infor[i].kind == 'metro'){ 
												var metro_name = infor[i].firstWord;
							        			if(searchUrl != ''){//검색메인화면->검색메인화면(ajax호출)
							        				beforeSearchUrl = searchUrl;
							        				searchUrl = "/api/search/metro?metro_no=" + infor[i].code;
							        				posChangeSubmit(1);//검색
							        				expressMap("metro" , metro_name);
							        				showLocal();//검색한 지역의 지역명 표시
							        			}else {//현재 화면->검색메인화면(새 페이지 호출)
								        			//alert("/search/metro?metro_no=" + infor[i].code + p);
									        		location.href ="/search/metro?metro_no=" + infor[i].code + filterUrl + sortUrl+ "&location_name=" + metro_name;
							        			}
							        		}
										    break;
							        	}
							        }
							        //autocomplete reset(prevent double clicked)
							        $("#"+id).autocomplete({
										source : new Array()
									});
							    }
							});
						},
						error : function(xhr, status, error) {
						}
				});
		});
	}
	//id에 존재하는 단어값으로 통합검색
	function searchIntegrationAboutId(word_id){
		//모바일의 검색텍스트창을 닫기
		$("#mobile_search_text").removeClass("opened_search");
		
		//검색 실행
		var search_word = $("#"+word_id).val();
		if(search_word.length < 2){
			return;
		}
		if((/^[0-9]+$/).test(search_word)){//정수형태이면
    		window.open("/room/"+search_word);
		} else if(search_word.charAt(0)== '#'){//번지검색이면
			expressMap("bunji", "");//검색 지역 반경 초기화
			showLocal();//검색한 지역의 지역명 표시
		} else if(search_word.charAt(search_word.length - 1) == '역'){//지하철역검색이면
			$("#search_type_name").text(search_word  +" 인근 최신방");//검색 종류  출력
			expressMap("metro", search_word);//검색 지역 반경 초기화
			showLocal();//검색한 지역의 지역명 표시
		} else{//지역명검색이면
			$("#search_type_name").text(search_word  +" 최신방");//검색 종류  출력 
			expressMap("", "");//검색 지역 반경 초기화
			showLocal();//검색한 지역의 지역명 표시
		}
		
		if(searchUrl != ''){//검색메인화면->검색메인화면(ajax호출)
			beforeSearchUrl = searchUrl;
			searchUrl = "/api/search/quick/integration?searchWord=" + encodeURI(encodeURIComponent(search_word));
			posChangeSubmit(1);//검색
		} else {//현재 화면->검색메인화면(새 페이지 호출)
			beforeSearchUrl = searchUrl;
			searchUrl = "/search/quick/integration?searchWord=" + encodeURI(encodeURIComponent(search_word));
		}
	}
	//단어값으로 통합검색
	function searchIntegrationAboutWord(search_word){
		if(search_word.length < 2){
			return;
		}
		if((/^[0-9]+$/).test(search_word)){//정수형태이면
    		window.open("/room/"+search_word);
		} else if(search_word.charAt(0)== '#'){//번지검색이면
			expressMap("bunji", search_word);//검색 지역 반경 초기화
			showLocal();//검색한 지역의 지역명 표시
		} else if(search_word.charAt(search_word.length - 1) == '역'){//지하철역검색이면
			expressMap("metro", search_word);//검색 지역 반경 초기화
			showLocal();//검색한 지역의 지역명 표시
		} else{//지역명검색이면 
			expressMap("local", search_word);//검색 지역 반경 초기화
			showLocal();//검색한 지역의 지역명 표시
		}
		
		if(searchUrl != ''){//검색메인화면->검색메인화면(ajax호출)
			beforeSearchUrl = searchUrl;
			searchUrl = "/api/search/quick/integration?searchWord=" + encodeURI(encodeURIComponent(search_word));
			posChangeSubmit(1);//검색
		}
	}
</script>