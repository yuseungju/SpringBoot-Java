<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
									<img id="profile" src="${pageContext.request.contextPath}/images/common/account50_mint.png" alt="중개사" />
								</p>
								<p class="name" >
									<sec:authentication property="principal.realname"/>
								</p>
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
				<!--consult_header마감-->
				<div class="panel">
	
					<!--div class="search_section filter_opened"필터옵션 더보기-->
					<div class="search_section" style="display:none;">
						<div class="filter ">
							<div class="filter_section">
								<div class="filter_body">
									<!--키워드-->
									<div class="row intro_filter">
										<div class="col2 mid_col1 fl tbl ">
											<div class="filter_label">
												<label>키워드</label>
											</div>
											<div class="filter_group r_border">
												<div class="filter_item col text">
													<div class="inner">
														<label for="keyword" class="blind">키워드</label>
														<div class="input col_wide">
															<span> <input type="text" id="keyword"
																placeholder="동, 지하철역, 매물번호를 입력해 주세요" />
															</span>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!--전용면적-->
										<div class="col2 mid_col1 fl tbl mid_t_border">
											<div class="filter_label">
												<label>섹터</label>
											</div>
											  <div class="filter_group">
                                                    <div class="filter_item col select">
                                                        <div class="inner col2 fl">
                                                            <label for="sector1" class="blind">섹터구선택</label>
                                                                   <select id="sector1" >
                                                                    </select> 
                                                        </div>       
                                                        <div class="inner col2 fl">
                                                            <label for="sector2" class="blind">섹터동선택</label>
	                                                        	<select id="sector2" >
	                                                        	</select>
                                                        </div>
                                                       </div>
                                                    </div>
										</div>
									</div>
									<!-- 키워드 섹션 row intro_filter마감-->
									<!--거래종류-->
									<div class="row intro_filter">
										<div class="col tbl">
											<div class="filter_label">
												<label>거래종류</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col6 sm_col2 t_col3 panel check">
													<div class="inner">
														<label> <span class="txt"> 전체 </span> <span
															class="input"> <input type="checkbox"  name ="trade_type" id ="all_type" onclick ="checkBoxAllTradeType()" 
																checked="checked" />
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col6 sm_col2 t_col3 panel check">
													<div class="inner">
														<label> <span class="txt"> 매매 </span> <span
															class="input"> <input type="checkbox"  name ="trade_type"  id ="trade"  onclick ="checkBoxTradeType()"/>
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col6 sm_col2 t_col3 panel check">
													<div class="inner">
														<label> <span class="txt"> 전세 </span> <span
															class="input"> <input type="checkbox"  name ="trade_type"  id ="charter"  onclick ="checkBoxTradeType()"/>
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col6 sm_col2 t_col3 panel check">
													<div class="inner">
														<label> <span class="txt"> 전월세 </span> <span
															class="input"> <input type="checkbox"  id="monthly_and_charter"  onclick ="checkBoxTradeType()"/>
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col6 sm_col2 t_col3 panel check">
													<div class="inner">
														<label> <span class="txt"> 월세 </span> <span
															class="input"> <input type="checkbox"  name ="trade_type"  id="monthly"  onclick ="checkBoxTradeType()"/>
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col6 sm_col2 t_col3 panel check">
													<div class="inner">
														<label> <span class="txt"> 단기임대 </span> <span
															class="input"> <input type="checkbox" name ="trade_type"  id="short_lease"  onclick ="checkBoxTradeType()" />
														</span>
														</label>
													</div>
												</div>
											</div>
	
										</div>
									</div>
									<!--row intro_filter 거래종류마감-->
									<!--건물종류-->
									<div class="row intro_filter">
										<div class="col tbl">
											<div class="filter_label">
												<label>건물종류</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col5 sm_col2 t_col3  panel check">
													<div class="inner">
														<label> <span class="txt"> 전체 </span> <span
															class="input"> <input type="checkbox"
																checked="checked" onclick="checkBoxAllBuildingType()" id="all_building_type"/>
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col2 t_col3  panel check">
													<div class="inner">
														<label> <span class="txt"> 아파트 </span> <span
															class="input"> <input type="checkbox"  name="building_type"   onclick="checkBoxBuildingType()" id="apartment" />
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col2 t_col3  panel check">
													<div class="inner">
														<label> <span class="txt"> 오피스텔 </span> <span
															class="input"> <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()" id="officetel"  />
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col2 t_col3  panel check">
													<div class="inner">
														<label> <span class="txt"> 주택 </span> <span
															class="input"> <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()" id="house" />
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col2 t_col3  panel check">
													<div class="inner">
														<label> <span class="txt"> 원룸 </span> <span
															class="input"> <input type="checkbox"   name="building_type"  onclick="checkBoxBuildingType()"  id="normal_room" />
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col2 t_col3  panel check">
													<div class="inner">
														<label> <span class="txt"> 상가 </span> <span
															class="input"> <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()" id= "shop" />
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col2 t_col3  panel check">
													<div class="inner">
														<label> <span class="txt"> 사무실 </span> <span
															class="input"> <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()" id="office" />
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col2 t_col3  panel check">
													<div class="inner">
														<label> <span class="txt"> 건물 </span> <span
															class="input"> <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()" id="building"  />
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col2 t_col3  panel check">
													<div class="inner">
														<label> <span class="txt"> 재개발 </span> <span
															class="input"> <input type="checkbox" name="building_type"  onclick="checkBoxBuildingType()" id="redevelopment" />
														</span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col2 t_col3  panel check">
													<div class="inner">
														<label> <span class="txt"> 이벤트 </span> <span
															class="input"> <input type="checkbox"   name="building_type"  onclick="checkBoxBuildingType()"  id="event" />
														</span>
														</label>
													</div>
												</div>
	
											</div>
										</div>
									</div>
									<!-- 건물종류 row intro_filter마감-->
									<!--보증금-->
									<div class="row intro_filter">
										<div class="col2 fl tbl mid_col1">
											<div class="filter_label">
												<label>보증금</label>
											</div>
											<div class="filter_group r_border">
												<div class="filter_item col2 text">
													<div class="inner">
														<div class="input">
															<span> <input type="text" id="depositmin"
																placeholder="보증금최소가" />
															</span>
														</div>
														<div class="txt">~</div>
													</div>
												</div>
												<div class="filter_item col2 text">
													<div class="inner">
														<div class="input">
															<span> <input type="text" id="depositmax"
																placeholder="보증금최고가" />
															</span>
														</div>
														<div class="txt">만원</div>
													</div>
												</div>
	
											</div>
										</div>
										<!--월세-->
										<div class="col2 fl tbl mid_col1 mid_t_border">
											<div class="filter_label">
												<label>월세</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col2 text">
													<div class="inner">
														<label for="monthmin" class="blind">월세최소</label>
														<div class="input">
															<span> <input type="text" id="monthmin"
																placeholder="월세최소가" />
															</span>
														</div>
														<div class="txt">~</div>
													</div>
												</div>
												<div class="filter_item col2 text">
													<div class="inner">
														<label for="monthmax" class="blind">월세최고</label>
														<div class="input">
															<span> <input type="text" id="monthmax"
																placeholder="월세최고가" />
															</span>
														</div>
														<div class="txt">만원</div>
													</div>
												</div>
	
											</div>
										</div>
									</div>
									<!-- 월세  row intro_filter마감-->
									<!--전세가-->
									<div class="row intro_filter">
										<div class="col2 fl tbl mid_col1">
											<div class="filter_label">
												<label>전세가</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col2 text">
													<div class="inner">
														<label for="leasemin" class="blind">전세최소</label>
														<div class="input">
															<span> <input type="text" id="chartermin"
																placeholder="전세최소가" />
															</span>
														</div>
														<div class="txt">~</div>
													</div>
												</div>
												<div class="filter_item col2 text">
													<div class="inner">
														<label for="leasemax" class="blind">전세최고</label>
														<div class="input">
															<span> <input type="text" id="chartermax"
																placeholder="전세최고가" />
															</span>
														</div>
														<div class="txt">만원</div>
													</div>
												</div>
	
											</div>
										</div>
										<!--기준가-->
										<div class="col2 fl tbl mid_col1 mid_t_border">
											<div class="filter_label">
												<label>기준가</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col2 text">
													<div class="inner">
														<label for="standardmin" class="blind">기준가최소</label>
														<div class="input">
															<span> <input type="text" id="standardmin"
																placeholder="기준최소가" />
															</span>
														</div>
														<div class="txt">~</div>
													</div>
												</div>
												<div class="filter_item col2 text">
													<div class="inner">
														<label for="standardmax" class="blind">기준가최고</label>
														<div class="input">
															<span> <input type="text" id="standardmax"
																placeholder="기준최고가" />
															</span>
														</div>
														<div class="txt">만원</div>
													</div>
												</div>
	
											</div>
										</div>
									</div>
									<!-- 기준가 row intro_filter마감-->
									<!--준공년도-->
									<div class="row ">
										<div class="col2 fl tbl  mid_col1">
											<div class="filter_label">
												<label>준공년도</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col select">
													<div class="inner">
														<label for="built" class="blind">준공년도</label> <select
															id="built">
						                                  <option>전체</option>
															<c:forEach var="i" begin="2000" end="2015">
						                                  		<option value ="${ i }">${ i } 이전</option>
															</c:forEach>
														</select>
													</div>
												</div>
	
											</div>
										</div>
										<!--번지-->
										<div class="col2 fl tbl mid_col1 mid_t_border">
											<div class="filter_label">
												<label>번지</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col text">
													<div class="inner">
														<label for="address" class="blind">번지</label>
														<div class="input no_txt col_wide">
															<span> <input type="text" id="address"
																placeholder="예)123-45" />
															</span>
														</div>
													</div>
												</div>
	
											</div>
										</div>
									</div>
									<!-- 번지 row intro_filter마감-->
									<!--룸개수-->
									<div class="row">
										<div class="col tbl">
											<div class="filter_label">
												<label>룸종류</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> 
														<input type="checkbox"  onclick ="checkRoomType()" id=all_room_type checked="checked"/>
														</span> <span class="txt"> 상관없음 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name ="room_type" id="open_room" onclick ="checkAnyRoomType()" />
														</span> <span class="txt"> 오픈형 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name ="room_type"  id="part_room" onclick ="checkAnyRoomType()"/>
														</span> <span class="txt"> 분리형 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"    name ="room_type"  id="duplex_room" onclick ="checkAnyRoomType()"/>
														</span> <span class="txt"> 복층형 </span>
														</label>
													</div>
												</div>
											</div>
	
										</div>
									</div>
									<!-- 룸개수 row intro_filter마감-->
									<!--룸종류-->
									<div class="row">
										<div class="col tbl">
											<div class="filter_label">
												<label>룸개수</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  onclick="checkRoomNum()" id=all_room_count checked="checked"/>
														</span> <span class="txt"> 상관없음 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="room_num" id= "one_room"  onclick="checkAnyRoomNum()" />
														</span> <span class="txt"> 원룸 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="room_num" id= "two_room"  onclick="checkAnyRoomNum()" />
														</span> <span class="txt"> 투룸 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="room_num" id = "three_room"  onclick="checkAnyRoomNum()" />
														</span> <span class="txt"> 쓰리룸+ </span>
														</label>
													</div>
												</div>
											</div>
	
										</div>
									</div>
									<!-- 룸종류 row intro_filter마감-->
									<!--층수-->
									<div class="row">
										<div class="col tbl">
											<div class="filter_label">
												<label>층수</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col5  mid_col2  check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" onclick="checkRoomPosition()" id="all_room_position" checked="checked"/>
														</span> <span class="txt"> 상관없음 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col5  mid_col2  check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name ="room_position"  id="up_ground" onclick="checkAnyRoomPosition()" />
														</span> <span class="txt"> 지상 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col5  mid_col2  check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name ="room_position" id="under_ground" onclick="checkAnyRoomPosition()" />
														</span> <span class="txt"> 지하 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col5  mid_col2  check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name ="room_position"  id="semi_basement"  onclick="checkAnyRoomPosition()" />
														</span> <span class="txt"> 반지하 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col5  mid_col2  check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"   name ="room_position"  id="rooftop" onclick="checkAnyRoomPosition()"/>
														</span> <span class="txt"> 옥탑방 </span>
														</label>
													</div>
												</div>
											</div>
	
										</div>
									</div>
									<!-- 층수 row intro_filter마감-->
									<!--공급면적-->
									<div class="row">
										<div class="col2 fl tbl mid_col1">
											<div class="filter_label">
												<label>공급면적</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col2 text">
													<div class="inner">
														<label for="area1min" class="blind">공급면적최소</label>
														<div class="input">
															<span> <input type="text" id="area1min"
																placeholder="공급면적최소" />
															</span>
														</div>
														<div class="txt">~</div>
													</div>
												</div>
												<div class="filter_item col2 text">
													<div class="inner">
														<label for="area1max" class="blind">공급면적최고</label>
														<div class="input">
															<span> <input type="text" id="area1max"
																placeholder="공급면적최고" />
															</span>
														</div>
														<div class="txt">m&sup2;</div>
													</div>
												</div>
	
											</div>
										</div>
										<!--전용면적-->
										<div class="col2 fl tbl mid_col1 mid_t_border">
											<div class="filter_label">
												<label>전용면적</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col2 text">
													<div class="inner">
														<label for="area2min" class="blind">전용면적최소</label>
														<div class="input">
															<span> <input type="text" id="area2min"
																placeholder="전용면적최소" />
															</span>
														</div>
														<div class="txt">~</div>
													</div>
												</div>
												<div class="filter_item col2 text">
													<div class="inner">
														<label for="area2max" class="blind">전용면적최고</label>
														<div class="input">
															<span> <input type="text" id="area2max"
																placeholder="전용면적최고" />
															</span>
														</div>
														<div class="txt">m&sup2;</div>
													</div>
												</div>
	
											</div>
										</div>
									</div>
									<!-- 전용면적 row intro_filter마감-->
									<!--옵션-->
									<div class="row">
										<div class="col tbl">
											<div class="filter_label">
												<label>옵션</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name="inside_option" id="full_option_room"/>
														</span> <span class="txt"> 풀옵션 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="inside_option" id="airconditioner"/>
														</span> <span class="txt"> 에어컨 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name="inside_option" id ="refrigerator"/>
														</span> <span class="txt"> 냉장고 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name="inside_option" id ="washer"/>
														</span> <span class="txt"> 세탁기 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="inside_option" id ="tv"/>
														</span> <span class="txt"> TV </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name="inside_option" id ="microwave"/>
														</span> <span class="txt"> 전자레인지 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="inside_option" id ="induction"/>
														</span> <span class="txt"> 인덕션 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="inside_option" id ="sink"/>
														</span> <span class="txt"> 싱크대 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="inside_option" id ="gasrange"/>
														</span> <span class="txt"> 가스레인지 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name="inside_option" id ="sofa"/>
														</span> <span class="txt"> 소파 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="inside_option" id ="bed"/>
														</span> <span class="txt"> 침대 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="inside_option" id ="built_in_closet"/>
														</span> <span class="txt"> 붙박이장 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name="inside_option" id ="dressing_table"/>
														</span> <span class="txt"> 화장대 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="inside_option"id ="veranda"/>
														</span> <span class="txt"> 베란다 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name="inside_option" id ="shoe_closet"/>
														</span> <span class="txt"> 신발장 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
											</div>
										</div>
									</div>
									<!--옵션 row intro_filter마감-->
									<!--현관보안-->
									<div class="row">
										<div class="col tbl">
											<div class="filter_label">
												<label>보안시설</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name="security_type" onclick="checkAllSecurityType()" id ="all_security" />
														</span> <span class="txt"> 전체 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name="security_type"  onclick="checkSecurityType()"  id="door_security"/>
														</span> <span class="txt"> 현관보안 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name="security_type"  onclick="checkSecurityType()"  id ="cctv"/>
														</span> <span class="txt"> CCTV </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
												<div class="filter_item col4 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name="security_type"  onclick="checkSecurityType()"  id ="number_key"/>
														</span> <span class="txt"> 번호키 </span>
														</label>
													</div>
												</div>
												<!--filter_item마감-->
	
											</div>
										</div>
									</div>
									<!--현관보안 row intro_filter마감-->
									<!--추가사항-->
									<div class="row ">
										<div class="col tbl">
											<div class="filter_label">
												<label>추가사항</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label class="longtext"> <span class="input">
																<input type="checkbox" name ="add_option" id="elevator"/>
														</span> <span class="txt"> 엘리베이터 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name ="add_option" id ="parking"/>
														</span> <span class="txt"> 주차가능 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 mid_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name ="add_option" id="animal"/>
														</span> <span class="txt"> 반려동물 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col3 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name ="add_option" id="empty"/>
														</span> <span class="txt"> 공실 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col5 sm_col3 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox"  name ="add_option" id="sale"/>
														</span> <span class="txt"> 매물 </span>
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!--추가사항 row intro_filter마감-->
									<div class="row filter_last">
										<div class="col tbl">
											<div class="filter_label">
												<label>사진 및 영상</label>
											</div>
											<div class="filter_group">
												<div class="filter_item col4 sm_col2 radio">
													<div class="inner">
														<label class="longtext"> <span class="input">
																<input type="radio"  name="pic" id="pic_keep"/>
														</span> <span class="txt"> 사진있음 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col4 sm_col2 radio">
													<div class="inner">
														<label class="longtext"> <span class="input">
																<input type="radio" name="pic" id="pic_none" />
														</span> <span class="txt"> 사진없음 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col4 sm_col2 radio">
													<div class="inner">
														<label class="longtext"> <span class="input">
																<input type="radio"  name="movie" id="movie_keep"/>
														</span> <span class="txt"> 영상있음 </span>
														</label>
													</div>
												</div>
												<div class="filter_item col4 sm_col2 radio">
													<div class="inner">
														<label class="longtext"> <span class="input">
																<input type="radio"  name="movie" id="movie_none"/>
														</span> <span class="txt"> 영상없음 </span>
														</label>
													</div>
												</div>
	
											</div>
										</div>
									</div>
									<div class="list_end">
										<span class="blind">필터항목 더보기/ 필터항목 접기</span>
									</div>
								</div>
								<!--filter_body-->
								<div class="filter_footer ">
									<div class="col tbl">
										<div class="filter_group button">
											<div class="reset btn">
												<button type="reset" onclick= "searchResetFilter()">
													<span>초기화</span>
												</button>
											</div>
											<div class="submit  btn">
												<button type="submit" onclick ="posChangeSubmit(1)">
													<span>필터적용</span>
												</button>
											</div>
										</div>
										<!-- filter_group마감-->
									</div>
								</div>
								<!-- row filter_footer마감-->
							</div>
							<!-- filter_section마감-->
						</div>
						<!-- 필터마감-->
					</div>
					<!--search_section마감-->
	
					<div class="btn_wrap">
						<div class="room_agent_btn btn">
							<a href="/room/enroll/overlap_check">방등록</a>
						</div>
	
					</div>
					<div class="content_body">
						<h3 class="blind">등록된방 목록</h3>
						<div class="room_list table_list">
							<div class="container">
								<div class="list_header">
									<p class="count" id="searchCount">등록된 방 : 총   0개 </p>
									<!--div class="sort opened" 소트목록 오픈된상태-->
									<div class="sort first" id ="sort_select">
										<a href="#sort_list"  onclick ="allSort(); return false;" class="sort_title" id="sort_title">방정렬</a>
										<div id="sort_list" class="dropdown">
											<ul class="drop_item">
												<li><a href="#" class ="sort_li"><span>최신등록순</span></a></li>
												<li><a href="#" class ="sort_li"><span>번지수 오름차순</span></a></li>
												<li><a href="#" class ="sort_li"><span>기준가 높은 순</span></a></li>
												<li><a href="#" class ="sort_li"><span>기준가 낮은 순</span></a></li>
												<li><a href="#" class ="sort_li"><span>월세 높은 순</span></a></li>
												<li><a href="#" class ="sort_li"><span>월세 낮은 순</span></a></li>
												<li><a href="#" class ="sort_li"><span>보증금 높은 순</span></a></li>
												<li><a href="#" class ="sort_li"><span>보증금 낮은 순</span></a></li>
												<li><a href="#" class ="sort_li"><span>전용면적 높은 순</span></a></li>
												<li><a href="#" class ="sort_li"><span>전용면적 낮은 순</span></a></li>
											</ul>
										</div>
										<!--sort_list마감-->
									</div>
									<!--sort마감-->
									<!--div class="sort opened" 소트목록 오픈된상태-->
									<div class="sort" id ="page_num_select">
										<a href="#count_list" onclick ="changePageNum(); return false;" class="sort_title" id ="page_num_title">30개씩</a>
										<div id="count_list" class="dropdown">
											<ul class="drop_item">
												<li><a href="#" class = page_num_li><span>30개씩</span></a></li>
												<li><a href="#" class = page_num_li><span>60개씩</span></a></li>
												<li><a href="#" class = page_num_li><span>90개씩</span></a></li>
											</ul>
										</div>
										<!--count_list마감-->
									</div>
									<!--count마감-->
								</div>
								<!--list_heade마감-->
								<table class="fixed board_table">
									<tbody id ="room_table">
									</tbody>
								</table>
							</div>
							<!--container마감-->
							<div class="page_wrap">
								<p class="paging">
									<a href="#" onClick="posChangeSubmit('pre');" class="bor" id="pre_page">&lt;<span class="blind">이전</span></a> 
									<a href="#" onClick="posChangeSubmit('pos1');" class="current" id ="pos1">1</a>
									<a href="#" onClick="posChangeSubmit('pos2');" id ="pos2">2</a> 
									<a href="#" onClick="posChangeSubmit('pos3');" id ="pos3">3</a>
									<a href="#" onClick="posChangeSubmit('pos4');" id ="pos4">4</a> 
									<a href="#" onClick="posChangeSubmit('pos5');" id ="pos5">5</a> 
									<a href="#" onClick="posChangeSubmit('next');" class="bor" id="next_page"><span class="blind">다음</span>&gt;</a>
								</p>
							</div>
							<!--page_wrap마감 -->
						</div>
	
						<div class="information">
							<h4>강남방 방등록 절차 안내</h4>
							<ul>
								<li>일반회원은 강남방에 1개의 방만 등록하실 수 있습니다.</li>
								<li>더 많은 방을 등록하셔야 하는 회원님은 강남방으로 문의 주시길 바랍니다.</li>
								<li>강남방에 등록되는 모든 매물은 실거래 매물인지 매물정보를(주소,거래유형,가격 등) 확인 후
									공개됩니다.</li>
								<li>매물 확인은 2일 정도 소요됩니다.</li>
							</ul>
							<p class="phone">
								<strong>문의</strong> 02-568-2453
							</p>
						</div>
						<!--information마감-->
						<div class="m_search_footer">
							<div class="btn  col2 fl">
								<button class="m_sort">
									<span>정렬</span>
								</button>
							</div>
							<div class="btn col2 fl">
								<button class="m_room_filter">
									<span>검색필터</span>
								</button>
							</div>
						</div>
					</div>
				</div>
				<!--panel마감-->
			</div>
			<!--page마감-->
	
		</div>
		<!--content마감-->
	</div>
	<!--content_wrap마감-->
	
