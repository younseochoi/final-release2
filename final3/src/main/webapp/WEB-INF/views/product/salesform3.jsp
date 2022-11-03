<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>물건 판매 등록</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){

	
	//태그 자동 추천 함수
	$("#tag").on("keydown",function(){
		$("#tag_result").html("");
		$.ajax({
			url: "getpdtdetailtags",
			type:	"get",
			data: {'keyword' : $("#tag").val()},
			dataType: "json", //결과 타입
			success: function(server){
				/* alert(server); */
				for(var i=0;i<server.length;i++){
					$("#tag_result").append('<button class="tagbtn" id="'+server[i].detail_name+'" value="'+server[i].detail_num+'">'+server[i].detail_name+'</button>');
				}//for end
				
				$(".tagbtn").click(function(e){
					$("#tag_result").html('<button class="tagbtn">'+$(this).attr('id')+'</button>');
					$("#detail_num").attr("value",$(this).attr('value'));
				}); //#tagbtn end
			}
		});//ajax end
	}); //#tag end
	
	
});//ready end
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
	padding-bottom: 20px;
}
#contents #form_name{
	font-size: 24px;
	font-weight: 700;
}
#sales_table{
	position:relative;
	display: flex;
	min-height:300px;
	width:100%;
	padding : 10px;
	border-collapse: collapse;
}
#sales_table th{
	width: 50px;
	height: 50px;
}
#sales_table td{
	width: 110px;
	height: 50px;
}
.tagbtn{
	border-radius: 8px;
	margin-left: 5px;
	margin-bottom: 5px;
}
#sales_table input[type=checkbox]{
}
#sales_table .header{
	width: 60px;
	text-align: center;
}
#sales_table .option{
	background-color: orange;
	width: 100px;
}
</style>
</head>
<body>
<div id="contents">
<div id="form_name">판매폼</div>
<form action="insertsales" enctype="multipart/form-data" method="post">
<table border=1 id="sales_table">
	<tr><td class="header">제목</td><td><input type="text" placeholder="제목을 입력하여주세요.(제품명 포함)" size="50" name="product_title" required="required"></td></tr>
	<tr>
		<td class="header">거래</td>
		 <td class="option"><input type="checkbox" name="safe_trade" value="1"> 안전거래
		<input type="checkbox" name="auction_check" value="1"> 경매전환
		</td>
		<td class="header" style= "width: 60px;">카테고리
			<select name="category_num" id="category_num" required="required">
				<option value="1">DVD</option>
				<option value="2">콘서트굿즈</option>
				<option value="3">앨범</option>
				<option value="4">포스터</option>
				<option value="5">포토북</option>
				<option value="6">포토카드</option>
				<option value="7">패션</option>
				<option value="8">문구류</option>
				<option value="9">기타</option>
			</select>
			<select name="idol_num">
				<option value="1">bts</option>
				<option value="2">nct</option>
			</select>
		</td>
			
			<!-- <td>
			<select name="category_num" id="category_num" required="required">
				<option value="1">DVD</option>
				<option value="2">콘서트굿즈</option>
				<option value="3">앨범</option>
				<option value="4">포스터</option>
				<option value="5">포토북</option>
				<option value="6">포토카드</option>
				<option value="7">패션</option>
				<option value="8">문구류</option>
				<option value="9">기타</option>
			</select>
			</td>
			<td>
			<select name="idol_num">
				<option value="1">bts</option>
				<option value="2">nct</option>
			</select>
			</td> -->
		<!-- <td class="option"><input type="checkbox" name="safe_trade" value="1"> 안전거래</td>
		<td class="option"><input type="checkbox" name="auction_check" value="1"> 경매전환</td>
		<td class="option">
			<select name="category_num" id="category_num" required="required">
				<option value="1">DVD</option>
				<option value="2">콘서트굿즈</option>
				<option value="3">앨범</option>
				<option value="4">포스터</option>
				<option value="5">포토북</option>
				<option value="6">포토카드</option>
				<option value="7">패션</option>
				<option value="8">문구류</option>
				<option value="9">기타</option>
			</select>
		</td>
		<td class="option">
			<select name="idol_num">
				<option value="1">bts</option>
				<option value="2">nct</option>
			</select>
		</td> -->
		
	</tr>
	<tr>
	<td class="header">상품 상태</td>
	<td class="option"> 
	<select name="product_status4">
			<option value="나쁨">나쁨</option>
			<option value="보통">보통</option>
			<option value="좋음">좋음</option>
		</select>
	<input type="checkbox" name="product_status1" value="1"> 개봉
	<input type="checkbox" name="product_status2" value="1">공식
	<input type="checkbox" name="product_status3" value="1">단종
	<input type="checkbox" name="product_status5" value="1"> 구성품 전부 포함</td>
	<!-- <td class="header">품질</td> -->
	<!-- <td class="option"> <input type="checkbox" name="product_status1" value="1"> 개봉</td>
	<td class="option"> <input type="checkbox" name="product_status2" value="1">공식</td>
	<td class="option"><input type="checkbox" name="product_status3" value="1">단종</td>
	<td class="option">
		<select name="product_status4">
			<option value="나쁨">나쁨</option>
			<option value="보통">보통</option>
			<option value="좋음">좋음</option>
		</select>
	</td>
	<td class="option"><input type="checkbox" name="product_status5" value="1"> 구성품 전부 포함</td> -->
	</tr>
	<tr><td class="header">가격</td><td><input type="number" name="product_price" value="" required="required"> 원</td>
		<td class="header"><input type="file" name="images" multiple="multiple"> </td>
	</tr>	
	<tr><td style="text-align: center;"><textarea rows="8" cols="120" placeholder="판매할 제품의 설명을 입력하여주세요." name="product_contents" required="required"></textarea> </td></tr>
	<tr><td class="header">상품명 태그</td><td colspan="1"><input type="text" id="tag" placeholder="판매할 물건명의 태그를 달아주세요." size="30"> </td><td colspan="3" id="tag_result">태그 나올 공간</td></tr>
	<tr><td  style="text-align: center;"><input type="submit" value="등록" id="submitbtn"> </td></tr>

</table>
	<input type="hidden" id="detail_num" name="detail_num" value="">
</form>
</div>
</body>
</html>