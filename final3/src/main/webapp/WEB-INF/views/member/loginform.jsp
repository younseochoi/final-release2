<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='./css/loginform.css?after'>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	
	document.addEventListener("keypress", function(e){
		if(e.keyCode == 13){ //enter press
			
			var ref = document.referrer;
			
			if($("#password").val() != "") {
				
				$.ajax({
					url : 'login',
					data : {'id':$("#id").val() , 'password':$("#password").val()},
					type : 'post',
					dataType : 'text',
					success : function(s) { 
						
						if(s==1) {
							window.location.href = ref;
						//	window.location.href = '/getproducts';
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
			
		}
	});
	
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
						window.location.href = ref;
					//	window.location.href = '/getproducts';
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
		
	$("#button1").on('click',function(){
		
		$.ajax({
			url : 'getMyID',
			data : {'user_email':$("#email1").val()},
			type : 'post',
			dataType : 'text',
			success : function(s) { 
				
				if(s==1) {
					$("#check1").html("이메일로 아이디가 전송되었습니다!")
				}
				else {
					$("#check1").html("해당 이메일로 가입된 아이디가 존재하지 않습니다");
					$("#email1").focus();
				}
				
			}
		});
	});
	
	$("#button2").on('click',function(){
		
		if($("#id2").val() != "" && $("#email2").val() != "") {
			
			$.ajax({
				url : 'getMyPW1',
				data : {'user_id':$("#id2").val() ,'user_email':$("#email2").val()},
				type : 'post',
				dataType : 'text',
				success : function(s) { 
					if(s != "none") {
						$("#check2").html("이메일로 인증번호가 발송되었습니다");
						$("#key1").attr("value", s);
						$("#key2").focus();
					}
					else {
						$("#check2").html("아이디 또는 이메일이 존재하지 않습니다");
						$("#check2").html(s);
					}				
				}
			});
		}
		else {
			$("#check2").html("아이디/이메일을 입력하세요");
			
			if($("#id2").val() == "") {
				$("#id2").focus();
			}
			else {
				$("#email2").focus();
			}
		}
		
	});
	
	$("#button3").on('click',function(){
		
		if($("#key2").val() != "") {
			if($("#key1").val() == $("#key2").val()) {
				
				$.ajax({
					url : 'getMyPW2',
					data : {'user_id':$("#id2").val()},
					type : 'post',
					dataType : 'text',
					success : function(s) {
						
						$("#result").append("회원님의 비밀번호 <h1>"+s+"</h1>")
						
					}
				});	
			}
			else {
				$("#check2").html("인증번호가 일치하지 않습니다");
				$("#key2").focus();
			}
		}
		else {
			$("#result").html("인증번호를 먼저 발급 받아야 합니다");
		}
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
		<li><a href="#ID-modal" rel="modal:open">아이디 찾기</a></li>
		<li><a href="#PW-modal" rel="modal:open">비밀번호 찾기</a></li>
		<li><a href="memberjoin">회원가입</a></li>
		</ul>
		</div>
	</div>
	
	
	<div id="ID-modal" class="modal">
		<h1 class="title">이메일로 아이디 찾기</h1><hr>
		<table class="table">
		<tr><td><input type="email" name="email" id="email1" class="input" placeholder="이메일을 입력하세요" onfocus="this.placeholder=''" onblur="this.placeholder='이메일을 입력하세요'" name="search"></td>
		<td><input type=button value="전 송" id="button1" class="button"></td></tr>
		</table>
		
		<div id="check1" class="check"></div>
	</div>
	
	
	<div id="PW-modal" class="modal">
		<h1 class="title">이메일로 비밀번호 찾기</h1><hr>
		<table class="table">
		<tr><td><input type="text" name="id" id="id2" class="input" placeholder="아이디를 입력하세요" onfocus="this.placeholder=''" onblur="this.placeholder='아이디를 입력하세요'"></td>
		<td rowspan="3"><input type=button value="전 송" id="button2" class="button"></td></tr>
		<tr><td><input type="email" name="email" id="email2" class="input" placeholder="이메일을 입력하세요" onfocus="this.placeholder=''" onblur="this.placeholder='이메일을 입력하세요'"></td></tr>
		</table>
		<div id="check2" class="check"></div>

		<table class="table">
		<tr><td><input type=hidden id="key1"><input type=text id="key2" class="input" placeholder="인증번호를 입력하세요" onfocus="this.placeholder=''" onblur="this.placeholder='인증번호를 입력하세요'"><br></td>
		<td><input type=button id="button3" class="button" value="인 증"></td></tr>
		</table>
		<div id="result" class="check"></div>
	</div>
</body>
</html>