<!-- 중개사의 방검색 -->
<script>
	var agentSearchUrl = '';//전체경로
	var agentFilterUrl ='';//상세검색
	var agentSortUrl = '';//정렬
	var metro_no ='';//지하철번호
	var address_code ='';//지역주소번호
	var room_no ='';//방번호
	var sector_code = '';//구와 섹터선택시 섹터번호
	var num_per_page = 30;//페이지당 방 출력 개수
	$(document).ready(function() { 
		//프로필 사진 설정
		setProfilePhoto('profile');
		//기본 url을 api/search 컨트롤러의 경로로 설정(ajax경로)
		agentSearchUrl = "/api/room/enroll/search/agent?p=" + agentFilterUrl +"&metro_no="+metro_no 
				+"&addr="+address_code+"&room_no="+room_no+"&sector_code="+sector_code 
				+"&num_per_page=" + num_per_page +"&sort="+agentSortUrl;
		posChangeSubmit(1);
	});
	
	//******************검색조건 초기화 시키고 검색*****************
	function searchResetFilter(){
		agentSearchUrl = '';//전체경로
		agentFilterUrl ='';//상세검색
		agentSortUrl = '';//정렬
		metro_no ='';//지하철번호
		address_code ='';//지역주소번호
		room_no ='';//방번호
		sector_code = '';//구와 섹터선택시 섹터번호
		num_per_page = 3;//페이지당 방 출력 개수
		resetFilter();//필터적용 지우기
	}
	//*******************************paging***************************
	var currentPg = 1;
	var currentBlock =0; 
	var nextPage = false;
	function setCurrentPage(pos){
		//currentBlock값 변경 
		if(pos == 'pre'){
			if(0 < currentBlock){
				currentBlock--;
				currentPg = (currentBlock)*5 + 1;
			}
			pos = 'pos1';
		} else if(pos == 'next'){
			currentBlock++;
			currentPg = currentBlock*5 + 1;
			pos = 'pos1';
		}
		//currentpg 값 변경
		if(pos == 'pos1' || pos == 'pos2' || 
				pos == 'pos3' || pos == 'pos4' || 
					pos == 'pos5' ){//페이지 버튼으로 페이지 변경시
			$("#"+pos).addClass("current");//현재 페이지 클릭표시 설정
			currentPg = currentBlock*5 + pos.substring(3)*1;//block를 통해 상대적으로 페이지를 구함
		}else{//원하는 페이지를 숫자로 입력받으면
			currentPg = pos;
			currentBlock = (pos-1)/5;
		}
	}
	var all_count = 0;
	function setPageIndex(currentBlock){
		 //이전 화살표 표시 설정
	 	 var pre_page = document.getElementById("pre_page");  
	 	 pre_page.style.display = 'none';  
		 if(0 < currentBlock){//이전 화살표를 표시해야되면
			   pre_page.style.display = 'inline-block';  
		 }
		 //페이지 버튼 페이지값 셋팅
		 $("#pos1").text(currentBlock*5 + 1);
		 $("#pos2").text(currentBlock*5 + 2);
		 $("#pos3").text(currentBlock*5 + 3);
		 $("#pos4").text(currentBlock*5 + 4);
		 $("#pos5").text(currentBlock*5 + 5);
	 	 var pos1 = document.getElementById("pos1"); 
	 	 var pos2 = document.getElementById("pos2");  
	 	 var pos3 = document.getElementById("pos3");  
	 	 var pos4 = document.getElementById("pos4");  
	 	 var pos5 = document.getElementById("pos5"); 
		 pos1.style.display ='none';  
		 pos2.style.display ='none';   
		 pos3.style.display ='none';  
		 pos4.style.display ='none';   
		 pos5.style.display ='none';  
		 if(currentBlock*num_per_page*5 + num_per_page*0 < all_count)//page 1을  표시해야되면
			 pos1.style.display ='inline-block';  
		 if(currentBlock*num_per_page*5 + num_per_page*1 < all_count)//page 2을  표시해야되면
			 pos2.style.display ='inline-block'; 
		 if(currentBlock*num_per_page*5 + num_per_page*2 < all_count)//page 3을  표시해야되면
			 pos3.style.display ='inline-block';  
		 if(currentBlock*num_per_page*5 + num_per_page*3 < all_count)//page 4을  표시해야되면
			 pos4.style.display ='inline-block';  
		 if(currentBlock*num_per_page*5 + num_per_page*4 < all_count)//page 5을  표시해야되면
			 pos5.style.display ='inline-block';
		 
		 //페이지 클릭 초기화
		 $("#pos1").removeClass("current");
		 $("#pos2").removeClass("current");
		 $("#pos3").removeClass("current");
		 $("#pos4").removeClass("current");
		 $("#pos5").removeClass("current");
		 //현재 페이지 클릭표시 설정
		 $("#pos"+ ((currentPg-1)%5 + 1)).addClass("current");
		 //다음 화살표 표시 설정
		 var next_page = document.getElementById("next_page");  
	     next_page.style.display = 'none'; 
		 if((currentBlock+1)*num_per_page*5 < all_count){//다음 화살표를 표시해야되면
		      next_page.style.display = 'inline-block';  
		 }
	}
	
	//******************검색할 페이지로 페이지상태를 변경하고 검색******************
	function posChangeSubmit(pos){
		setfilterUrl();
		setCurrentPage(pos);//현재페이지 설정
		search(agentSearchUrl, currentPg);
		setPageIndex(currentBlock);//페이지 인덱스 표시 설정 (이전, 1 ~ 5 ,다음 버튼)
	}

	//******************중개사의 방 필터 검색******************
	function setfilterUrl(){
		setFilter();
		agentSearchUrl = "/api/room/enroll/search/agent?p=" + agentFilterUrl +"&metro_no=" + metro_no 
				+"&addr="+address_code+"&room_no="+room_no+"&sector_code="+sector_code 
				+"&num_per_page=" + num_per_page +"&sort="+agentSortUrl;
	}
	
	//******************중개사의 방 검색******************
	function search(url, pg){
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : url+"&pg=" + pg,
			async : false,//총 검색개수를 받아온 이후 다음 절차수행, 반드시 동기 false로
			success : function(data) {//msg를 받는 것이 성공하면
				setInfor(data);
				all_count = data.allSearchCount;
			},
			error : function(xhr, status, error) {
			}
		});
	}
	function setInfor(data){ 
		var str = "";
		$("#room_table").empty();
		for(var a= 0; a <data.roomList.length; a++){
			var  infor = data.roomList[a];
			var  gungu_dong =  data.roomList[a].gungu +' ' + data.roomList[a].dong;
		    
		    //매물번호설정
			var no =  infor.no;
	
			//거래 종류 설정
			var type ='';
		    if(0 != (infor.type&1)) 
		    	type +='매매,';
		    if((infor.type&2) != 0  && (infor.type&4) != 0)
		    	type +='전월세,';
		    if((infor.type&2) != 0)
		    	type +='전세,';
		    if((infor.type&4) != 0)
		    	type +='월세,';
		    if((infor.type&8) != 0)
			    type +='단기임대,';
			
		    //전세/월세/임대에 따라 거래가 설정
			//1매매/2전세/4월세/6전월세/8단기임대
		    var charter_deposit = infor.charter_deposit;// 전세가
		    var sale_price = infor.sale_price;//매매가
			var deposit= infor.deposit;// 보증금
			var monthly_rent= infor.monthly_rent;//월세
			var deposit_modify= infor.deposit_modify;//보증금협의가능
			var standard= infor.standard_deposit;// 기준가
			var maintenance_cost = infor.maintenance_cost;//관리비
			var date = infor.date;
			var name_trade_price ='';
			name_trade_price+="<span class=\"tit\">";
			var trade_price ='';
			trade_price+="<span>";
			if((infor.type&1) != 0){//매매이면
				//매매가표시
				name_trade_price += '매/';
				trade_price = "<span class=\"deposit\">"+ sale_price + "</span>";
			}
			if((infor.type&2) != 0  && (infor.type&4) != 0){//전월세 이면
				//전세, 월세 둘다적용
				name_trade_price += '전/보/월/관/';
				trade_price = "<span class=\"deposit\">"+ charter_deposit + "</span>" + "/";
				trade_price += ("<span class=\"month\">" + deposit);
				if(deposit_modify == 1)
					trade_price += "(협의가능)";
				trade_price += ("/" + monthly_rent);
				trade_price += ("/" + maintenance_cost/10000 + "</span>");
			}
			else if((infor.type&2) != 0){//전세이면(전월세에 포함)
				//전세가 표시
				name_trade_price += '전/관/';
				trade_price = "<span class=\"deposit\">"+ charter_deposit +  "</span>";
				trade_price += ("/<span>" + maintenance_cost/10000 + "</span>");
			}
			else if((infor.type&4) != 0){//월세이면(전월세에 포함)
				//보증금/월세 표시
				name_trade_price += '보/월/관/';
				trade_price = "<span class=\"deposit\">"+ deposit + "</span>";
				if(deposit_modify == 1)
					trade_price += "(보증급 협의가능)";
				trade_price += "/";
				trade_price += ("<span class=\"month\">" +  monthly_rent + "/" + maintenance_cost/10000  + "</span>");
			}else if((infor.type&8) != 0){//단기임대이면(전월세, 월세에 포함)
				//보증금/월세 표시
				name_trade_price += '보/월/관';
				trade_price = "<span class=\"deposit\">"+ deposit + "</span>";
				if(deposit_modify == 1)
					trade_price += "(보증급 협의가능)";
				trade_price += "/";
				trade_price += ("<span class=\"month\">" +  monthly_rent + "/" + maintenance_cost/10000  +"</span>");
			}
			name_trade_price+="</span>";
			trade_price+="</span>";
			
			//주소값 설정
			var address = '';
			address = infor.si +"시 " +  infor.gungu +" " +  infor.dong +" ";
			if(infor.main_address != null && infor.main_address != '' && infor.sub_address != null && infor.sub_address != '')
				address+= (infor.main_address +"-" + infor.sub_address +" ");
			if(infor.last_address != null && infor.last_address != '' )
				address+= (infor.last_address); 
			
			str+="	<tr>";
			str+="		<td class=\"col_pic\">";
			str+="			<div class=\"image_list\">";
			str+="				<div class=\"media_photo media_cover\">";
			str+="					<div class=\"media_cover\">";
			
			if (typeof(infor.fake_url[0]) == "undefined"){//사진등록이 안되었으면 기본이미지로 설정
				str+="						<img src=\"" + "${pageContext.request.contextPath}/images/common/pic_base.jpg"+"\" alt=\"2003번 방사진\"";
				str+="							class=\"img_responsive_height\" onclick =\"detailShow("+no+")\" />";
			}else{//사진등록이 됐으면 이미지의 첫번쨰로 대표이미지 설정
				str+="						<img src=\""+"http://112.175.245.57"+infor.fake_url[0]+"\" alt=\"2003번 방사진\"";
				str+="							class=\"img_responsive_height\" onclick =\"detailShow("+no+")\" />";
	        }
			str+="					</div>";
			str+="				</div>";
			str+="			</div>";
			str+="		</td>";
			str+="		<td class=\"col_desc  m_no_col\">";
			str+="			<div class=\"row\">";
			str+="				<p class=\"col_wide fl\">";
			str+="					<span class=\"addr\">"+address+"</span>";
			str+="				</p>";
			str+="				<p class=\"col_sm fl\">";
			str+="					<span class=\"tit\">구분</span> <span>"+type+"</span>";
			str+="				</p>";
			str+="				<p class=\"col_sm  fl\">";
			str+="					<span class=\"tit\">기준가</span> <span>"+standard+"</span>";
			str+="				</p>";		
			str+="				<p class=\"col_sm  fl\">";
			str+= name_trade_price;
	        str+= trade_price;
			str+="				</p>";
			str+="			</div>";
			str+="			<div class=\"row\">";
			str+="				<p class=\"col_sm  fl\">";
			str+="					<span class=\"tit\">매물번호</span> <span>"+no+"</span>";
			str+="				</p>";
			str+="				<p class=\"col_sm fl\">";
			str+="					<span class=\"tit\">등록일</span> <span>"+date+"</span>";
			str+="				</p>";
			str+="			</div>";
			str+="		</td>";
			str+="		<td class=\"col_btn m_no_col\">";
			str+="			<p class=\"btn edit_btn\">";
			str+="				<a href=\"/room/modify/agent/"+no+"\">수정</a>";
			str+="			</p>";
			str+="			<p class=\"btn copy_btn\">";
			str+="				<a href=\"#\">복사</a>";
			str+="			</p>";
			str+="		</td>";
			str+="	</tr>";
		}
		//방 검색결과 적용
		$("#room_table").append(str);
		
		//방 검색결과 수 적용
		$("#searchCount").empty();
		$("#searchCount").append("등록된 방 : 총   " + data.allSearchCount + "개");
		
	}
	//방상세보기페이지
	function detailShow(no){
		location.href = "/room/"+no;
	}
