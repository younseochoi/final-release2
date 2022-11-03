<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	
	if("${sessionUser_num}" != "") {
		$("#login-button").css('display','none');
		$("#logout-button").removeAttr("hidden");
	}
	else {
		$("#my-page").css('display','none');
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


});
</script>
</head>
<body>
경매 확인용 메인 페이지<br>
<a href="productdetail?product_num=1">상품페이지</a><br>
<div id="login">
	<a href="loginform"><input type="button" id="login-button" value="로그인"></a>
	<a href="logout"><input type="button" id="logout-button" value="로그아웃" hidden="true"></a><br>
</div>
<div id="my-page" style="border: 1px solid black">
	<h1>로그인 시 표시될 버튼들</h1>
	<a href="sellproductlist">판매글모아보기</a>
	<a href="buyinglist?buyer_num=${sessionUser_num}">구매 목록(로그인 해야됨)</a>
</div>
<hr>
<div class="menu">
<form action="search" method="get">
<select id="search_select"  name="search_select">
	<option value="product_title">제목</option>
	<option value="product_contents">내용</option>
</select>
	<input type="text" placeholder="검색어 입력" name="keyword">
	<button type="submit">검색</button>
</form>
	<!-- <button type="submit" id="search_detail_btn">상세검색</button> 추후 추가 고려중-->
</div>
</body>
</html>