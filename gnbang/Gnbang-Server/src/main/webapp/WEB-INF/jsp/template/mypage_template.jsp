<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<meta name="keyword" content="강남방, 부동산, 매매, 전세, 월세, 전월세, 단기임대, 아파트, 오피스텔,빌라, 원룸 " />
		<meta name="description" content="강남방, 강남에서 방구할 땐 강남방, 중개사가 직접 찍은 실사진,  허위매물제로, 부동산정보서비스, " />
		<link rel="stylesheet"
			href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<link href="${pageContext.request.contextPath}/css/style.css"
			rel="stylesheet" />
		<link rel="stylesheet"
			href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<title>강남방 -강남에서 방구할땐 강남방</title>
		<link href="${pageContext.request.contextPath}/images/common/favicon.ico" rel="shortcut icon"  />
	</head>	

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/script.js"></script>
 	<script type="text/javascript" src="/js/common/server_data/login.js" ></script>
	<script type="text/javascript" src="/js/common/simple_function/cookie.js"></script>
	<script type="text/javascript" src="/js/common/server_data/member_infor.js"></script>
	<script type="text/javascript" src="/js/common/simple_function/expression.js"></script>
	<script type="text/javascript" src="/js/common/simple_function/math.js"></script>
	<script type="text/javascript" src="/js/common/simple_function/thread.js"></script>
	<script type="text/javascript" src="/js/common/server_data/room_photo.js"></script>
	<script type="text/javascript" src="/js/common/simple_function/html_and_js.js"></script>
	     <!--[if lt IE 9]>
	      <script src="js/html5shiv.min.js"></script>
	      <script src="js/respond.min.js"></script>
	    <![endif]-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 
	
    <body class="${bodyClass}">
		<tiles:insertAttribute name="loginPopUP" ignore="true" />
		<a href="#content_wrap" class="skip">본문바로가기</a>
		<div id="wrap">
			<tiles:insertAttribute name="header" ignore="true" />
			<!--content_wrap-->
			<div id="content_wrap" class="clearfix">
				<div class="content">
					<div class="page">
						<tiles:insertAttribute name="page_header" ignore="true" />
						<div class="panel">
							<tiles:insertAttribute name="leftNav" ignore="true" />
							<tiles:insertAttribute name="body" ignore="true" />
						</div>
					</div>
				</div><!--page마감-->
			</div><!--content마감-->
		</div><!--content_wrap마감-->
		<div class="footer">
			<div class="footer_inner"></div>
			<!--footer_inner마감-->
		</div>
		<!-- right tab -->
		<tiles:insertAttribute name="rightNav" ignore="true" />
		<tiles:insertAttribute name="popUp" ignore="true" />
	</body>	

</html>