</script>

<script>
//************************컴포넌트 상태변화*******************
	//월세/전세/단기임대/전월게/매매 의 체크박스 전체선택 및 해제
	function checkBoxAllTradeType(){
		//거래종류 전체 체크 및 해제
		$("#all_type").prop("checked", true);
		$("#monthly").prop("checked", false);
		$("#monthly_and_charter").prop("checked", false);
		$("#charter").prop("checked", false);
		$("#trade").prop("checked", false);
		$("#short_lease").prop("checked", false);
	}
	//단일선택시 전체체크박스의 선택및 해제
	function checkBoxTradeType(){
		//단일선택시 전체체크박스 상태 변화
		if($("#monthly").is(":checked") 
			&& $("#monthly_and_charter").is(":checked")
			&& $("#charter").is(":checked")
			&& $("#trade").is(":checked")
			&& $("#short_lease").is(":checked")){//모든사항체크시
			$("#all_type").prop("checked", true);//전체선택체크
			$("#monthly").prop("checked", false);
			$("#monthly_and_charter").prop("checked", false);
			$("#charter").prop("checked", false);
			$("#trade").prop("checked", false);
			$("#short_lease").prop("checked", false);
		}else if (
				!$("#monthly").is(":checked") 
				&& !$("#monthly_and_charter").is(":checked") 
				&& !$("#charter").is(":checked") 
				&& !$("#trade").is(":checked") 
				&& !$("#short_lease").is(":checked") )
		{//체크가 전부안되어있으면 전체체크박스 체크
			$("#all_type").prop("checked", true);
		}else{
			$("#all_type").prop("checked", false);
		}
	}
	
	//아파트/오피스텔/주택/원룸/상가/사무실/건물/재개발/이벤트 의 체크박스 전체선택 및 해제
	function checkBoxAllBuildingType(){
			$("#all_building_type").prop("checked", true);
			$("#apartment").prop("checked", false);
			$("#officetel").prop("checked", false);
			$("#house").prop("checked", false);
			$("#normal_room").prop("checked", false);
			$("#shop").prop("checked", false);
			$("#office").prop("checked", false);
			$("#building").prop("checked", false);
			$("#redevelopment").prop("checked", false);
			$("#event").prop("checked", false);
	}
	//아파트/오피스텔/주택/원룸/상가/사무실/건물/재개발/이벤트 의 단일체크시 체크박스상태변화
	function checkBoxBuildingType(){
		if (
			$("#apartment").is(":checked") 
			&& $("#officetel").is(":checked") 
			&& $("#house").is(":checked") 
			&& $("#normal_room").is(":checked") 
			&& $("#shop").is(":checked") 
			&& $("#office").is(":checked") 
			&& $("#building").is(":checked") 
			&& $("#redevelopment").is(":checked") 
			&& $("#event").is(":checked")){//체크박스 모두체크시
			$("#all_building_type").prop("checked", true);
			$("#apartment").prop("checked", false);
			$("#officetel").prop("checked", false);
			$("#house").prop("checked", false);
			$("#normal_room").prop("checked", false);
			$("#shop").prop("checked", false);
			$("#office").prop("checked", false);
			$("#building").prop("checked", false);
			$("#redevelopment").prop("checked", false);
			$("#event").prop("checked", false);
		}else if (
				!$("#apartment").is(":checked") 
				&& !$("#officetel").is(":checked") 
				&& !$("#house").is(":checked") 
				&& !$("#normal_room").is(":checked") 
				&& !$("#shop").is(":checked") 
				&& !$("#office").is(":checked") 
				&& !$("#building").is(":checked") 
				&& !$("#redevelopment").is(":checked") 
				&& !$("#event").is(":checked")
			){//체크가 전부안되어있으면 전체체크박스 체크
				$("#all_building_type").prop("checked", true);
		}else{
			$("#all_building_type").prop("checked", false);
		}
	}
	
	//현관보안/ 보안/ cctv 의 체크박스 전체선택 및 해제
	function checkAllSecurityType(){
		$("#all_security").prop("checked", true);
		$("#door_security").prop("checked", false);
		$("#cctv").prop("checked", false);
		$("#number_key").prop("checked", false);
	}
	//현관보안/ 보안/ cctv 의 체크박스 단일선택
	function checkSecurityType(){
		if (
				$("#door_security").is(":checked") 
				&& $("#cctv").is(":checked") 
				&& $("#number_key").is(":checked")){//체크박스 모두체크시
				$("#all_security").prop("checked", true);
				$("#door_security").prop("checked", false);
				$("#cctv").prop("checked", false);
				$("#number_key").prop("checked", false);
			}else if (
					!$("#door_security").is(":checked") 
					&& !$("#cctv").is(":checked") 
					&& !$("#number_key").is(":checked")
				){//체크가 전부안되어있으면 전체체크박스 체크
					$("#all_security").prop("checked", true);
			}else{
				$("#all_security").prop("checked", false);
			}
	}

	//방형태 상관없음 선택시
	function checkRoomType(){
		$("#all_room_type").prop("checked", true);
		$("#open_room").prop("checked", false);
		$("#part_room").prop("checked", false);
		$("#duplex_room").prop("checked", false);
	}
	//룸형태 사항 체크시
	function checkAnyRoomType(){
		if ($("#open_room").is(":checked") &&
		$("#part_room").is(":checked") &&
		$("#duplex_room").is(":checked")) {
			$("#all_room_type").prop("checked", true);
			$("#open_room").prop("checked", false);
			$("#part_room").prop("checked", false);
			$("#duplex_room").prop("checked", false);
		}else if (
				!$("#open_room").is(":checked") 
				&& !$("#part_room").is(":checked") 
				&& !$("#duplex_room").is(":checked")
			){//체크가 전부안되어있으면 전체체크박스 체크
				$("#all_room_type").prop("checked", true);
		}else{
			$("#all_room_type").prop("checked", false);
		}
	}
	
	//방수 상관없음 선택시
	function checkRoomNum(){
		$("#all_room_count").prop("checked", true);
		$("#one_room").prop("checked", false);
		$("#two_room").prop("checked", false);
		$("#three_room").prop("checked", false);
	}
	//룸의 수사항 체크시
	function checkAnyRoomNum(){
		if ($("#one_room").is(":checked") &&
		$("#two_room").is(":checked") &&
		$("#three_room").is(":checked")) {
			$("#all_room_count").prop("checked", true);
			$("#one_room").prop("checked", false);
			$("#two_room").prop("checked", false);
			$("#three_room").prop("checked", false);
		}else if (
				!$("#one_room").is(":checked") 
				&& !$("#two_room").is(":checked") 
				&& !$("#three_room").is(":checked")
			){//체크가 전부안되어있으면 전체체크박스 체크
				$("#all_room_count").prop("checked", true);
		}else{
			$("#all_room_count").prop("checked", false);
		}
	}
	
	//방위치 상관없음 선택시
	function checkRoomPosition(){
		$("#all_room_position").prop("checked", true);
		$("#up_ground").prop("checked", false);
		$("#under_ground").prop("checked", false);
		$("#semi_basement").prop("checked", false);
		$("#rooftop").prop("checked", false);
	}
	//룸의 위치 사항 체크시
	function checkAnyRoomPosition(){
		if ($("#up_ground").is(":checked") &&
		$("#under_ground").is(":checked") &&
		$("#semi_basement").is(":checked") &&
		$("#rooftop").is(":checked")) {
			$("#all_room_position").prop("checked", true);
			$("#up_ground").prop("checked", false);
			$("#under_ground").prop("checked", false);
			$("#semi_basement").prop("checked", false);
			$("#rooftop").prop("checked", false);
		}else if (
				!$("#up_ground").is(":checked") 
				&& !$("#under_ground").is(":checked") 
				&& !$("#semi_basement").is(":checked")
				&& !$("#rooftop").is(":checked")
			){//체크가 전부안되어있으면 전체체크박스 체크
				$("#all_room_position").prop("checked", true);
		}else{
			$("#all_room_position").prop("checked", false);
		}
	}
	
	//모든 상세검색 조건 내용 초기화
	function resetFilter(){
		$("#charter").prop("checked", false);
		$("#monthly_and_charter").prop("checked", false);
		$("#monthly").prop("checked", false);
		$("#short_lease").prop("checked", false);
		$("#trade").prop("checked", false);
		$("#all_type").prop("checked", true);

		document.getElementById("depositmin").value = "";
		document.getElementById("depositmax").value = "";
		document.getElementById("monthmin").value = "";
		document.getElementById("monthmax").value = "";
		document.getElementById("chartermin").value = "";
		document.getElementById("chartermax").value = "";
		document.getElementById("standardmin").value = "";
		document.getElementById("standardmax").value = "";
		
		$("#apartment").prop("checked", false);
		$("#officetel").prop("checked", false);
		$("#house").prop("checked", false);
		$("#normal_room").prop("checked", false);
		$("#shop").prop("checked", false);
		$("#office").prop("checked", false);
		$("#building").prop("checked", false);
		$("#redevelopment").prop("checked", false);
		$("#event").prop("checked", false);
		$("#all_building_type").prop("checked", true);
		$("#filter_building_type").addClass("hide");
		
		$('#built option:eq(0)').attr('selected', 'selected');
		document.getElementById("address").value = "";
		
		$("#all_room_type").prop("checked", true);
		$("#open_room").prop("checked", false);
		$("#part_room").prop("checked", false);
		$("#duplex_room").prop("checked", false);

		$("#all_room_count").prop("checked", true);
		$("#one_room").prop("checked", false);
		$("#two_room").prop("checked", false);
		$("#three_room").prop("checked", false);

		$("#all_room_position").prop("checked", true);
		$("#up_ground").prop("checked", false);
		$("#under_ground").prop("checked", false);
		$("#semi_basement").prop("checked", false);
		$("#rooftop").prop("checked", false);
		
		document.getElementById("area2min").value = "";
		document.getElementById("area2max").value = "";
		document.getElementById("area1min").value = "";
		document.getElementById("area1max").value = "";

		$("#full_option_room").prop("checked", false);
		$("#airconditioner").prop("checked", false);
		$("#refrigerator").prop("checked", false);
		$("#washer").prop("checked", false);
		$("#tv").prop("checked", false);
		$("#microwave").prop("checked", false);
		$("#induction").prop("checked", false);
		$("#sink").prop("checked", false);
		$("#gasrange").prop("checked", false);
		$("#sofa").prop("checked", false);
		$("#bed").prop("checked", false);
		$("#built_in_closet").prop("checked", false);
		$("#dressing_table").prop("checked", false);
		$("#veranda").prop("checked", false);
		$("#shoe_closet").prop("checked", false);
		
		$("#door_security").prop("checked", false);
		$("#cctv").prop("checked", false);
		$("#number_key").prop("checked", false);
		$("#all_security").prop("checked", true);
		
		$("#elevator").prop("checked", false);
		$("#parking").prop("checked", false);
		$("#animal").prop("checked", false);
		$("#empty").prop("checked", false);
		$("#sale").prop("checked", false);
		
		$("#pic_keep").prop("checked", false);
		$("#pic_none").prop("checked", false);
		$("#movie_keep").prop("checked", false);
		$("#movie_none").prop("checked", false);
		
		initAddressList();//섹터 초기화
		document.getElementById("keyword").value = "";//키워드 지우기
	}	
	//페이지당 출력 개수 
	function changePageNum(){
		if($("#page_num_select").hasClass("opened")) 
			$("#page_num_select").removeClass("opened");
		else
			$("#page_num_select").addClass("opened");
	}
	//정렬
	function changeSort(){
		if($("#sort_select").hasClass("opened")) 
			$("#sort_select").removeClass("opened");
		else
			$("#sort_select").addClass("opened");
	}
