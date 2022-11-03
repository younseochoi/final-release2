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

	
	var pay_price_str = ${user_money-productdto.product_price};
	//var pay_price_str =-10;
	if(pay_price_str<0){
		$('#paysubmitbtn').attr('disabled',true);
		$('#hiddenitem').css('display','block');
		
	}
	
	$('#securepaymentform').submit(function(e) {
		if($('#termscheck').is(':checked')==false){
			alert("서비스 이용약관에 동의해주세요.");
			e.preventDefault();
		}
    }); // end submit()
    
	 $("#openPop").click(function(e) {
	        $("#banner_online").show();
	    });

	    $("#openModalPop").click(function(e) {
	    	
	        $("#banner_online").fadeIn();
	        $("#modal").fadeIn();
	    });

	    $("#close_button").click(function(){
	        $("#banner_online").fadeOut();
	        $("#modal").fadeOut();
	    });
});//ready end


</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@800&display=swap');
#securepaymentform{
	position:relative;
	display:flex;
	flex-flow:column;
	align-items:center;
	justify-content:center;
	border: 1px solid black;
}
.formitem{
	border: 1px solid black;
	width: 650px;
}
#formitem_table{
	width: 100%;
	border-collapse: collapse;
}
#banner_online {
    height: 270px;
    width: 350px;
    border: 1px solid black;
    box-shadow: 3px 3px 7px 1px grey;
    background-color: white;
    z-index: 9999;
    margin-left: 36%;
    margin-top: 6%;
    display: none;
    position: fixed;
}
#banner_online h2 {
    text-align: center;
    font-size: 17px;
    margin-bottom: 10px;
}

#banner_online p .second {
    margin-left: 6px;
}

.pop_content {
    font-size: 13px;
    margin-left: 20px;
}

#banner_online_how {
    height: 78px;
    width: 444px;
    margin-left: 28px;
    border: 1px solid #82bf77;
    margin-top: 22px;
}

#banner_online_how h3 {
    font-size: 12px;
    margin-left: 6px;
    margin-top: 16px;
}

#close_button {
    float: right;
    margin-top: -3px;
}

.p_bottom {
    margin-left: 30px;
}

#modal {
  position:fixed;
  width:100%;
  height:100%;
  background:rgba(0, 0, 0, 0.5);
  top: 0;
  left: 0;
  z-index: 99;
  display: none;
}
</style>
</head>
<body>
<div id="securepaymentform">
<div class="formitem">
<table border="1" id="formitem_table">
			<colgroup>
				<col width="15%">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<td colspan="3">택배거래, 안전결제로 구매합니다.</td>
				</tr>
				<tr>
					<th rowspan="2"><img src="${image_path}" width="50px" height="50px"> </th>
					<td id="pay_price">${productdto.product_price }원</td>
				</tr>
				<tr>
					<td>${productdto.product_title }</td>
				</tr>
			</tbody>
		</table>
</div>
<form action="securepaymentprocess" method="post" id="securepaymentform">
	<div class="formitem">
		<table border="1" id="formitem_table">
			<colgroup>
				<col width="25%">
				<col width="25%">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th>결제금액</th>
					<td>상품 금액</td>
					<td>${productdto.product_price }원</td>
				</tr>
				<tr>
					<th></th>
					<td>현재 보유 머니</td>
					<td>${user_money}원</td>
				</tr>
				<tr>
					<th></th>
					<td>결제 후 잔액</td>
					<%-- <td><span id="pay_price">${productdto.product_price-user_money}</span>원</td> --%>
					<td id="pay_price">${user_money-productdto.product_price}원</td>
					<td id="hiddenitem" style="display: none;"><a href="">잔액충전하러가기</a></td>
				</tr>
				<tr>
					<th></th>
					<td>배송비</td>
					<td>배송비별도</td>
				</tr>
				<tr>
					<th></th>
					<td>총 결제 금액</td>
					<td>${productdto.product_price }원</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="formitem"> 
		<table border="1" id="formitem_table">
			<colgroup>
				<col width="25%">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th><input type="checkbox" name="" id="termscheck"> </th>
					<td>
						개인정보 제 3자 제공동의와 결제 대행 서비스 이용약관에 동의합니다.<br>
						<a href="" id="openPop">자세히보기</a>
						<button id="openPop">자세히보기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="formitem">
		<input type="hidden" value="${productdto.product_price}" name="pay_price">
		<input type="hidden" value="1" name="product_num">
		<input type="submit" id="paysubmitbtn" value="결제하기"> 
	</div>
</form>
<div id= "modal"> 
모다아알
</div>
    <div id = "banner_online">
        <div id="close_button" style ="cursor: pointer;"> 
        </div>
        <h2>CATEGORIES</h2>
        <div class="pop_content">
            <p>1) Algorithm</p>
            <p>2) 영어공부</P>
            <p>3) Deep Learning</p>
            <p>4) Web</p>
            <p class="p_bottom">- spring</p>
            <p class="p_bottom">- javaScript</p>
            <a style= "float: right; margin-right: 13px;" href="https://bbo-blog.tistory.com/" target="_blank" >뽀블로그 클릭</a>
        </div>
    </div>


</div>

</body>
</html>