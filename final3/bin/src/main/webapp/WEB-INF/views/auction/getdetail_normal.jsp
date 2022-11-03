<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="CSS/slideStyle.css">
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {

	
	if("${sessionUser_num}" == "" || "${sessionUser_num}" == "${temp_dto.user_num}") {
		
		$("#request-form").css("display","none");
	}
	
	if("${temp_dto.user_num}" != "${sessionUser_num}") {
		
		$("#accept-button").css("display","none");
	}
	// 경매요청 및 취소와 경매로 바꾸기 버튼에 대한 표시
		
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
					$("#request-val").html(s);
				}
			}
		});
	});
	// 경매 요청 및 횟수 확인 ajax
	// product_num 값에 대하여 나중에 설정해야 함. 지금은 무조건 1로 줌
	// 마찬가지로 user_num 값에 대해서도 
	
	if("${sessionUser_num}" != "") {
		$("#login-button").attr('hidden',true);
		$("#logout-button").removeAttr("hidden");
	}
	
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
		
		if(${request_num} < 1) {
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
</style>
</head>
<body>

상단바 추후 수정 예정
<div id="login">
<a href="loginform"><input type="button" id="login-button" value="로그인"></a>
<a href="logout"><input type="button" id="logout-button" value="로그아웃" hidden="true"></a>
로그인한 사람의 user_num : ${sessionUser_num}
</div>
<hr>

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
		<td colspan="3"><input type=button id="chat_button" value="채팅"></td>
	</tr>
	<tr>
		<td colspan="4">설명 : ${temp_dto.product_contents }</td>
	</tr>
</table>

</div>

</body>
</html>