</script>
<!-- 키워드 자동완성 기능 -->
<script>
	/************************** auto complete ***********************/
	$(function() {
		$("#keyword").keyup(
				function(event) {
					metro_no ='';
					address_code ='';
					room_no ='';
					//값을 세팅
					currentWord = $("#keyword").val();
					if (!currentWord)//입력값이 없으면
						return;
					jQuery.ajax({
						type : "GET",
						dataType : "json",
						url : "/api/search/quick?searchWord=" + currentWord,
						async : false,
						success : function(data) {//msg를 받는 것이 성공하면
							autoWord = new Array();
							var infor = data.autoWordList;
							for (var i = 0; i < infor.length; i++)
								autoWord.unshift((infor[i].firstWord + " "
										+ infor[i].secondWord + " "
										+ infor[i].thirdWord).trim());
							$("#keyword").autocomplete({
								source : autoWord,
								select: function(event, ui) {
							        for (var i = 0; i < infor.length; i++){
							        	if(autoWord[infor.length - i -1] == ui.item.label){//선택한 단어와 가져왔던 자동완성이 일치하면
							        		//페이지 표시 초기화
											
							        		if(infor[i].kind == 'addressCode'){
							        			address_code = infor[i].code;
							        		} if(infor[i].kind == 'roomNo'){
							        			room_no =  infor[i].code;
							        		}  if(infor[i].kind == 'metro'){ 
							        			metro_no =  infor[i].code;
											}
										    break;
							        	}
							        }
							    }
							});
						},
						error : function(xhr, status, error) {
						}
				});
		});
	});
