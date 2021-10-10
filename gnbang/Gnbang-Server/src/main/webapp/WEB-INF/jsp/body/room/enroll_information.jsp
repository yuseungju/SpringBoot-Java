<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	
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
							 		<img  id="profile" src="${pageContext.request.contextPath}/images/common/account_120.png"/>
								</p>
								<p class="name">최은정님</p>
								<p class="desc">
									<strong class="txt1">${ roomCount }</strong> 방 등록
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
					<form id="enrollForm" method ="POST">
						<!--content_body-->
						<div class="content_body rwa">
							<h3 class="blind">방등록 2-정보입력</h3>
							<div class="step_section section">
								<ul class="step_wrap">
									<li class="step  "><span class="icon step1 "></span><span
										class="txt"><span class="list_num">1</span>주소중복확인</span></li>
									<li class="step current"><span class="icon step3 "></span><span
										class="txt"><span class="list_num">2</span>정보입력</span></li>
									<li class="step "><span class="icon step4 "></span><span
										class="txt"><span class="list_num">3</span>방등록완료</span></li>
								</ul>
							</div>
							<h4 class="first">주소</h4>
							<div class="container section shadow">
								<div class="row no_edit">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">집주소</div>
										</div>
										<div class="form_group tc ">
											<div class="pad">
												<div class="row">
													<div class="cols">
														<div class="form_label2 fl">
															<label>주소</label>
														</div>
														<div class="form_group2">
															<div class="text">
																<div class="input">
																	<span><input type="text" value="${postAddress.si} ${postAddress.gungu} ${postAddress.dong}"                                 
																		disabled="disabled"></span>
																</div>
															</div>
														</div>
													</div>
												</div>
												<!--번지-->
												<div class="row">
													<div class="cols">
														<div class="form_label2 fl">
															<label>번지</label>
														</div>
														<div class="form_group2">
															<div class="col text fl">
																<div class="inner">
																	<div class="input">
																		<span> <input type="text" value="${postAddress.main_address} - ${postAddress.sub_address} "                       
																			disabled="disabled" />
																		</span>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<!--나머지주소-->
												<div class="row">
													<div class="cols">
														<div class="form_label2 fl">
															<label>나머지 주소</label>
														</div>
														<div class="form_group2">
															<div class="col text fl">
																<div class="inner">
																	<div class="input">
																		<span> <input type="text" value="${postAddress.last_address} "
																			disabled="disabled" />
																		</span>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<!--새주소-->
												<div class="row">
													<div class="cols">
														<div class="form_label2 fl">
															<label>새주소</label>
														</div>
														<div class="form_group2">
															<div class="text">
																<div class="input">
																	<span><input type="text"
																		value="${postAddress.roadAddress}"
																		disabled="disabled"></span>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--집주소container마감-->
							<!--기본정보---->
							<h4>기본정보</h4>
							<div class="container section shadow">
								<div class="row">
									<div class="col tbl">
										<div class="form_group tc  col_wide first">
											<div class="pad ">
												<div class="radio fl">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" checked="checked" name="close_chk" />
														</span> <span class="txt">매물</span>
														</label>
													</div>
												</div>
												<div class="radio fl">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name="close_chk"/>
														</span> <span class="txt">매물보류</span>
														</label>
													</div>
												</div>
												<div class="select fl col_sm clear" id="sale_hold">
												</div>
												<div class="text fl col_sm clear"id="hold_content">
												</div>
		
											</div>
										</div>
		
									</div>
								</div>
								<!--건물종류-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">건물종류</div>
										</div>
										<div class="form_group tc ">
											<div class="pad">
												<div class="fl col6 mid_col4  sm_col2 radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" checked="checked"  name ="building_type_chk"/>
														</span> <span class="txt"> 아파트 </span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" name ="building_type_chk" />
														</span> <span class="txt"> 오피스텔 </span>
		
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="building_type_chk"/>
														</span> <span class="txt"> 주택 </span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="building_type_chk"/>
														</span> <span class="txt"> 원룸 </span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="building_type_chk"/>
														</span> <span class="txt"> 상가 </span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="building_type_chk"/>
														</span> <span class="txt"> 사무실 </span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="building_type_chk"/>
														</span> <span class="txt"> 건물 </span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="building_type_chk"/>
														</span> <span class="txt"> 재개발 </span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="building_type_chk"/>
														</span> <span class="txt"> 이벤트 </span>
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--층수-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">층수</div>
										</div>
		
										<div class="form_group tc ">
											<div class="col2 mid_col1 fl">
												<div class="odd pad tbl2">
													<div class="form_label2 tc2">
														<label for="">해당층</label>
													</div>
													<div class="form_group tc2">
														<div class="select">
															<div class="input">
																<span> <select id = "floor_no">
																		<option>해당층선택</option>
																		<option>반지하</option>
																		<option>지하</option>
																		<option>옥탑방</option>
																		<c:forEach var="i" begin="1" end="80">
									                                  		<option value ="${ i }">${ i }층</option>
																		</c:forEach>
																</select>
																</span>
															</div>
														</div>
													</div>
													<!--input-->
		
												</div>
												<!--odd-->
											</div>
											<div class="col2 mid_col1 fl">
												<div class="even pad tbl2">
													<div class="form_label2 tc2">
														<div for="">전체층수</div>
													</div>
													<div class="form_group tc">
														<div class="select">
															<div class="input">
																<span> <select id="all_floor">
																		<option>전체층선택</option>
																		<c:forEach var="i" begin="1" end="80">
									                                  		<option value ="${ i }">${ i }층</option>
																		</c:forEach>
																</select>
																</span>
															</div>
														</div>
													</div>
													<!--input-->
		
												</div>
												<!--even-->
											</div>
										</div>
									</div>
								</div>
								<!--층수row마감-->
								<!--준공년도-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">준공년도</div>
										</div>
										<div class="form_group tc">
											<div class="pad tbl2">
		
												<div class="text mid_col1 col2 tc2">
													<div class="input col_mid fl">
														<span>
															<input type="text" name ="built" placeholder="예)1999">
														</span>
													</div>
													<div class="txt fl">년</div>
		
												</div>
												<div class="guide col2  mid_col1 tc2">
													<span>숫자만 네 자리로 입력해 주세요 예)1998</span>
												</div>
		
											</div>
										</div>
		
									</div>
								</div>
								<!--룸개수-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">룸개수</div>
										</div>
										<div class="form_group tc">
											<div class="pad ">
												<div class="text col2 mid_col1">
													<div class="input col_mid   fl">
														<span><input type="text" name ="room_count"></span>
													</div>
													<div class="txt fl">개</div>
												</div>
		
											</div>
										</div>
		
									</div>
								</div>
								<!--욕실수-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label  tc">
											<div class="pad">욕실수</div>
										</div>
										<div class="form_group tc">
											<div class="pad ">
												<div class="text col2 mid_col1">
													<div class="input col_mid   fl">
														<span><input type="text" name="bathroom_count"></span>
													</div>
													<div class="txt fl">개</div>
												</div>
		
											</div>
										</div>
		
									</div>
								</div>
								<!--룸종류-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">방형태</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="fl col6 mid_col4  sm_col2 radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" checked="checked" name="room_type_chk"/>
														</span> <span class="txt">오픈형</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" name="room_type_chk"/>
														</span> <span class="txt">분리형</span>
		
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" name="room_type_chk"/>
														</span> <span class="txt">복층형</span>
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--면적-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label  tc">
											<div class="pad">면적</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="row">
													<div class="cols">
														<div class="form_label2 fl">
															<label>공급면적</label>
														</div>
														<div class="form_group2">
															<div class="col2 text fl">
																<div class="inner">
																	<div class="input">
																		<span> <input type="text" id ="leased_pyeong" onchange="calPyeongToArea(this)" />
																		</span>
																	</div>
																	<div class="txt">평 =</div>
																</div>
															</div>
															<div class="col2 text fl">
																<div class="inner">
																	<div class="input">
																		<span> <input type="text" id ="leased_area" name="leased_area" onchange="calAreaToPyeong(this)"/>
																		</span>
																	</div>
																	<div class="txt">
																		m<sup>2</sup>
																	</div>
																</div>
															</div>
		
														</div>
													</div>
												</div>
												<!--전용면적-->
												<div class="row">
													<div class="cols">
														<div class="form_label2 fl">
															<label>전용면적</label>
														</div>
														<div class="form_group2">
															<div class="col2 text fl">
																<div class="inner">
																	<div class="input">
																		<span> <input type="text"  id ="exclusive_pyeong" onchange="calPyeongToArea(this)" />
																		</span>
																	</div>
																	<div class="txt">평 =</div>
																</div>
															</div>
															<div class="col2 text fl">
																<div class="inner">
																	<div class="input">
																		<span> <input type="text"  id ="exclusive_area"  name = "exclusive_area" onchange="calAreaToPyeong(this)" />
																		</span>
																	</div>
																	<div class="txt">
																		m<sup>2</sup>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<!--전용면적-->
												<div class="guide ">
													<span>한단위만 입력하셔도 자동 계산되어 입력됩니다</span>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--면적row마감-->
								<!--입주가능일-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">입주가능일</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="row">
													<div class="col mid_col1  sm_col1   check">
														<div class="inner">
															<label> <span class="input"> <input
																	type="checkbox" name = "chk_empty"/>
															</span> <span class="txt">공실</span>
															</label>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="fl col6 mid_col2  sm_col2 radio">
														<div class="inner">
															<label> <span class="input"> <input
																	type="radio" checked="checked" name ="move_chk"/>
															</span> <span class="txt">즉시</span>
															</label>
														</div>
													</div>
		
													<div class="fl col6 mid_col2  sm_col2  radio ">
														<div class="inner">
															<label> <span class="input"> <input
																	type="radio" name ="move_chk"/>
															</span> <span class="txt">협의</span>
															</label>
		
														</div>
													</div>
												</div>
												<div class="row">
													<div class=" text option tbl2">
														<label class="txt tc">일자</label> <span class="input tc">
															<input type="text"  name ="move_day"/>
														</span>
													</div>
												</div>
		
											</div>
										</div>
									</div>
								</div>
								<!--입주가능일마감-->
							</div>
							<!--기본정보마감-->
							<!--금액정보---->
							<h4>금액정보</h4>
							<div class="container section shadow">
								<!--건래종류-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">거래종류</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="fl col6 mid_col4  sm_col2 radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" checked="checked" name ="trade_type_chk"/>
														</span> <span class="txt">매매</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="trade_type_chk"/>
														</span> <span class="txt">전세</span>
		
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="trade_type_chk"/>
														</span> <span class="txt">전월세</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="trade_type_chk"/>
														</span> <span class="txt">월세</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio"  name ="trade_type_chk"/>
														</span> <span class="txt">단기임대</span>
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--기준가-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label  tc">
											<div class="pad">기준가</div>
										</div>
										<div class="form_group tc">
											<div class="pad tbl2">
												<div class="text col2 mid_col1 tc2">
													<div class="input col_mid fl">
														<span><input type="text" name="standard_deposit" id="standard_deposit"/></span>
													</div>
													<div class="txt fl">만원</div>
		
												</div>
												<div class="guide col2 mid_col1 tc2">
													<span>가격을 입력하지 않으면 매물로 표시되지 않습니다.</span>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--매매가-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">매매가</div>
										</div>
										<div class="form_group tc">
											<div class="pad ">
												<div class="text col2 mid_col1">
													<div class="input col_mid fl">
														<span><input type="text" name="sale_price" id="sale_price"/></span>
													</div>
													<div class="txt fl">만원</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--전세가-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">전세가</div>
										</div>
										<div class="form_group tc">
											<div class="pad ">
												<div class="text col2 mid_col1">
													<div class="input col_mid fl">
														<span><input type="text" name="charter_deposit" id="charter_deposit"/></span>
													</div>
													<div class="txt fl">만원</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--보증금-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">보증금</div>
										</div>
										<div class="form_group tc">
											<div class="pad tbl2">
												<div class="text col2 tc2">
													<div class="input col_mid fl">
														<span><input type="text" name="deposit" id="deposit"/></span>
													</div>
													<div class="txt fl">만원</div>
		
												</div>
												<div class="fl col mid_col1  sm_col1   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" name ="deposit_modify_chk" />
														</span> <span class="txt">보증금조정가능</span>
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--월세-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">월세</div>
										</div>
										<div class="form_group tc">
											<div class="pad tbl2">
												<div class="text col2 mid_col1 tc2">
													<div class="input col_mid fl">
														<span><input type="text" name ="monthly_rent"/></span>
													</div>
													<div class="txt fl">만원</div>
		
												</div>
												<div class="guide mid_col1 col2  tc2">
													<span>전세일 경우 0을 입력하세요.</span>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--관리비-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">관리비</div>
										</div>
										<div class="form_group tc">
											<div class="row">
												<div class="pad tbl2">
													<div class="text col2 mid_col1 tc2">
														<div class="input col_mid fl">
															<span><input type="text" name ="maintenance_cost"/></span>
														</div>
														<div class="txt fl">원</div>
		
													</div>
													<div class="guide mid_col1 col2  tc2">
														<span>관리비가 없을 경우 0을 입력하세요.</span>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="cols pad mt tbl2">
													<div class="form_label3  mid_col1 tc2">
														<label>관리비포함 항목</label>
													</div>
													<div class="form_group3 mid_col1 tc2">
														<div class="pad">
															<div class="fl col6 mid_col4  sm_col2 check">
																<div class="inner">
																	<label> <span class="input"> <input
																			type="checkbox"  id="in_electronic_bill"/>
																	</span> <span class="txt">전기세</span>
																	</label>
																</div>
															</div>
															<div class="fl col6 mid_col4  sm_col2 check">
																<div class="inner">
																	<label> <span class="input"> <input
																			type="checkbox" id="in_gas_bill"/>
																	</span> <span class="txt">가스비</span>
																	</label>
																</div>
															</div>
															<div class="fl col6 mid_col4  sm_col2 check">
																<div class="inner">
																	<label> <span class="input"> <input
																			type="checkbox" id="in_water_bill" />
																	</span> <span class="txt">수도세</span>
																	</label>
																</div>
															</div>
															<div class="fl col6 mid_col4  sm_col2 check">
																<div class="inner">
																	<label> <span class="input"> <input
																			type="checkbox"  id="in_internet_bill"/>
																	</span> <span class="txt">인터넷</span>
																	</label>
																</div>
															</div>
															<div class="fl col6 mid_col4  sm_col2 check">
																<div class="inner">
																	<label> <span class="input"> <input
																			type="checkbox"  id="in_tv_bill"/>
																	</span> <span class="txt">TV</span>
																	</label>
																</div>
															</div>
															<div class="fl col6 mid_col4  sm_col2 check">
																<div class="inner">
																	<label> <span class="input"> <input
																			type="checkbox"  id="in_clean_fee"/>
																	</span> <span class="txt">청소</span>
																	</label>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--중개수수료-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">중개수수료</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="text  col2 mid_col1">
													<div class="input col_mid   fl">
														<span><input type="text" name = "brokerage"></span>
													</div>
													<div class="txt fl">만원</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--중개수수료마감-->
							</div>
							<!--금액정보마감-->
							<!--추가정보---->
							<h4>추가정보</h4>
							<div class="container section shadow">
								<!--보안시설-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">보안시설</div>
										</div>
										<div class="form_group  tc">
											<div class="pad">
												<div class="fl col6 mid_col4  sm_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id="security"/>
														</span> <span class="txt">현관보안</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id="cctv"/>
														</span> <span class="txt">CCTV</span>
		
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id="digital_doorlock"/>
														</span> <span class="txt">번호키</span>
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--옵션-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">옵션</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="fl col6 mid_col4  sm_col2 check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="airconditioner"/>
														</span> <span class="txt">에어컨</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="refrigerator"/>
														</span> <span class="txt">냉장고</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="washer" />
														</span> <span class="txt">세탁기</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="tv"/>
														</span> <span class="txt">TV</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="microwave"/>
														</span> <span class="txt">전자레인지</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="induction"/>
														</span> <span class="txt">인덕션</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="sink"/>
														</span> <span class="txt">싱크대</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="gasrange"/>
														</span> <span class="txt">가스레인지</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="sofa"/>
														</span> <span class="txt">쇼파</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="bed"/>
														</span> <span class="txt">침대</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="built_in_closet"/>
														</span> <span class="txt">붙박이장</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="closet"/> 
														</span> <span class="txt">옷장</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="dressing_table"/>
														</span> <span class="txt">화장대</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="veranda" />
														</span> <span class="txt">베란다</span>
														</label>
													</div>
												</div>
												<div class="fl col6 mid_col4  sm_col2   check">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="shoe_closet"/>
														</span> <span class="txt">신발장</span>
														</label>
													</div>
												</div>
												<div class="col1 mid_col1  sm_col1  check nest  clear">
													<div class="inner">
														<label> <span class="input"> <input
																type="checkbox" id ="other"/>
														</span> <span class="txt">기타</span> <span class="text"> <input
																id ="input_other" type="text" />
														</span>
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--엘리베이터 반려동물-->
								<div class="row">
									<!--엘리베이터-->
									<div class="col2 tbl fl mid_col1">
										<div class="form_label tc width">
											<div class="pad">엘리베이터</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="fl col2 radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" checked="checked" name ="elevator_chk">
														</span> <span class="txt">있음</span>
														</label>
													</div>
												</div>
												<div class="fl col2   radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" name ="elevator_chk">
														</span> <span class="txt">없음</span>
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!--반려동물-->
									<div class="col2 mid_col1 tbl fl">
										<div class="form_label tc width">
											<div class="pad">반려동물</div>
										</div>
										<div class="form_group tc ">
											<div class="pad">
												<div class="fl col2  radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" checked="checked" name ="animal_chk">
														</span> <span class="txt">가능</span>
														</label>
													</div>
												</div>
												<div class="fl col2  radio">
													<div class="inner">
														<label> <span class="input"> <input
																type="radio" name ="animal_chk">
														</span> <span class="txt">불가능</span>
		
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--주차-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">주차</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="row">
													<div class="fl col6 mid_col2  sm_col2 radio">
														<div class="inner">
															<label> <span class="input"> <input
																	type="radio" checked="checked" name ="parking_chk"/>
															</span> <span class="txt">가능</span>
															</label>
														</div>
													</div>
													<div class="fl col6 mid_col2  sm_col2   radio">
														<div class="inner">
															<label> <span class="input"> <input
																	type="radio" name ="parking_chk"/>
															</span> <span class="txt">불가능</span>
		
															</label>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="text option  tbl2 ">
														<div class="txt tc">
															<label>주차옵션</label>
														</div>
		
														<div class="input tc">
															<input type="text" name ="parking_option">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--난방종류-->  
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">난방종류</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="select col2 col_sm">
													<div class="input">
														<span> <select id="select_heating_type">
																<option>난방종류선택</option>
																<option>중앙난방</option>
																<option>개별난방</option>
																<option>지역난방</option>
														</select>
														</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--추가정보마감-->
							<!--상세정보-->
							<h4>상세보기</h4>
							<div class="container section shadow">
								<!--상세설명-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label  tc">
											<div class="pad">상세설명</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="textarea">
													<textarea placeholder="매물 상세 페이지에 보여지는 문구입니다" name ="detail" > </textarea>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--요구사항-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label  tc">
											<div class="pad">요구사항</div>
										</div>
										<div class="form_group tc">
											<div class="pad">
												<div class="textarea">
													<textarea
														placeholder="외부에 공개되지 않으며 강남방 중개사만 볼수 있는 메모입니다.&#13;&#10;강남방 중개사에게 전달할 사항을 입력해 주세요" name ="requirement"></textarea>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--동영상링크-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label tc">
											<div class="pad">동영상링크</div>
										</div>
										<div class="form_group tc">
											<div class="pad ">
												<div class="text ">
													<div class="input">
														<span><input type="text"
															placeholder="링크될 동영상 주소를 입력해주세요" name ="movie_url"></span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--상세정보마감-->
							<!--사진등록-->
							<h4>사진등록</h4>
							<div class="container pic_add section shadow">
								<div class="row guide col">
									<div class="pad">
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
												<button  type="button" onclick="reset_photo_ul()">
													<span>새로고침</span>
												</button>
											</p>
										</div>
									</div>
								</div>
		
									<div class="row box">
										<ul id="photo_ul">
											<li class="pic_list col6 mid_col4 sm_col2 " id="photo_add_li">
												<div class="pic ">
													<div class="media_cover ">
														<a href="#" onclick="document.all.uploadFile.click(); return false;" id ="photo_add_btn" class="btn_up"><span class="blind">사진올리기</span></a>
													</div>
												</div>
											</li>
										
										</ul>
							
									</div>
							</div>
							<!--사진등록마감-->
							<!--연락처---->
							<h4>연락처</h4>
							<div class="container section shadow">
								<!--연락처1-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label  tc">
											<div class="pad">연락처1</div>
										</div>
										<div class="form_group tc">
											<div class="col2 mid_col1 fl ">
												<div class="odd pad tbl2">
													<div class="form_label2 tc2">
														<label>관계</label>
													</div>
													<div class="form_group tc2  text">
														<div class="input ">
															<span><input type="text" name= "contact_who_1" placeholder="ex)임대인"></span>
														</div>
													</div>
												</div>
											</div>
											<div class="col2 mid_col1 fl ">
												<div class="even pad tbl2">
													<div class="form_label2 tc2">
														<label>전화번호</label>
													</div>
													<div class="form_group tc2  text">
														<div class="input ">
															<span><input type="text" name= "contact_phone_1"
																placeholder="– 없이 숫자만 입력하세요 "></span>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--연락처2-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label  tc">
											<div class="pad">연락처2</div>
										</div>
										<div class="form_group tc">
											<div class="col2 mid_col1 fl ">
												<div class="odd pad tbl2">
													<div class="form_label2 tc2">
														<label>관계</label>
													</div>
													<div class="form_group tc2  text">
														<div class="input ">
															<span><input type="text" name= "contact_who_2" placeholder="ex)관리인"></span>
														</div>
													</div>
												</div>
											</div>
											<div class="col2 mid_col1 fl ">
												<div class="even pad tbl2">
													<div class="form_label2 tc2">
														<label>전화번호</label>
													</div>
													<div class="form_group tc2  text">
														<div class="input ">
															<span><input type="text" name= "contact_phone_2"
																placeholder="– 없이 숫자만 입력하세요 "></span>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--연락처3-->
								<div class="row">
									<div class="col tbl">
										<div class="form_label  tc">
											<div class="pad">연락처3</div>
										</div>
										<div class="form_group tc">
											<div class="col2 mid_col1 fl ">
												<div class="odd pad tbl2">
													<div class="form_label2 tc2">
														<label>관계</label>
													</div>
													<div class="form_group tc2  text">
														<div class="input ">
															<span><input type="text" name= "contact_who_3" placeholder="ex)관리부동산"></span>
														</div>
													</div>
												</div>
											</div>
											<div class="col2 mid_col1 fl ">
												<div class="even pad tbl2">
													<div class="form_label2 tc2">
														<label>전화번호</label>
													</div>
													<div class="form_group tc2  text">
														<div class="input ">
															<span><input type="text" name= "contact_phone_3"
																placeholder="– 없이 숫자만 입력하세요 "></span>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--연락처마감-->
						</div>
						<!--content_body마감-->
						<!--버튼-->
						<div class="row btn_wrap mt">
							<div class="button">
								<div class="btn close close_btn">
									<button type="reset" onclick ='location.href="/room/enroll/agent"'>
										<span>취소</span>
									</button>
								</div>
								<div class="btn submit">
									<button type="submit" onclick ="uploadAll(); return false;">
										<span>방등록</span>
									</button>
								</div>
							</div>
						</div>
						
					</form>
				</div>
				<!--panel마감-->
			</div>
			<!--page마감-->
	
		</div>
		<!--content마감-->
	</div>
	<!--content_wrap마감-->
	
	<form id="upload_file_frm" onsubmit="return false;">
	<input id="upload_file" type="file" name="uploadFile" accept="*" style='display: none;' onchange="selectPhoto(this);" />
	</form>

