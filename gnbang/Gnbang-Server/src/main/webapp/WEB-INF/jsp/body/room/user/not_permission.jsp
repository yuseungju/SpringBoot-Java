<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>

<!-- <body class="room sub"> -->
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
				<div class="panel shadow_gray">
					<div class="content_header room_header">
						<div class="container">
							<div class="inner">
								<div class="pic">
									<p>
										<img id ="header_profile" 
											src="${pageContext.request.contextPath}/images/common/account30.png"
											alt="중개사" />
									</p>
									<p class="name">최은정님</p>
									<p class="desc">
										<strong class="txt1">0개</strong> 방이 등록 되었습니다.
									</p>
								</div>
								<div class="guide">
									<ul>
										<li><strong>강남방은 직거래 사이트가 아니며 중개 수수료가 발생합니다.</strong></li>
										<li>등록되는 모든 매물은 강남방이 실 매물인지 확인 후 강남방에 공개됩니다.</li>
										<li>부동산 중개사무소는 일반회원으로 방등록이 불가합니다.</li>
										<li>부동산 중개사무소에서는 중개사회원으로 가입하여 방등록을 하셔야 합니다. <a
											href="/join3Form" title="중개사회원 가입으로 이동">[중개사회원 가입 바로가기]</a></li>
										<li>강남방에서는 방등록 대행을 해드리고 있습니다. 방등록이 어려우신 분들은 <strong
											class="room_agency_btn"><a href="#room_agnecy"
												title="방등록 대행 신청">“방등록 대행 신청”</a></strong>을 하시면 됩니다.
										</li>
									</ul>
								</div>
							</div>
	
						</div>
					</div>
					<!--consult_header마감-->
					<div class="btn_wrap">
						<div class="room_btn btn">
							<a href="room_write.html">방등록</a>
						</div>
						<div class="room_agency_btn btn">
							<a href="#popup_room_agency" title="방등록 대행 신청">방등록 대행 신청</a>
						</div>
					</div>
					<div class="content_body">
						<h3 class="blind">승인 반려된 방 목록</h3>
						<ul class="tab_list">
							<li><p>
									<a href="/room/room">등록된방(<span>1</span>)
									</a>
								</p></li>
							<li><p>
									<a href="/room/room2">승인 대기(<span>0</span>)
									</a>
								</p></li>
							<li><p class="current">
									승인 반려(<span>1</span>)
								</p></li>
						</ul>
						<div class="room_list table_list">
							<div class="container">
								<table class="fixed board_table">
									<tbody>
										<tr>
											<td class="col_pic">
												<div class="image_list">
													<div class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb.jpg"
																alt="2003번 방사진" class="img_responsive_height" />
														</div>
													</div>
												</div>
											</td>
											<td class="col_desc  m_no_col">
												<div class="row">
													<p class="col_wide fl">
														<span class="addr">서울 강남구 도곡동 417-6 신명빌딩 2층 전체</span>
													</p>
													<p class="col_sm fl">
														<span class="tit">구분</span> <span>월세</span>
													</p>
													<p class="col_sm  fl">
														<span class="tit">기준가</span> <span>23,000</span>
													</p>
													<p class="col_sm  fl">
														<span class="tit">보/월/관</span> <span>3000/200/</span>
													</p>
												</div>
												<div class="row">
													<p class="col_sm  fl warning_txt">
														<span class="tit">반려사유</span> <span>부적절한 사진</span>
													</p>
													<p class="col_sm fl">
														<span class="tit">등록일</span> <span>2016-01-01</span>
													</p>
												</div>
	
											</td>
											<td class="col_btn m_no_col"><p class="btn edit_btn">
													<a href="">수정하기</a>
												</p></td>
	
										</tr>
										<tr>
											<td class="col_pic">
												<div class="image_list">
													<div class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb.jpg"
																alt="2003번 방사진" class="img_responsive_height" />
														</div>
													</div>
												</div>
											</td>
											<td class="col_desc  m_no_col">
												<div class="row">
													<p class="col_wide fl">
														<span class="addr">서울 강남구 도곡동 417-6 신명빌딩 2층 전체</span>
													</p>
													<p class="col_sm fl">
														<span class="tit">구분</span> <span>월세</span>
													</p>
													<p class="col_sm  fl">
														<span class="tit">기준가</span> <span>23,000</span>
													</p>
													<p class="col_sm  fl">
														<span class="tit">보/월/관</span> <span>3000/200/</span>
													</p>
												</div>
												<div class="row">
													<p class="col_sm  fl warning_txt">
														<span class="tit">반려사유</span> <span>부적절한 사진</span>
													</p>
													<p class="col_sm fl">
														<span class="tit">등록일</span> <span>2016-01-01</span>
													</p>
												</div>
	
											</td>
											<td class="col_btn m_no_col"><p class="btn edit_btn">
													<a href="">수정하기</a>
												</p></td>
	
										</tr>
										<tr>
											<td class="col_pic">
												<div class="image_list">
													<div class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb.jpg"
																alt="2003번 방사진" class="img_responsive_height" />
														</div>
													</div>
												</div>
											</td>
											<td class="col_desc  m_no_col">
												<div class="row">
													<p class="col_wide fl">
														<span class="addr">서울 강남구 도곡동 417-6 신명빌딩 2층 전체</span>
													</p>
													<p class="col_sm fl">
														<span class="tit">구분</span> <span>월세</span>
													</p>
													<p class="col_sm  fl">
														<span class="tit">기준가</span> <span>23,000</span>
													</p>
													<p class="col_sm  fl">
														<span class="tit">보/월/관</span> <span>3000/200/</span>
													</p>
												</div>
												<div class="row">
													<p class="col_sm  fl warning_txt">
														<span class="tit">반려사유</span> <span>부적절한 사진</span>
													</p>
													<p class="col_sm fl">
														<span class="tit">등록일</span> <span>2016-01-01</span>
													</p>
												</div>
	
	
											</td>
											<td class="col_btn m_no_col"><p class="btn edit_btn">
													<a href="">수정하기</a>
												</p></td>
	
										</tr>
									</tbody>
								</table>
							</div>
							<!--container마감-->
							<div class="page_wrap">
								<p class="paging">
									<a href="#" class="bor">&lt;<span class="blind">이전</span></a> <a
										href="#" class="current">1</a> <a href="#">2</a> <a href="#">3</a>
									<a href="#">4</a> <a href="#">5</a> <a href="#" class="bor"><span
										class="blind">다음</span>&gt;</a>
								</p>
							</div>
							<!--page_wrap마감 -->
						</div>
						<div class="information">
							<h4>강남방 방등록 승인 정책 안내</h4>
							<ul>
								<li>승인반려 정책</li>
								<li>승인반려 정책</li>
								<li>승인반려 정책</li>
								<li>승인반려 정책</li>
							</ul>
							<p class="phone">
								<strong>문의</strong> 02-568-2453
							</p>
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
	<!--wrap마감-->
 --%>