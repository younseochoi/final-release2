<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='./css/room.css'>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {

});
</script>
</head>
<body>
<h1>채팅목록</h1><hr>
<table border="2">
<tr>
<c:forEach items="${chattinglist}" var="dto" varStatus="status">
<tr>
<td>
<form action="chatting2" method="post">
<input type=hidden value="${dto.product_num}" name="product_num">
<input type=hidden value="${dto.buyer_num}" name="buyer_num">
<input type=hidden value="${dto.buyer_name}" name="buyer_name">
<input type=hidden value="${dto.seller_num}" name="seller_num">
<input type=hidden value="${dto.roomNumber}" name="roomNumber">
<input type=submit value="${dto.buyer_name}님" style="border: thin;">
</form>
</td>
<td>채팅내용~~</td>
</tr>
</c:forEach>
</table>
<script src='./js/room.js'></script>
</body>
</html>