<script>
	$(document).ready(function() { 
		//프로필 사진 설정
		setProfilePhoto('profile');
	});
</script>				
<script>	
	var formData = {};//등록할 모든 정보 보관
	function uploadAll(){
		setEnrollInfor();//기본 저장정보설정
		setAddressAtr();//주소 인근 정보 설정
		if(!check())//기본 저장정보 예외 확인	
			return;
		uploadAllPhotoAndInfor();//사진 임시폴더에서 실제 경로로 최종등록
	}
</script>
<!-- 파일업로드 -->
<script>
	/*************************파일 업로드 및 방등록 데이터 설정************************************/
	 var temp_enroll_num = 0;//임시등록 성공 수
	 var photo_cnt = 0;//사진 고유번호 
	 var photo_li_id = [];//뷰에보여지는 사진 id 
	 var photo_temp_url = [];
	 var upload = document.getElementById('upload_file');
	 function selectPhoto(obj){
		if(obj.value =='')//사진찾기 -> 사진 선택을 안하고 취소했으면
			return;
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
	//이미지 컨테이터(뷰)출력
	function addPhotoView(){
		var str ="";
		str+="<li class=\"pic_list col6 mid_col4 sm_col2\" id= \"li_"+ photo_cnt + "\">";
		str+="	<div class=\"pic\">";
		str+="		<div class=\"media_cover media_photo\">";
		str+="			<img src=\"\" id= \"preview_"+ photo_cnt + "\" alt=\"상세사진1\" />";
		str+="		</div>";
		str+="		<div class=\"btn_del\">";
		str+="			<a href=\"#\" onclick=\"remove("+ photo_cnt + "); return false;\" alt=\"사진삭제하기\"><span class=\"blind\">사진삭제</span></a>";
		str+="		</div>";
		str+="	</div>";
		str+="</li>";
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
	//사진 선택 지우기
	function remove(target_photo_cnt){
		$("#li_" + target_photo_cnt).remove();
		photo_li_id.splice(photo_li_id.indexOf(target_photo_cnt),1);
	}
	//모든 사진지우기
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
		photo_temp_url.push(photo_cnt);
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
	        	}else{
    				photo_temp_url.splice(target_photo_cnt, 1, data.tempPath); 
    				temp_enroll_num++;//사진등록성공시
	        	}
	        },
	        error:function(request,status,error){
	        }
		});
	}
	//사진모두를 서버에  업로드(파일경로저장 , ftp업로드, 강남방서버 업로드)
	function uploadAllPhotoAndInfor(){
		if(0< photo_li_id.length && photo_li_id.length < 3){
			alert('사진을 등록 할 경우 3개 이상만 업로드 해주세요.');
			return;
		}
		if(temp_enroll_num !=  photo_temp_url.length){//등록할 이미지의 수와 임시로등록된이미지의수가 다르면 종료(임시업로드 처리중에있으면)
			alert('사진을 찾고있습니다. 잠시후 다시 시도해주세요');
			return;
		}
		var path_data = [];
		for(var i = 0; i < photo_li_id.length; i++)
			path_data.push(photo_temp_url[photo_li_id[i]]);//선택된사진들의(뷰에 보여지는) 경로만 데이터로지정
		formData["tempPathArr"] =	JSON.stringify(path_data);
	    $.ajax({
	        type: 'POST',
	        url: "/api/room/enroll",
	        contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(formData),
	        async: true,
	        success: function(result) {
	        	if(result)
	        		document.location.href = "/room/enroll/complete";//성공시에 등록완료창으로
	        	else 
	        		alert('다시 로그인해주세요.');
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert('사진등록실패, 방 상세보기에서 사진을 추가해주세요.');//서버에러
	        }
	    });
	}
	</script>
	<!-- 위치 및 주소정보 -->
	<script>
	/*************************방 위치정보 설정************************************/
	function setAddressAtr(){
		//방등록시 필요한 주소 데이터 가져오기
		//방등록시 필요한  주소데이터 설정
		formData["local_code"] = "${postAddress.code}";
		formData["main_address"] = "${postAddress.main_address}";
		formData["sub_address"] = "${postAddress.sub_address}";
		formData["last_address"] = "${postAddress.last_address}";
		formData["lat"] = "${postAddress.lat}";
		formData["lng"] = "${postAddress.lng}";
	}
	//인근 지하철역 정보 설정
	function setMetro(){
		var lat = "${postAddress.lat}";
		var lng = "${postAddress.lng}"
		var code =  "SW8";
		var  information = '' ;
		var tempData= [];
		jQuery
		.ajax({
			type : "GET",
			dataType : "json",
			url : "https://apis.daum.net/local/v1/search/category.json?apikey=<%=GlobalValue.mapApi%>&location="
					+lat+","+lng+"&radius=500&code="+code+"&sort=2" + "&count=10" ,
			async : true,//크로스도메인은 어차피 동기만 지원
			dataType : "jsonp",
			success : function(data) {//msg를 받는 것이 성공하면
				//중복되는 역과 호선 제거  ex)강남역1호선, 강남역 2호선  -->  강남역
				var current;
				var before;
				for(var i=0; i < data.channel.item.length; i++){
					current = (data.channel.item[i].title).substring(0, (data.channel.item[i].title).lastIndexOf(' ') +1);
					if(i == 0){
						tempData.push(current);
						before = current;
					}else {
						if(before != current){
							tempData.push(current);
							before = current;
						}
					}
				}
				//정리된 지하철역 이름만 저장
				for(var i =0; i < tempData.length; i++)
					formData["metroName"+(i + 1)] = tempData[i];
			},
			error : function(xhr, status, error) {
			}
		});
	} 
	setMetro();
	function setSection(){
		var section;
		var dong = "${postAddress.dong}";
		var main_address = "${postAddress.main_address}";
		if("신사동".indexOf(dong) != -1) {  
		         if ( main_address >= 501 && main_address <= 586 )
		           section = "sinsa1";
		        else if ( main_address >= 587 && main_address <= 629 )
		       	 section = "apgujeong1";
	     }
	     else if("압구정동".indexOf(dong) != -1) {  
	        if ( main_address >= 587 && main_address <= 629 )
	            section = "apgujeong1";
	        else if ( main_address >= 630 && main_address <= 666 )
	            section = "apgujeong2";
	     }
	     else if("청담동".indexOf(dong) != -1) {  
	        if ( main_address >= 1 && main_address <= 47 )
	            section = "cheongdam1";
	        else if ( main_address >= 48 && main_address <= 77 )
	            section = "cheongdam2";
	        else if ( main_address >= 78 && main_address <= 129 )
	            section = "cheongdam3";
	     }
	     else if("논현동".indexOf(dong) != -1) {  
	        if ( main_address >= 1 && main_address <= 58 )
	            section = "nonhyeon1";
	        else if ( main_address >= 59 && main_address <= 90 )
	            section = "nonhyeon2";
	        else if ( main_address >= 91 && main_address <= 119 )
	            section = "nonhyeon3";
	        else if ( main_address >= 120 && main_address <= 206 )
	            section = "nonhyeon4";
	        else if ( main_address >= 207 && main_address <= 237 )
	            section = "nonhyeon5";
	        else if ( main_address >= 238 && main_address <= 278  )
	            section = "nonhyeon6";
	     }
	     else if("삼성동".indexOf(dong) != -1) {  
	        if ( main_address >= 1 && main_address <= 51 )
	            section = "samsung1";
	        else if ( main_address >= 52 && main_address <= 77 )
	            section = "samsung2";
	        else if ( main_address >= 78 && main_address <= 111 )
	            section = "samsung3";
	        else if ( main_address >= 112 && main_address <= 144 )
	            section = "samsung4"; 
	        else if ( main_address >= 145 && main_address <= 171 )
	            section = "samsung5";
	     }
	     else if("역삼동".indexOf(dong) != -1) {  
	        if ( main_address >= 601 && main_address <= 649 )
	            section = "yeoksam1";
	        else if ( main_address >= 808 && main_address <= 822 )
	            section = "yeoksam1";
	        else if ( main_address >= 650 && main_address <= 679 )
	            section = "yeoksam2";
	        else if ( main_address >= 680 && main_address <= 705 )
	            section = "yeoksam3";
	        else if ( main_address >= 706 && main_address <= 716 )
	            section = "yeoksam4";
	        else if ( main_address >= 754 && main_address <= 768 )
	            section = "yeoksam4";    
	        else if ( main_address >= 717 && main_address <= 734 )
	            section = "yeoksam5";
	        else if ( main_address >= 769 && main_address <= 788 )
	            section = "yeoksam5";  
	        else if ( main_address >= 735 && main_address <= 753  )
	            section = "yeoksam6";
	        else if ( main_address >= 789 && main_address <= 799  )
	            section = "yeoksam6";   
	        else if ( main_address >= 823 && main_address <= 840  )
	       	 section = "yeoksam6";   
	     }
	     else if("대치동".indexOf(dong) != -1) {  
	        if ( main_address >= 889 && main_address <= 941 )
	           section = "daechi1";
	        else if ( main_address >= 942 && main_address <= 988 )
	           section = "daechi2";
	     }
	     else if("도곡동".indexOf(dong) != -1) {  
	   	  	section = "dogok1";
	     }
	     else if("잠원동".indexOf(dong) != -1) {  
	        if ( main_address >= 6 && main_address <= 48 )
	       	section = "jamwon1";
	     }
	     else if("반포동".indexOf(dong) != -1) {  
	        if ( main_address >= 701 && main_address <= 748 )
	           section = "banpo1";
	     }
	     else if("서초동".indexOf(dong) != -1) {
	        if ( main_address >= 1301 && main_address <= 1318 )
	           section = "seocho1";
	        else if ( main_address >= 1319 && main_address <= 1339 )
	           section = "seocho2";
	        
	        else if ( main_address >= 1340 && main_address <= 1366 )
	           section = "seocho3";
	     }
		 formData["sectionName"] = section;
	}
	setSection();
