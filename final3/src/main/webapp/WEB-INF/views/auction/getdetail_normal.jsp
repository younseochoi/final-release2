<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<link rel="stylesheet" href="CSS/slideStyle.css">
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {

	
	if("${sessionUser_num}" == "") {
		
		$("#request-button").on('click',function(){
			window.location.replace("loginform");
		});
		
		$("#cancle-button").on('click',function(){
			window.location.replace("loginform");
		});
		
		$("#chatting-button1").on('click',function(){
			event.preventDefault();
			window.location.replace("loginform");
		});
		// @@@@@@@@@@@@@@@@@@@@@@@@@@@@ 로그인을 안했을 경우 버튼 표시에 대하여 논의 필요
	}
	else {
		
		$("#request-button").on('click',function(e){
			
			$.ajax({
				url : 'auction_request',
				data : {'product_num': ${temp_dto.product_num}, 'user_num': "${sessionUser_num}" },
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
				data : {'product_num': ${temp_dto.product_num}, 'user_num': "${sessionUser_num}" },
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
	
	if("${temp_dto.user_num}" != "${sessionUser_num}") { 
	// 구매자 로그인
		
		$("#accept-button").css("display","none");
	}
	else { 
	// 판매자 로그인
	
		$("#chatting-form1").attr('hidden',true);
		$("#chatting-form2").removeAttr('hidden');
		$("#request-button").css("display","none");
		$("#cancle-button").css("display","none");
		
		$.ajax({
			url : 'roomchecking',
			data : {'seller_num':${sessionUser_num} , 'product_num':${temp_dto.product_num}},
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
			location.replace('request_accepting?product_num=${temp_dto.product_num}');
		}
	});
	// 경매로 바꾸기 버튼에 대한 기능
});
</script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@800&display=swap');
#contents{
	position:relative;
	display: flex;
	flex-flow:column;
	align-items: center;
	justify-content: center;
	border : 1px solid black;
	padding-top: 20px;
	min-width:800px;
	padding-bottom: 20px;
}
#contents #form_name{
	font-size: 24px;
	font-weight: 700;
}
#product_table{
	min-height:300px;
	padding : 10px;
	border-collapse: collapse;
	margin:20px;
}
#product_table td{
	padding:10px;
	margin: 10px;
}
button{
	border-radius: 8px;
	margin-left: 5px;
	margin-bottom: 30px;
}
#product_table .header{
	width: 100px;
	text-align: center;
}
#chat_button{
	width: 80px;
	height: 40px;
	background-color: #5C75E6;
	color: white;
	font-size: 17px;
	align: center;
	border-radius: 8px;
}
#buy_btn, #resetbtn{
	background-color: #5C75E6;
	color: white;
}
</style>
</head>
<body>
<div id="contents">
<div id="form_name">일반판매상품페이지</div>
<table border="1" id="product_table">
	<tr>
		<td rowspan="7">
		<!-- 이미지 슬라이드 부분 -->
		<div id="slideShow">
			<ul class="slides">
		      	<c:forEach var="image" items="${imagepath}" >
					<li><img src="resources/images/${image }" alt="사진" width="400px" height="300px"/></li>
				</c:forEach>
		    </ul>  
		 	<p class="controller">
				<!-- &lang: 왼쪽 방향 화살표 &rang: 오른쪽 방향 화살표 -->
				<span class="prev">&lang;</span>  
				<span class="next">&rang;</span>
		    </p>
		</div>
		<script src="JS/slideShow.js"></script>
		</td>
		<td colspan="3">
			<!-- 경매 요청 버튼은 sessionID가 다른 유저한테만 보일 예정. 요청 취소는 요청 했을때만? -->
			<form id="request-form">
			<input type=button id="request-button" value="경매 요청">
			<input type=button id="cancle-button" value="경매 요청 취소"><br>
			</form>
		</td>
	</tr>
	<tr>
		<!-- 게시글 id와 sessionID가 같은 유저한테만 보임. 경매 요청 값이 5 이상이면 활성화(색상을 바꾼던가 해서?) -->
		<td colspan="3"><input type=button id="accept-button" value="경매로 바꾸기"></td>
	</tr>
	<tr>
		<td colspan="3" class="header"><h1>${temp_dto.product_title}</h3></td>
	</tr>
	
	<tr>
		<td colspan="3"><h3>${temp_dto.product_price} 원</h3></td>
	</tr>
	<tr><td colspan="3">판매자 : <a href="userreview?user_num=${temp_dto.user_num}">${user_id}</a></td></tr>
	<tr>
		<td>안전결제여부 : ${temp_dto.safe_trade}</span></td>
		<td>경매요청횟수 : <span id="request-val">${request_num}</span></td>
		<td>게시날짜 : ${temp_dto.product_time}</td>
	</tr>
	<tr>
		<td colspan="3">
		   <ul>
	           <li>미개봉/개봉 : ${temp_dto.product_status1}</li>
	           <li>공식/비공식 : ${temp_dto.product_status2}</li>
	           <li>단종/단종아님 : ${temp_dto.product_status3}</li>
	           <li>좋음/보통/나쁨 : ${temp_dto.product_status4}</li>
	           <li>구성품 포함 / 미포함 : ${temp_dto.product_status5}</li>
       		</ul>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<input type=button id="chat_button" value="채팅">
			<form action="chatting1" method="post" id="chatting-form1">
				<input type=hidden name="buyer_num" value="${sessionUser_num}">
				<input type=hidden name="seller_num" value="${temp_dto.user_num}">
				<input type=hidden name="product_num" value="${temp_dto.product_num}">
				<input type=submit id="chatting-button1" value="판매자와 채팅하기"><br>
			</form>
			<form action="chatting_list" method="post" id="chatting-form2" hidden="true">
				<input type=hidden name="seller_num" value="${sessionUser_num}">
				<input type=hidden name="product_num" value="${temp_dto.product_num}">
				<input type=submit id="chatting-button2" value="채팅목록"><br>
			</form>
		</td>
	</tr>
	<tr>
		<td colspan="4">설명 : ${temp_dto.product_contents }</td>
	</tr>
	<!-- 안전 결제 상품일 경우 안전 결제 버튼 띄우기 -->
	<c:if test="${temp_dto.safe_trade }">
		<tr><td colspan="4"><button id="buy_btn" onclick='location.href="/getsecurepaymentform?product_num=${temp_dto.product_num}"'>안전 결제</button></td></tr>
	</c:if>
	<!-- 안전 결제 상품일 경우 안전 결제 버튼 띄우기 end -->
	<!-- 시세 보기 연결 -->
	<tr><td colspan="4"><jsp:include page="../product/quote.jsp" flush="false">
		<jsp:param value="${temp_dto.detail_num}" name="detail_num"/>
	</jsp:include></td></tr>
</table>
</div>
</body>
</html>