<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='./css/AuctionPage2.css'>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {

	
	if("${sessionUser_num}" == "") {
		
		$("#request-button").on('click',function(){
			alert("로그인을 하셔야 합니다");	
		});
		
		$("#cancle-button").on('click',function(){
			alert("로그인을 하셔야 합니다");	
		});
		
		$("#chatting-button1").on('click',function(){
			alert("로그인을 하셔야 합니다");
			event.preventDefault();
		});
		// @@@@@@@@@@@@@@@@@@@@@@@@@@@@ 로그인을 안했을 경우 버튼 표시에 대하여 논의 필요
	}
	else {
		
		$("#request-button").on('click',function(e){
			
			$.ajax({
				url : 'auction_request',
				data : {'product_num': ${product_dto.product_num}, 'user_num': "${sessionUser_num}" },
				type : 'post',
				dataType : 'text',
				success : function(s) {
					
					if(${request_num} == s) {
						alert("이미 요청함");
						// 이미 요청했다면 기존의 값과 리턴된 s 값이 같으므로..
					}
					else {
						location.reload();
						}
					}
				});
			});
		
		$("#cancle-button").on('click',function() {
			$.ajax({
				url : 'cancle_request',
				data : {'product_num': ${product_dto.product_num}, 'user_num': "${sessionUser_num}" },
				type : 'post',
				dataType : 'text',
				success : function(s) {
					
						if(s == 0) {
							alert("요청 기록이 존재하지 않습니다.");
						}
						else {
							alert("요청 취소 완료");
							location.reload();
						}
					}
				});
			});
		// 경매 요청 및 취소 버튼에 대한 ajax	
	}
	
	if("${product_dto.user_num}" != "${sessionUser_num}") {
	// 구매자 로그인
		$("#list-button").css('display','none');
		
	}
	else { 
	// 판매자 로그인
	
		$("#chatting-form1").css('display','none');
		$("#accept-button").removeAttr('hidden');
		$("#request-button").css("display","none");
		$("#cancle-button").css("display","none");

		$.ajax({
			url : 'roomchecking',
			data : {'seller_num':"${sessionUser_num}" , 'product_num':${product_dto.product_num}},
			type : 'post',
			dataType : 'text',
			success : function(s) {
				
				if(s == 0) {
					$("#chatting-button2").on('click',function(){
						alert("채팅 목록이 존재하지 않습니다");
						event.preventDefault();
					});
				}
			}
		});
		// 채팅 목록에 대한 ajax
			
	}
	// 경매로 바꾸기 버튼에 대한 표시
		
	if("${sessionUser_num}" != "") {
		$("#login-button").attr('hidden',true);
		$("#logout-button").removeAttr("hidden");
	}
	// 로그인 및 로그아웃 버튼에 대한 표시
	
	$("#logout-button").on('click',function(e){
		
		$.ajax({
			url : 'logout',
			type : 'post',
			dataType : 'text',
			success : function(s) { 
				location.reload();
			}
		});
	});
	// 로그아웃 버튼에 대한 ajax
	
	$("#accept-button").on('click',function(){
		
		if(${request_num} < 5) {
			alert("경매 요청이 5회 이상이어야 경매로 변경 가능합니다");
		}
		else {
			location.replace('request_accepting?product_num=${product_dto.product_num}');
		}
	});
	// 경매로 바꾸기 버튼에 대한 기능
	
	
	
	
	
	
});
</script>
</head>
<body>
<h1>임시 일반 판매 상품 페이지</h1><hr>
<table>
	<tr><td>글 제목</td><td>${product_dto.product_title}</td></tr>
	<tr><td>물품 번호</td><td>${product_dto.product_num}</td></tr>
	<tr><td>판매자 고유번호</td><td>${product_dto.user_num}</td></tr>
	<tr><td>등록 날짜</td><td>${product_dto.product_time}</td></tr>
	<tr><td>경매 물품 번호</td><td>${product_dto.detail_num}</td></tr>
	<tr><td>판매가</td><td>${product_dto.product_price}</td></tr>
	<tr><td>경매 요청 횟수</td><td><div id="request-val">${request_num}</div></td></tr>
</table><hr>
<form id="request-form">
<input type=button id="request-button" value="경매 요청">
<input type=button id="cancle-button" value="경매 요청 취소">
경매 요청 버튼은 sessionID가 다른 유저한테만 보일 예정. 요청 취소는 요청 했을때만? <hr>
</form>
<form action="chatting1" method="post" id="chatting-form1">
	<input type=hidden name="buyer_num" value="${sessionUser_num}">
	<input type=hidden name="seller_num" value="${product_dto.user_num}">
	<input type=hidden name="product_num" value="${product_dto.product_num}">
	<input type=submit id="chatting-button1" value="판매자와 채팅하기"><br>
</form>

			
<div id="list-div">
	<a href="#list-modal" rel="modal:open"><input type=button id="list-button" value="채팅목록"></a>
	<div id="list-modal" class="modal">
		<h1>채 팅 목 록</h1><hr id="chat-hr1">
		  <table id="list-table">
			<c:forEach items="${chattinglist}" var="chat" varStatus="status">
			<tr>
			<td class="buyer-name">
			<form action="chatting2" method="post" id="list-form">
			<input type=hidden value="${chat.product_num}" name="product_num">
			<input type=hidden value="${chat.buyer_num}" name="buyer_num">
			<input type=hidden value="${chat.buyer_name}" name="buyer_name">
			<input type=hidden value="${chat.seller_num}" name="seller_num">
			<input type=hidden value="${chat.roomNumber}" name="roomNumber" id="roomNumber">
			<input type=submit value="${chat.buyer_name}" id="go-chat">
			</form>
			</td>
			<td>
			<div id="chat">${chat.last_chat}</div>
			</td>
			
			</tr>
			</c:forEach>
			</table>
	</div>
</div>

<input type=button id="accept-button" value="경매로 바꾸기" hidden="true"><br>
게시글 id와 sessionID가 같은 유저한테만 보임. 경매 요청 값이 5 이상이면 활성화(색상을 바꾼던가 해서?)
<hr>
<div id="login">
<a href="loginform"><input type="button" id="login-button" value="로그인"></a>
<a href="logout"><input type="button" id="logout-button" value="로그아웃" hidden="true"></a><br>
로그인한 사람의 user_num : ${sessionUser_num} // 버튼 위치 옮겨야 함
</div>
</body>
</html>