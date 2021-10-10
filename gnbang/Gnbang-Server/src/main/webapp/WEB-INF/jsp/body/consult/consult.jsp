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
								<img
									src="${pageContext.request.contextPath}/images/consult/help.png"
									alt="도와줘요. 강남방" />
							</p>
						</div>
						<div class="container">
							<div class="inner">
								<div class="pic">
									<p>
										<img
											src="${pageContext.request.contextPath}/images/consult/man.png"
											alt="중개사" />
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
					<div class="btn_wrap">
						<div class="consult_btn btn">
							<a href="/consult/write">상담신청</a>
						</div>
					</div>
					<div class="content_body">
						<h3 class="blind">상담 목록</h3>
						<div class="consult_list table_list">
							<div class="container">
								<div class="list_header">
									<p class="count">상담신청 : 총 2개</p>
								</div>
								<table class="fixed board_table">
									<thead>
										<tr class="m_hidden">
											<th class="col_no" title="번호">번호</th>
											<th class="col_date " title="신청일">신청일</th>
											<th class="col_region">지역</th>
											<th class="col_price ">가격</th>
											<th class="col_btn"><span class="blind">버튼</span>&nbsp;</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="col_no">2</td>
											<td class="col_date m_no_col">2016-01-02</td>
											<td class="col_region m_no_col">강남구 삼성동</td>
											<td class="col_price m_no_col">1000/70</td>
											<td class="col_btn m_no_col"><p class="btn edit_btn">
													<a href="/consult/edit">조건수정</a>
												</p>
												<p class="btn list_btn">
													<a href="/consult/result">검색결과보기</a>
												</p></td>
										</tr>
										<tr>
											<td class="col_no ">1</td>
											<td class="col_date m_no_col">2016-01-01</td>
											<td class="col_region m_no_col">강남구 대치동</td>
											<td class="col_price m_no_col">1000/70</td>
											<td class="col_btn m_no_col"><p class="btn edit_btn">
													<a href=/consult/consult_edit>조건수정</a>
												</p>
												<p class="btn list_btn">
													<a href="/consult/consult_result">검색결과보기</a>
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
					</div>
				</div>
			</div>
			<!--page마감-->
	
		</div>
		<!--content마감-->
	</div>
	<!--content_wrap마감-->
<script>
function s(){
	alert("${str1111}");
}s();
</script>