</script>
<script>
function setFilter(){//필터 url적용
	var numberInput = false;
	var url='';	

	//거래 종류
	if ($('input:checkbox[id="trade"]').is(":checked") != "")//매매
		url +="1";url +=":";
	if ($('input:checkbox[id="charter"]').is(":checked") != "") //전세
		url +="2";url +=":";
	if ($('input:checkbox[id="monthly_and_charter"]').is(":checked")!= "") //전월세
		url +="6";url +=":";
	if ($('input:checkbox[id="monthly"]').is(":checked")!= "") //월세
		url +="4";url +=":";
	if ($('input:checkbox[id="short_lease"]').is(":checked") != "") //단기임대
		url +="8";url +=":";
	
	//금액
	if ($("#depositmin").val() == ''){//보증금 최소
		url +="0";
	} else{
		url +=$("#depositmin").val();
		numberInput =true;
	}
	url +=":";
	if ($("#depositmax").val() == ''){//보증금 최대
		url +=999999999;
	} else {
		url += $("#depositmax").val();
		numberInput =true;
	}
	url +=":";			
	if ($("#monthmin").val() == ''){//월세 최소
		url +="0";
	} else {
		url +=$("#monthmin").val();
		numberInput =true;
	}
	url +=":";
	if ($("#monthmax").val() == ''){//월세 최대
		url +=999999999;
	} else{
		url += $("#monthmax").val();
		numberInput =true;
	}
	url +=":";
	if ($("#chartermin").val() == ''){//전세 최소
		url +="0";
	} else{
		url +=$("#chartermin").val();
		numberInput =true;
	}
	url +=":";
	if ($("#chartermax").val() == ''){//전세 최대
		url +=999999999;
	} else{
		url += $("#chartermax").val();
		numberInput =true;
	}
	url +=":";
	if ($("#standardmin").val() == ''){//기준가 최소
		url +="0";
	} else{
		url +=$("#standardmin").val();	
		numberInput =true;
	}
	url +=":";
	if ($("#standardmax").val() == ''){//기준가 최대
		url +=999999999;
	} else{
		url +=$("#standardmax").val();
		numberInput =true;
	}
	url +=":";
	
	//건물종류 : 아파트/오피스텔/주택/원룸/상가/사무실/건물/재개발/이벤트
	if ($('input:checkbox[id="apartment"]').is(":checked") != "") //아파트
		url +="1";url +=":";
	if ($('input:checkbox[id="officetel"]').is(":checked") != "") //오피스텔
		url +="1";url +=":";
	if ($('input:checkbox[id="house"]').is(":checked") != "") //주택
		url +="1";url +=":";	
	if ($('input:checkbox[id="normal_room"]').is(":checked") != "") //원룸
		url +="1";url +=":";
	if ($('input:checkbox[id="shop"]').is(":checked") != "") //상가
		url +="1";url +=":";	
	if ($('input:checkbox[id="office"]').is(":checked") != "") //사무실
		url +="1";url +=":";
	if ($('input:checkbox[id="building"]').is(":checked") != "") //건물
		url +="1";url +=":";	
	if ($('input:checkbox[id="redevelopment"]').is(":checked") != "") //재개발
		url +="1";url +=":";
	if ($('input:checkbox[id="event"]').is(":checked") != "") //이벤트
		url +="1";url +=":";
		
	//준공년도
	if($("#built option:selected").val() != '전체'){
		url +=$("#built option:selected").val();url +=":"
		numberInput = true;
	}else{
		url +=new Date().getFullYear();url +=":"
	}
		
	//번지
	url +=$("#address").val();url +=":";
	//룸종류
	/* if($('input:checkbox[id="all_room_type"]').is(":checked") != ""){//방 형태 상관없음 체크시
		url +="1";url +=":"; 
		url +="1";url +=":";
		url +="1";url +=":";
	} else{ */
		if ($('input:checkbox[id="open_room"]').is(":checked") != "") //오픈형
			url +="1";url +=":";  			
		if ($('input:checkbox[id="part_room"]').is(":checked") != "") //분리형
			url +="1";url +=":";  		
		if ($('input:checkbox[id="duplex_room"]').is(":checked") != "") //복층형
			url +="1";url +=":";  
	/* } */
		
	/* //룸개수 room_count
	if($('input:checkbox[id="all_room_count"]').is(":checked") != ""){//룸개수 상관없음 체크시
		url +="1";	url +=":"; 	
		url +="1";	url +=":";
		url +="1"; url +=":";  
	} else{ */
		if ($('input:checkbox[id="one_room"]').is(":checked") != "") //월룸
			url +="1";	url +=":"; 		
		if ($('input:checkbox[id="two_room"]').is(":checked") != "") //투룸
			url +="1";	url +=":"; 		
	    if ($('input:checkbox[id="three_room"]').is(":checked") != "") //쓰리룸
			url +="1"; url +=":";  
	/* } */
	
	//층수
	/* if($('input:checkbox[id="all_room_position"]').is(":checked") != ""){//룸위치(층수) 상관없음 체크시
		url +="1";url +=":";	
		url +="1";url +=":";
		url +="1";url +=":";  
		url +="1";url +=":";  
	} else{ */
		if ($('input:checkbox[id="up_ground"]').is(":checked") != "") //지상
			url +="1";url +=":";			
		if ($('input:checkbox[id="under_ground"]').is(":checked") != "") //지하
			url +="1";url +=":";			
		if ($('input:checkbox[id="semi_basement"]').is(":checked") != "") //반지하
			url +="1";url +=":";  			
		if ($('input:checkbox[id="rooftop"]').is(":checked") != "") //옥탑방
			url +="1";url +=":";  
	/* } */

        
   //전용면적 최소 최대
	if ($("#area2min").val() == ''){//전용면적 최소
		url +=0;
	}else{
		url +=$("#area2min").val();
		numberInput =true;
	}
	url +=":"; 
	if ($("#area2max").val() == ''){//전용면적 최대
		url +=999999999;
	}else{
		url +=$("#area2max").val();
		numberInput =true;
	}
	url +=":"; 
	
	//공급면적 최소 최대     
	if ($("#area1min").val() == ''){//공급면적 최소 
		url +=0;
	}else{
		url +=$("#area1min").val();
		numberInput =true;
	}
	url +=":";  
	if ($("#area1max").val() == ''){//공급면적 최대
		url +=999999999;
	} else{
		url +=$("#area1max").val();
		numberInput =true;
	}
	url +=":";  
	
	//옵션
	if ($('input:checkbox[id="full_option_room"]').is(":checked") != "") //풀옵션
		url +="1";url +=":";			
	if ($('input:checkbox[id="airconditioner"]').is(":checked") != "") //에어컨
		url +="1";url +=":";			
	if ($('input:checkbox[id="refrigerator"]').is(":checked") != "") //냉장고
		url +="1";url +=":";  
	if ($('input:checkbox[id="washer"]').is(":checked") != "") //세탁기
		url +="1";url +=":";			
	if ($('input:checkbox[id="tv"]').is(":checked") != "") //tv
		url +="1";url +=":";    
	if ($('input:checkbox[id="microwave"]').is(":checked") != "") //전자레인지
		url +="1";url +=":";			
	if ($('input:checkbox[id="induction"]').is(":checked") != "") //인덕션
		url +="1";url +=":";  
	if ($('input:checkbox[id="sink"]').is(":checked") != "") //싱크대
		url +="1";url +=":";			
	if ($('input:checkbox[id="gasrange"]').is(":checked") != "") //가스레인지
		url +="1";url +=":";     
	if ($('input:checkbox[id="sofa"]').is(":checked") != "") //소파
		url +="1";url +=":";			
	if ($('input:checkbox[id="bed"]').is(":checked") != "") //침대
		url +="1";url +=":";   
	if ($('input:checkbox[id="built_in_closet"]').is(":checked") != "") //붙박이장
		url +="1";url +=":";			
	if ($('input:checkbox[id="dressing_table"]').is(":checked") != "") //화장대
		url +="1";url +=":";   		
	if ($('input:checkbox[id="veranda"]').is(":checked") != "") //베란다
		url +="1";url +=":";			
	if ($('input:checkbox[id="shoe_closet"]').is(":checked") != "") //신발장
		url +="1";url +=":";   		

	//보안
	if ($('input:checkbox[id="door_security"]').is(":checked") != "") //현관보안
		url +="1";url +=":";   
	if ($('input:checkbox[id="cctv"]').is(":checked") != "") //cctv
		url +="1";url +=":";   
	if ($('input:checkbox[id="number_key"]').is(":checked") != "") //자동번호키
		url +="1";url +=":";   		
	
	//기타옵션
	if ($('input:checkbox[id="elevator"]').is(":checked") != "") //엘리베이터
		url +="1";url +=":";   		
	if ($('input:checkbox[id="parking"]').is(":checked") != "") //주차가능
		url +="1";url +=":"; 	
	if ($('input:checkbox[id="animal"]').is(":checked") != "") //반려동물
		url +="1";url +=":"; 
	if ($('input:checkbox[id="empty"]').is(":checked") != "") //공실
		url +="1";url +=":";   		
	if ($('input:checkbox[id="sale"]').is(":checked") != "") //매물
		url +="1";url +=":"; 	

	//사진 동영상 보유사항
	if ($('input:radio[id="pic_keep"]').is(":checked") != ""){//사진있음
		url +="1"; url +=":";
		numberInput =true;
	} else {
		url +=":";
	}  
	if ($('input:radio[id="pic_none"]').is(":checked") != ""){ //사진없음
		 url +="1"; url +=":";
		numberInput =true;
	}else{
		url +=":";
	}

	if ($('input:radio[id="movie_keep"]').is(":checked") != ""){//사진있음
		url +="1"; url +=":";
		numberInput =true;
	} else {
		url +=":";
	}
	if ($('input:radio[id="movie_none"]').is(":checked") != ""){ //사진없음
		 url +="1"; url +=":";
		 numberInput =true;
	} else{
		url +=":";
	}
	agentFilterUrl = url;
}
</script>
<!-- 페이지 당 검색 개수  -->
<script>
	$(function() {
		//페이지 개수선택
		 $('.page_num_li').click(function(){
			 var select_text = $(this).text();
			 if(select_text == '30개씩')
				 num_per_page = 30;
			 else if(select_text == '60개씩')
				 num_per_page = 60;
			 else if(select_text == '90개씩')
				 num_per_page = 90;
			 $("#page_num_title").text(num_per_page +"개씩");//드롭박스 title값 선택값으로 설정
			 changePageNum();//페이지 설정 드롭박스 상태변화
			 posChangeSubmit(1);//검색
		});
		//정렬 선택
		$('.sort_li').click(function(){
			 var select_text = $(this).text();
		 	 if(select_text == '최신등록순'){
				 agentSortUrl = 'date desc';
		 	 }else if(select_text == '번지수 오름차순'){
				 agentSortUrl = 'main_address, sub_address asc';
			 }else if(select_text == '기준가 높은 순'){
			 	agentSortUrl = 'standard_deposit desc';
			 }else if(select_text == '기준가 낮은 순'){
				 agentSortUrl = 'standard_deposit asc';
			 }else if(select_text == '월세 높은 순'){
				 agentSortUrl = 'monthly_rent desc';
			 }else if(select_text == '월세 낮은 순'){
				 agentSortUrl  ='monthly_rent asc';
			 }else if(select_text == '보증금 높은 순'){
				 agentSortUrl = 'deposit desc';
			 }else if(select_text == '보증금 낮은 순'){
				 agentSortUrl = 'deposit asc';
			 }else if(select_text == '전용면적 높은 순'){
				 agentSortUrl = 'exclusive_area desc';
		 	 }else if(select_text == '전용면적 낮은 순'){
				 agentSortUrl = 'exclusive_area asc';
		 	 }
			 $("#sort_title").text(select_text);//드롭박스 title값 선택값으로 설정
		 	 changeSort();//정렬 선택 드롭박스 상태변화
		 	posChangeSubmit(1);
		});
	});
	//정렬을 적용하지 않고 검색
	function allSort(){
		changeSort();//드롭박스 상태변화
		agentSortUrl ='';//정렬 값 초기화
		posChangeSubmit(1);//정렬초기화된값으로 검색
	}