</script>
<!-- 방등록 기본정보 저장및 예외 확인 -->
<script>
	var close='';//매물(0)/매물보류(1)
	var close_reason=':::';//'계약완료 : 임대인요청 : 기타 : 기타의 사유
	var close_reason_content='';//매물보류 기타사유
	var building_type='';//건물 형태
	//층수
	var all_floor=0;//전체층수
	var floor_no=0;//해당층수
	var semi_basement=0;// 반지하여부
	var rooftop=0;// 옥탑방여부
	
	var built ='';//준공년도
	
	var bathroom_count='';//욕실수
	var room_count = '';//방개수
	var room_count_onepointfive = 0;//1.5룸여부
	var room_type='';  //방형태
	
	var exclusive_area=''; //전용면적
	var leased_area=''; //공급면적
	
	var empty='';//공실여부
	var move_type='';//이사 가능날짜 협의/즉시
	var move_day='';//입주가능일
	
	var trade_type='';//거래 종류  매매/전세/전월세/월세/단기임대
	
	//가격
	var standard_deposit='';//기준가
	var sale_price='';//매매가
	var charter_deposit='';//전세
	var deposit='';//보증금
	var monthly_rent='';//월세
	var maintenance_cost='';//관리비
	var  deposit_modify='';//보증금협의가능
	var  brokerage='';//중개수수료
	
	var parking_option='';//주차옵션
	var parking='';//주차여부
	var animal='';//반려동물
	var elevator='';//엘리베이터여부
	
	var heating_type=-1;//난방종류
	
	//기타옵션(보안, )
	var  other_option='';
	
	var detail='';//상세보기 상세설명
	var requirement='';//요구사항
	var movie_url='';//동영상경로
	
	var contact_who_1;//연락처 관계1(임대)
	var contact_phone_1;//연락처
	var contact_who_2;//연락처 관계2(관리)
	var contact_phone_2;//연락처
	var contact_who_3;//연락처 관계3(부동산)
	var contact_phone_3;//연락처
	
	function setEnrollInfor(){
		//방 등록 정보 값 name에 설정
		//name: other_option 기타옵션 초기화
		other_option = '';
		formData["other_option"] = other_option;
		//name: close   매물 여부 : 매물(0)/매물보류(1) 
		close = $('input[name="close_chk"]:checked').index('input[name="close_chk"]');
		if(close == 0)
			formData["close"] = 0;
		else
			formData["close"] = 1;
		
		//name : close_reason    매물보류 사유->  계약완료 : 임대인요청 : 기타 : 기타의 사유 
		close_reason_content ='';
		if(close_reason == '::기타:')
			close_reason_content = $("input[name='close_reason_content']").val();
		close_reason += close_reason_content;
		$("input[name='close_reason']").val(close_reason);
		formData["close_reason"] = close_reason;

		//name : apartment/officetel/house/normal_room/
		//name : /shop/office/building/redevelopment/event  건물종류
		building_type = $('input:radio[name=building_type_chk]:checked').index('input[name="building_type_chk"]');
		formData["apartment"] = 0;
		formData["officetel"] = 0;
		formData["house"] = 0;
		formData["normal_room"] = 0;
		formData["shop"] = 0;
		formData["office"] = 0;
		formData["building"] = 0;
		formData["redevelopment"] = 0;
		formData["event"] = 0;
		if(building_type == 0)
			formData["apartment"] = 1;
		else if(building_type == 1)
			formData["officetel"] = 1;
		else if(building_type == 2)
			formData["house"] = 1;
		else if(building_type == 3)
			formData["normal_room"] = 1;
		else if(building_type == 4)
			formData["shop"] = 1;
		else if(building_type == 5)
			formData["office"] = 1;
		else if(building_type == 6)
			formData["building"] = 1;
		else if(building_type == 7)
			formData["redevelopment"] = 1;
		else if(building_type == 8)
			formData["event"] = 1;
		
		//name :  floor_no/all_floor  해당층수/전체층수
		all_floor = $("#all_floor option:selected").val();//전체층수
		floor_no = $("#floor_no option:selected").val();//해당층수
		if(floor_no =='옥탑방'){
			rooftop = 1;// 옥탑방여부
			floor_no = 0;//해당층수
		}else if(floor_no =='반지하'){
			semi_basement = 1;// 반지하여부
			floor_no = 0;//해당층수
		}else if(floor_no =='지하'){
			floor_no= -1;//해당층수
		}
		formData["all_floor"] = all_floor;
		formData["floor_no"] = floor_no;
		formData["semi_basement"] = semi_basement;
		formData["rooftop"] = rooftop;
		
		//name :  built  준공년도
		built = $("input[name='built']" ).val();
		formData["built"] = built;
		
		//name :  room_count  방의 수
		room_count = $("input[name='room_count']" ).val();
		formData["room_count"] = room_count;

		//name :  bathroom_count  욕실 수
		bathroom_count = $("input[name='bathroom_count']" ).val();
		formData["bathroom_count"] = bathroom_count;
		
		//name :  room_count_onepointfive  1.5룸 여부
		room_count_onepointfive = 0;
		if(room_count == '1.5')
			room_count_onepointfive = 1;
		formData["room_count_onepointfive"] = room_count_onepointfive;

		//name :  room_type  오픈형(1)/분리형(2)/복층형(3)
		room_type = $('input:radio[name=room_type_chk]:checked').index('input[name="room_type_chk"]');
		if(room_type == 0){
			formData["room_type"] = 1;
		}else if(room_type == 1){
			formData["room_type"] = 2;
		}else if(room_type == 2){
			formData["room_type"] = 3;
		}
		
		//name :  leased_area  공급면적
		leased_area = $("input[name='leased_area']" ).val();//공급면적
		formData["leased_area"] = leased_area;
		
		//name :  exclusive_area  전용면적
		exclusive_area = $("input[name='exclusive_area']" ).val();//전용면적
		formData["exclusive_area"] = exclusive_area;
		
		//name : empty  공실x(0)/공실(1)
		empty = $('input:checkbox[name=chk_empty]:checked').index('input[name="chk_empty"]');
		if(empty == -1)
			empty = 0;
		else if(empty == 0)
			empty = 1;
		formData["empty"] = empty;
		
		//name : move_now/move_modify   이사 가능 날짜: 협의가능/즉시
		move_type = $('input:radio[name=move_chk]:checked').index('input[name="move_chk"]');
		formData["move_modify"] = 0;
		formData["move_now"] = 0;
		if(move_type == 0){//이사가능날짜 즉시이면
			formData["move_now"] = 1;
		}else if(move_type == 1){//이사가능날짜 협의가능이면
			formData["move_modify"] = 1;
		}
		// name :move_day  입주가능일 
		move_day = $("input[name*='move_day']" ).val();
		formData["move_day"] = move_day;
		
		//name : type   거래종류 : 매매(1)/전세(2)/전월세(4)/월세(8)/단기임대(16)
		trade_type = $('input:radio[name=trade_type_chk]:checked').index('input[name="trade_type_chk"]');
		if(trade_type == 0){
			formData["type"] = 1;
		}else if(trade_type == 1){
			formData["type"] = 2;
		}else if(trade_type == 2){
			formData["type"] = 6;
		}else if(trade_type == 3){
			formData["type"] = 4;
		}else if(trade_type == 4){
			formData["type"] = 8;
		}
		
		//name :  standard_deposit/charter_deposit/deposit/
		//name :  /monthly_rent/maintenance_cost/brokerage    거래가격
		standard_deposit = $("input[name='standard_deposit']" ).val();//기준가
		formData["standard_deposit"] = standard_deposit;
		sale_price = $("input[name='sale_price']" ).val();//매매가
		formData["sale_price"] = sale_price;
		charter_deposit = $("input[name='charter_deposit']" ).val();//전세
		formData["charter_deposit"] = charter_deposit;
		deposit = $("#deposit").val();//보증금
		formData["deposit"] = deposit;
		monthly_rent = $("input[name='monthly_rent']" ).val();//월세
		formData["monthly_rent"] = monthly_rent;
		maintenance_cost = $("input[name='maintenance_cost']" ).val();//관리비
		formData["maintenance_cost"] = maintenance_cost;
		brokerage = $("input[name='brokerage']" ).val();//중개수수료
		formData["brokerage"] = brokerage;
		
		//name : in_electronic_bill/in_gas_bill/in_water_bill/
		//name : /in_tv_bill/in_internet_bill/in_clean_fee    관리비 포함 내역
		formData["in_electronic_bill"] = 0;
		formData["in_gas_bill"] = 0;
		formData["in_water_bill"] = 0;
		formData["in_tv_bill"] = 0;
		formData["in_internet_bill"] = 0;
		formData["in_clean_fee"] = 0;
		if($("#in_electronic_bill").is(":checked"))
			formData["in_electronic_bill"] = 1;
		if($("#in_gas_bill").is(":checked"))
			formData["in_gas_bill"] = 1;
		if($("#in_water_bill").is(":checked"))
			formData["in_water_bill"] = 1;
		if($("#in_internet_bill").is(":checked"))
			formData["in_internet_bill"] = 1;
		if($("#in_tv_bill").is(":checked"))
			formData["in_tv_bill"] = 1;
		if($("#in_clean_fee").is(":checked"))
			formData["in_clean_fee"] = 1;
		
		//name : deposit_modify  보증금 조정 가능      
		deposit_modify = $('input:checkbox[name=deposit_modify_chk]:checked').index('input[name="deposit_modify_chk"]');
		if(deposit_modify == -1){//보증금 조정 불가능
			formData["deposit_modify"] = 0;
		}else if(deposit_modify == 0){//조정가능
			formData["deposit_modify"] = 1;
		}
		
		//name : security/digital_doorlock/other_option     보안 있음(1)/없음(0), 보안옵션 내용
		formData["security"] = 0;
		formData["digital_doorlock"] = 0;
		if($("#security").is(":checked"))//현관보안
			formData["security"] = 1;
		if($("#digital_doorlock").is(":checked"))//번호키
			formData["digital_doorlock"] = 1;
		if($("#cctv").is(":checked"))//cctv체크시 other option에 추가
			other_option += 'cctv(방범시스템),';
		formData["other_option"] = other_option;

		//name : airconditioner/refrigerator/washer/
		//name : tv/microwave/induction/
		//name : gasrange/bed/built_in_closet/dressing_table
		//name : veranda/other_option           옵션 있음(1)/없음(0)
		formData["airconditioner"] = 0;
		formData["refrigerator"] = 0;
		formData["tv"] = 0;
		formData["microwave"] = 0;
		formData["induction"] = 0;
		formData["gasrange"] = 0;
		formData["bed"] = 0;
		formData["built_in_closet"] = 0;
		formData["closet"] = 0;
		formData["dressing_table"] = 0;
		formData["veranda"] = 0;
		
		if($("#airconditioner").is(":checked"))
			formData["airconditioner"] = 1;
		if($("#refrigerator").is(":checked"))
			formData["refrigerator"] = 1;
		if($("#washer").is(":checked"))
			formData["washer"] = 1;
		if($("#tv").is(":checked"))
			formData["tv"] = 1;
		if($("#microwave").is(":checked"))
			formData["microwave"] = 1;
		if($("#induction").is(":checked"))
			formData["induction"] = 1;
		if($("#gasrange").is(":checked"))
			formData["gasrange"] = 1;
		if($("#bed").is(":checked"))
			formData["bed"] = 1;
		if($("#built_in_closet").is(":checked"))
			formData["built_in_closet"] = 1;
		if($("#closet").is(":checked"))
			formData["closet"] = 1;
		if($("#dressing_table").is(":checked"))
			formData["dressing_table"] = 1;
		if($("#veranda").is(":checked"))
			formData["veranda"] = 1;
		if($("#shoe_closet").is(":checked"))
			other_option += '신발장,';
		if($("#sofa").is(":checked"))
			other_option += '쇼파,';
		if($("#sink").is(":checked"))
			other_option += '싱크대,';
		if($("#other").is(":checked"))
			other_option += ($("#input_other").val()+",");
		formData["other_option"] = other_option;
		
		//name : elevator  엘리베이터 있음(1)/없음(0)
		elevator = $('input:radio[name=elevator_chk]:checked').index('input[name="elevator_chk"]');
		if(elevator == 0){
			formData["elevator"] = 1;
		}else if(elevator == 1){
			formData["elevator"] = 0;
		}
		
		//name : animal  반려동물 가능(1)/불가능(0)
		animal = $('input:radio[name=animal_chk]:checked').index('input[name="animal_chk"]');
		if(animal == 0){
			formData["animal"] = 1;
		}else if(animal == 1){
			formData["animal"] = 0;
		}
		
		//name :  parking 주차여부 : 주차가능(1)/불가능(0)
		parking = $('input:radio[name=parking_chk]:checked').index('input[name="parking_chk"]');
		if(parking == 0){
			formData["parking"] = 1;
		}else if(parking == 1){
			formData["parking"] = 0;
		}
		
		//name :  parking_option  주차옵션
		parking_option = $("input[name='parking_option']" ).val();//주차옵션
		formData["parking_option"] = parking_option;
		
		//name :  heating_type  난방종류
		var select_index = $("#select_heating_type option").index($("#select_heating_type option:selected"));
        if(select_index == 0){
        	heating_type = -1;
        } else if(select_index == 1){
        	heating_type = 0;
        } else if(select_index == 2){
        	heating_type = 1;
	    } else if(select_index == 3){
	    	heating_type = 2;
	    }
		formData["heating_type"] = heating_type;
		
		//name :  detail  상세보기 상세설명
		detail = $('textarea[name="detail"]').val();
		formData["detail"] = detail;
		//name :  requirement  요구사항
		requirement = $('textarea[name="requirement"]').val();
		formData["requirement"] = requirement;
		//name :  movie_url  동영상경로
		movie_url = $("input[name='movie_url']" ).val();
		formData["movie_url"] = movie_url;
		
		//name :  contact_who_1/contact_phone_1     //연락처 관계1(임대)
		//name :  contact_who_2/contact_phone_2     //연락처 관계2(관리)
		//name :  contact_who_3/contact_phone_3     //연락처 관계3(부동산)
		contact_who_1 = $("input[name='contact_who_1']" ).val();
		formData["contact_who_1"] = contact_who_1;
		contact_phone_1 = $("input[name='contact_phone_1']" ).val();
		formData["contact_phone_1"] = contact_phone_1;
		contact_who_2 = $("input[name='contact_who_2']" ).val();
		formData["contact_who_2"] = contact_who_2;
		contact_phone_2 = $("input[name='contact_phone_2']" ).val();
		formData["contact_phone_2"] = contact_phone_2;
		contact_who_3 = $("input[name='contact_who_3']" ).val();
		formData["contact_who_3"] = contact_who_3;
		contact_phone_3 = $("input[name='contact_phone_3']" ).val();
		formData["contact_phone_3"] = contact_phone_3;
	}
	function check(){
	    if(close == 1 && close_reason ==':::'){//매물보류 입력확인
			alert('매물 보류 이유를 선택해주세요.');
			return false;
		}else if(close == 1 && close_reason =='::기타:'){//매물 보류 기타 사유 입력확인
			alert('매물 보류 기타 사유를 적어주세요.');
			return false;
		}
		
		else if(all_floor=='전체층선택'){//전체층선택 입력확인
			alert('전체층을 선택해주세요.');
			return false;
		}else if(floor_no=='해당층선택'){//해당층선택 입력확인
			alert('해당층을 선택해주세요.');
			return false;
		}else if(built ==''){//준공년도 입력확인
			alert('준공년도를 입력해주세요.');
			return false;
		}else if(built.length != 4){//준공년도 입력확인   //4자리 확인
			alert('준공년도를 정확히 입력해주세요.');
			return false;
		}
		
		else if(room_count ==''){//방개수 입력확인
			alert('방개수를 입력해주세요.');
			return false;
		}else if(10 < room_count){//방개수 입력확인  //개수초과
			alert('방개수 10개 초과');
			return false;
		}else if (!(/^[0-9]+$/).test(room_count)) {//방개수 입력확인 //정수 형태가 아니면
			alert('방개수를 정확히 입력해주세요.');
			return false;
		}
		
		else if(bathroom_count ==''){//욕실수 입력확인
			alert('욕실수를 입력해주세요.');
			return false;
		}else if(4 < bathroom_count){//욕실수 입력확인  //개수초과
			alert('욕실수 4개 초과');
			return false;
		}else if (!(/^[0-9]+$/).test(bathroom_count)) {//욕실수 입력확인 //정수 형태가 아니면
			alert('욕실수를 정확히 입력해주세요.');
			return false;
		}
		
		else if(leased_area ==''){//공급면적 입력확인
			alert('공급면적를 입력해주세요.');
			return false;
		}else if (!(/^[0-9]+(.[0-9]+)?$/).test(leased_area)) {//공급면적 입력확인 //실수 형태가 아니면
			alert('공급면적을 정확히 입력해주세요.');
			return false;
		}else if (8 < leased_area.length) {//공급면적 입력확인 //숫자의 범위를 초과하면
			alert('공급면적 범위를 초과하였습니다.');
			return false;
		}
		
		else if(exclusive_area ==''){//전용면적 입력확인
			alert('전용면적를 입력해주세요.');
			return false;
		}else if (!(/^[0-9]+(.[0-9]+)?$/).test(exclusive_area)) {//전용면적 입력확인 //실수 형태가 아니면
			alert('전용면적을 정확히 입력해주세요.');
			return false;
		}else if (8 < exclusive_area.length) {//임대면적 입력확인 //숫자의 범위를 초과하면
			alert('전용면적 범위를 초과하였습니다.');
			return false;
		} 
		
		else if(standard_deposit ==''){//기준가 입력확인
			alert('기준가를 입력해주세요.');
			return false;
		}else if (!(/^[0-9]+$/).test(standard_deposit)) {//기준가 입력확인 //정수 형태가 아니면
			alert('기준가를 정확히 입력해주세요.');
			return false;
		}else if (8 < standard_deposit.length) {//기준가 입력확인 //기준가 범위를 초과하면
			alert('기준가 범위를 초과하였습니다.');
			return false;
		}

		else if(sale_price ==''){//매매가 입력확인
			alert('매매가를 입력해주세요.');
			return false;
		}else if (!(/^[0-9]+$/).test(sale_price)) {//매매가 입력확인 //정수 형태가 아니면
			alert('매매가를 정확히 입력해주세요.');
			return false;
		}else if (8 < sale_price.length) {//매매가 입력확인 //매매가 범위를 초과하면
			alert('매매가 범위를 초과하였습니다.');
			return false;
		}
	    
		else if(charter_deposit ==''){//전세 입력확인
			alert('전세가를 입력해주세요.');
			return false;
		}else if (!(/^[0-9]+$/).test(charter_deposit)) {//전세 입력확인 //정수 형태가 아니면
			alert('전세가를 정확히 입력해주세요.');
			return false;
		}else if (8 < charter_deposit.length) {//전세 입력확인 //전세 범위를 초과하면
			alert('전세가 범위를 초과하였습니다.');
			return false;
		}

		else if(deposit ==''){//보증금 입력확인
			alert('보증금을 입력해주세요.');
			return false;
		}else if (!(/^[0-9]+$/).test(deposit)) {//보증금 입력확인 //정수 형태가 아니면
			alert('보증금을 정확히 입력해주세요.');
			return false;
		}else if (8 < deposit.length) {//보증금 입력확인 //전세 범위를 초과하면
			alert('보증금 범위를 초과하였습니다.');
			return false;
		}

		else if(monthly_rent ==''){//월세 입력확인
			alert('월세를 입력해주세요.');
			return false;
		}else if (!(/^[0-9]+$/).test(monthly_rent)) {//월세 입력확인 //정수 형태가 아니면
			alert('월세를 정확히 입력해주세요.');
			return false;
		}else if (8 < monthly_rent.length) {//월세 입력확인 //전세 범위를 초과하면
			alert('월세 범위를 초과하였습니다.');
			return false;
		}

		else if(maintenance_cost ==''){//관리비 입력확인
			alert('관리비를 입력해주세요.');
			return false;
		}else if (!(/^[0-9]+$/).test(maintenance_cost)) {//관리비 입력확인 //정수 형태가 아니면
			alert('관리비를 정확히 입력해주세요.');
			return false;
		}else if (8 < maintenance_cost.length) {//관리비 입력확인 //전세 범위를 초과하면
			alert('관리비 범위를 초과하였습니다.');
			return false;
		}

		else if(brokerage ==''){//관리비 입력확인
			alert('중개 수수료를 입력해주세요.');
			return false;
		}else if (!(/^[0-9]+$/).test(brokerage)) {//관리비 입력확인 //정수 형태가 아니면
			alert('중개 수수료를 정확히 입력해주세요.');
			return false;
		}else if (8 < brokerage.length) {//관리비 입력확인 //전세 범위를 초과하면
			alert('중개 수수료 범위를 초과하였습니다.');
			return false;
		}
	    
		else if (3000 < other_option.length){//기타옵션  // 글자수제한
			alert('기타옵션 3000자 초과');
			return false;
		}
		
		else if (50 < parking_option.length){//주차옵션  // 글자수제한
			alert('주차옵션 50자 초과');
			return false;
		}
	    /* 
			else if (parking_option =''){//주차 옵션 입력확인
			alert('주차 옵션을 입력해주세요.');
		} */
		else if (20 < move_day.length){//입주가능일  // 글자수제한
			alert('입주가능일 20자 초과');
			return false;
		}/* 
			else if (30 < move_day.length){//입주가능일 입력확인
			alert('입주가능일 입력해주세요.');
		} */
		else if (heating_type == -1){//난방 종류 입력확인
			alert('난방종류를 선택해주세요.');
			return false;
		}
		/* 
			else if (detail =''){//상세설명 입력확인
			alert('상세설명을 입력해주세요.');
		} */
		else if (3000 < detail.length){//상세설명 // 글자수제한
			alert('상세설명3000자 초과');
			return false;
		}/*
			else if (requirement =''){//요구사항 입력확인
			alert('요구사항을 입력해주세요.');
		} */
		else if (3000 < requirement.length){//요구사항  // 글자수제한
			alert('요구사항 3000자 초과');
			return false;
		}/*
			else if (movie_url =''){//동영상경로 입력확인
			alert('동영상경로를 입력해주세요.');
		} */
		else if (50 < movie_url.length){//동영상경로  // 글자수제한
			alert('동영상 경로를 정확히 입력해주세요.');
			return false;
		}

		else if ( contact_who_1 =='' || contact_phone_1 =='' ){//임대인 연락처 입력확인
			alert('임대인 연락처를 입력해주세요.');
			return false;
		}else if (20 < contact_who_1.length || 20 < contact_phone_1.length ){//임대인 연락처   // 글자수제한
			alert('동영상 경로를 정확히 입력해주세요.');
			return false;
		}else if ( contact_who_2 =='' || contact_phone_2 =='' ){//관리인 연락처 입력확인
			alert('관리인 연락처를 입력해주세요.');
			return false;
		}else if (20 < contact_who_2.length || 20 < contact_phone_2.length ){//관리인 연락처   // 글자수제한
			alert('동영상 경로를 정확히 입력해주세요.');
			return false;
		}else if ( contact_who_3 =='' || contact_phone_3 =='' ){//관리부동산 연락처 입력확인
			alert('관리부동산 연락처를 입력해주세요.');
			return false;
		}else if (20 < contact_who_3.length || 20 < contact_phone_3.length ){//관리부동산 연락처   // 글자수제한
			alert('동영상 경로를 정확히 입력해주세요.');
			return false;
		}
		return true;
	}	
	
	//매물또는 매물보류 체크시
	$("input[name=close_chk]").click(function() {  //click 함수
		var check = $(this).index('input[name="close_chk"]');
		var str = '';
	 	if(check == 0){//매물 체크시
	 		close_reason=':::';
	 		close_reason_content='';
	 		str = '';
	 	}else{//매물보류 체크시
	 		str +="		<div class=\"input\">";
			str +="			<span> <select id=\"sale_hold_select\">";
			str +="				<option>사유선택</option>";
			str +="				<option>계약완료</option>";
			str +="				<option>임대인요청</option>";
			str +="				<option>기타</option>";
			str +="			</select>";
			str +="			</span>";
			str +="		</div>";
	 	}
    	$("#hold_content").empty();
 		$("#sale_hold").empty();
 		str+="";
 		$("#sale_hold").append(str);
    });

	$(function() {
		 //매물보류 사유선택시
		 $(document).on("change","#sale_hold_select",function(){
			$("#hold_content").empty();
			var select_index = $("#sale_hold_select option").index($("#sale_hold_select option:selected"));
	        if(select_index == 0){
	        	close_reason = ':::';
	        } else if(select_index == 1){
	        	close_reason = '계약완료:::';
	        } else if(select_index == 2){
	        	close_reason = ':임대인요청::';
		    } else if(select_index == 3){
	        	close_reason = '::기타:';
	        	var str = '';
	        	str+= "<div class=\"input\">";
	        	str+= "	<span><input type=\"text\" name = \"close_reason_content\" id=\"close_reason_content\" placeholder=\"기타사유를 입력하세요\"></span>";
	        	str+= "</div>";
	        	$("#hold_content").append(str);
	        }
		});
	});
