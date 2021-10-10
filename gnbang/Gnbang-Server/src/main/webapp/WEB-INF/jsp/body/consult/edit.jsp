<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>

<!-- <body class="consult sub"> -->
	<!--content_wrap-->
	<div id="content_wrap" class="clearfix">
		<div class="content">
			<div class="page">
				<div class="page_header">
					<h2>
						<span class="txt1">상담신청, </span><span class="txt2">방구해요</span>
					</h2>
				</div>
				<!--page_header마감-->
				<div class="panel">
					<div class="content_header consult_header">
						<div class="tip">
							<p>
								<img src="images/consult/help.png" alt="도와줘요. 강남방" />
							</p>
						</div>
						<div class="container">
							<div class="inner">
								<div class="pic">
									<p>
										<img src="images/consult/man.png" alt="중개사" />
									</p>
								</div>
								<div class="guide">
									<p class="tit">방을 찾고 있으신가요?</p>
									<p>
										그런데 어떻게 찾을지 모르시겠다면 <span class="txt1">강남방</span>에 <span
											class="txt2">상담신청</span>하세요
									</p>
									<p>강남방이 신청하신 내용에 딱 맞는 방을 찾아드립니다.</p>
								</div>
							</div>
	
						</div>
					</div>
					<!--consult_header마감-->
					<div class="content_body shadow">
						<h3 class="blind">상담신청 정보입력</h3>
						<div class="container section">
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">희망지역</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
	
											<div class="text">
												<div class="input">
													<span><input type="text"
														placeholder="동,지하철역을 입력해주세요"></span>
												</div>
											</div>
	
										</div>
									</div>
	
								</div>
							</div>
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">희망거래종류</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
											<div class=" col6 mid_col2 box check first">
												<div class="inner">
													<label> <span class="txt"> 전체 </span> <span
														class="input"> <input type="checkbox" />
													</span>
													</label>
												</div>
											</div>
											<div class=" col6 mid_col2 box check">
												<div class="inner">
													<label> <span class="txt"> 매매 </span> <span
														class="input"> <input type="checkbox" />
													</span>
													</label>
												</div>
											</div>
											<div class=" col6 mid_col2 box check">
												<div class="inner">
													<label> <span class="txt"> 전세 </span> <span
														class="input"> <input type="checkbox" />
													</span>
													</label>
												</div>
											</div>
											<div class="col6 mid_col2 box check">
												<div class="inner">
													<label> <span class="txt"> 전월세 </span> <span
														class="input"> <input type="checkbox" />
													</span>
													</label>
												</div>
											</div>
											<div class=" col6 mid_col2 box check">
												<div class="inner">
													<label> <span class="txt"> 월세 </span> <span
														class="input"> <input type="checkbox" />
													</span>
													</label>
												</div>
											</div>
											<div class="col6 mid_col2 box check last">
												<div class="inner">
													<label> <span class="txt"> 단기임대 </span> <span
														class="input"> <input type="checkbox" />
													</span>
													</label>
												</div>
											</div>
	
										</div>
									</div>
	
								</div>
							</div>
							<!--희망거래종류row마감-->
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">희망가격</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
											<div class="row">
												<div class="cols">
													<div class="form_label2 fl">
														<label>보증금</label>
													</div>
													<div class="form_group2">
														<div class="col2 text fl">
															<div class="inner">
																<div class="input">
																	<span> <input type="text" id="despositmin"
																		placeholder="보증금최소가" />
																	</span>
																</div>
																<div class="txt">~</div>
															</div>
														</div>
														<div class="col2 text fl">
															<div class="inner">
																<div class="input">
																	<span> <input type="text" id="despositmax"
																		placeholder="보증금최고가" />
																	</span>
																</div>
																<div class="txt">만원</div>
															</div>
														</div>
	
													</div>
												</div>
											</div>
											<!-- 보증금row intro_filter마감-->
											<!--월세-->
											<div class="row">
												<div class="cols">
													<div class="form_label2 fl">
														<label>월세</label>
													</div>
													<div class="form_group2">
														<div class="col2 text fl">
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
														<div class="col2 text fl">
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
											<!-- 월세마감-->
										</div>
									</div>
								</div>
							</div>
							<!--희망가격row마감-->
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">연락처</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
											<div class="text">
												<div class="input">
													<span><input type="text"
														placeholder="'-'없이 숫자만 입력해 주세요"></span>
												</div>
											</div>
										</div>
									</div>
	
								</div>
							</div>
							<!--연락처row마감-->
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">연락가능시간</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
											<div class="text">
												<div class="input">
													<span><input type="text"
														placeholder="상담가능한 시간을 입력해 주세요"></span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--연락처row마감-->
							<div class="row">
								<div class="col tbl">
									<div class="form_label tc">
										<div class="pad">희망조건</div>
									</div>
									<div class="form_group tc">
										<div class="pad">
											<div class="textarea">
												<textarea placeholder="희망 조건을 입력해 주세요"></textarea>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--연락처row마감-->
						</div>
						<!--container마감-->
	
					</div>
					<!--content_body마감-->
	
					<div class="row btn_wrap">
						<div class="button">
							<div class="btn close close_btn">
								<button>
									<span>취소</span>
								</button>
							</div>
							<div class="btn submit">
								<button>
									<span>수정</span>
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
	
	
<script>
	//상담내역을 수정한다.
	function edit(){
		var data = {};
		data["no"] = 2;
	    $.ajax({
	        type: 'PUT',
	        url: "/api/consult",
	        contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(data),
	        async: false,
	        success: function() {
	        	alert('수정되었습니다.');
	        	document.location.href="/consult";
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            alert('수정 실패 : 다시 시도해주세요');
	        }
	    });
	}
	</script>
	
	
	
	