</script>
<!-- 섹션선택 -->
<script>
	//셋팅하기전 섹터번호 섹터구 섹터이름을 초기화
	var gungu='';
	var dong='';
	var local_code = [];
	//*******************지역 클릭시 리스트 셋팅 설정 ************************
    setGunguList();
	function initAddressList(){
		gungu='';
		dong='';
		local_code = [];
		sector_code = '';
		setGunguList();
		$("#sector2").empty(); 
		$("#sector2").append("<option> 섹터선택 </option>");
		//alert(sector_code);
	}
	$(function() {	
		 //군 리스트 셋팅 고정
		 $("#sector1").on("change",function(){
			 gungu = $("#sector1 option:selected").text();//선택한  구값 보관
			 setDongList(gungu);// 동/주소코드 리스트 가져와서 셋팅
			 sector_code ='';
		});
		 $("#sector2").on("change",function(){
	        dong = $("#sector2 option:selected").text();//선택한  동값 보관
	        var select_index = $("#sector2 option").index($("#sector2 option:selected"));
	        sector_code = local_code[select_index];
		});
	});
	//*******************ajax:  주소 목록 리스트 셋팅***********************
	//구 리스트 set
	function setGunguList(){
		//구 리스트 셋팅, 구 선택 값설정
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : "/api/location/sector", 
			async : false,
			success : function(data) {
				//구 리스트 셋팅
				$("#sector1").empty();
				local_code.push(" ");
		    	$("#sector1").append("<option>섹터구선택 </option>");
				$("#sector2").append("<option>섹터선택 </option>");
				for(var i = 0; i < data.sectorGuList.length; i++){
		    		   $("#sector1").append("<option>" + data.sectorGuList[i] +"</option>");
				}
			},
			error : function(xhr, status, error) {
			}
		})
	}
	//동 리스트 셋팅, 동 선택 값설정
	function setDongList(gungu){
		//동과 코드 리스트 가져오기
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : "/api/location/sector?sector_gu="+encodeURI(encodeURIComponent(gungu)),
			async : false,
			success : function(data) {
				//동과 코드 리스트 셋팅
				local_code = [];
				$("#sector2").empty(); 
				local_code.push("");
				$("#sector2").append("<option>섹터선택 </option>");
				for(var i = 0; i < data.sectorDongList.length; i++){
	    		        $("#sector2").append("<option>" + data.sectorDongList[i].name + "</option>");
		    		    local_code.push(data.sectorDongList[i].no);
				}
			},
			error : function(xhr, status, error) {
			}
		})
	}
</script>
