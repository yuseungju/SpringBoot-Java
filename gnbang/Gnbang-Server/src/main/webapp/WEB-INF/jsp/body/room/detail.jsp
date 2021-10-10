<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!-- <body class="detail"> -->
	<sec:authorize access="hasRole('ROLE_AGENT')">
		<div class="top_agent_btn">
			<div class="container">
				<div class="button">
					<p class="btn_info_req  btn">
						<a href="#poup_info_req" title="정보수정요청팝업창보기"><span>정보수정요청</span></a>
					</p>
					 <p class="btn_pic_add btn">
						 <a href="#popup_pic_add" title="사진추추가팝업창보기"><span>사진추가</span></a>
					 </p>      
					<p class="btn_comment_add btn">
						<a href="#poup_comment_add" title="정보수정요청팝업창보기"><span>코멘트달기</span></a>
					</p>
					<p class="btn_contract  btn">
						<a href="#poup_contract" title="계약완료신고팝업창보기"><span>계약완료신고</span></a>
					</p>
					<p class="btn_cart  btn">
						<a href="#poup_cart" title="매물담기팝업창보기"><span>매물담기</span></a>
					</p>
					<p class="btn_lessor  btn">
						<a href="#poup_lessor" title="임대인연락처팝업창보기"><span>임대인연락처보기</span></a>
					</p>
					<p class="btn_print  btn">
						<a href="#" onclick ="print(); return false;" title="인쇄하기"><span>인쇄</span></a>
					</p>
	
				</div>
			</div>
		</div>
	</sec:authorize>
	<!--agent_btn 마감-->
	
	<!--content_wrap-->
	<div id="content_wrap" class="clearfix">
		<div class="content">
			<div class="page">
				<div class="detail_header">
					<div class="container">
						<h2 class="mm_num">
							<span>매물번호 :</span> <span>${room.no}</span>
						</h2>
						<div class="gallery">
							<!--계약완료시만 노출-->
							<div class="notice_wrap">
								<div class="notice">
									<div class="txt">계약완료된 방입니다.</div>
								</div>
							</div>
							<!--notice_wrap마감-->
							<!--여기까지 계약완료시만 노출-->
							<div class="view">
								<div class="image_list">
									<div class="media_photo media_cover">
										<div class="media_cover">
											 <c:if test="${room.fake_url.size() eq 0}">
												 <img id ="selected_photo"
													src="${pageContext.request.contextPath}/images/common/pic_base.jpg"
													alt="기본 방사진" class="img_responsive_height" />
											 </c:if>
											 <c:forEach items="${room.fake_url}" var="fake_url" begin="0" end="0">
												 <c:if test="${room.fake_url.size() ne 0}">
													 <img id ="selected_photo"
														src="http://112.175.245.57${fake_url}"
														alt="ftp 저장 방사진" class="img_responsive_height" />
												 </c:if>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
							<div class="g_control">
								<div class="btn_prev btn_control" onclick ="showBigPhoto('left')" title="이전이미지">
									<p>
										<span class="blind">이전</span>
									</p>
								</div>
							 	<div class="btn_next btn_control" onclick ="showBigPhoto('right')" title="다음이미지">
									<p>
										<span class="blind">다음</span>
									</p>
								</div> 
							</div>
							<!--control마감-->
	
							<div class="page_num">
								<p>
									<span class="cur_page" id ="cur_page">1</span>
									<span>/</span>
									<span class="tot_page" id ="tot_page">${room.fake_url.size()}</span>
								</p>
							</div>
							<!--페이지마감-->
							<div class="thum">
								<div class="inner">
									<ul class="thum_list">
									<c:forEach items="${room.fake_url}" var="fake_url"  varStatus="i" >
										<c:if test="${i.index < 8}">
											<li class="current" id ="li_${i.index}">
												<a href="#" onclick="selectPhoto('${i.index}')">
													<img  id ="img_${i.index}"
														src="http://112.175.245.57${fake_url}"
														alt="섬네일1" />
												</a>
											</li>	
										</c:if>
										<c:if test="${8 <= i.index}">
											<li class="current" id ="li_${i.index}" style="display:none;">
												<a href="#" onclick="selectPhoto('${i.index}')">
													<img  id ="img_${i.index}"
														src="http://112.175.245.57${fake_url}"
														alt="섬네일1" />
												</a>
											</li>	
										</c:if>
									</c:forEach>
									</ul>
								</div>
								<div class="control">
									<div class="btn_prev btn_control" onclick ="showPhoto('left')" title="이전이미지">
										<p>
											<span class="blind">이전</span>
										</p>
									</div>
									<div class="btn_next btn_control" onclick ="showPhoto('right')" title="다음이미지">
										<p>
											<span class="blind">다음</span>
										</p>
									</div>
								</div>
								<!--control마감-->
	
							</div>
							<!--thumb마감-->
						</div>
						<!--gallery마감-->
						<div class="summary">
							<div class="s1">
								<p id ="price">
									<!-- 거래타입에 맞는 거래가 출력부분 -->
								</p>
							</div>
						</div>
						<!--summary마감-->
						<div class="comment">
							<div class="container">
								<div class="comment_header">
									<h3>
										<span class="txt">코멘트</span><span class="num" id="comment_size"></span>
									</h3>
									<div class="guide">
										<p class="tit" onclick ="setCommentDescState()">
											<span class="blind">코멘트는?</span>
										</p>
										<div class="desc" id ="comment_desc">
											<p>
												<strong>코멘트안내</strong>코멘트는 해당 관청에 등록된 공인중개사 및 중개보조원이 올린
												정보입니다.
											</p>
											<p class="close" onclick ="setCommentDescState()">
												<span class="blind">닫기</span>
											</p>
										</div>
									</div>
								</div>
								<div class="comment_list " >
									<div id ="comment_list_background">
										<!-- ajax호출로 코멘트 set 
											코멘트,코멘트,......
										-->
									</div>
									<!--row마감-->
									<div class="list_end">
										<span>더보기</span>
									</div>
								</div>
								<!--comment_list마감-->
							</div>
							<!--container마감-->
						</div>
						<!--comment마감-->
					</div>
					<!--container마감-->
				</div>
				<!--detail_header마감-->
	
				<div class="b_info detail_body">
	
					<div class="container">
						<h3>기본정보</h3>
	
						<div class="inner">
							<div class="row">
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>관리비</div>
										</dt>
										<dd>
											<div>${room.maintenance_cost}원</div>
										</dd>
									</dl>
								</div>
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>관리비포함</div>
										</dt>
										<dd>
											<div>
												<c:set var="cumma" value="" />
												<c:if test="${room.in_electronic_bill == 1 }">
															전기세 
														    <c:set var="cumma" value="," />
												</c:if>
												<c:if test="${room.in_gas_bill == 1 }">
													<c:out value="${cumma}" />
															가스비
															<c:set var="cumma" value="," />
												</c:if>
												<c:if test="${room.in_water_bill == 1 }">
													<c:out value="${cumma}" />
															수도세
														    <c:set var="cumma" value="," />
												</c:if>
												<c:if test="${room.in_tv_bill == 1 }">
													<c:out value="${cumma}" />
															tv수신료
														    <c:set var="cumma" value="," />
												</c:if>
												<c:if test="${room.in_clean_fee == 1 }">
													<c:out value="${cumma}" />청소비
														</c:if>
											</div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>방수/욕실수</div>
										</dt>
										<dd>
											<div>${room.room_count }/${room.bathroom_count}</div>
										</dd>
									</dl>
								</div>
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>방종류</div>
										</dt>
										<dd>
											<div>${it.room_type }
												<c:if test="${room.room_type ==1 }">
															오픈형
														</c:if>
												<c:if test="${room.room_type ==2 }">
															분리형
														</c:if>
												<c:if test="${room.room_type ==3 }">
															복층형
														</c:if>
												<c:if test="${room.room_type ==4 }">
															사무용
														</c:if>
												<c:if test="${room.room_type ==5 }">
															주거용
														</c:if>
												<c:if test="${room.room_type ==6 }">
															일부층사용
														</c:if>
												<c:if test="${room.room_type ==7 }">
															전층사용
														</c:if>
												<c:if test="${room.room_type ==8 }">
															원룸원거실
														</c:if>
												<c:if test="${room.room_type ==9 }">
															세미분리
														</c:if>
											</div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>건물형태</div>
										</dt>
										<dd>
											<div>
												<c:if test="${room.apartment == 1}">
															아파트
														</c:if>
												<c:if test="${room.officetel == 1 }">
															오피스텔
														</c:if>
												<c:if test="${room.house == 1}">
															주택
														</c:if>
												<c:if test="${room.normal_room == 1}">
															원룸
														</c:if>
												<c:if test="${room.shop == 1}">
															상가
														</c:if>
												<c:if test="${room.office == 1}">
															사무실
														</c:if>
												<c:if test="${room.building == 1}">
															건물
														</c:if>
												<c:if test="${room.event == 1}">
															이벤트
														</c:if>
												<c:if test="${room.land == 1}">
															땅
														</c:if>
											</div>
										</dd>
									</dl>
								</div>
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>주소</div>
										</dt>
										<dd>
											<div>${room.si}&nbsp;${room.gungu}&nbsp;
												${room.dong}&nbsp; 
												<sec:authorize access="hasRole('ROLE_AGENT')"> 
												${room.main_address}-${room.sub_address}&nbsp;
												 ${room.last_address}&nbsp; 
												</sec:authorize></div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
	
							<div class="row">
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>해당층/총층</div>
										</dt>
										<dd>
											<div>${room.floor_no}(층)/${room.all_floor}(층)</div>
										</dd>
									</dl>
								</div>
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>준공년도</div>
										</dt>
										<dd>
											<div>${room.built}년</div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>공급/전용</div>
										</dt>
										<dd>
											<div>
												${room.leased_area}m<sup>2</sup>
												(<fmt:formatNumber value="${room.leased_area * 0.3025}" pattern="0.0"/>평)
												/${room.exclusive_area}m<sup>2</sup>
												(<fmt:formatNumber value="${room.exclusive_area * 0.3025}" pattern="0.0"/>평)
											</div>
										</dd>
									</dl>
								</div>
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>입주가능일</div>
										</dt>
										<dd>
											<div>
												<c:if test="${room.move_now ==1 }">
															즉시
														</c:if>
												<c:if test="${room.move_modify ==1 }">
															조정가능
														</c:if>
												<c:if test="${room.move_day == null}">
															${room.move_day }
														</c:if>
											</div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col info_item opt">
									<dl>
										<dt>
											<div>옵션</div>
										</dt>
										<dd>
											<div>
												<c:if test="${room.full_option_room == 1}">
													<span class="full"><i class="txt">플옵션</i></span>
												</c:if>
												<c:if test="${room.airconditioner == 1}">
													<span class="air"><i class="txt">에어컨</i></span>
												</c:if>
												<c:if test="${room.refrigerator == 1}">
													<span class="fridge"><i class="txt">냉장고</i></span>
												</c:if>
												<c:if test="${room.washer == 1}">
													<span class="washer"><i class="txt">세탁기</i></span>
												</c:if>
												<c:if test="${room.tv == 1}">
													<span class="tv"><i class="txt">TV</i></span>
												</c:if>
												<c:if test="${room.microwave == 1}">
													<span class="microwave"><i class="txt longtext">전자레인지</i></span>
												</c:if>
												<c:if test="${room.induction == 1}">
													<span class="indection"><i class="txt">인덕션</i></span>
												</c:if>
												<c:if test="${ fn:contains(room.other_option,'싱크대')}">
													<span class="sink"><i class="txt">싱크대</i></span>
												</c:if>
												<c:if test="${room.gasrange == 1}">
													<span class="stove"><i class="txt longtext">가스레인지</i></span>
												</c:if>
												<c:if
													test="${ fn:contains(room.other_option,'쇼파')  ||  fn:contains(room.other_option,'소파')}">
													<span class="sofa"><i class="txt">쇼파</i></span>
												</c:if>
												<c:if test="${room.bed == 1}">
													<span class="bed"><i class="txt">침대</i></span>
												</c:if>
												<c:if test="${room.built_in_closet == 1}">
													<span class="closet"><i class="txt">붙박이장</i></span>
												</c:if>
												<c:if test="${room.closet == 1}">
													<span class="wardrobe"><i class="txt">옷장</i></span>
												</c:if>
												<c:if test="${room.dressing_table == 1}">
													<span class="dressingtable"><i class="txt">화장대</i>
												</c:if>
												<c:if test="${room.veranda == 1}">
													<span class="veranda"><i class="txt">베란다</i></span>
												</c:if>
												<c:if test="${ fn:contains(room.other_option,'신발장')}">
													<span class="shoecloset"><i class="txt">신발장</i></span>
												</c:if>
											</div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>반려동물</div>
										</dt>
										<dd>
											<div>
												<c:if test="${room.animal == 1}">
															가능
														</c:if>
												<c:if test="${room.animal == 0}">
															불가능
														</c:if>
											</div>
										</dd>
									</dl>
								</div>
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>엘리베이터</div>
										</dt>
										<dd>
											<div>
												<c:if test="${room.elevator == 1}">
															있음
														</c:if>
												<c:if test="${room.elevator == 0}">
															없음
														</c:if>
											</div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>주차</div>
										</dt>
										<dd>
											<div>
												<c:if test="${room.parking == 1}">
															가능
														</c:if>
												<c:if test="${room.parking == 0}">
															불가능
														</c:if>
											</div>
										</dd>
									</dl>
								</div>
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>주차옵션</div>
										</dt>
										<dd>
											<div>
												${room.parking_option }
												<c:if test="${room.parking_count > 0}">
															, ${room.parking_count}대
														</c:if>
												<c:if test="${room.parking_free == 1}">
															, 주차비용포함
														</c:if>
											</div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>난방종류</div>
										</dt>
										<dd>
											<div>
												<c:if test="${room.heating_type == 0}">
															중앙난방
														</c:if>
												<c:if test="${room.heating_type == 1}">
															개별난방
														</c:if>
												<c:if test="${room.heating_type == 1}">
															지역난방
														</c:if>
											</div>
										</dd>
									</dl>
								</div>
								<div class="col2 info_item">
									<dl>
										<dt>
											<div>중개수수료</div>
										</dt>
										<dd>
											<div>${room.brokerage}원</div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
						</div>
					</div>
					<!--container마감-->
				</div>
				<!--a_info추가정보마감-->
				<div class="d_info detail_body">
					<div class="container">
						<h3>상세설명</h3>
						<div class="inner">
							<div class="row">
								<div class="col info_item">
									<dl>
										<dt>
											<div>상세설명</div>
										</dt>
										<dd>
											<div>
												<p>${room.detail}</p>
											</div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col info_item">
									<div class="video_wrap">
										<iframe src="https://player.vimeo.com/video/149602379"></iframe>
									</div>
								</div>
							</div>
							<!--row마감-->
						</div>
					</div>
					<!--container마감-->
				</div>
				<!--d_info마감-->
				<div class="l_info detail_body">
					<div class="container">
						<h3>위치 및 주변 정보</h3>
						<div class="inner">
							<div class="row">
								<div class="col info_item">
										<!--location마감-->
										<div id="map" class="map_wrap"></div>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col info_item t_border">
									<dl>
										<dt>
											<div>인근지하철역</div>
										</dt>
										<dd>
											<div id="station"></div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col info_item ">
									<dl>
										<dt>
											<div>편의점</div>
										</dt>
										<dd>
											<div id="convenience"></div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col info_item ">
									<dl>
										<dt>
											<div>관공서</div>
										</dt>
										<dd>
											<div id=offices></div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="col info_item ">
									<dl>
										<dt>
											<div>은행</div>
										</dt>
										<dd>
											<div id="bank"></div>
										</dd>
									</dl>
								</div>
							</div>
							<!--row마감-->
						</div>
						<!--inner마감-->
					</div>
					<!--container마감-->
				</div>
				<!--l_info위치및 주변정보마감-->
	
			</div>
			<!--page마감-->
			<div class="detail_side">
				<div class="container">
					<div class="agent_info ">
						<div class="inner">
							<h3>중개사정보</h3>
							<div class="agt1 agt row">
								<dl>
									<dt>담당</dt>
									<dd>${room.manageName}</dd><!-- 
									<dt>연락처</dt>
									<dd>010-1234-1234</dd> -->
								</dl>
							</div>
							<div class="agt2 agt row">
								<dl>
									<dt>사진등록</dt>
									<dd>${room.photoManageName}</dd><!-- 
									<dt>연락처</dt>
									<dd>010-1234-1234</dd> -->
								</dl>
							</div>
							<div class="office row">
								<div class="desc">
									<dl>
										<dt>강남방부동산중개법인</dt>
										<dd>대표 정지아</dd>
										<dd>서울시 강남구 삼성동</dd>
										<dd class="tel">02-568-2453</dd>
									</dl>
								</div>
								<div class="pic">
									<span><img
										src="${pageContext.request.contextPath}/images/common/map_test.png"
										alt="" /></span>
								</div>
							</div>
						</div>
						<!--inner마감-->
					</div>
					<!--agent_info마감-->
					<div class="notice">
						이방은 중개사무소가 등록한 매물입니다. 거래 시 <strong>법정 중개 수수료가 발생</strong>하오니 참고해주세요
					</div>
					<div class="btn_wrap">
						<div class="notify btn">
							<p class="btn_notify">
								<a href="#popup_notify" title="허위신고하기"><span>허위신고</span></a>
							</p>
						</div>
					</div>
					<div class="inquiry">
						<div class="row tit">
							<p>
								<span>2003번 </span>방이 궁금하세요?
							</p>
							<!--매물번호출력-->
						</div>
						<div class="inner">
	
							<div class="row">
								<div class="guide">
									<p>고객님의 연락처 및 통화 가능 시간을 남겨 주세요. 담당자가 연락처 및 가능 시간 확인 후 원하시는
										시간에 연락 드리겠습니다.</p>
								</div>
							</div>
							<div class="row">
								<div class="text">
	
									<div class="input_wrap">
										<label for="cust_tel">연락번호 :</label>
										<div class="input">
											<span class="bor_input"> <input type="text"
												id="cust_tel" placeholder="하이픈없이 숫자만 입력해주세요"></span>
										</div>
									</div>
	
									<div class="input_wrap">
										<label for="cust_time">상담가능시간 :</label>
										<div class="input">
											<span class="bor_input"><input type="text"
												id="cust_time" placeholder="상담가능한 시간 자유롭게 입력해주세요"></span>
										</div>
									</div>
								</div>
								<!--text마감-->
								<div class="inquiry_btn">
									<button onclick="applyConsult()">
										<span>문의신청</span>
									</button>
								</div>
							</div>
							<!--마감row-->
						</div>
						<!--inner마감-->
					</div>
					<!--inquir마감-->
				</div>
				<!--container마감-->
			</div>
			<!--detail_side-->
			
			<sec:authorize access="hasRole('ROLE_AGENT')">
				<div class="m_detail_footer m_agent_btn">
					<div class="container">
						<div class="button">
							<!--div class="btn_agent  btn opened"오픈된 상태-->
							<div class="btn_agent  btn" id ="btn_agent">
								<button onclick ="showAgentMenu()">
									<span>중개사메뉴...</span>
								</button>
								<div class="m_agent_menu">
		
									<div class="container">
										<p class="btn_info_req ">
											<a href="#popup_info_req">정보수정요청</a>
										</p>
										<p class="btn_contract ">
											<a href="#popup_constract">계약완료신고</a>
										</p>
										<p class="btn_comment_add ">
											<a href="#popup_comment_add">코멘트달기</a>
										</p>
									</div>
								</div>
							</div>
							<div class="btn_cart  btn">
								<button>
									<span>매물담기</span>
								</button>
							</div>
							<div class="btn_lessor  btn">
								<button>
									<span>임대인연락처보기</span>
								</button>
							</div>
							<div class="btn_pic_add ">
								<a href="#popup_comment_add"><span class="blind">사진추가</span></a>
							</div>
						</div> 
					</div>
		
				</div>
			</sec:authorize>
			<!--m_detail_footer마감-->
	
		</div>
		<!--content마감-->
	</div>
	<!--content_wrap마감-->
		<p class="go_top">
			<a href="#"><span class="blind">top</span></a>
		</p>
		<div class="footer">
			<div class="footer_inner"></div>
			<!--footer_inner마감-->
		</div>
		<!--footer마감-->
	</div>
	<!--wrap마감-->
	
	<!--팝업레이어-->
	<div class="overlay"></div>	<!--팝업레이어 테스트 오버레이 삭제해도 되요-->
	<div class="popup_wrap">
		<div class="popup_notify popup" id="popup_notify">
			<div class="pop_cell">
				<div class="container">
					<div class="popup_title_wrap">
						<div class="popup_title">허위매물신고</div>
						<div class="popup_close close_btn">
							<a href="#content_wrap" title="허위매물신고닫기"><span class="blind">허위매물신고닫기</span></a>
						</div>
					</div>
					<div class="popup_content_wrap">
						<div class="popup_content">
							<div class="row">
								<label> <span class="input check"> <input
										type="checkbox" id ="fake_exist"/>
								</span> <span class="txt"> 방이 나갔습니다. </span>
								</label>
							</div>
							<!--row마감-->
							<div class="row">
								<label> <span class="input  check"> <input
										type="checkbox" id ="fake_photo"/>
								</span> <span class="txt"> 사진과 다릅니다. </span>
								</label>
							</div>
							<!--row마감-->
							<div class="row">
								<label> <span class="input check"> <input
										type="checkbox" id ="fake_infor"/>
								</span> <span class="txt"> 표기된 정보와 다릅니다. </span>
								</label>
							</div>
							<!--row마감-->
							<div class="row">
								<label> <span class="input  check"> <input
										type="checkbox" id ="fake_other"/>
								</span> <span class="txt"> 기타 </span>
								</label>
							</div>
							<!--row마감-->
							<div class="row ">
								<div class="input text">
									<input type="text" id ="fake_other_content" placeholder="기타내용을 입력해 주세요" />
								</div>
							</div>
							<!--row마감-->
							<div class="row">
								<div class="button">
									<div class="btn  close close_btn">
										<button>
											<span>닫기</span>
										</button>
									</div>
									<div class="btn submit close_btn">
										<button onclick = "addFakeProperty()">
											<span>신고</span>
										</button>
									</div>
								</div>
							</div>
						</div>
						<!--popup_content마감-->
					</div>
					<!--popup_content_wrap마감-->
				</div>
			</div>
		</div>
	</div>
	<!--inquiry문의신청팝업마감-->
	
	<div class="popup_info_req  popup" id="popup_info_req">
		<div class="pop_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">정보수정요청</div>
					<div class="popup_close close_btn">
						<span class="blind">닫기</span>
					</div>
				</div>
				<div class="popup_content_wrap">
					<div class="popup_content">
						<p class="tit">정보수정</p>
						<div class="row">
							<label> <span class="input check"> 
							<input type="checkbox" id="modify_phone"/>
							</span> <span class="txt"> 잘못된 전화번호입니다. </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> <span class="input check"> 
							<input type="checkbox" id="modify_cost"/>
							</span> <span class="txt"> 금액이 잘못되었습니다. </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> <span class="input check">
							<input type="checkbox" id="modify_option"/>
							</span> <span class="txt" > 옵션이 잘못되었습니다. </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> 
							<span class="input check">
							<input type="checkbox" id="modify_other"/>
							</span> <span class="txt" > 기타 </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row ">
							<div class="input text">
							<input type="text" placeholder="기타내용을 입력해 주세요" id="other_content"/>
							</div>
						</div>
						<!--row마감-->
					</div>
					<!--popup_content마감-->
					<div class="popup_content t_border">
						<p class="tit">사진변경</p>
						<div class="row">
							<label> <span class="input check"> 
							<input type="checkbox"  id="modify_photo_add"/>
							</span> <span class="txt"> 사진을 추가해주세요 </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> <span class="input check"> 
							<input type="checkbox"  id="modify_photo_remove"/>
							</span> <span class="txt"> 사진을 삭제해주세요 </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row ">
							<div class="input text">
								<input type="text" placeholder="사진 삭제 이유를 입력해 주세요" id="photo_remove_content"/>
							</div>
						</div>
						<!--row마감-->
						<div class="row">
							<div class="button">
								<div class="btn close close_btn">
									<button>
										<span>닫기</span>
									</button>
								</div>
								<div class="btn submit close_btn">
									<button onclick ="addModifyText()">
										<span>확인</span>
									</button>
								</div>
							</div>
						</div>
					</div>
					<!--popup_content마감-->
				</div>
				<!--popup_content_wrap마감-->
			</div>
		</div>
		<!--container-->
	</div>
		<!--popup_info_req팝업마감-->
	<div class="popup_pic_add popup" id="popup_pic_add">
		<div class="pop_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">사진추가</div>
					 <div class="popup_close close_btn">
						<span class="blind">닫기</span>
					</div>
				</div>
				<div class="popup_content_wrap">
					<div class="popup_content">
						<div class="row">
							<div class="guide">
								<ol>
									<li>사진 1장당 10MB까지 등록 가능합니다.</li>
									<li>사진은 최소 5장 이상 등록하셔야 합니다.</li>
									<li>사진은 총 16장 까지 등록 가능합니다.</li>
									<li>개인정보, 중개사 정보 등 매물과 관련 없는 정보가 포함된 사진은 삭제 처리됩니다.</li>
									<li>등록한 사진이 보이지 않을 경우 <strong>새로고침</strong> 단추를 클릭 하세요.
									</li>
								</ol>
								<div class="reload">
									<p class="btn">
										<button onclick="reset_photo_ul()">
											<span>새로고침</span>
										</button>
									</p>
								</div>
							</div>
						</div>
						<!--아래부분이 변경된 부분입니다.-->
						<div class="row box">
							<form id="enrollForm" method ="POST">
								<ul id="photo_ul">
									<!-- 
											 html생성 공간( 추가되는 사진 ) 
									 !-->			
									<li class="pic_list col4 mid_col4 sm_col2" id="photo_add_li">
										<div class="pic" onclick='document.all.uploadFile.click();'>
											<div class="media_cover">
												<a href="#" class="btn_up"  ><span class="blind">사진추가</span></a>
											</div>
										</div>
									</li>
								</ul>
							</form>
						</div>
						<div class="row">
							<div class="button">
								<div class="btn close close_btn">
									<button>
										<span>취소</span>
									</button>
								</div>
								<div class="btn submit">
									<button onclick ="uploadAllPhoto(); return false;">
										<span>사진올리기</span>
									</button>
								</div>
							</div>
						</div>
					</div>
					<!--popup_content마감-->
				</div>
				<!--popup_content_wrap마감-->
			</div>
		</div>
	</div>

	<!--popup_pic_add팝업마감-->
	<div class="popup_comment_add popup" id="popup_comment_add">
		<div class="pop_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">중개사코멘트</div>
					<div class="popup_close close_btn">
						<span class="blind">닫기</span>
					</div>
				</div>
				<div class="popup_content_wrap">
					<div class="popup_content">
						<div class="row">
							<div class="guide">
								<p class="tit">중개사 코멘트 안내</p>
								<ol>
									<li>각 매물에 대한 중개사코멘트는 먼저 등록되는 코멘트를 기준으로 최대 3개까지 등록됩니다.</li>
									<li>각 매물에 대한 중개사코멘트는 <strong>중개사 1명 당 1개만 등록</strong>하실 수
										있습니다.
									</li>
									<li>코멘트 등록 시 등록하신 중개사님께 x포인트가 지급됩니다.</li>
								</ol>
		
							</div>
						</div>
						<div class="row comment_box">
							<div class="comment_wrap">
								<div class="input bor_input">
									<label for="comment_input" class="blind">중개사코멘트</label> <input
										type="text" id="comment_input" placeholder="코멘트를 입력해주세요" />
								</div>
							</div>
							<div class="comment_btn">
								<button type="button" onclick = "addComment()">
									<span>등록</span>
								</button>
							</div>
						</div>
						<div class="row no_padding_top">
							<div class="comment_list" id ="comment_list_popup">
									<!--
										 ajax로 셋팅, 코멘트 달기 찹업창에서 코멘트들 출력 
									-->
							</div>
							<!--comment_list마감-->
						</div>
						<div class="row">
							<div class="button">
								<div class="btn close close_btn">
									<button>
										<span>닫기</span>
									</button>
								</div>
		
							</div>
						</div>
					</div>
					<!--popup_content마감-->
				</div>
				<!--popup_content_wrap마감-->
			</div>
		</div>
	</div>
	<!--popup_commnet_add팝업마감-->
	<div class="popup_contract popup" id="popup_contract">
		<div class="pop_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">계약완료신고</div>
					<div class="popup_close close_btn">
						<span class="blind">닫기</span>
					</div>
				</div>
				<div class="popup_content_wrap">
					<div class="popup_content">
						<div class="row">
							<div class="guide">
								<p>계약완료 신고를 하시겠습니까?</p>
							</div>
						</div>
						<div class="row">
							<div class="button">
								<div class="btn close close_btn">
									<button>
										<span>닫기</span>
									</button>
								</div>
								<div class="btn submit close_btn">
									<button onclick ="endContract()">
										<span>확인</span>
									</button>
								</div>
							</div>
						</div>
					</div>
					<!--popup_content마감-->
				</div>
				<!--popup_content_wrap마감-->
			</div>
		</div>
	</div>
	
	<!--popup_contract팝업마감-->
	<div class="popup_cart popup" id="popup_cart">
		<div class="pop_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">관심매물담기</div>
					<div class="popup_close close_btn">
						<a href="#content_wrap" title="관심매물닫기"><span class="blind">관심매물닫기</span></a>
					</div>
				</div>
				<!--popup_title_wrap마감-->
				<div class="popup_content_wrap" id ="cust_make">
					<div class="popup_content">
						<div class="ac_body">
							<div class="row cust_make">
								<div class="ac_label">
									<p class="tit">새로운 고객생성</p>
								</div>
								<div class="text">
									<div class="row">
										<div class="inner">
											<label for="customer">고객명전화번호 :</label>
											<div class="input">
												<span> <input type="text" id="customer"
													placeholder="고객명전화번호를입력해주세요" />
												</span>
												<p class="desc">“고객명전화번호” 로 등록해주세요(예: 홍길동01012341234)</p>
											</div>
										</div>
										<div class="inner">
											<label for="customer_desc">고객설명: </label>
											<div class="input">
												<span> <input type="text" id="customer_desc"
													placeholder="설명을입력해주세요" />
												</span>
											</div>
										</div>
									</div>
		
									<div class="btn">
										<p>
											<button onclick ="createUser()">
												<span>고객생성</span>
											</button>
										</p>
									</div>
								</div>
								<!--text마감마감-->
							</div>
							<!--row cust_make마감-->
		
							<div class="row cust_list">
								<div class="inner">
									<div class="ac_label">
										<p class="tit">고객선택</p>
									</div>
									<div class="check_list">
										<ul class="row " id="cartUserInCheck">
											
										</ul>
										<div class="btn">
											<p>
												<button onclick ="addSelectItem()">
													<span>선택매물담기</span>
												</button>
											</p>
										</div>
										<!--btn마감-->
									</div>
									<!--check_list마감-->
								</div>
							</div>
							<!--row cust_list마감-->
						</div>
						<!--ac_body마감-->
					</div>
					<!--popup_conntent마감-->
				</div>
				<!--popup_content_wrap마감-->
			</div>
		</div>
		<!--container마감-->
	</div>
	<div class="popup_lessor popup" id="popup_lessor">
		<!--임대인 연락처 확인시의 처음 뜨는 팝업-->
		<div class="pop_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">임대인 연락처 확인 1/3</div>
					<div class="popup_close close_btn">
						<a href="#content_wrap" title="임대인연락처닫기"><span class="blind">임대인연락처닫기</span></a>
					</div>
				</div>
				<!--popup_title_wrap마감-->
				<div class="popup_content_wrap">
					<div class="popup_content">
						<div class="row">
							<div class="inner">
								<div class="ac_label">
									<p class="tit">임대인 연락처 확인 사유를 선택해 주세요</p>
								</div>
								<div class="check_list">
									<ul>
										<li class="row ">
											<div>
												<label> <span class="input radio"> <input
														type="radio" name='radio' id='radio_photo' />
												</span> <span class="txt"> 사진 촬영을 위한 연락처 확인 </span>
												</label>
											</div>
										</li>
										<li class="row ">
											<div>
												<label> <span class="input radio"> <input
														type="radio" name='radio' id='radio_visit' />
												</span> <span class="txt"> 고객과 방문을 위한 연락처 확인 </span>
												</label>
											</div>
										</li>
									</ul>
		
								</div>
								<!--check_list마감-->
							</div>
						</div>
						<!--row cust_list마감-->
						<div class="row">
							<div class="button">
								<div class="btn close close_btn">
									<button>
										<span>취소</span>
									</button>
								</div>
								<div class="btn submit">
									<button onclick="selectPopup()">
										<span>다음</span>
									</button>
								</div>
							</div>
						</div>
					</div>
					<!--popup_conntent마감-->
				</div>
				<!--popup_content_wrap마감-->
			</div>
		<!--container마감-->
		</div>
	</div>
	
	<div class="popup_lessor popup" id="popup_lessor2">
		<!--임대인 연락처 확인시의 처음 뜨는 팝업-->
		<div class="pop_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">임대인 연락처 확인 2/3</div>
					<div class="popup_close close_btn">
						<a href="#content_wrap" title="임대인연락처닫기"><span class="blind">임대인연락처닫기</span></a>
					</div>
				</div>
				<!--popup_title_wrap마감-->
				<div class="popup_content_wrap">
					<div class="popup_content">
						<div class="row cust_list">
							<div class="inner">
								<div class="ac_label">
									<p class="tit">임대인 연락처 확인을 위해 상담고객을 선택해 주세요</p>
								</div>
								<div class="check_list">
									<ul class="row " id="cartUserInShowContact">
									</ul>
								</div>
								<!--check_list마감-->
							</div>
						</div>
						<!--row cust_list마감-->
						<div class="row">
							<div class="button">
								<div class="btn close close_btn">
									<button>
										<span>취소</span>
									</button>
								</div>
								<div class="btn submit">
								<button onclick="showContactPopup()">
									<span>다음</span>
								</button>
							</div>
							</div>
						</div>
					</div>
					<!--popup_conntent마감-->
				</div>
				<!--popup_content_wrap마감-->
			</div>
		<!--container마감-->
		</div>
	</div>
	
	<div class="popup_lessor popup" id="popup_lessor3">
		<div class="pop_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">임대인 연락처 확인 3/3</div>
					<div class="popup_close close_btn">
						<a href="#content_wrap" title="임대인연락처닫기"><span class="blind">임대인연락처닫기</span></a>
					</div>
				</div>
				<!--popup_title_wrap마감-->
				<div class="popup_content_wrap">
					<div class="popup_content">
						<p class="tit">임대인연락처</p>
						<div class="row" id="contact_div"></div>
						<div class="row">
							<div class="button">
								<div class="btn close close_btn">
									<button onclick="closeContact()">
										<span>닫기</span>
									</button>
								</div>
							</div>
						</div>
					</div>
					<!--popup_conntent마감-->
				</div>
			</div>
		</div>
	</div>
	
	<!-- 파일업로드 기능 -->
	<form id="upload_file_frm" onsubmit="return false;">
	<input id="upload_file" type="file" name="uploadFile"  accept="image/*"  style='display: none;' onchange="selectUploadPhoto(this);" />
	</form>

