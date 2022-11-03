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
					$(".tagbtn").css("background-color","#ed6f69");
				}); //#tagbtn end
			}
		});//ajax end
	}); //#tag end
	
	$('#salesform').on('submit',function(e){ //태그 (detail_num)등록되지 않은 경우 submit 막기
		if($('#detail_num').val()==''){
			e.preventDefault();
			alert('상품명 태그를 선택하여주십시오.');
		}
	});
	$('#tagbtn').on('click',function(e){
		e.preventDefault();
	})
	
});//ready end
</script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@800&display=swap');
button, input[type=submit]{
	outline: 0;
	border:none;
	transition: all 0.2s ;
	border-radius: 8px;
}
#contents{
	position:relative;
	display: flex;
	flex-flow:column;
	align-items: center;
	justify-content: center;
	/* border : 1px solid red; */
	padding-top: 20px;
	min-width:800px;
	padding-bottom: 20px;
}
#contents #form_name{
	font-size: 24px;
	font-weight: 700;
	color :  rgb(67, 91, 124,0.7);
	margin-bottom: 20px;
}
#contents #contents_box{
	background-color:rgb(208, 217, 232,0.2);
	border:2px solid rgb(92, 117, 230,0.1);
	border-radius: 8px;
	padding:10px;
	min-height:300px;
}
#sales_table{
	padding : 20px;
	background-color: :red;
	border-collapse: collapse;
	border-radius: 8px;
}
#sales_table th{
	width: 50px;
	height: 50px;
}
#sales_table td{
	width: 110px;
	height: 50px;
}
#sales_table input[type=text], input[type=number], textarea{
	width:95%;
	height: 30px;
	border: none;
	border-radius: 8px;
	padding: 3px 5px 3px 5px;
}
#sales_table input[type=number]{
	width:75%;
	height: 30px;
	border: none;
	border-radius: 8px;
	padding: 3px 5px 3px 5px;
}
#sales_table textarea{
	height: 200px;
	width: 600px;
	padding: 15px;
}
/* button, input[type=submit]{
	border-radius: 8px;
	margin-left: 5px;
	margin-bottom: 5px;
	
} */

#sales_table .header{
	width: 100px;
	text-align: center;
	border : 2px solid rgb(92, 117, 230,0.3);
}
#sales_table .option{
	background-color: orange;
	width: 100px;
}
#submitbtn{
	width: 100px;
	height: 35px;
	background-color: #5C75E6;
	color: white;
	font-size: 17px;
}
#submitbtn:hover{
	
  	background-color:#6682FF;
  	box-shadow: 0px 0px 0px 5px rgba(192, 194, 250,0.7);
}
#sales_table select{
	height: 25px;
	border : 2px solid rgb(92, 117, 230,0.3);
	border-radius: 8px;
}
#sales_table input[type=checkbox]{
	/* 체크박스 기본값 없애기 */	
	 -webkit-appearance: none;
     -moz-appearance: none;
     appearance: none;
    width:15px;
    height:15px;
    border-radius:3px;
    outline: 0;
	border : 2px solid rgb(92, 117, 230,0.3);
	background-color:  #fff;
}

#sales_table input[type="checkbox"]:checked {
  background-color:  rgb(92, 117, 230,0.3);
  background-image:url("/serverimg/checkicon.png");
  background-size: contain;
  background-repeat: no-repeat;
}
.data{
	border : 2px solid rgb(92, 117, 230,0.3);
	padding-left: 10px;
}
.tagbtn{
	height: 20px;
	outline: 0;
	border:none;
	margin-left: 5px;
	margin-bottom: 5px;
	background-color:#ffbda7;
	color: #fff;
	cursor: pointer;
}
.tagbtn:hover{
background-color:#ed6f69;
}
</style>
</head>
<body>
<jsp:include page="../template/header.jsp" flush="true"/>
<div id="contents">
<div id="form_name">판매할 상품을 등록하세요!</div>
<form action="insertsales" enctype="multipart/form-data" method="post" id="salesform">
<div id="contents_box">
<table  id="sales_table">
	<tr><td class="header">제목</td><td colspan="3" class="data"><input type="text" placeholder="제목을 입력하여주세요.(제품명 포함)" size="50" name="product_title" required="required"></td></tr>
	<tr>
		<td class="header">거래</td>
		<td class="data">
			<input type="checkbox" name="safe_trade" value="1"> 안전거래
			<input type="checkbox" name="auction_check" value="1"> 경매전환
		</td>
		<td class="header data">카테고리</td>
		<td class="data"> <select name="category_num" id="category_num">
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
	</tr>
	<tr><td class="header">상품 상태</td>
		<td colspan="3" class="data">
		<select name="product_status4">
				<option value="나쁨">나쁨</option>
				<option value="보통">보통</option>
				<option value="좋음">좋음</option>
			</select>
		<input type="checkbox" name="product_status1" value="1"> 개봉
		<input type="checkbox" name="product_status2" value="1">공식
		<input type="checkbox" name="product_status3" value="1">단종
		<input type="checkbox" name="product_status5" value="1"> 구성품 전부 포함</td>
	</tr>
	<tr><td class="header">가격</td><td class="data" style="width: 220px;"><input type="number" name="product_price" value="" required="required"> 원</td>
		<td colspan="2" class="data"><input type="file" name="images" multiple="multiple"> </td>
	</tr>
	<tr><td class="header">상품 설명</td><td colspan="3" class="data"><textarea rows="8" cols="100" placeholder="판매할 제품의 설명을 입력하여주세요. 상세할수록 좋습니다!" name="product_contents" required="required"></textarea> </td></tr>
	<tr><td class="header">상품명 태그</td><td colspan="1" class="data"><input type="text" id="tag" placeholder="판매할 물건명의 태그를 달아주세요." size="30"> </td><td  class="data" colspan="3" id="tag_result"></td></tr>
	<tr><td colspan="4" style="text-align: center;" ><div style="height: 40px; margin-top:20px;"><input type="submit" value="등록" id="submitbtn"></div> </td></tr>
	
</table>
	<input type="hidden" id="detail_num" name="detail_num" value="">
</div>
</form>
</div>
</body>
</html>