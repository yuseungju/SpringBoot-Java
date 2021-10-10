<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	
	<c:forEach items="${interestCartUser}" var="interestCartUser" >
	<p>매물번호: ${interestCartUser.room_item_no}</p><br>
	관심매물 담기번호: ${interestCartUser.no}<br>
	고객번호: ${interestCartUser.room_item_cart_list_no}<br>
	고객 연락처와 이름 : ${interestCartUser.name}<br>
	고객설명: ${interestCartUser.explain}<br>
	등록일: ${interestCartUser.date}<br>
	------------------------------------<br><br>
	</c:forEach> 