<!-- 방상세보기 페이지 확인시 추가 및 가져오는 값-->
<script>
	$(document).ready(function(){
		 //최근 본방 추가
		 insertRecently();

		 //기본 정보들 뷰에 셋팅
		 getComment();//방에 대한 코멘트들 
		 getCartUser();//중개사의 고객
		 getModifyText();//중개사의 수정요청 기록
		 getFakeText();//허위매물 신고내역 
		 setPrice();//거래가 출력
		 //고객명+연락처 자동완성
		 setAutoUserWord();
	});
</script>
<!-- 최근본방추가 -->
<script>
	function insertRecently(){
		$.ajax({
			type : "POST",
			url : "/api/room/recently?room_no=" + '${room.no}',
			async : true
		});
	}
</script>
<!-- 파일업로드 -->
<script>
	/*************************파일 업로드 및 방등록 데이터 설정************************************/
	 var temp_enroll_num = 0;//임시등록 성공 수
	 var photo_cnt = 0;//사진 고유번호 
	 var photo_li_id = [];//뷰에보여지는 사진만큼만 할당된 id
	 var photo_temp_url = [];//업로드 또는 취소했을때, 등록했던 이미지의 모든 임시경로(업로드 했던만큼)
	 var upload = document.getElementById('upload_file');
	 var allready_num =  get_allready_num();
	 function selectUploadPhoto(obj){
		if(obj.value =='')//사진찾기 -> 사진 선택을 안하고 취소했으면
			return;
		if(allready_num != 0 ){
			alert('해당되는 매물은 이미 사진등록이 완료되었습니다.');
			return;
		}
		if(16 <= photo_li_id.length){
			alert('사진은 16개 까지만 등록가능합니다.');
			return;
		}
		addPhotoView();//사진뷰 생성
		uploadTempPhoto(photo_cnt);//업로드
		//파일 폼 상태 초기화
		$('#upload_file').val('');
		photo_cnt++;
	};
	//이미  존재하는 사진수를 가져옴
	function get_allready_num(){
		//등록된 사진의 개수를 가져온다.
		var room_cnt = 0;
		 $.ajax({
			 	type : "GET",
				dataType : "json",
		        url: "/api/room/photo_count?room_no="  +"${room.no}",
		        async: false,//필수 등록이전 방의 수를 확인하기위해 동기화시켜야함
		        success: function(data) {
		        	room_cnt = data;
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        	room_cnt = 9999;//에러시에 방사진 추가 못하도록 함
		        }
		 });
		 return room_cnt;
	}
	//이미지 컨테이터(뷰)출력
	function addPhotoView(){
		var str ="";
		str+=" <li class=\"pic_list col4 mid_col4 sm_col2\" id= \"li_"+ photo_cnt + "\">";
		str+=" <input type =\"text\" value=\"\" name =\"file_name\" style='display: none;'/>";
		str+=" <div class=\"pic\">";
		str+=" 		<div class=\"media_cover media_photo\">";
		str+=" 			<img src=\"\" id= \"preview_"+ photo_cnt + "\" alt=\"상세사진4\" />";
		str+=" 		</div>";
		str+=" 		<div class=\"btn_del\">";
		str+=" 			<a href=\"#\" onclick=\"remove("+ photo_cnt + "); return false;\" alt=\"사진삭제하기\"><span class=\"blind\">사진삭제</span></a>";
		str+=" 		</div>";
		str+=" 	</div>";
		str+=" </li>";
		photo_li_id.push(photo_cnt);//사진하나의  id저장
		$("#photo_add_li").before(str);//사진(뷰) 하나추가
		
		//미리보기 섬네일
		var upload = document.getElementById('upload_file');
		var	holder = document.getElementById('preview_' + photo_cnt);
		var file = upload.files[0], reader = new FileReader();
		reader.onload = function(event) {
			var img = new Image();
			img.src = event.target.result;
			holder.src = reader.result;
		};
		reader.readAsDataURL(file);
	}
	//사진 선택 지우기(뷰에서만)
	function remove(target_photo_cnt){
		$("#li_" + target_photo_cnt).remove();
		photo_li_id.splice(photo_li_id.indexOf(target_photo_cnt),1);
	}
	//모든 사진지우기(뷰에서만)
	function reset_photo_ul(){
		//이미지 (뷰) 초기화
		for(var i = 0; i < photo_li_id.length; i++)
			$("#li_" + photo_li_id[i]).remove();
		//파일 폼 상태 초기화
		$('#upload_file').val('');
		photo_li_id = [];//파일폼인덱스 초기화
	}
	//사진하나를 서버에 임시 업로드
	function uploadTempPhoto(target_photo_cnt){
		var fd = new FormData($("#upload_file_frm")[0]);
		photo_temp_url.push(target_photo_cnt);
		$.ajax({
			url:"/api/room/enroll/temp_photo",
			type: "POST",
			data: fd,  
			enctype: 'multipart/form-data',
	        processData: false,
	        contentType: false,
	        cache: false,
	        async: true,
	        success: function (data) {
	        	if(data.tempPath == "ErrExtension"){
    				alert('jpg만 지원합니다.');
    				remove(target_photo_cnt);
	        	}else if(data.tempPath == "ErrSize"){
    				alert('10MB를 초과했습니다.');
    				remove(target_photo_cnt);
	        	}else if(data.tempPath == "ErrLogin"){
    				alert('다시 로그인해주세요.');
    				remove(target_photo_cnt);
    				document.location.href ="/";
	        	}else{
    				photo_temp_url.splice(target_photo_cnt, 1, data.tempPath); 
    				temp_enroll_num++;
	        	}
	        },
	        error:function(request,status,error){
	            alert('등록 실패');//서버에러
	        }
		});
	}
	//사진모두를 서버에  업로드(파일경로저장 , ftp업로드, 강남방서버 업로드)
	function uploadAllPhoto(){
		if(photo_li_id.length < 3){
			alert('사진등록은 3개 이상만 등록 가능합니다.');
			return;
		}
		if(temp_enroll_num !=  photo_temp_url.length){//등록할 이미지의 수와 임시로등록된이미지의수가 다르면 종료(임시업로드 처리중에있으면)
			alert('사진을 찾고있습니다. 잠시후 다시 시도해주세요');
			return;
		}
		var path_data = [];
		for(var i = 0; i < photo_li_id.length; i++)
			path_data.push(photo_temp_url[photo_li_id[i]]);//선택된사진들의(뷰에 보여지는) 경로만 데이터로지정
	    $.ajax({
	        type: 'POST',
	        url: "/api/room/"+"${no}"+"/photo",
	        contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(path_data),
	        async: true,
	        success: function(result) {
	        	if(result){
	        		alert('등록이 완료되었습니다.');
	    	       	window.location.reload();//성공시에 뷰 새로고침
	        	}else {
	        		alert('다시 로그인해주세요.');		
	        		document.location.href = "/";//초기화면
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	        	document.location.reload();
	            alert('등록 실패 : 다시 시도해주세요');
	        }
	    });
	}
</script>

<!-- 사진클릭 이벤트 -->
<script>
	/* 사진 하나 선택시  */
	function selectPhoto(index){
		//선택한이미지의 경로를  큰이미지의 경로로 바꿔준다.
		$('#selected_photo').attr('src' , $("#img_"+index).attr('src'));
		//선택한 이미지의 인덱스로 페이지 표시
		$("#cur_page").text(index*1 + 1);  
		$("#tot_page").text('${room.fake_url.size()}');
	}
	/* 보여지는 작은 이미지들의 좌우 페이지 이동 */
	var page = 1;
	function showPhoto(direction){
		if(direction =='left' && 1 < page)
			page -= 1;//한 페이지 앞의 이미지 선택
		else if(direction =='right' && page*8  < '${room.fake_url.size()}'){
			page += 1;//한 페이지 뒤의 이미지선택
		}
		//전체 안보이게하기
		for(var i = 0; i < '${room.fake_url.size()}'; i++){
		     $("#li_"+ i ).hide();
		}
		//선택된 페이지만 보이기
		for(var i = (page-1)*8; i < (page)*8  && i < '${room.fake_url.size()}'; i++){
		     $("#li_"+ i ).show();
		}
	}
	//보여지는 메인 사진 설정
	var select_index = 0;
	function showBigPhoto(direction){
		if(direction =='left' && 0 < select_index)//선택된 사진이 맨앞의 이미지가 아니면
			select_index -= 1;//한칸앞의 이미지 선택
		else if(direction =='right' && select_index < '${room.fake_url.size()}' -1){//선택된 사진이 맨뒤의 이미지가아니면
			select_index += 1;//한칸 뒤의 이미지선택
		}
		selectPhoto(select_index);
	}
</script>

<!-- 코멘트팝업 -->
<script>
	//코멘트달기 에대한설명 닫기 보이기
	setTimeout(function(){
		 setCommentDescState();
	},3000);
	function setCommentDescState(){
		$("#comment_desc").toggle();
	}
</script>
<script>
	//코멘트 추가
	function addComment(){
		var data = {};
		data["text"] = $("#comment_input").val();
	    $.ajax({
	        type: 'PUT',
	        url: "/api/room/"+"${room.no}"+"/agent/comment",
	        contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(data),
	        async: false,
	        success: function(result) {
	        	if(result == 1){
	        		alert('등록되었습니다.');
	        	}else if(result == -1){
	        		alert('해당 매물의 코멘트수는 제한 초과되었습니다.');
	        	}else if(result == -2){
	        		alert('회원님이 등록한 코멘트가 이미 존재합니다.');
	        	}
	        	getComment();
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert('등록 실패 : 다시 시도해주세요');
	        }
	    });
	}
	//코멘트들을 서버로부터 get
	function getComment(){
		 $.ajax({
			 	type : "GET",
				dataType : "json",
		        url: "/api/room/"+"${room.no}"+"/agent/comment",
		        async: false,
		        success: function(result) {
		        	setComment(result);
		        	$("#comment_size").text(result.commentList.length);
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        }
		    });
      //  $("#comment_input").load(window.location.href+" #comment_input");
	}
	//서버로부터 얻은 코멘트들을 뷰에 출력
	function setComment(data){
		//방상세보기 기본 페이지에서 코멘트 출력 
		var str='';
		var  infor;
		var comment_show ='';
		$("#comment_list_background").empty();
		for(var a = 0; a < data.commentList.length ; a++){
			infor = data.commentList[a];
			if(a==0) comment_show = "row on";
			else     comment_show = "row";
			str+="	<div class=\"" +  comment_show + "\">";
			str+="	<div class=\"profile\">"
			str+="		<span class=\"pic\"><img";
			str+="			src=\"${pageContext.request.contextPath}/images/common/account50_mint.png\"";
			str+="			alt=\"\" /></span>";
			str+="	</div>";
			str+="	<div class=\"text_wrap\">";
			str+="		<div class=\"text\">";
			str+="			<p class=\"agt_box\">";
			str+="				<span class=\"agt_name\">"+infor.name+"</span>";
			str+="				<span class=\"agt_tel\">"+infor.phone+"</span>";
			str+="			</p>";
			str+="			<p class=\"txt\">"+infor.text+"</p>";
			str+="			<p class=\"date\">"+infor.date+"</p>";
			str+="		</div>";
			str+="	</div>";
			str+="</div>";
		}
		$("#comment_list_background").append(str);
		
		//코멘트달기 팝업 창의 코멘트 출력 
		var str='';
		var  infor;
		$("#comment_list_popup").empty();
		for(var a = 0; a < data.commentList.length ; a++){
			infor = data.commentList[a];
			if(a==0) comment_show = "row on";
			else     comment_show = "row";
			str+= "<!--row마감-->";
			str+= "	<div class=\"row\">";
			str+= "		<div class=\"profile\">";
			str+= "			<span class=\"pic\"><img";
			str+= "				src=\"${pageContext.request.contextPath}/images/common/account50_mint.png\"";
			str+= "				alt=\"\" /></span>";
			str+= "		</div>";
			str+= "		<div class=\"text_wrap\">";
			str+= "			<div class=\"text\">";
			str+= "				<p class=\"agt_box\">";
			str+= "					<span class=\"agt_name\">"+infor.name+"</span>";
			str+= "		            <span class=\"agt_tel\">"+infor.phone+"</span>";
			str+= "				</p>";
			str+= "				<p class=\"txt\">"+infor.text+"</p>";
			str+= "				<p class=\"date\">"+infor.date+"</p>";
			str+= "			</div>";
			str+= "</div>";
			str+= "</div>";
		}
		$("#comment_list_popup").append(str);
	}
</script>


<!-- 수정 요청 팝업 -->
<script>
	//수정내역 기록 가져오기 /수정요청 팝업창에 체크상태로 보여주기
	function getModifyText(){
	    $.ajax({
	        type: 'GET',
	        url: "/api/room/"+"${room.no}"+"/agent/modify_room_info",
	        async: false,
	        success: function(data) {
	        	setModifyText(data);
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	        }
	  	 });
	}
	//가져온 수정요청내역을 체크상태로 보임
	function setModifyText(data){
		var infor = data.modifyText;
		if(infor.length == 0)//기존 수정요청 내역이 없으면
			return;
		if(infor[0]  != "")
			$("#modify_phone").prop("checked", true);
		if(infor[1]  != "")
			$("#modify_cost").prop("checked", true);
		if(infor[2]  != "")
			$("#modify_option").prop("checked", true);
		if(infor[3]  != "")
			$("#modify_other").prop("checked", true);
		if(typeof infor[4] != "undefined") 
			document.getElementById("other_content").value = infor[4] ;
		if(infor[5]  != "")
			$("#modify_photo_add").prop("checked", true);
		if(infor[6]  != "")
			$("#modify_photo_remove").prop("checked", true);
		if(typeof infor[7] != "undefined") 
			document.getElementById("photo_remove_content").value = infor[7];
	}
	//수정내역 추가
	function addModifyText(){
		//수정내역 추가하기
		var data = {};
		data["text"] = getModifyCheck();
	    $.ajax({
	        type: 'PUT',
	        url: "/api/room/"+"${room.no}"+"/agent/modify_room_info",
	        contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(data),
	        async: false,
	        success: function(result) {
	        	if(result == 1){
	        		alert('수정 요청 되었습니다.');
	        	}else if(result == 2){
	        		alert('수정 요청 사항이 변경 되었습니다.');
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert('등록 실패 : 다시 시도해주세요');
	        }
	    });
	}
	//수정내역들을 하나의 문자열로 합침 구분자 =>" :"  
	function getModifyCheck(){
		var checkStr='';
		var token = ":"
		if ($("#modify_phone").is(":checked")) //전화번호 수정 체크시
			checkStr += '잘못된 전화번호 입니다.'; 
		checkStr += token;
		if ($("#modify_cost").is(":checked")) //금액 수정 체크시
			checkStr += '금액이 잘못 되었습니다.'; 
		checkStr += token;
		if ($("#modify_option").is(":checked")) //옵션 수정 체크시
			checkStr += '옵션이 잘못 되었습니다.';
		checkStr += token;
		if ($("#modify_other").is(":checked")) //기타 수정 체크시
			checkStr += '기타.'; 
		checkStr += token; //기타체크사항 추가
		if ($("#modify_other").is(":checked")) //기타 수정 체크시
			checkStr += $("#other_content").val(); 
		checkStr += token; //기타내용 추가
		if ($("#modify_photo_add").is(":checked")) //사진추가 수정 체크시
			checkStr += '사진을 추가해주세요.'; 
		checkStr += token;
		if ($("#modify_photo_remove").is(":checked")) //사진삭제 수정 체크시
			checkStr += '사진을 삭제해주세요.';
		checkStr += token;
		if ($("#modify_photo_remove").is(":checked")) //사진삭제 수정 체크시
			checkStr += $("#photo_remove_content").val();
		return checkStr;
	}
</script>

<!-- 허위매물신고 -->
<script>
	//허위매물신고 기록 가져오기 /허위매물신고 팝업창에 체크상태로 보여주기
	function getFakeText(){
	    $.ajax({
	        type: 'GET',
	        url: "/api/room/"+"${room.no}"+"/agent/report_fake_room",
	        async: false,
	        success: function(data) {
	        	setFakeText(data);
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	        }
	  	 });
	}
	//가져온허위매물신고내역을 체크상태로 보임
	function setFakeText(data){
		var infor = data.fakeText;
		if(infor.length == 0)//기존 허위매물 신고내역이 없으면
			return;
		//허위 신고내역 기록 가져와 뷰의 체크박스 상태에 설정
		if(infor[0]  != "")
			$("#fake_exist").prop("checked", true);
		if(infor[1]  != "")
			$("#fake_photo").prop("checked", true);
		if(infor[2]  != "")
			$("#fake_infor").prop("checked", true);
		if(infor[3]  != "")
			$("#fake_other").prop("checked", true);
		if(typeof infor[4] != "undefined") 
			document.getElementById("fake_other_content").value = infor[4];
	}
	//허위매물신고 추가				
	function addFakeProperty(){
		 //수정내역 추가하기
		var data = {};
		data["text"] = getFakeCheck();
	    $.ajax({
	        type: 'PUT',
	        url: "/api/room/"+"${room.no}"+"/agent/report_fake_room",
	        contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(data),
	        async: false,
	        success: function(result) {
	        	if(result == 1){
	        		alert('허위 매물 신고가 접수 되었습니다.');
	        	}else if(result == 2){
	        		alert('신고내역이 수정 되었습니다.');
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert('등록 실패 : 다시 시도해주세요');
	        }
	    });  
	}
	//허위매물신고 체크사항들을 하나의 문자열로 합침 구분자 =>":"  
	function getFakeCheck(){
		var checkStr='';
		var token = ":"
		if ($("#fake_exist").is(":checked")) //전화번호 수정 체크시
			checkStr += '방이 나갔습니다.'; 
		checkStr += token;
		if ($("#fake_photo").is(":checked")) //금액 수정 체크시
			checkStr += '사진과 다릅니다.'; 
		checkStr += token;
		if ($("#fake_infor").is(":checked")) //옵션 수정 체크시
			checkStr += '표기된 정보와 다릅니다.';
		checkStr += token;
		if ($("#fake_other").is(":checked")) //기타 수정 체크시
			checkStr += '기타.'; 
		checkStr += token; 
		if ($("#fake_other").is(":checked")) //기타 수정 체크시
			checkStr += $("#fake_other_content").val();
		return checkStr;
	}
</script>

<!-- 계약완료신고 -->
<script>
	function endContract(){
		$.ajax({
			type : 'PUT',
			url : "/api/room/" + "${room.no}" + "/agent/complete_contract" ,
			async : false,
			success : function(data) {
				if(data){
					alert('계약완료 되었습니다. 매물로 이용 불가능합니다.');
					/* $("#popup_contract").hide(); */
					document.location.href = "/search";
				}else{
					alert('이미 계약 또는 취소된 방입니다.');
				}
			},
			error : function(xhr, status, error) {
			}
		});
	}
</script>

<!-- 거래가 게산하여 출력-->
<script>
     function setPrice(){
    	   //거래 종류 설정
			var type ='';
		    if(0 != (("${room.type}"*1)&1)) 
		    	type +='매매,';
		    if((0 != (("${room.type}"*1)&2))   &&(0 != (("${room.type}"*1)&4)))
		    	type +='전월세,';
		    if(0 != (("${room.type}"*1)&2))
		    	type +='전세,';
		    if(0 != (("${room.type}"*1)&4))
		    	type +='월세,';
		    if(0 != (("${room.type}"*1)&8))
			    type +='단기임대,';

		    //전세/월세/임대에 따라 거래가 설정
			//1매매/2전세/4월세/6전월세/8단기임대
		    var charter_deposit =  commaMoney("${room.charter_deposit}");// 전세가
		    var sale_price = commaMoney("${room.sale_price}");//매매가
			var deposit= commaMoney("${room.deposit}");// 보증금
			var monthly_rent= commaMoney("${room.monthly_rent}");//월세
			var maintenance_cost = ("${room.maintenance_cost}"*1)/10000;
			maintenance_cost= commaMoney(maintenance_cost);//관리비
			var deposit_modify= commaMoney("${room.deposit_modify}");//보증금협의가능
			var trade_price ='';
			if(0 != (("${room.type}"*1)&1)){//매매이면
				//매매가표시
				trade_price += ("<span class=\"deposit\"> "+ sale_price  + "</span>");
				trade_price +=", ";
			}
			if((0 != (("${room.type}"*1)&2)) && ((("${room.type}"*1)&4) != 0)){//전월세 이면
				//전세,보증금,월세,관리비 표시
				trade_price += ("<span class=\"deposit\"> "+ charter_deposit + "</span>" + "<span class=\"bar\">/</span>");
				trade_price += ("<span class=\"month\">" + deposit);
				if(deposit_modify == 1)
					trade_price += "(협의가능)";
				trade_price += ("/" + monthly_rent);
				trade_price += ("/" + maintenance_cost+ "</span>");
				trade_price +=", ";
			}
			else if(0 != (("${room.type}"*1)&2)){//전세이면(전월세에 포함)
				//전세가/관리비 표시
				trade_price += ("<span class=\"deposit\"> "+ charter_deposit + "/" + maintenance_cost + "</span>");
				trade_price +=", ";
			}
			else if(0 != (("${room.type}"*1)&4)){//월세이면(전월세에 포함)
				//보증금/월세/관리비 표시
				trade_price += ("<span class=\"deposit\"> "+ deposit + "</span>"+
				"<span class=\"bar\">/</span>"+
				"<span class=\"month\">" +  monthly_rent + "/" + maintenance_cost  + "</span>");
				if(deposit_modify== 1)
					trade_price += "(보증급 협의가능)";
				trade_price +=", ";
			}else if(0 != (("${room.type}"*1)&8)){//단기임대이면(전월세, 월세에 포함)
				//보증금/월세 /관리비 표시
				trade_price += ("<span class=\"deposit\"> "+ deposit + "</span>"+
				"<span class=\"bar\">/</span>"+
				"<span class=\"month\">" +  monthly_rent + "/" + maintenance_cost  +"</span>");
				if(deposit_modify == 1)
					trade_price += "(보증급 협의가능)";
				trade_price +=", ";
			}
    	  var str ='';
    	  str+= "<span class=\"txt1\">";
    	  str+= type;
    	  str+= "</span>";
    	  str+= "<span class=\"price\"> ";
    	  str+= trade_price;
    	  str+= "</span>";
     	  $("#price").append(str);
    }
  	function commaMoney(str){
  		return str;
  	}
</script>

<!-- 임대인연락처보기/ 매물담기 팝업 -->
<script>
	//***************************** 주기능 : 매물담기*******************
	//중개사의 고객생성
	var client_no =-1;
	function createUser() {
		//고객생성정보 값 설정
		var data = {};
		data["explain"] = $("#customer_desc").val();
		data["name"] = $("#customer").val();
		data["client_no"] = client_no;
		
		if($("#customer_desc").val() == '' || $("#customer").val() ==''){
			alert('정보를 보두 입력해주세요.');
			return;
		}
		
		//설정된 고객정보값을 서버에 저장
		$.ajax({
			type :  'POST',
			dataType : "json",
			url : "/api/room/agent/interest/client" ,
			contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(data),
			async : false,
			success : function(data) {
				if(data){
					// 추가된 고객의 정보를 함께 가져와 뷰에 설정
					getCartUser();
					alert('등록되었습니다.');
				}
				else
					alert('이미 등록된 연락처와 이름입니다.');
					
			},
			error : function(xhr, status, error) {
			}
		});
	}
	//한 중개사의 고객 정보들을 서버로부터 get
	function getCartUser(){
		//한 중개사의 고객리스트를 가져옴
		 $.ajax({
			 	type : "GET",
				dataType : "json",
		        url: "/api/room/agent/interest/client",
		        async: false,
		        success: function(result) {
		        	//한 중개사의 고객리스트를 모두가져와 고객리스트로 뷰에 셋팅
		        	setCartUser(result);
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        }
		    });
      //  $("#comment_input").load(window.location.href+" #comment_input");
	}
	function setCartUser(data){
	 	//고객들의 정보를 뷰에 셋팅
		var str='';
		var  infor;
		$("#cartUserInShowContact").empty();//고객리스트 초기화
		//한 중개사의 모든 고객의 정보를 추가()
		for(var a = 0; a < data.cartUserList.length ; a++){
			infor = data.cartUserList[a];
			str+="	<li>";
			str+="	    <div>";
			str+="		    <label> <span> <input type=\"checkbox\"  value =\""+ infor.no +"\" name =\"checkContact\"/>";
			str+="		        </span> <span class=\"txt\"> "+ infor.name +" </span>";
			str+="          </label>";
			str+="      </div>";
			str+="  </li> ";
		} 
		$("#cartUserInShowContact").append(str);
		
		str='';
		//한 중개사의 모든 고객의 정보를 추가(관심 매물추가하는 팝업, 고객선택리스트)
		$("#cartUserInCheck").empty();
		for(var a = 0; a < data.cartUserList.length ; a++){
			infor = data.cartUserList[a];
			str+="	<li>";
			str+="	    <div>";
			str+="		    <label> <span> <input type=\"checkbox\"  value =\""+ infor.no +"\" name=\"checkCartUser\"/>";
			str+="		        </span> <span class=\"txt\"> "+ infor.name +" </span>";
			str+="          </label>";
			str+="      </div>";
			str+="  </li> ";
		} 
		$("#cartUserInCheck").append(str);
		
	}
	//관심매물추가 기능에서(고객을 선택한 이후) 관심매물을 추가해주는 기능
	function addSelectItem(){
		//고객을 다중으로 선택시 여러고객의 번호를 서버에 보내기위해 배열에 담음
		var data = [];
		for(var i =0; i < $("input[name=checkCartUser]").length; i++){
			var checkUser = document.getElementsByName("checkCartUser");
			if(checkUser[i].checked){
				data.push($("input[name=checkCartUser]:eq(" + i + ")").val());
			}
		}
		//관심매물을 서버에 저장
		 $.ajax({
				type : "PUT",
		        url: "/api/room/"+ "${room.no}" +"/agent/interest",
		        contentType: 'application/json; charset=utf-8',
		        data: JSON.stringify(data),
		        async: false,
				success : function(data) {
					alert('등록되었습니다. 이미 등록한 고객의 경우는 등록되지 않습니다.');
				},
				error : function(xhr, status, error) {
				}
		 });
	}
	//고객명 자동완성 /기존고객여부확인
	function setAutoUserWord(){
		$("#customer").keyup(
				function(event) {
					client_no =-1;
					//값을 세팅
					currentWord = $("#customer").val();
					if (!currentWord)//입력값이 없으면
						return;
					jQuery.ajax({
						type : "GET",
						dataType : "json",
						url : "/api/room/agent/interest/client_list?name=" + encodeURI(encodeURIComponent(currentWord)),
						async : false,
						success : function(data) {//msg를 받는 것이 성공하면
							autoWord = new Array();
							for (var i = 0; i < data.userList.length; i++)
								autoWord.unshift(data.userList[i].name + ""
										+ data.userList[i].phone);
							$("#customer").autocomplete({
								source : autoWord,
							    appendTo : $("#cust_make"),
								select: function(event, ui) {
							        for (var i = 0; i < data.userList.length; i++){
							        	if(autoWord[data.userList.length - i -1] == ui.item.label){//선택한 단어와 가져왔던 자동완성이 일치하면
							        		//페이지 표시 초기화
							        		client_no = data.userList[i].no;
										    break;
							        	}
							        } 
							        //autocomplete reset(prevent double clicked)
							        $("#customer").autocomplete({
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
	//***************************** 주기능 : 임대인 연락처 확인**************************
	//고객선택 팝업
	function popup_lessor2(){
        $("#popup_lessor").hide();
      	$("#popup_lessor2").show();
		getCartUser();//고객의 정보를 보여줌
	}
	//임대인 연락처확인 팝업
	function popup_lessor3(data){
        $("#popup_lessor").hide();
        $("#popup_lessor2").hide();
      	$("#popup_lessor3").show();
		getContact(data);
	}
	function selectPopup(){
		if ($("#radio_photo").is(":checked")) //사진을 찍기 위해 연락처를 확인하는경우  연락처 팝업으로
			popup_lessor3();
		else if ($("#radio_visit").is(":checked")) //고객과의 방문을위해 연락처를 확인하는경우  고객선택 팝업으로
			popup_lessor2();
		else
			alert('연락처 확인 이유를 선택해주세요.');
	}
	function showContactPopup(){
		var selected = false;
		var data = [];
		for(var i =0; i < $("input[name=checkContact]").length; i++){
			var checkUser = document.getElementsByName("checkContact");
			if(checkUser[i].checked){
				data.push($("input[name=checkContact]:eq(" + i + ")").val());
				selected = true;
			}
		}
		if(selected){
			popup_lessor3(data);
		}else{
			alert('상담고객을 선택해주세요.');
		}
	}
	//임대인 연락처확인 기록(고객들의 번호 data)/ 임대인의 연락처를 얻음
	function getContact(data){
		if(typeof data == "undefined") 
		 data  = [];
		 $.ajax({
			 type : "POST",
				dataType : "json",
		        url: "/api/room/"+ "${room.no}" +"/agent/lessor_phone",
		        contentType: 'application/json; charset=utf-8',
		        data: JSON.stringify(data),
		        async: false,
				success : function(data) {
					setContact(data.lessorInfor);
				},
				error : function(xhr, status, error) {
				}
		 });
	}
	//임대인의 연락처를 뷰에 보임
	function setContact(lessor){
		var str ='';
		var cnt = 1;
		if(lessor.contact_who_1 != ''){
			str+="<p>연락처" + (cnt++) +" ("+ lessor.contact_who_1 +") : "
				+ lessor.contact_phone_1 + "</p>";
		}if(lessor.contact_who_2 != ''){
			str+="<p>연락처" + (cnt++) +"  ("+ lessor.contact_who_2 +") : "
			+ lessor.contact_phone_2 + "</p>";
		}if(lessor.contact_who_3 != ''){
			str+="<p>연락처" + (cnt++) +" ("+ lessor.contact_who_3 +") : "
			+ lessor.contact_phone_3 + "</p>";
		}if(lessor.contact_who_4 != ''){
			str+="<p>연락처" + (cnt++) +" ("+ lessor.contact_who_4 +") : "
			+ lessor.contact_phone_4 + "</p>";
		}
		$("#contact_div").empty();
		$("#contact_div").append(str);
	}
</script>

<!-- 인쇄 -->
<script type="text/javascript">
	function print()
	{		/* 	win = window.open(); 
			self.focus(); 
			win.document.open();
			win.document.write('<html><'head'><title></title><style>');
			win.document.write('</style></haed><body>');
			win.document.write(document.getElementById('ss').innerHTML);
	 		win.document.write('</body></html>');
			win.document.close();
			win.print();
			win.close(); */
	}
</script>

<!-- 상담문의신청 -->
<script>
	//문의 신청추가
	function applyConsult(){
		var data = {};
		data["phone"] = $("#cust_tel").val();
		data["comment"] = $("#cust_time").val();
		//설정된 고객정보값을 서버에 저장
		$.ajax({
			type: 'POST',
	        url: "/api/room/"+"${room.no}"+"/consult",
	        contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(data),
			async : false,
	
	        success: function(result) {
	        	if(result)
	        		alert("상담이 신청되었습니다.");
	        	else 
	        		alert('이미 신청하셨습니다.');
	        },
			error : function(xhr, status, error) {
				alert('등록실패! 다시 시도해주세요.');
			}
		});
	}

</script>

<!-- 지도 -->
<script type="text/javascript"
	src="//apis.daum.net/maps/maps3.js?apikey=<%=GlobalValue.mapApi%>"></script>
<script>
	/************************* 지도 뷰 생성************************************/
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng("${room.lat}","${room.lng}"), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };
	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	/*************************마커로 위치표시************************************/
	var marker = new daum.maps.Marker({
	    position: new daum.maps.LatLng("${room.lat}","${room.lng}")
	});
	marker.setMap(map);
	
	/*************************지도 확대 축소영역 범위지정***********************/
	//지도에 시본제공되는 전체스크롤 막기
	$('#map').on({
	    'mousewheel': function(e) {
	        if (e.target.id == 'el') return;
	        e.preventDefault();
	    }
	});
	//지도영역에서의 마우스 위치
	var over_state = "out";
	daum.maps.event.addListener(map, 'mouseover', function() {
		over_state = "in";
	});
	daum.maps.event.addListener(map, 'mouseout', function() {
		over_state = "out";
	});
	//확대 축소 범위지정
    var delta = 0;
    window.addEventListener('DOMMouseScroll', wheel, false);
	window.onmousewheel = document.onmousewheel = wheel;
	map.setZoomable(false);
	function wheel(event){
	    if (!event) event = window.event;
	    if (event.wheelDelta) {
	        delta = event.wheelDelta/120;
	        if (window.opera) delta = -delta;
	    } 
	    else if (event.detail) delta = -event.detail/3;
		if( over_state =="in"){//마우스가 지도안에 있을때
			if(<%= request.isUserInRole("ROLE_AGENT")%>){//중개사 로그인시에
				map.setZoomable(true);//확대 축소 범위 무제한
			} else if(delta < 0){//휠 아래로/지도축소시
				map.setZoomable(true);//확대 축소 범위 무제한
		    } else if(delta > 0){//휠 위래/지도확대시
		    	if (5 < map.getLevel()){
					map.setZoomable(true);//확대가능
		    	}else{//250m축적부터는  더 이상 확대 불가
		    		map.setZoomable(false);
		    	}
		    }	
		}
	}
</script>

<!-- 지도에서의 인근 위치정보 -->
<script>
	/************************* 인근 위치정보 설정************************************/
	$(document).ready(function(){
		var lat = "${room.lat}";
		var lng = "${room.lng}";	
		setNearInfor('SW8', lat , lng , 'station');
		setNearInfor('CS2', lat , lng , 'convenience');
		setNearInfor('PO3', lat , lng , 'offices');
		setNearInfor('BK9', lat , lng , 'bank');
		
		//지도 위치 설정
		var coords = new daum.maps.LatLng(lat, lng);
		map.setCenter(coords);
	})
	function setNearInfor(code, lat , lng, target) {
		var  information = '' ;
		jQuery
		.ajax({
			type : "GET",
			dataType : "json",
			url : "https://apis.daum.net/local/v1/search/category.json?apikey=<%=GlobalValue.mapApi%>&location="
					+lat+","+lng+"&radius=500&code="+code+"&sort=2" + "&count=6" ,
			async : false,
			dataType : "jsonp",
			success : function(data) {//msg를 받는 것이 성공하면
				for(var i=0; i < data.channel.item.length; i++){
					if(i == 0)
						information = data.channel.item[i].title +
						'('  + data.channel.item[i].distance + 'm)';
					else if(0 < i )
						information += ',   '+ data.channel.item[i].title +
						'('  + data.channel.item[i].distance + 'm)';
				}
				$('#'+target).append(information);
			},
			error : function(xhr, status, error) {
			}
		});
	}
</script>

<script>
	//중개사들이 볼수 있는 메뉴를 보여주기/숨기기
	function showAgentMenu(){
		if($("#btn_agent").hasClass("opened")) 
			 $("#btn_agent").removeClass("opened");	
		else
			 $("#btn_agent").addClass("opened");
	}
</script>