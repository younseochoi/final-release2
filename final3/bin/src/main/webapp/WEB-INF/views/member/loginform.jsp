<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='./css/loginform.css'>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	
	$("#login-button").on('click',function(e){
	
		var ref = document.referrer;
		
		if($("#password").val() != "") {
			
			$.ajax({
				url : 'login',
				data : {'id':$("#id").val() , 'password':$("#password").val()},
				type : 'post',
				dataType : 'text',
				success : function(s) { 
					
					if(s==1) {
						//window.location.href = ref;
						window.location.href = '/getproducts';
					}
					else {
						alert("아이디 또는 비밀번호가 옳지 않습니다.");
						$("#password").focus();
					}
					
				}
			});
		}
		else {
			$("#password").focus();
			
		}
		
	});
	// 로그인 버튼에 대한 ajax
	
	$("#logo-img").on('click',function(){
		
		window.location.href = "/getproducts"
	});
	

});
</script>
</head>
<body>
	<div id="main-div">
		<div id="second-div">
			<div id="div1">
			<img alt="" src="/serverimg/logo2.png" id="logo-img">
			</div>
			<div id="div2">
			<input type=text id="id" placeholder="아이디" class="input" onfocus="this.placeholder=''" onblur="this.placeholder='아이디'">
			</div>
			<div id="div3">
			<input type=password id="password" placeholder="비밀번호" class="input" onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호'">
			</div>
			<div id="div4">
			<input type=button id="login-button" value="로 그 인">
			</div>
		</div>
		<div id="third-div">
		<ul>
		<li><a href="">아이디 찾기</a></li>
		<li><a href="">비밀번호 찾기</a></li>
		<li><a href="">회원가입</a></li>
		</ul>
		</div>
	</div>
</body>
</html>