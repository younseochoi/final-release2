<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='./css/chatting.css'>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {


});
</script>
</head>
<body>
	<div id="container" class="container">
		<input type="hidden" id="sessionUser_num" value="${sessionUser_num}">
		<input type="text" id="roomNumber" value="${roomNumber}">
		<input type="hidden" id="userName" value="${buyer_name}">
		<table border="2" style="text-align: center;">
		<tr><td>${seller_name}</td></tr>
		<tr><td><input type=button id="report-button" value="신고하기"></td></tr>
		<tr><td><input type=button id="getout-button" value="채팅방 나가기"></td></tr>
		</table>
		<div id="info-table">
			<table border="2">
			<tr><td>${dto.product_title}</td></tr>
			<tr><td>${dto.product_price}원</td></tr>
			</table>
		</div>
		<div id="chating" class="chating">
		</div>

		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
<script src='./js/chatting.js'></script>
</body>
</html>