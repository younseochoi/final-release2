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
		$('#hiddenitem').css('display','');
		$('#payprice').css('color','red');
	}
	
	$('#securepaymentform').submit(function(e) {
		if($('#termscheck').is(':checked')==false){
			alert("서비스 이용약관에 동의해주세요.");
			e.preventDefault();
		}
    }); // end submit()
    
	$('.price').each(function(){ // 가격 표시 , 세자리마다 콤마 찍기
		  var price = $(this).text();
		  price = price.slice(0,-1); //맨 마지막 글자 짜르기 (원)
		  let result = price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		  result+='원';
		  $(this).html(result);
	});
    
	const popup = $('#popup_t');
    $('#openpop_t').on('click',function(e){
    	e.preventDefault();
    	
    		$('#popup_t').css('display','');
    		//$(this).val('true');
    		popup.classList.remove('hide');
    		popup.removeClass('hide');
    		popup.addClass('has-filter');
    		if (popup.hasClass('has-filter')) {
    		  	popup.removeClass('has-filter');
    		  } else {
    		  	popup.removeClass('has-filter');
    		  }
    		
    	
    });
    $('#closepopupbtn_t').on('click',function(e){
    	e.preventDefault();
    	popup.removeClass('has-filter');
		popup.addClass('hide');
    });
    
 

	
});//ready end


</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@800&display=swap');
button, input[type=submit]{
	outline: 0;
	border:none;
	transition: all 0.2s ;
}

#securepaymentform{
	position:relative;
	display:flex;
	flex-flow:column;
	align-items:center;
	/* justify-content:center; */
	/* border: 1px solid black; */
	min-height:300px;
}
#securepaymentinnerform{
/* 	border: 1px solid black; */
	width: 650px;
	border-radius: 8px;
	padding:15px;
	background-color: #f5f5f5;
}
.formitem{
	width: 100% ;
	margin-bottom:15px;
}
.formitem_table{
	width: 100%;
	height:180px;
	border-collapse: collapse;
	border-bottom: 2px solid #c6d1e3;;
}
#formtitle{
	height: 30px;
	border-bottom: 2px solid #c6d1e3;
}
#formtitletext{
	font-size: 22px;
	font-weight: 600;
	padding :3px;
	margin-bottom: 8px;
}
#formitem_table1{
	height:110px;
	border-bottom: 2px solid #c6d1e3;
}
#formitem_table2{
	height:200px;
	border: 2px solid #c6d1e3;
}
.tablecol2{
	border-left:2px solid #c6d1e3;
	border-bottom: 2px solid #c6d1e3;;
	padding-left: 15px;
}
#formitem_table3{
	height:100px;
	border: 2px solid #c6d1e3;
}
#paysubmitbtn{
	width: 100px;
	height: 30px;
	border-radius: 8px;
	background-color: #5C75E6;
	color: white;
}
#paysubmitbtn:hover, #closepopupbtn:hover{
	cursor:pointer;
	background-color:  #68abfe;
}	
#paysubmitbtn:disabled{
	background-color: gray;
	opacity : 0.6;
	cursor: no-drop;
}
input[type=checkbox]{
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

input[type="checkbox"]:checked {
  background-color:  rgb(92, 117, 230,0.3);
  background-image:url("/serverimg/checkicon.png");
  background-size: contain;
  background-repeat: no-repeat;
}
/* 팝업창  */
#popup_t {
  display: flex;
  justify-content: center;
  align-items: center;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, .7);
  z-index: 1;
}

#popup_t.hide {
  display: none;
}

#popup_t.has-filter {
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
}

#popup_t .content {
	width:450px;
 	 padding: 20px;
 	 background: #fff;
 	 border-radius: 5px;
 	 box-shadow: 1px 1px 3px rgba(0, 0, 0, .3);
}
#popup_t .termstitle{
	font-weight: 700;
	font-size: 18px;
	margin-bottom: 15px;
	
}
#popup_t .termscontent{
	margin-bottom: 45px;
	color: #6f7792;
}
.terms_highligt{
	color : black;
	font-weight: 700;
	margin-bottom: 10px;
}
#popupbtnarea{
	height: 50px;
}
#closepopupbtn_t{
 	width: 120px;
 	height: 35px;
 	border-radius: 8px;
	background-color: #5C75E6;
	color: white;
}
#openpop_t{
	border: none;
	text-decoration-line: underline;
	cursor :pointer;
	outline: none;
	background-color: #f5f5f5;
}
#openpop_t:hover{
	color: #5C75E6;
}
</style>
</head>
<body>
<jsp:include page="../template/header.jsp" flush="true"/>
<div id="securepaymentform">
<div id="securepaymentinnerform">
<div class="formitem">
<table class="formitem_table" id="formitem_table1">
			<colgroup>
				<col width="15%">
				<col width="*">
			</colgroup>
			<tbody>
				<tr id="formtitle"> 
					<td colspan="3" id="formtitletext">택배거래, 안전결제로 구매합니다.</td>
				</tr>
				<tr>
					<th rowspan="2"><img src="${image_path}" width="50px" height="50px"> </th>
					<td id="pay_price" class="price">${productdto.product_price }원</td>
				</tr>
				<tr>
					<td>${productdto.product_title }</td>
				</tr>
			</tbody>
		</table>
