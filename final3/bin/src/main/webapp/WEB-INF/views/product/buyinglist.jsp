<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='./css/buyinglist.css'>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {


});
</script>
</head>
<body>
<h1>구매목록</h1><hr>
<table border="1">
<c:forEach items="${buyinglist}" var="dto" varStatus="status">
<tr><td><img alt="썸네일" src="${dto.image_path}"></td><td>${dto.product_title}</td></tr>
</c:forEach>
</table>
<script src='./js/buyinglist.js'></script>
</body>
</html>