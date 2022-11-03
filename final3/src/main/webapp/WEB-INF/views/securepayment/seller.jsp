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
$(document).ready(function(){
	//운송장 번호 등록 - ajax 
	$("#registerbtn").on("click",function(){
		$.ajax({
			url: "registerbillingnumber",
			type:	"post",
			data: {'billing_number' : $("#inputbillingnumber").val(), 'product_num' : $("#hiddenproductnum").val()},
			dataType: "json", //결과 타입
			success: function(server){
				if(server.result == 'success'){
					alert('성공적으로 운송장 번호를 등록하였습니다.');
				}else{
					alert('운송장 번호 등록에 실패하였습니다. 다시 시도해주십시오.');
				}
			}//success end
		});//ajax end
	}); //click end 
	
	//입금받기(구매자 7일동안 구매확정 안함)  - ajax 
	$("#depositbtn").on("click",function(){
		alert($('#hidden_pay_price').val());
		$.ajax({
			url: "depositseller",
			type:	"post",
			data: {'pay_price' : $("#hidden_pay_price").val()},
			dataType: "json", //결과 타입
			success: function(server){
				if(server.result == 'success'){
					alert('성공적으로 운송장 번호를 등록하였습니다.');
				}else{
					alert('운송장 번호 등록에 실패하였습니다. 다시 시도해주십시오.');
				}
			}//success end
		});//ajax end
	}); //click end 
});//ready end
</script>
</head>
<body>
판매자 운송장번호 등록
<form action="registerbillingnumber" method="post">
	<input type="text" id="inputbillingnumber" name="billing_number">
	<input type="hidden" id="hiddenproductnum" name="product_num" value="1">
	<button id="registerbtn">운송장 번호 등록</button>
</form>
판물건 모아보기 
<c:forEach items="${sellinglist }" var="s">
<c:if test="${not empty s.buyer_check && s.elapsed_date>7 }"><button id="depositbtn">입금받기</button></c:if>
${s } <br>
${s.pay_price }
<input type="hidden" value="${s.pay_price }" name="pay_price" id="hidden_pay_price">
<input type="hidden" value="${s.product_num}" name="product_num" id="hiddenproduct_num">
</c:forEach>
</body>
</html>