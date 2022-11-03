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
	
});
</script>
<title> 회원가입 </title>
</head>
<body>

<h1> 회원가입 폼</h1>
<form action="memberjoin" enctype="multipart/form-data" method="post">
아이디 : <input type=text id="user_id" name="user_id" placeholder="아이디를 입력하시오" required="required"><br>
비밀번호 : <input type=password id="user_password" name="user_password" required="required"><br>
이름 : <input type=text id="user_name" name="user_name" placeholder="이름을 입력하시오" required="required"><br>
이메일 : <input type=email id="user_email" name="user_email" required="required"><br>
전화번호 : <input type=tel id="user_tel" name="user_tel" required="required"><br>
<input type=submit value="회원가입">
</form>

</body>
</html>