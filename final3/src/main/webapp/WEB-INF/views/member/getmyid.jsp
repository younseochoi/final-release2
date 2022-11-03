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
	
	$("#button").on('click',function(){
		
		$.ajax({
			url : 'getMyID',
			data : {'user_email':$("#email").val()},
			type : 'post',
			dataType : 'text',
			success : function(s) { 
				
				if(s==1) {
					$("#check").html("이메일로 아이디가 전송되었습니다!")
				}
				else {
					$("#check").html("해당 이메일로 가입된 아이디가 존재하지 않습니다.");
				}
				
			}
		});
	});
	
	
	

});
</script>
</head>
<body>
<h1>아이디 찾기</h1>
<div id="check"></div>
이메일로 아이디 찾기 : <input type="email" name="email" id="email">
<input type=button value="아이디 찾기" id="button">
</body>
</html>