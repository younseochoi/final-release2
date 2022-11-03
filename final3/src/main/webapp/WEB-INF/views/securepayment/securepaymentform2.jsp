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
	
});//ready end
</script>
<!-- 다음주소 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- <script>
/* 다음 주소 연동 */
function execution_daum_address(){
 		console.log("동작");
	   new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            
	        	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
 
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
 
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                 	// 추가해야할 코드
                    // 주소변수 문자열과 참고항목 문자열 합치기
                      addr += extraAddr;
                
                } else {
                	addr += ' ';
                }
 
             	// 제거해야할 코드
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $(".address1_input").val(data.zonecode);
                $(".address2_input").val(addr);				
                // 커서를 상세주소 필드로 이동한다.
                $(".address3_input").attr("readonly", false);
                $(".address3_input").focus();	 
	            
	            
	        }
	    }).open();  	
	
}
</script> -->
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
.address_search_btn{
    vertical-align: middle;
    display: inline-block;
    border: 1px solid #aaa;
    width: 90px;
    text-align: center;
    height: 30px;
    line-height: 30px;
    color: #555;
    cursor: pointer;
    border-radius: 8px;
}
#formitem_table{
	width: 100%;
	border-collapse: collapse;
}
</style>
</head>
<body>
<form action="securepaymentprocess" method="post">
<div id="securepaymentform">
	<%-- <div class="formitem">
		<table border="1" id="formitem_table">
			<colgroup>
				<col width="25%">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th>배송지</th>
					<td>
						<input class="address1_input" readonly="readonly"> <a class="address_search_btn" onclick="execution_daum_address()">주소 찾기</a><br>
						<input class="address2_input" readonly="readonly"><br>
						<input class="address3_input" readonly="readonly">
					</td>
				</tr>
			</tbody>
		</table>
	</div> --%>
	<div class="formitem">
		결제가능할시만 결제 금액 상품금액, 배송비 별도, 총 결제 금액 
		현재 보유머니 (결제 금액보다 보유머니 클때만 결제가능) 이거 확인하는 모듈만들어야함.
		보유머니가 더 작다면 충전하로 가기 링크 달아주기 
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
					<td>10000원</td>
				</tr>
				<tr>
					<th></th>
					<td>현재 보유 머니</td>
					<td>90000원</td>
				</tr>
				<tr>
					<th></th>
					<td>배송비</td>
					<td>배송비별도</td>
				</tr>
				<tr>
					<th></th>
					<td>총 결제 금액</td>
					<td>10000원</td>
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
					<th><input type="checkbox" name=""> </th>
					<td>
						개인정보 제 3자 제공동의와 결제 대행 서비스 이용약관에 동의합니다.<br>
						<a href="">자세히보기</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="formitem">
		<input type="submit" value="결제하기"> 
	</div>
</div>
</form>
</body>
</html>