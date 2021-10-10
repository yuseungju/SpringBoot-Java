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
					<div class="content_header consult_result_header consult_header">
						<h3>
							<span class="region">강남구 삼성동</span> <span class="price">1000/70</span>
							검색결과입니다.
						</h3>
						<div class="btn_wrap  consult_btn_wrap">
							<div class="consult_btn btn">
								<a href="/consult">상담신청 목록보기</a>
							</div>
						</div>
					</div>
					<!--consult_header마감-->
	
					<div class="content_body consult_result_body">
						<div class="s_result">
							<div class="row col3 t_col2    mid_col1 odd">
								<div class="row_inner shadow_gray">
									<div class="ribbon ">
										<p class="recommend on">
											<!--추천매물일때 클래스 on추가-->
											<span class="txt">추천</span>
										</p>
										<p class="urgent  on">
											<!--급매물일때 클래스 on추가-->
											<span class="txt">급</span>
										</p>
									</div>
									<!-- ribbon마감-->
	
									<div class="fav fav_check">
										<!--찜하기를 선택했을때  fav_check 클래스 추가-->
										<p class="btn_fav_check">
											<span class="blind">찜하기</span>
										</p>
										<p class="btn_fav_uncheck">
											<span class="blind">찜하기취소</span>
										</p>
									</div>
									<!-- fav마감-->
									<div class="thum  image_list">
										<div class="inner">
											<ul class="thum_list">
												<li><a href="/room/detail"
													class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb.jpg"
																alt="샘플집" class="res_height" />
														</div>
												</a></li>
											</ul>
										</div>
										<!-- inner마감-->
										<div class="btn_prev btn_control" title="이전이미지">
											<p>
												<span class="blind">이전</span>
											</p>
										</div>
										<div class="btn_next btn_control" title="다음이미지">
											<p>
												<span class="blind">다음</span>
											</p>
										</div>
									</div>
									<!-- thum마감-->
									<div class="info_grounp">
										<div class="inner">
											<div class="info1 info">
												<a href="/room/detail">
													<p class="address  fl">
														<span>강남구 역삼동</span>
													</p>
													<p class="floor fl">옥탑방</p>
												</a>
											</div>
											<!-- info1마감-->
											<div class="info2 info">
												<a href="/room/detail"><p class="no fl">
														<span class="txt">매물번호:</span><span class="num">1239</span>
													</p></a>
											</div>
											<!-- info2마감-->
											<div class="info3 info">
												<a href="/room/detail"><p class="tradetype btn fl">
														<span>단기임대</span>
													</p>
													<p class="buldingtype btn fl">
														<span>오피스텔</span>
													</p>
													<p class="price fl">
														<span class="deposit">4000</span><span class="bar">/</span><span
															class="month">300</span>
													</p></a>
											</div>
											<!-- info3마감-->
											<div class="info4 info">
												<a href="/room/detail"><p class="option">
														<span>풀옵션</span><span>공실</span><span>분리형</span><span>주차</span><span>베란다</span><span>현관보안</span><span>반려동물</span>
													</p></a>
											</div>
											<!-- info4마감-->
											<div class="info5 info">
												<a href="/room/detail"><p>삼성역 인근, 풀옵션, 화이트톤 인테리어</p></a>
											</div>
											<!-- info5마감-->
										</div>
										<!-- inner마감-->
	
									</div>
									<!-- info_group마감-->
								</div>
								<!-- row_inner마감-->
							</div>
							<!-- row col2 odd마감-->
							<div class="row col3 t_col2    mid_col1 even">
								<div class="row_inner shadow_gray">
	
									<div class="ribbon ">
										<p class="recommend on">
											<span class="txt">추천</span>
										</p>
										<p class="urgent">
											<span class="txt">급</span>
										</p>
									</div>
									<!-- ribbon마감-->
									<div class="fav">
										<p class="btn_fav_check">
											<span class="blind">찜하기</span>
										</p>
										<p class="btn_fav_uncheck">
											<span class="blind">찜하기취소</span>
										</p>
									</div>
									<!--fav마감-->
									<div class="thum  image_list">
										<div class="inner">
											<ul class="thum_list">
												<li><a href="/room/detail"
													class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb4.jpg"
																alt="샘플집" class="res_height" />
														</div>
												</a></li>
											</ul>
										</div>
										<!--inner 마감-->
										<div class="btn_prev btn_control" title="이전이미지">
											<p>
												<span class="blind">이전</span>
											</p>
										</div>
										<div class="btn_next btn_control" title="다음이미지">
											<p>
												<span class="blind">다음</span>
											</p>
										</div>
									</div>
									<!--thum마감-->
									<div class="info_grounp">
										<div class="inner">
	
											<div class="info1 info">
												<a href="/room/detail"><p class="address  fl">
														<span>강남구 역삼동</span>
													</p>
													<p class="floor fl">옥탑방</p></a>
											</div>
											<!--info1마감-->
											<div class="info2 info">
												<a href="/room/detail"><p class="no fl">
														<span class="txt">매물번호:</span><span class="num">1239</span>
													</p></a>
											</div>
											<!--마감info2-->
											<div class="info3 info">
												<a href="/room/detail"><p class="tradetype btn fl">
														<span>전세</span>
													</p>
													<p class="buldingtype btn fl">
														<span>아파트</span>
													</p>
													<p class="price fl">
														<span class="deposit">4000</span><span class="bar">/</span><span
															class="month">300</span>
													</p></a>
	
											</div>
											<!-- info3마감-->
											<div class="info4 info">
												<a href="/room/detail"><p class="option">
														<span>풀옵션</span><span>공실</span><span>분리형</span><span>주차</span><span>베란다</span><span>현관보안</span><span>반려동물</span>
													</p></a>
											</div>
											<!-- info4마감-->
											<div class="info5 info">
												<a href="/room/detail"><p>삼성역 인근, 풀옵션, 화이트톤 인테리어</p></a>
											</div>
											<!-- info5마감-->
										</div>
										<!-- inner마감-->
	
									</div>
									<!-- info_group마감-->
								</div>
								<!-- row_inner마감-->
							</div>
							<!-- row col2 even마감-->
							<div class="row col3 t_col2    mid_col1 odd">
								<div class="row_inner shadow_gray">
									<div class="ribbon ">
										<p class="recommend on">
											<!--추천매물일때 클래스 on추가-->
											<span class="txt">추천</span>
										</p>
										<p class="urgent  on">
											<!--급매물일때 클래스 on추가-->
											<span class="txt">급</span>
										</p>
									</div>
									<!-- ribbon마감-->
	
									<div class="fav fav_check">
										<!--찜하기를 선택했을때  fav_check 클래스 추가-->
										<p class="btn_fav_check">
											<span class="blind">찜하기</span>
										</p>
										<p class="btn_fav_uncheck">
											<span class="blind">찜하기취소</span>
										</p>
									</div>
									<!-- fav마감-->
									<div class="thum  image_list">
										<div class="inner">
											<ul class="thum_list">
												<li><a href="/room/detail"
													class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb5.jpg"
																alt="샘플집" class="res_height" />
														</div>
												</a></li>
											</ul>
										</div>
										<!-- inner마감-->
										<div class="btn_prev btn_control" title="이전이미지">
											<p>
												<span class="blind">이전</span>
											</p>
										</div>
										<div class="btn_next btn_control" title="다음이미지">
											<p>
												<span class="blind">다음</span>
											</p>
										</div>
									</div>
									<!-- thum마감-->
									<div class="info_grounp">
										<div class="inner">
											<div class="info1 info">
												<a href="/room/detail">
													<p class="address  fl">
														<span>강남구 역삼동</span>
													</p>
													<p class="floor fl">옥탑방</p>
												</a>
											</div>
											<!-- info1마감-->
											<div class="info2 info">
												<a href="/room/detail"><p class="no fl">
														<span class="txt">매물번호:</span><span class="num">1239</span>
													</p></a>
											</div>
											<!-- info2마감-->
											<div class="info3 info">
												<a href="/room/detail"><p class="tradetype btn fl">
														<span>단기임대</span>
													</p>
													<p class="buldingtype btn fl">
														<span>오피스텔</span>
													</p>
													<p class="price fl">
														<span class="deposit">4000</span><span class="bar">/</span><span
															class="month">300</span>
													</p></a>
	
											</div>
											<!-- info3마감-->
											<div class="info4 info">
												<a href="/room/detail"><p class="option">
														<span>풀옵션</span><span>공실</span><span>분리형</span><span>주차</span><span>베란다</span><span>현관보안</span><span>반려동물</span>
													</p></a>
											</div>
											<!-- info4마감-->
											<div class="info5 info">
												<a href="/room/detail"><p>삼성역 인근, 풀옵션, 화이트톤 인테리어</p></a>
											</div>
											<!-- info5마감-->
										</div>
										<!-- inner마감-->
	
									</div>
									<!-- info_group마감-->
								</div>
								<!-- row_inner마감-->
							</div>
							<!-- row col2 odd마감-->
							<div class="row col3 t_col2    mid_col1 even">
								<div class="row_inner shadow_gray">
	
									<div class="ribbon ">
										<p class="recommend on">
											<span class="txt">추천</span>
										</p>
										<p class="urgent">
											<span class="txt">급</span>
										</p>
									</div>
									<!-- ribbon마감-->
									<div class="fav">
										<p class="btn_fav_check">
											<span class="blind">찜하기</span>
										</p>
										<p class="btn_fav_uncheck">
											<span class="blind">찜하기취소</span>
										</p>
									</div>
									<!--fav마감-->
									<div class="thum  image_list">
										<div class="inner">
											<ul class="thum_list">
												<li><a href="/room/detail"
													class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb6.jpg"
																alt="샘플집" class="res_height" />
														</div>
												</a></li>
											</ul>
										</div>
										<!--inner 마감-->
										<div class="btn_prev btn_control" title="이전이미지">
											<p>
												<span class="blind">이전</span>
											</p>
										</div>
										<div class="btn_next btn_control" title="다음이미지">
											<p>
												<span class="blind">다음</span>
											</p>
										</div>
									</div>
									<!--thum마감-->
									<div class="info_grounp">
										<div class="inner">
	
											<div class="info1 info">
												<a href="/room/detail"><p class="address  fl">
														<span>강남구 역삼동</span>
													</p>
													<p class="floor fl">옥탑방</p></a>
											</div>
											<!--info1마감-->
											<div class="info2 info">
												<a href="/room/detail"><p class="no fl">
														<span class="txt">매물번호:</span><span class="num">1239</span>
													</p></a>
											</div>
											<!--마감info2-->
											<div class="info3 info">
												<a href="/room/detail"><p class="tradetype btn fl">
														<span>전세</span>
													</p>
													<p class="buldingtype btn fl">
														<span>아파트</span>
													</p>
													<p class="price fl">
														<span class="deposit">4000</span><span class="bar">/</span><span
															class="month">300</span>
													</p></a>
	
											</div>
											<!-- info3마감-->
											<div class="info4 info">
												<a href="/room/detail"><p class="option">
														<span>풀옵션</span><span>공실</span><span>분리형</span><span>주차</span><span>베란다</span><span>현관보안</span><span>반려동물</span>
													</p></a>
											</div>
											<!-- info4마감-->
											<div class="info5 info">
												<a href="/room/detail"><p>삼성역 인근, 풀옵션, 화이트톤 인테리어</p></a>
											</div>
											<!-- info5마감-->
										</div>
										<!-- inner마감-->
	
									</div>
									<!-- info_group마감-->
								</div>
								<!-- row_inner마감-->
							</div>
							<!-- row col2 even마감-->
							<div class="row col3 t_col2    mid_col1 odd">
								<div class="row_inner shadow_gray">
									<div class="ribbon ">
										<p class="recommend on">
											<!--추천매물일때 클래스 on추가-->
											<span class="txt">추천</span>
										</p>
										<p class="urgent  on">
											<!--급매물일때 클래스 on추가-->
											<span class="txt">급</span>
										</p>
									</div>
									<!-- ribbon마감-->
	
									<div class="fav fav_check">
										<!--찜하기를 선택했을때  fav_check 클래스 추가-->
										<p class="btn_fav_check">
											<span class="blind">찜하기</span>
										</p>
										<p class="btn_fav_uncheck">
											<span class="blind">찜하기취소</span>
										</p>
									</div>
									<!-- fav마감-->
									<div class="thum  image_list">
										<div class="inner">
											<ul class="thum_list">
												<li><a href="/room/detail"
													class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb.jpg"
																alt="샘플집" class="res_height" />
														</div>
												</a></li>
											</ul>
										</div>
										<!-- inner마감-->
										<div class="btn_prev btn_control" title="이전이미지">
											<p>
												<span class="blind">이전</span>
											</p>
										</div>
										<div class="btn_next btn_control" title="다음이미지">
											<p>
												<span class="blind">다음</span>
											</p>
										</div>
									</div>
									<!-- thum마감-->
									<div class="info_grounp">
										<div class="inner">
											<div class="info1 info">
												<a href="/room/detail">
													<p class="address  fl">
														<span>강남구 역삼동</span>
													</p>
													<p class="floor fl">옥탑방</p>
												</a>
											</div>
											<!-- info1마감-->
											<div class="info2 info">
												<a href="/room/detail"><p class="no fl">
														<span class="txt">매물번호:</span><span class="num">1239</span>
													</p></a>
											</div>
											<!-- info2마감-->
											<div class="info3 info">
												<a href="/room/detail"><p class="tradetype btn fl">
														<span>단기임대</span>
													</p>
													<p class="buldingtype btn fl">
														<span>오피스텔</span>
													</p>
													<p class="price fl">
														<span class="deposit">4000</span><span class="bar">/</span><span
															class="month">300</span>
													</p></a>
	
											</div>
											<!-- info3마감-->
											<div class="info4 info">
												<a href="/room/detail"><p class="option">
														<span>풀옵션</span><span>공실</span><span>분리형</span><span>주차</span><span>베란다</span><span>현관보안</span><span>반려동물</span>
													</p></a>
											</div>
											<!-- info4마감-->
											<div class="info5 info">
												<a href="/room/detail"><p>삼성역 인근, 풀옵션, 화이트톤 인테리어</p></a>
											</div>
											<!-- info5마감-->
										</div>
										<!-- inner마감-->
	
									</div>
									<!-- info_group마감-->
								</div>
								<!-- row_inner마감-->
							</div>
							<!-- row col2 odd마감-->
							<div class="row col3 t_col2    mid_col1 even">
								<div class="row_inner shadow_gray">
	
									<div class="ribbon ">
										<p class="recommend on">
											<span class="txt">추천</span>
										</p>
										<p class="urgent">
											<span class="txt">급</span>
										</p>
									</div>
									<!-- ribbon마감-->
									<div class="fav">
										<p class="btn_fav_check">
											<span class="blind">찜하기</span>
										</p>
										<p class="btn_fav_uncheck">
											<span class="blind">찜하기취소</span>
										</p>
									</div>
									<!--fav마감-->
									<div class="thum  image_list">
										<div class="inner">
											<ul class="thum_list">
												<li><a href="/room/detail"
													class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb4.jpg"
																alt="샘플집" class="res_height" />
														</div>
												</a></li>
											</ul>
										</div>
										<!--inner 마감-->
										<div class="btn_prev btn_control" title="이전이미지">
											<p>
												<span class="blind">이전</span>
											</p>
										</div>
										<div class="btn_next btn_control" title="다음이미지">
											<p>
												<span class="blind">다음</span>
											</p>
										</div>
									</div>
									<!--thum마감-->
									<div class="info_grounp">
										<div class="inner">
	
											<div class="info1 info">
												<a href="/room/detail"><p class="address  fl">
														<span>강남구 역삼동</span>
													</p>
													<p class="floor fl">옥탑방</p></a>
											</div>
											<!--info1마감-->
											<div class="info2 info">
												<a href="/room/detail"><p class="no fl">
														<span class="txt">매물번호:</span><span class="num">1239</span>
													</p></a>
											</div>
											<!--마감info2-->
											<div class="info3 info">
												<a href="/room/detail"><p class="tradetype btn fl">
														<span>전세</span>
													</p>
													<p class="buldingtype btn fl">
														<span>아파트</span>
													</p>
													<p class="price fl">
														<span class="deposit">4000</span><span class="bar">/</span><span
															class="month">300</span>
													</p></a>
	
											</div>
											<!-- info3마감-->
											<div class="info4 info">
												<a href="/room/detail"><p class="option">
														<span>풀옵션</span><span>공실</span><span>분리형</span><span>주차</span><span>베란다</span><span>현관보안</span><span>반려동물</span>
													</p></a>
											</div>
											<!-- info4마감-->
											<div class="info5 info">
												<a href="/room/detail"><p>삼성역 인근, 풀옵션, 화이트톤 인테리어</p></a>
											</div>
											<!-- info5마감-->
										</div>
										<!-- inner마감-->
	
									</div>
									<!-- info_group마감-->
								</div>
								<!-- row_inner마감-->
							</div>
							<!-- row col2 even마감-->
							<div class="row col3 t_col2    mid_col1 odd">
								<div class="row_inner shadow_gray">
									<div class="ribbon ">
										<p class="recommend on">
											<!--추천매물일때 클래스 on추가-->
											<span class="txt">추천</span>
										</p>
										<p class="urgent  on">
											<!--급매물일때 클래스 on추가-->
											<span class="txt">급</span>
										</p>
									</div>
									<!-- ribbon마감-->
	
									<div class="fav fav_check">
										<!--찜하기를 선택했을때  fav_check 클래스 추가-->
										<p class="btn_fav_check">
											<span class="blind">찜하기</span>
										</p>
										<p class="btn_fav_uncheck">
											<span class="blind">찜하기취소</span>
										</p>
									</div>
									<!-- fav마감-->
									<div class="thum  image_list">
										<div class="inner">
											<ul class="thum_list">
												<li><a href="/room/detail"
													class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb5.jpg"
																alt="샘플집" class="res_height" />
														</div>
												</a></li>
											</ul>
										</div>
										<!-- inner마감-->
										<div class="btn_prev btn_control" title="이전이미지">
											<p>
												<span class="blind">이전</span>
											</p>
										</div>
										<div class="btn_next btn_control" title="다음이미지">
											<p>
												<span class="blind">다음</span>
											</p>
										</div>
									</div>
									<!-- thum마감-->
									<div class="info_grounp">
										<div class="inner">
											<div class="info1 info">
												<a href="/room/detail">
													<p class="address  fl">
														<span>강남구 역삼동</span>
													</p>
													<p class="floor fl">옥탑방</p>
												</a>
											</div>
											<!-- info1마감-->
											<div class="info2 info">
												<a href="/room/detail"><p class="no fl">
														<span class="txt">매물번호:</span><span class="num">1239</span>
													</p></a>
											</div>
											<!-- info2마감-->
											<div class="info3 info">
												<a href="/room/detail"><p class="tradetype btn fl">
														<span>단기임대</span>
													</p>
													<p class="buldingtype btn fl">
														<span>오피스텔</span>
													</p>
													<p class="price fl">
														<span class="deposit">4000</span><span class="bar">/</span><span
															class="month">300</span>
													</p></a>
	
											</div>
											<!-- info3마감-->
											<div class="info4 info">
												<a href="/room/detail"><p class="option">
														<span>풀옵션</span><span>공실</span><span>분리형</span><span>주차</span><span>베란다</span><span>현관보안</span><span>반려동물</span>
													</p></a>
											</div>
											<!-- info4마감-->
											<div class="info5 info">
												<a href="/room/detail"><p>삼성역 인근, 풀옵션, 화이트톤 인테리어</p></a>
											</div>
											<!-- info5마감-->
										</div>
										<!-- inner마감-->
	
									</div>
									<!-- info_group마감-->
								</div>
								<!-- row_inner마감-->
							</div>
							<!-- row col2 odd마감-->
							<div class="row col3 t_col2    mid_col1 even">
								<div class="row_inner shadow_gray">
	
									<div class="ribbon ">
										<p class="recommend on">
											<span class="txt">추천</span>
										</p>
										<p class="urgent">
											<span class="txt">급</span>
										</p>
									</div>
									<!-- ribbon마감-->
									<div class="fav">
										<p class="btn_fav_check">
											<span class="blind">찜하기</span>
										</p>
										<p class="btn_fav_uncheck">
											<span class="blind">찜하기취소</span>
										</p>
									</div>
									<!--fav마감-->
									<div class="thum  image_list">
										<div class="inner">
											<ul class="thum_list">
												<li><a href="/room/detail"
													class="media_photo media_cover">
														<div class="media_cover">
															<img
																src="${pageContext.request.contextPath}/photo/sample/thumb6.jpg"
																alt="샘플집" class="res_height" />
														</div>
												</a></li>
											</ul>
										</div>
										<!--inner 마감-->
										<div class="btn_prev btn_control" title="이전이미지">
											<p>
												<span class="blind">이전</span>
											</p>
										</div>
										<div class="btn_next btn_control" title="다음이미지">
											<p>
												<span class="blind">다음</span>
											</p>
										</div>
									</div>
									<!--thum마감-->
									<div class="info_grounp">
										<div class="inner">
	
											<div class="info1 info">
												<a href="/room/detail"><p class="address  fl">
														<span>강남구 역삼동</span>
													</p>
													<p class="floor fl">옥탑방</p></a>
											</div>
											<!--info1마감-->
											<div class="info2 info">
												<a href="/room/detail"><p class="no fl">
														<span class="txt">매물번호:</span><span class="num">1239</span>
													</p></a>
											</div>
											<!--마감info2-->
											<div class="info3 info">
												<a href="/room/detail"><p class="tradetype btn fl">
														<span>전세</span>
													</p>
													<p class="buldingtype btn fl">
														<span>아파트</span>
													</p>
													<p class="price fl">
														<span class="deposit">4000</span><span class="bar">/</span><span
															class="month">300</span>
													</p></a>
											</div>
											<!-- info3마감-->
											<div class="info4 info">
												<a href="/room/detail"><p class="option">
														<span>풀옵션</span><span>공실</span><span>분리형</span><span>주차</span><span>베란다</span><span>현관보안</span><span>반려동물</span>
													</p></a>
											</div>
											<!-- info4마감-->
											<div class="info5 info">
												<a href="/room/detail"><p>삼성역 인근, 풀옵션, 화이트톤 인테리어</p></a>
											</div>
											<!-- info5마감-->
										</div>
										<!-- inner마감-->
	
									</div>
									<!-- info_group마감-->
								</div>
								<!-- row_inner마감-->
							</div>
							<!-- row col2 even마감-->
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
						<!--s_result마감-->
	
					</div>
				</div>
			</div>
			<!--page마감-->
	
		</div>
		<!--content마감-->
	</div>
	<!--content_wrap마감-->
	
