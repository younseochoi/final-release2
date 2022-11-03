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
	
	$("#title").keydown(function(){
		
		
		if($("#title").val() == "아이폰") {
			
			$.ajax({
				url : '',
				data : {'title':$("#title").val()},
				type : 'get',
				dataType : 'json',
				success : function(e) {
					$("#detail").html("<option>"+e.index[]+"</option>");
				}
			});
		}
	}
});
</script>
</head>
<body>
<h1>main 페이지</h1>
<p>권도연 추가</p>
<p>정찬식 추가</p>
<p>김미애 추가</p>
<p>최윤서 추가</p>
zz
<form>
		상품제목<input type=text id="title">
		상품이름
		<select id="detail">
			<option></option>
		</select>
</form>
</body>
</html>