</script>

<!-- 컴포넌트 상태변화 -->
<script>
	//면적을 평수로
	function calAreaToPyeong(obj)  {
		if(obj.id == 'exclusive_area'){
			$("#exclusive_pyeong").val(($("#exclusive_area").val() * 0.3025).toFixed(2));
		}else if(obj.id == 'leased_area'){
			$("#leased_pyeong").val(($("#leased_area").val() * 0.3025).toFixed(2));
		}
	}
	//평수를 면적으로
	function calPyeongToArea(obj)  {
		if(obj.id == 'exclusive_pyeong'){
			$("#exclusive_area").val(($("#exclusive_pyeong").val() * 3.305785).toFixed(2));
		}else if(obj.id == 'leased_pyeong'){
			$("#leased_area").val(($("#leased_pyeong").val() * 3.305785).toFixed(2));
		}
	}
</script>


<!-- 프로필사진 -->
<script>
	//프로필 사진 경로가져오기
	function setProfilePhoto(contain_id){
		var path ='';
		$.ajax({
			url:"/api/member/photo",
			type: "GET", 
	        async: false,
	        success: function (data) {
	        	path = data;
	        },
	        error:function(request,status,error){
	        }
		});
		if(10 < path.length);//프로필사진이 있으면 (존재하는 url의 길이는 최소 10을 넘는다.)
			$('#' + contain_id).attr('src' , "http://112.175.245.57" + path);
		
	}
</script>