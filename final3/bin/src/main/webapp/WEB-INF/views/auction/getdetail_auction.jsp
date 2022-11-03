<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="CSS/slideStyle.css">
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {

	var price = ${dto1.bid_unit} + ${dto1.final_price};
	$("#bid-price").attr('min',price);
	$("#bid-price").attr('value',price);
	
	if("${sessionUser_num}" != "") {
		$("#login-button").attr('hidden',true);
		$("#logout-button").removeAttr("hidden");
	}

	const end = new Date("${dto1.end_time}");
	
	var x = setInterval(function() { 
		// 현재시간을 계속 갱신해야 하므로 Interval 사용함
		const start = new Date();
		const diff = end - start;    
		const day = Math.floor(diff / (1000*60*60*24));
	    const hour = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	    const min = Math.floor((diff / (1000*60)) % 60);
	    const sec = Math.floor(diff % (1000 * 60) / 1000);
		
	    $("#time").html(day+"일 "+hour+"시간 "+min+"분 "+sec+"초 남음");
	    
	    if(diff < 0) {
	    	clearInterval(x);
	    	$("#time").html("경매 종료");
	    }
	});
	// 경매 남은 시간
	
    
	
	$("#logout-button").on('click',function(e){
		
		$.ajax({
			url : 'logout',
			type : 'post',
			dataType : 'text',
			success : function(s) { 
				location.reload();
			}
		});
	});
	// 로그아웃 버튼에 대한 ajax
	
	if("${sessionUser_num}" != "${dto2.user_num}") {
		
		if("${sessionUser_num}" != "") {
			$.ajax({
				url : 'my_bid',
				data : {'auction_num': ${dto1.auction_num} , 'user_num' : "${sessionUser_num}"},
				type : 'get',
				dataType : 'text',
				success : function(s) {
					if(s == 0) {
						$("#my-bid").html("");
					}
					else {
						$("#my-bid").html(s+"원");
					}
				}
			});
		}
		else {
			$("#my-bid").html("");
		}
	}
	else {
		$("#my-bid").html("내 경매 상품입니다.");
	}

	if(${dto1.auction_method} == 1) {
		$("#auction-method").html("비공개(비딩)");
		
		$("#final_price").html("비공개");
		$("#bid-unit").html("1호가");
		
		$("#bid-button").on('click',function(){
			
			if("${sessionUser_num}" == "${dto2.user_num}") {
				
				alert("자신의 상품에는 입찰이 불가합니다");
			}
			// 자신의 상품에 입찰하려고 할 때
			
			else {
				
				if( $("#bid-price").val()%${dto1.bid_unit} == 0 ) {
					var really = confirm("입찰하시겠습니까? 입찰은 취소하실 수 없습니다");
						
					if(really) {
						
						$.ajax({
							url : 'private_bid',
							data : {'auction_num': ${dto1.auction_num} , 'user_num':"${sessionUser_num}" , 'bid_price':$("#bid-price").val() , 'product_num':${dto1.product_num}},
							type : 'post',
							dataType : 'text',
							success : function(s) {
								
								if(s == 0) {
									
									var really = confirm("보유 머니가 부족합니다! 충전하시겠습니까?");
									
									if(really) {
										window.location.replace("temp_main");
										// 보유 머니 충전 페이지로 바꾸자@@@@@@@@@@@@@@@@@@@@@@@@@@@@
									}
									else { }
			
								}
								// 충전머니 부족할 때
								else if(s == 1) {
									alert("상위 입찰 완료")	
								}
								// 이미 입찰함
								else if(s == 3) {
									alert("이전 입찰 금액보다 낮은 금액으로 입찰하실 수 없습니다.");
								}
								else {
									alert("입찰 완료");
								}
								// 입찰 완료
							}
						});
					}
					else {	}
					
				}
				else {
					alert("입찰의 최소 단위는 ${dto1.bid_unit}원 입니다.")
				}
			}
		});
	}
	else if(${dto1.auction_method} == 0) {
		
		$("#auction-method").html("공개");
		$("#bid-button").on('click',function(){
			
			if("${sessionUser_num}" == "${dto2.user_num}") {
				
			if(${sessionUser_num} == ${dto2.user_num}) {
				alert("자신의 상품에는 입찰이 불가합니다");
			}
			// 자신의 상품에 입찰하려고 할 때
			
			else if("${sessionUser_num}" == "") {
				alert("입찰을 하려면 로그인을 하셔야 합니다");
			else {
					var really = confirm("입찰하시겠습니까? 입찰은 취소하실 수 없습니다");
					if(really) {
						$.ajax({
							url : 'open_bid',
							data : {'auction_num': ${dto1.auction_num} , 'user_num':${sessionUser_num} , 'bid_price':$("#bid-price").val(), 'product_num':${dto1.product_num}},
							type : 'post',
							dataType : 'text',
							success : function(s) {
								
								if(s == 0) {
									var really = confirm("보유 머니가 부족합니다! 충전하시겠습니까?");
									if(really) {
										window.location.replace("temp_main");
										// 보유 머니 충전 페이지로 바꾸자@@@@@@@@@@@@@@@@@@@@@@@@@@@@
									}
									else { }
								}
								// 충전머니 부족할 때
								else if(s == 1) {
									alert("고객님의 입찰이 가장 최신 입찰 입니다.")		
								}
								// 이미 입찰하였고, 아직 최고가가 경신 안됨
								else {
									alert("입찰 완료");
								}
								// 입찰 완료
							}
						});
					}
					else {	}
			}
			else {
				if($("#bid-price").val() <= ${dto1.final_price}) {
					alert("현재가격보다 높은 가격을 제시해야 합니다");
				}
				else {
					if( $("#bid-price").val()%${dto1.bid_unit} == 0 ) {
						
						var really = confirm("입찰하시겠습니까? 입찰은 취소하실 수 없습니다");
							
						if(really) {
							
							$.ajax({
								url : 'open_bid',
								data : {'auction_num': ${dto1.auction_num} , 'user_num':"${sessionUser_num}" , 'bid_price':$("#bid-price").val(), 'product_num':${dto1.product_num}},
								type : 'post',
								dataType : 'text',
								success : function(s) {
									
									if(s == 0) {
										
										var really = confirm("보유 머니가 부족합니다! 충전하시겠습니까?");
										
										if(really) {
											window.location.replace("temp_main");
											// 보유 머니 충전 페이지로 바꾸자@@@@@@@@@@@@@@@@@@@@@@@@@@@@
										}
										else { }
				
									}
									// 충전머니 부족할 때
									else if(s == 1) {
										alert("회원님의 입찰이 가장 최신 입찰 입니다.")
										
									}
									// 이미 입찰하였고, 아직 최고가가 경신 안됨
									else {
										
										alert("입찰 완료");
										location.reload();
										
									}
									// 입찰 완료
								}
							});
						}
						else {	}
						}
					else {
						alert("입찰의 최소 단위는 ${dto1.bid_unit}원 입니다.")
					}
				}	
				}
			});
		}	
});
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
	min-width:800px;
	padding-bottom: 20px;
}
#contents #form_name{
	font-size: 24px;
	font-weight: 700;
}
#product_table{
	min-height:300px;
	padding : 10px;
	border-collapse: collapse;
	margin:20px;
}
#product_table td{
	padding:10px;
	margin: 10px;
}
button{
	border-radius: 8px;
	margin-left: 5px;
	margin-bottom: 30px;
}
#product_table .header{
	width: 100px;
	text-align: center;
}
#chat_button{
	width: 80px;
	height: 40px;
	background-color: #5C75E6;
	color: white;
	font-size: 17px;
	align: center;
	border-radius: 8px;
}
</style>
</head>

