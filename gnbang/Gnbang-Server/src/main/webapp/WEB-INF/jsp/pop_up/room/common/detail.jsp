<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>	

<!--팝업레이어-->
<div class="overlay"></div>	<!--팝업레이어 테스트 오버레이 삭제해도 되요-->
<div class="popup_wrap">
	<div class="popup_notify popup" id="popup_notify">
		<div class="popup_cell">
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
									type="checkbox" id="fake_exist" />
							</span> <span class="txt"> 방이 나갔습니다. </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> <span class="input  check"> <input
									type="checkbox" id="fake_photo" />
							</span> <span class="txt"> 사진과 다릅니다. </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> <span class="input check"> <input
									type="checkbox" id="fake_infor" />
							</span> <span class="txt"> 표기된 정보와 다릅니다. </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> <span class="input  check"> <input
									type="checkbox" id="fake_other" />
							</span> <span class="txt"> 기타 </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row ">
							<div class="input text">
								<input type="text" id="fake_other_content"
									placeholder="기타내용을 입력해 주세요" />
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
									<button onclick="addFakeProperty()">
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
	<!--inquiry문의신청팝업마감-->
	<!--m_detail_footer마감-->
	<div class="popup_inquiry popup" id="popup_inquiry">
		<div class="popup_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">문의신청</div>
					<div class="popup_close close_btn">
						<a href="#content_wrap" title="문의신청닫기"><span class="blind">문의신청닫기</span></a>
					</div>
				</div>
				<div class="popup_content_wrap">
					<div class="popup_content">
						<div class="row tit">
							<p>
								<span>${room.no}번</span>방이 궁금하세요?
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
	
									<div class="input_wrap clearfix">
										<label for="pop_cust_tel">연락번호 :</label>
										<div class="input">
											<span> <input type="text" id="pop_cust_tel"
												placeholder="하이픈없이 숫자만 입력해주세요">
											</span>
										</div>
									</div>
	
									<div class="input_wrap clearfix">
										<label for="pop_cust_time">가능시간 :</label>
										<div class="input">
											<span> <input type="text" id="pop_cust_time"
												placeholder="상담가능한 시간 자유롭게 입력해주세요">
											</span>
										</div>
									</div>
								</div>
								<!--text마감-->
							</div>
							<!--inner마감-->
	
							<div class="row">
								<div class="button">
									<div class="btn close close_btn">
										<button>
											<span>닫기</span>
										</button>
									</div>
									<div class="btn submit">
										<button onclick="applyConsultPopup()">
											<span>문의신청</span>
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
		<div class="popup_cell">
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
							<label> <span class="input check"> <input
									type="checkbox" id="modify_phone" />
							</span> <span class="txt"> 잘못된 전화번호입니다. </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> <span class="input check"> <input
									type="checkbox" id="modify_cost" />
							</span> <span class="txt"> 금액이 잘못되었습니다. </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> <span class="input check"> <input
									type="checkbox" id="modify_option" />
							</span> <span class="txt"> 옵션이 잘못되었습니다. </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> <span class="input check"> <input
									type="checkbox" id="modify_other" />
							</span> <span class="txt"> 기타 </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row ">
							<div class="input text">
								<input type="text" placeholder="기타내용을 입력해 주세요"
									id="other_content" />
							</div>
						</div>
						<!--row마감-->
					</div>
					<!--popup_content마감-->
					<div class="popup_content t_border">
						<p class="tit">사진변경</p>
						<div class="row">
							<label> <span class="input check"> <input
									type="checkbox" id="modify_photo_add" />
							</span> <span class="txt"> 사진을 추가해주세요 </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row">
							<label> <span class="input check"> <input
									type="checkbox" id="modify_photo_remove" />
							</span> <span class="txt"> 사진을 삭제해주세요 </span>
							</label>
						</div>
						<!--row마감-->
						<div class="row ">
							<div class="input text">
								<input type="text" placeholder="사진 삭제 이유를 입력해 주세요"
									id="photo_remove_content" />
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
									<button onclick="addModifyText()">
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
		<div class="popup_cell">
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
							<form id="enrollForm" method="POST">
								<ul id="photo_ul">
									<!-- 
											 html생성 공간( 추가되는 사진 ) 
									 !-->
									<li class="pic_list col4 mid_col4 sm_col2" id="photo_add_li">
										<div class="pic" onclick='document.all.uploadFile.click();'>
											<div class="media_cover">
												<a href="#" class="btn_up"><span class="blind">사진추가</span></a>
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
									<button onclick="uploadAllPhoto(); return false;">
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
		<div class="popup_cell">
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
								<button type="button" onclick="addComment()">
									<span>등록</span>
								</button>
							</div>
						</div>
						<div class="row no_padding_top">
							<div class="comment_list" id="comment_list_popup">
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
		<div class="popup_cell">
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
									<button onclick="endContract()">
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
		<div class="popup_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">관심매물담기</div>
					<div class="popup_close close_btn">
						<a href="#content_wrap" title="관심매물닫기"><span class="blind">관심매물닫기</span></a>
					</div>
				</div>
				<!--popup_title_wrap마감-->
				<div class="popup_content_wrap" id="cust_make">
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
											<button onclick="createUser()">
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
												<button onclick="addSelectItem()">
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
		<div class="popup_cell">
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
		<div class="popup_cell">
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
		<div class="popup_cell">
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
									<button>
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
	<div class="popup_agt_tel  popup" id="popup_agt_tel">
		<div class="popup_cell">
			<div class="container">
				<div class="popup_title_wrap">
					<div class="popup_title">연락처 보기</div>
					<div class="popup_close close_btn">
						<span class="blind">닫기</span>
					</div>
				</div>
				<div class="popup_content_wrap">
					<div class="popup_content">
						<div class="row">
							<div class="profile_photo">
								<p class="pic">
									<img  onerror="this.src='${pageContext.request.contextPath}/images/common/pic_base.jpg'" src="${pageContext.request.contextPath}/images/common/map_test.png" alt=" 중개보조원 사진">
								</p>

							</div>
							<div class="agent_info ">
								<div class="agt1 agt row">
									<dl>
										<dt class="blind">TEL</dt>
										<dd class="tel in-bl">
											<span id="manage_phone">
												${room.managePhone}
											</span>
										</dd>
									</dl>
									<dl>
										<dt class="in-bl">담당 :</dt>
										<dd class="in-bl" id="manage_name">
											${room.manageName} <span>(중개보조원)</span>
										</dd>

									</dl>
								</div>
								<div class="office row">
									<div class="pic">
										<span><img  onerror="this.src='${pageContext.request.contextPath}/images/common/pic_base.jpg'" src="${pageContext.request.contextPath}/images/common/map_test.png" alt="" /></span>
									</div>
									<div class="o_info">
										<p class="o_name">강남방부동산중개법인</p>
										<dl>
											<dt>대표</dt>
											<dd><%=GlobalValue.agentRepresentative%></dd>
										</dl>
										<dl>
											<dt>주소</dt>
											<dd><%=GlobalValue.gnbangAddress%></dd>
										</dl>
									</div>

								</div>
								<!--inner마감-->
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
	<!--popup_agt_tel팝업마감-->
</div>

<!-- 파일업로드 기능 -->
<form id="upload_file_frm" onsubmit="return false;">
<input id="upload_file" type="file" name="uploadFile"  accept="image/*"  style='display: none;' onchange="selectUploadPhoto(this);" />
</form> 
<!-- 사진 최종등록이 완료동안 보여질 로딩바 -->
<div id="loading" class="">                               
   <img  onerror="this.src='${pageContext.request.contextPath}/images/common/pic_base.jpg'" class="loading_img" src="${pageContext.request.contextPath}/images/common/loading.gif" alt="사진업로드 중 입니다. 잠시 기다려주세요 "/>
</div>
   
   
   