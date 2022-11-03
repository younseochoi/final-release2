<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<script src="js/jquery-3.6.0.min.js"></script>
<link rel='stylesheet' type='text/css' href='./css/chatting.css'>
<script>
$(document).ready(function() {
	
	if("${sessionUser_num}" == "") {
		window.location.replace("temp_main");
	}
	
	$("#chatting").focus();
	
	var ref = document.referrer;

	$("#getout-button").on('click',function(){
		
		window.location.href = ref;
	});

});
</script>
</head>
<body>
<input type="hidden" id="sessionUser_num" value="${sessionUser_num}">
<input type="hidden" id="roomNumber" value="${roomNumber}">
<input type="hidden" id="buyer_num" value="${buyer_num}">
<input type="hidden" id="buyer_name" value="${buyer_name}">
<input type="hidden" id="seller_num" value="${seller_num}">
<input type="hidden" id="seller_name" value="${seller_name}">
<input type="hidden" id="time" value="${time}">
<input type="hidden" id="time2" value="${time2}">
<div class="div-td"></div>
<div id="info-div">
	<table id="info-table">
	<tr>
	<td colspan="3" class="title"><div class="title" id="title"></div></td></tr>
	<tr>
	<td colspan="2" class="title_msg-td"><img id="thumbnail" alt="" src="/final/${image}" onerror="this.src=null; this.src='/serverimg/none.png'"></td>
	<td rowspan="6" id="msg-td">
		<div id="container" class="container">
			<div class="div1"></div>
			<div id="yourMsg">
				<table class="input-table">
					<tr>
						<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
						<th><button onclick="send()" id="sendBtn">전송</button></th>
					</tr>
				</table>
			</div>
		</div></td></tr>
	<tr>
	<td class="head">판매자</td>
	<td class="info">${seller_name}</td></tr>
	<tr>
	<td class="head">상품명</td>
	<td class="info">${dto.product_title}</td></tr>
	<tr>
	<td class="head">가격</td>
	<td class="info">${dto.product_price}원</td></tr>
	<tr>
	<td colspan="2" id="contents-td">${dto.product_contents}</td></tr>
	<tr>
	<td colspan="2" id="getout-td"><input type=button id="getout-button" value="채팅방 나가기"></td></tr>
	</table>
</div>
<script src='./js/chatting.js'></script>
</body>
</html>