<body>
상단바 추후 수정 예정
<div id="login">
<a href="loginform"><input type="button" id="login-button" value="로그인"></a>
<a href="logout"><input type="button" id="logout-button" value="로그아웃" hidden="true"></a>
로그인한 사람의 user_num : ${sessionUser_num}
</div>

<table border="2">
<tr><td>물품번호</td><td>${dto1.product_num}</td></tr>
<tr><td>경매번호</td><td>${dto1.auction_num}</td></tr>
<tr><td>판매자</td><td>${user_id}</td></tr>
<tr><td>경매기간</td><td><div id="time"></div></td></tr>
<tr><td>경매물품</td><td>${detail_name}</td></tr>
<tr><td>입찰방식</td><td><div id="auction-method"></div></td></tr>
<tr><td>입찰 수</td><td><div id="much-bid">${much}</div></td></tr>
</table><br>
<table border="2">
<tr><td>시작가</td><td>${dto2.product_price}원</td></tr>
<tr><td><div id="bid-unit">입찰단위</div></td><td>${dto1.bid_unit}원</td></tr>
<tr><td>현재가격</td><td><div id="final_price">${dto1.final_price}원</div></td></tr>
<tr><td>내 제시가</td><td><div id="my-bid"></div></td></tr>
<tr><td>입찰금액</td><td><input type=number step=${dto1.bid_unit} id="bid-price" name="bid_price"></td></tr>
<tr><td colspan="2"><input type="button" id="bid-button" value="입찰하기"></td></tr>
=======
<hr>