</div>
<form action="securepaymentprocess" method="post" id="securepaymentform">
	<div class="formitem">
		<table  class="formitem_table" id="formitem_table2">
			<colgroup>
				<col width="25%">
				<col width="25%">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th style="text-align: center;">결제금액</th>
					<td class="tablecol2">상품 금액</td>
					<td class="tablecol2 price">${productdto.product_price }원</td>
				</tr>
				<tr>
					<th></th>
					<td class="tablecol2">현재 보유 머니</td>
					<td class="tablecol2 price">${user_money}원</td>
				</tr>
				<tr>
					<th></th>
					<td class="tablecol2">결제 후 잔액</td>
					<%-- <td><span id="pay_price">${productdto.product_price-user_money}</span>원</td> --%>
					<td id="payprice" class="tablecol2 price">${user_money-productdto.product_price}원</td>
				</tr>
				<tr id="hiddenitem" style="display:none;">
					<th></th>
					<td class="tablecol2"></td>
					<td class="tablecol2" ><a href="">잔액충전하러가기</a></td>
				</tr>
				<tr>
					<th></th>
					<td class="tablecol2">배송비</td>
					<td class="tablecol2">배송비별도</td>
				</tr>
				<tr>
					<th></th>
					<td class="tablecol2">총 결제 금액</td>
					<td class="tablecol2 price">${productdto.product_price }원</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="formitem"> 
		<table border="1" class="formitem_table" id="formitem_table3">
			<colgroup>
				<col width="25%">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th style="text-align: center;"><input type="checkbox" name="" id="termscheck"> </th>
					<td class="tablecol2" style="padding-top: 10px;">
						<span style="font-weight: 700;">개인정보 제 3자 제공동의와 결제 대행 서비스 이용약관에 동의합니다.</span><br>
						<button id="openpop_t" value="false">자세히보기</button>
						<div style="width: 400px; margin: 10px 0 10px 0;">
						<span style="color: #7f869d; font-size: 14px;">
							모든 상품들에 대하여, ㅇㅇ마켓은 통신판매중개자로서 중고거래마켓의 거래 당사자가 아니며,
							입점판매자가 등록한 상품정보 및 거래에 대해 책임을 지지 않습니다. 
						</span>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="formitem" style="text-align: center;">
		<input type="hidden" value="${productdto.product_price}" name="pay_price">
		<input type="hidden" value="${param.product_num }" name="product_num">
		<input type="submit" id="paysubmitbtn" value="결제하기"> 
	</div>
	<div id="popup_t" style="display: none;" >
		<div class="content" style="overflow-y: scroll; height:550px;">
	    	<p style="font-size: 16px; font-weight: 700;"> 안전페이 이용약관</p>
	    	<div>
		    	 <div class="termstitle">제 1조(목적)</div>
		    	 <div class="termscontent">
		    	이 약관은 ㅇㅇ 주식회사(이하 '회사'라 함)이 제공하는 
		    	안전페이 서비스(전자지급결제대행서비스 및 결제대금예치서비스)의 이용에 관한 제반사항과   
		    	기타 필요한 사항을 구체적으로 규정함을 목적으로 합니다.
		    	</div>
		    	
		    	<div class="termstitle">제 2조(용어의 정의)</div>
		    	  <div class="termscontent">
		    	이 약관에서 정하는 용어의 정의는 다음과 같습니다.
		    	<br>	    	  <br>
		    	1. '안전페이 서비스'(이하 '서비스'라 함)는 회원 상호간의 거래의 안전을 위하여 회사가 물품대금의 입출금을 중개할 목적으로 마련한 절차를 말합니다.<br>
		    	2. '회원'은 이 약관을 승인하고 회사와 서비스이용계약을 체결한 자를 말합니다. <br>
		    	3. '판매자'는 물품을 판매할 의사로 해당 물품을 회사가 제공한 양식에 맞춰 등록한 회원을 말합니다.<br>
		    	4. '구매자'는 물품을 구매할 의사로 해당 물품의 금액을 회사에 지불해 물품을 구매하는 회원입니다.<br>
		    	5.. 안전거래 또는 매매보호서비스 또는 에스크로: 회사가 운영하는 인터넷 사이트에서 회원 상호간의 거래의 안전을 위하여 회사가 물품대금의 
		    	입출금을 중개할 목적으로 마련한 절차를 말합니다. 위 항목에서 정의되지 않은 약관상의 용어의 의미는 일반적인 관행에 의합니다.
		    	</div>
		    	
		    	<div class="termstitle">제 3조(약관의 명시, 효력 및 변경)</div>
		    	  <div class="termscontent">
		    	1. 회사는 이용자가 서비스를 이용하기 전에 이 약관을 게시하고 회원이 약관의 중요한 내용울 확인할 수 있도록합니다.<br>
		    	2. 회사는 필요에 의해 본 약관을 변경할 수 있으며 변경사유가 발생할 경우, 변경된 내용을 공지한 후 회원으로부터 이의제기가 없는 1주일
		    	이 경과되면 자동으로 변경된 약관이 적용됩니다.  <br>
		    	3. 이 약관은 서비스를 통하여 공지함으로써 효력이 발생합니다.<br>
		    	</div>
		    	
		    	<div class="termstitle">제 4조(관련법령과의 관계)</div>
		    	  <div class="termscontent">
		    	1. 이 약관에서 정하지 않은 사항은 전기통신사업법, 전자문서 및 전자거래 기본법, 정보통신망 이용촉진 및 정보보호등에 관한 법률,
		    	전자상거거래 등에서 소비자보호등에서의 소비자보호에 관한 법률 등 관련법령의 규정과 일반적인 상관 례에 의합니다.<br>
		    	2. 회원은 회사가 제공하는 서비스를 이용함에 있어서 전자상거래 등에서의 소비자보호에 관한 법률 
		    	(예시:공급서, 표시광고, 반품, 배송 등 통신판매에 관한 규정), 전자상거래 등에서의 소비자보호에 관한 법률 (예시:소비자보호에 관한 규정), 소비자기본법(예시:사업자의 의무에 관한 규정), 
		    	정보통신망 이용촉진 및 정보보호등에 관한 법률 (예시:개인정보보호에 관한 규정) 등 관련법령을 준수하여야 하며, 이 약관의 규정을 들어 관련법령 위반에 대한 면책을 주장할 수 없습니다.<br>
		    	</div>
		    	
		    	<div class="termstitle">제 5조(이용계약의 성립)</div>
		    	  <div class="termscontent">
		    	  1. 이용 신청시 "번개페이 이용약관에 동의"를 선택하면 이 약관에 동의하는 것으로 간주됩니다.
		    	</div>
		    	
		    	<div class="termstitle">제 6조(개인정보의 보호 및 사용)</div>
		    	  <div class="termscontent">
		    		1. 사용회사는 개인정보를 중요하게 생각하고 관리하고 있습니다. 회사의 개인정보보호에 대해서는 개인정보처리방침을 통해 확인하실 수 있습니다.<br>
					2. 회사가 제5조에 따라 요구하는 회원의 개인정보는 본 이용계약의 이행과 본 이용계약상의 서비스제공을 위한 목적으로 이용합니다.<br>
					3. 회원이 회사 및 회사와 제휴한 서비스들을 편리하게 이용할 수 있도록 하기 위해 회원 정보는 회사와 제휴한 업체에 제공될 수 있습니다.<br>
					(단, 회사는 회원 정보 제공 이전에 제휴 업체, 제공 목적, 제공할 회원 정보의 내용 등을 사전에 공지하고 회원의 동의를 얻어야 합니다.)<br>
					4. 회원은 회원정보 수정을 통해 언제든지 개인 정보에 대한 열람 및 수정을 할 수 있습니다.<br>
					5. 회원이 이용신청서에 회원정보를 기재하고, 회사에 본 약관에 따라 이용신청을 하는 것은 회사가 본 약관에 따라 이용신청서에 기재된 회원정보를 수집, 이용 및 제공하는 것에 동의하는 것으로 간주됩니다.<br>
		    	</div>
		    	<div class="termstitle">제 7조(면책조항)</div>
		    	  <div class="termscontent">
		    		1. 회사가 회원들에게 제공하는 서비스는 온라인 거래장소를 제공하고 기타 부가정보를 제공함에 그치는 것이므로 
		    		서비스를 통하여 이루어지는 회원 상호간의 거래와 관련된 거래이행, 물품배송, 청약철회 또는 반품, 
		    		물품하자로 인한 분쟁해결 등 필요한 사후처리는 거래당사자인 회원들이 직접 수행하여야 합니다.
		    		 회사는 이에 대하여 관여하지 않으며 어떠한 책임도 부담하지 않습니다.<br>
					2. 회사는 천재지변 또는 이에 준하는 불가항력, 정보통신설비의 보수점검, 
					교체 또는 고장, 통신의 두절 등으로 인하여 일시적 또는 종국적으로 서비스를 제공할 수 없는 경우,
					 서비스 제공에 관한 책임이 면제됩니다. 이 경우 회사는 회사가 제공하는 인터넷사이트 화면에 게시하거나 기타의 방법으로 회원들에게 통지합니다.<br>
					3. 회사는 인터넷 이용자 또는 회원의 귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 않습니다.<br>
					4. 회사는 서비스를 통하여 거래되는 물품의 하자, 물품등록정보의 오류, 미비 등으로 인하여 회원이 입는 손해에 대해서는 책임(제조물책임 포함)을 지지 않습니다.<br>
					5. 회사는 회원이 다른 회원이 게재한 정보, 자료, 사실의 정확성 등을 신뢰함으로써 입은 손해에 대하여 책임을 지지 않습니다.<br>
		    	</div>
		    	<div class="termstitle">제 8조(서비스 이용자의 의무)</div>
		    	  <div class="termscontent">
		    	  <div class="terms_highligt">1. 판매자의 의무</div>
					1) 상품의 등록은 반드시 판매목적으로, 판매가 가능한 상품만을 등록하여야 하며, 상품의 등록은 회사가 정한 양식에 따라 진행하여야 합니다.<br>
					2) 판매 목적의 상품을 등록한 판매자는 구매자의 문의에 성실, 정확히 답하여야 합니다. 판매자의 불성실, 부정확한답변으로 인하여 구매자에게 발생한 손해에 대하여 판매자가 책임을 부담합니다.<br>
					3) 판매자는 상품의 매매와 관련하여 관련법령을 준수하여야 하며, 이 약관 및 회사가 서비스 화면에서 고지하는 내용을 준수하여야 합니다.<br>
					관련 법령, 이 약관 및 고지내용을 위반하거나 이행하지 아니하여 발생하는 모든 손실, 손해에 대하여 판매자가 책임을 부담합니다.<br>
					4) 상품은 허위/과장/과대광고, 신용카드결제시스템만을 이용하기 위하여 허위 등록하는 경우 등에 대하여 회사는 해당 판매 상품을 삭제, 취소할 수 있으며, 이에 따른 모든 책임은 해당 상품을 등록한 판매자가 부담하여야 합니다.<br>
					5) 판매자는 구매자의 거래취소 요청이 있는 경우 이를 타당한 이유없이 거부하여서는 안 되며, 부당한 요금을 요구하여서는 안됩니다.<br>
					6) 판매자는 전자상거래 등에서의 소비자보호에 관한 법률 등 상품의 매매와 관련한 법령에서 정하는 기간동안 필요자료를 보관하여야 합니다.<br>
					7) 판매자는 구매자와 상품매매 절차에서 분쟁이 발생한 경우 분쟁의 해결을 위하여 성실히 임하여야 하며, 분쟁해결의 불성실로 인하여 구매자와 회사에 발생한 모든 손실, 손해를 부담하여야 합니다.<br><br>
					
					<div class="terms_highligt">2. 구매자의 의무</div>
					
					1) 구매자는 구매의사 없이 판매자의 상품에 구매표시를 하여서는 안 됩니다. 
					구매의사 없이 고의적으로 판매자의 상품판매의 기회를 방해하거나 다른 구매자의 구매기회를 방해한 것이 적발되는 경우 회사는 
					해당 아이디에 대하여 회원자격을 정지하는 등의 조치를 취할 수 있습니다.<br>
					2) 구매자는 상품을 구매하기 전에 반드시 상품의 내용과 거래의 조건을 확인한 후 구매를 하여야 합니다. 
					구매하려는 상품의 내용과 거래의 조건을 확인하지 않고 구매하여 발생한 모든 손실, 손해에 대한 책임은 구매자가 부담하여야 합니다.<br>
					3) 구매자는 이 약관 및 회사가 서비스 화면에서 고지하는 내용을 준수하여야 하며, 약관 및 고지내용을 위반하거나 이행하지 아니하여 발생하는 모든 손실, 손해에 대하여 책임을 부담합니다.<br>
					4) 회사는 판매자가 등록한 상품의 내용과 거래조건에 대해서 어떠한 보증이나 대리를 하지 않습니다. 따라서 구매자는 상품 구매시 스스로의 책임하에 상품을 구매하여야 합니다.<br>
					5) 구매자는 구매한 상품에 거래취소 또는 반품의 원인이 발생한 경우 수령한 상품을 임의로 사용하거나 훼손되도록 방치하여서는 안 됩니다. 거래취소 또는 반품 상품의 임의사용이나 상품보관의 미흡으로 인한 상품훼손에 대하여 합당한 비용을 부담하여야 합니다.<br>
					6) 구매자는 판매자와 상품매매 절차에서 분쟁이 발생한 경우 분쟁의 해결을 위하여 성실히 임하여야 하며, 분쟁해결의 불성실로 인하여 판매자와 회사에 발생한 모든 손실, 손해를 부담하여야 합니다.<br>
					7) 구매자는 상품의 구매시 결제방법을 사용함에 있어 반드시 본인 명의의 결제수단을 사용하여야 하며, 타인의 결제수단을 임의사용 하여서는 안 됩니다. 
					타인의 결제수단을 임의로 사용함으로써 발생하는 회사, 결제수단 소유자, 판매자의 손실과 손해에 대한 모든 책임은 구매자가 부담합니다.<br><br>
					
					<div class="terms_highligt">3. 회사의 의무</div>
					
					1) 회사는 회사가 제공하는 서비스를 이용하는 이용자에게 서비스 이용에 관련한 중요사항을 고지합니다.<br>
					2) 회사는 서비스가 안전하게 제공될 수 있도록 각종 설비와 자료를 관리합니다.<br>
					3) 회사는 서비스를 이용하는 회원간 분쟁이 발생하여 그 분쟁의 해결이 원활하지 않은 경우 분쟁의 원활한 해결을 위하여 노력합니다.<br>
					4) 회사는 회사가 제공하는 서비스가 서비스 제공목적에 맞게 이용이 되고 있는지를 수시로 확인할 수 있으며, 
					이용 목적에 위반되거나 벗어난 이용이 확인되는 즉시 관련 이용자에게 사유의 소명을 요청할 수 있으며, 사유의 소명이 타당하지 않다고 판단되는 경우 관련 이용자의 서비스 이용을 제한할 수 있습니다.<br>
					5) 회사는 서비스 제공자로서 관련 법령에서 정하는 기간동안 필요정보를 보관합니다. 또한 보관중인 자료에 대하여 당사자의 요청이 있는 경우 관련 자료를 제공할 수 있습니다.<br>
					6) 전자적 장치의 운영장애, 그 밖의 사유로 거래 내용을 제공 할 수 없을 때 회사는 회원들에게 이를 즉시 알립니다. <br>
		    	</div>
		    	<div class="termstitle">제 8조(분쟁처리 및 분쟁조정)</div>
		    	  <div class="termscontent">
		    	 	1. 이용자는 서비스 이용과 관련한 의견 및 불만을 제기 및 거래분쟁 처리를 요구할 수 있습니다.<br>
					2. 이용자가 회사에 대하여 분쟁처리를 신청한 경우 회사는 15일 이내 이에 대한 조사 또는 처리 결과를 이용자에게 안내합니다.<br>
					3. 이용자는 금융위원회의 설치 등에 관한 법률 제 51조의 규정에 따른 금융감독원의 금융분쟁조정위원회나 전자상거래 등에서의 
					소비자보호에 관한 법률 제 31조 제 1항의 규정에 따른 한국소비자원에 회사의 전자금융거래 서비스의 이용과 관련한 분쟁조정을 신청할 수 있습니다.<br>
		    	</div>
		    	<div class="termstitle">제 10조(서비스 이용제한)</div>
		    	  <div class="termscontent">
					1. 회사는 회사가 제공하는 서비스의 원활한 진행 및 회원간 안전한 서비스 이용이 이루어지도록 하기 위하여 일정한 경우 회원자격을 정지할 수 있습니다. 회원자격이 정지된 회원은 회사가 제공하는 서비스의 이용이 제한됩니다.<br>		    	  
		    	</div>
	    	</div> <!-- inner -->
		    <div id="popupbtnarea" style="text-align: center;"><button id="closepopupbtn_t">확인하였습니다</button></div>
 	 </div>
	</div>
</form>
</div>
</div>
</body>
</html>