<div id="contents">
<div id="form_name">경매상품페이지</div>
<table border="1" id="product_table">
	<tr>
		<td rowspan="6">
		<!-- 이미지 슬라이드 부분 -->
		<div id="slideShow">
			<ul class="slides">
		      	<c:forEach var="image" items="${imagepath}" >
					<li><img src="resources/images/${image }" alt="사진" width="400px" height="300px"/></li>
				</c:forEach>
		    </ul>  
		 	<p class="controller">
				<!-- &lang: 왼쪽 방향 화살표 &rang: 오른쪽 방향 화살표 -->
				<span class="prev">&lang;</span>  
				<span class="next">&rang;</span>
		    </p>
		</div>
		<script src="JS/slideShow.js"></script>
		</td>
		<td colspan="3">
			${detail_name}
		</td>
	</tr>
	<tr>
		<td colspan="3" class="header"><h1>${product_dto.product_title}</h3></td>
	</tr>
	<tr>
		<td colspan="3"><h3>${product_dto.product_price} 원</h3></td>
	</tr>
	<tr>
		<td>안전결제여부 : ${product_dto.safe_trade}</span></td>
		<td>입찰방식 : <div id="auction-method"></div></td>
		<td>경매시간 : ${auction_dto.end_time}까지 + 남은시간</td>
	</tr>
	<tr>
		<td colspan="3">
		   <ul>
	           <li>미개봉/개봉 : ${product_dto.product_status1}</li>
	           <li>공식/비공식 : ${product_dto.product_status2}</li>
	           <li>단종/단종아님 : ${product_dto.product_status3}</li>
	           <li>좋음/보통/나쁨 : ${product_dto.product_status4}</li>
	           <li>구성품 포함 / 미포함 : ${product_dto.product_status5}</li>
       		</ul>
		</td>
	</tr>
	<tr>
		<td colspan="3"><input type=button id="chat_button" value="채팅"></td>
	</tr>
	<tr>
		<td rowspan="7" colspan="2" >설명 : ${temp_dto.product_contents }</td>
		<td>시작가</td><td>${product_dto.product_price}원</td>
	</tr>
	<tr>
		<td><div id="bid-unit">입찰단위</div></td><td>${dto1.bid_unit}원</td>
	</tr>
	<tr>
		<td>현재가격</td><td><div id="final_price">${dto1.final_price}원</div></td>
	</tr>
	<tr>
		<td>내 제시가</td><td><div id="my-bid"></div></td>
	</tr>
	<tr>
		<td>입찰금액</td><td><input type=number step=1000 id="bid-price" name="bid_price" min="${auction_dto.final_price}" value="${auction_dto.final_price}"></td>
	</tr>
	<tr>
		<td>입찰 수</td><td><input type=button id="bid_detail" value="경매기록보기"></td>
	</tr>
	<tr>
		<td colspan="2"><input type="button" id="bid-button" value="입찰하기"></td>
	</tr>

</table>

</div>

</body>

</html>