<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel='stylesheet' type='text/css' href='./css/AuctionPage.css'>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<script src="js/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>
<script>
$(document).ready(function() {

	var price = ${auction_dto.bid_unit} + ${auction_dto.final_price};
	$("#bid-price").attr('min',price);
	$("#bid-price").attr('value',price);
	
	if("${sessionUser_num}" != "") {
		$("#login-button").attr('hidden',true);
		$("#logout-button").removeAttr("hidden");
		
	}
	
	if("${sessionUser_num}" == "") {
		
		$("#chat-button").on('click',function(){
			event.preventDefault();
			window.location.replace("loginform");
		});
	}

	const end = new Date("${auction_dto.end_time}");
	
	var x = setInterval(function() { 
		// 현재시간을 계속 갱신해야 하므로 Interval 사용함
		const start = new Date();
		const diff = end - start;    
		const day = Math.floor(diff / (1000*60*60*24));
	    const hour = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	    const min = Math.floor((diff / (1000*60)) % 60);
	    const sec = Math.floor(diff % (1000 * 60) / 1000);
	    
	    if(day < 1) {
	    	$("#time").html(hour+"시간 "+min+"분 "+sec+"초");
	    }
	    else if(hour < 1) {
		    $("#time").html(min+"분 "+sec+"초");
	    }
	    else {
	    	 $("#time").html(day+"일 "+hour+"시간 "+min+"분 "+sec+"초");
	    }
		
	    
	    if(diff < 0) {
	    	clearInterval(x);
	    	$("#time").html("경매 종료");
	    	$("#bid-button").css("display","none");
	    }
	   
	});
	// 경매 남은 시간

	
	
	if("${sessionUser_num}" != "${product_dto.user_num}") {
		
		$("#list-button").css('display','none');
		
		if("${sessionUser_num}" != "") {
			$.ajax({
				url : 'my_bid',
				data : {'auction_num': ${auction_dto.auction_num} , 'user_num' : "${sessionUser_num}"},
				type : 'get',
				dataType : 'text',
				success : function(s) {
					if(s == 0) {
						$("#my-bid").html("");
					}
					else {
						$("#my-bid").html(s+" 원");
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
		
		
		$("#chatting-form1").css('display','none');

		$.ajax({
			url : 'roomchecking',
			data : {'seller_num':"${sessionUser_num}" , 'product_num':${product_dto.product_num}},
			type : 'post',
			dataType : 'text',
			success : function(s) {
				
				if(s == 0) {
					$("#chatting-button2").on('click',function(){
						alert("채팅 목록이 존재하지 않습니다");
						event.preventDefault();
					});
				}
			}
		});
		// 채팅 목록에 대한 ajax
	}
	
	
	

	if(${auction_dto.auction_method} == 1) {
		$("#auction-method").html("비공개(비딩)");
		
		$("#final_price").html("비공개");
		$("#bid-unit").html("1호가");
		
		$("#bid-button").on('click',function(){
			
			if("${sessionUser_num}" == "${product_dto.user_num}") {
				
				alert("자신의 상품에는 입찰이 불가합니다");
			}
			// 자신의 상품에 입찰하려고 할 때
			
			else {
				
				if( $("#bid-price").val()%${auction_dto.bid_unit} == 0 ) {
					var really = confirm("입찰하시겠습니까? 입찰은 취소하실 수 없습니다");
						
					if(really) {
						
						$.ajax({
							url : 'private_bid',
							data : {'auction_num': ${auction_dto.auction_num} , 'user_num':"${sessionUser_num}" , 'bid_price':$("#bid-price").val() , 'product_num':${auction_dto.product_num}},
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
					alert("입찰의 최소 단위는 ${auction_dto.bid_unit}원 입니다.")
				}
			}
		});
	}
	else if(${auction_dto.auction_method} == 0) {
		
		$("#auction-method").html("공개");
		
		$("#bid-button").on('click',function(){
			
			if("${sessionUser_num}" == "${product_dto.user_num}") {
				
				alert("자신의 상품에는 입찰이 불가합니다");
			}
			// 자신의 상품에 입찰하려고 할 때
			
			else if("${sessionUser_num}" == "") {
				window.location.replace("loginform");
			}
			else {
				if($("#bid-price").val() <= ${auction_dto.final_price}) {
					alert("현재가격보다 높은 가격을 제시해야 합니다");
				}
				else {
					if( $("#bid-price").val()%${auction_dto.bid_unit} == 0 ) {
						
						var really = confirm("입찰하시겠습니까? 입찰은 취소하실 수 없습니다");
							
						if(really) {
							
							$.ajax({
								url : 'open_bid',
								data : {'auction_num': ${auction_dto.auction_num} , 'user_num':"${sessionUser_num}" , 'bid_price':$("#bid-price").val(), 'product_num':${auction_dto.product_num}},
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
						alert("입찰의 최소 단위는 ${auction_dto.bid_unit}원 입니다.")
					}
				}	
				}
			});
		}
	
	if(${product_dto.product_status1} == 0) {
		$("#statu1").html("개봉여부 : 미개봉");
	}
	else {
		$("#statu1").html("개봉여부 : 개봉");
	}
	
	if(${product_dto.product_status2} == 0) {
		$("#statu2").html("공식여부 : 비공식");
	}
	else {
		$("#statu2").html("공식여부 : 공식");
	}
	
	if(${product_dto.product_status3} == 0) {
		$("#statu3").html("단종여부 : 비단종");
	}
	else {
		$("#statu3").html("단종여부 : 단종");
	}
	if(${product_dto.product_status5} == 0) {
		$("#statu5").html("구성품 포함");
	}
	else {
		$("#statu5").html("구성품 미포함");
	}
	// 상품 상태
	
	if("${product_dto.safe_trade}" == 0) {
		$("#safe-trade").html("불가능");
	}
	else {
		$("#safe-trade").html("가능");
	}
	
	
	var count = ${count};
	// 이미지 갯수
	
	var img = $(".img-list:eq(0)").attr("src");
	$("#main-img").attr("src",img);
	var i;

	
	for(var i=0; i<count; i++) {
		
		$(".img-list:eq("+i+")").on('click',function(){
			var img = $(this).attr("src");
			$("#main-img").attr("src",img);
			$(this).css("border-color","red");
			$(".img-list").not(this).css("border-color","black");
		});
	}
});
</script>
</head>
<body>
<div id="main-div">
	<table id="info-table">
		<tr>
		<td rowspan="7" id="img-td" class="img"><img id="main-img" src="" onerror="this.src=null; this.src='/serverimg/none.png'"></td>
		<td class="head">경매물품</td><td class="info">${detail_name}</td></tr>
		<tr><td class="head">남은시간</td><td class="info"><div id="time"></div></td></tr>
		<tr><td class="head">판매자</td><td class="info"><a href="/userreview?user_num=${product_dto.user_num}" id="user-id">${user_id}</a></td></tr>
		<tr><td class="head">물품번호</td><td class="info">${auction_dto.product_num}</td></tr>
		<tr><td class="head">경매번호</td><td class="info">${auction_dto.auction_num}</td></tr>
		<tr><td class="head">입찰방식</td><td class="info"><div id="auction-method"></div></td></tr>
		<tr><td class="head">입찰 수</td><td class="info"><div id="much-bid">${much}</div></td></tr>
		<tr><td rowspan="2" class="img">
			<!-- 이미지 슬라이드 부분 -->
			<ul class="slides">
			    <c:forEach var="image" items="${images}">
				<li><img class="img-list" src="/final/${image}" onerror="this.src=null; this.src='/serverimg/none.png'"></li>
				</c:forEach>
			</ul>  
		</td>
		<td class="head">안전거래</td><td class="info"><div id="safe-trade"></div></td>
		</tr>
		<tr>
		<td class="head" id="statu-td">물품 상태</td>
		<td>
			<table id="statu-table">
				<tr><td id="statu1"></td></tr>
				<tr><td id="statu2"></td></tr>
				<tr><td id="statu3"></td></tr>
				<tr><td id="statu4">상태 : ${product_dto.product_status4}</td></tr>
				<tr><td id="statu5"></td></tr>
			</table>
		</td></tr>
	</table>
	
	<div id="bid-div">
		<table id="bid-table" class="bid-table">
			<tr><td class="head2">시작가</td><td class="info2">${product_dto.product_price} 원</td></tr>
			<tr><td class="head2"><div id="bid-unit">입찰단위</div></td><td class="info2">${auction_dto.bid_unit} 원</td></tr>
			<tr><td class="head2">현재가격</td><td class="info2"><div id="final_price">${auction_dto.final_price} 원</div></td></tr>
			<tr><td class="head2">내 제시가</td><td class="info2"><div id="my-bid"></div></td></tr>
			<tr><td class="head2">입찰금액</td><td class="info2" id="bid-td"><input type=number step=${auction_dto.bid_unit} id="bid-price" name="bid_price"></td></tr>
		</table>
		<table class="bid-table">
			<tr><td class="button-td"><input type="button" id="bid-button" value="입찰하기"></td>
			<td class="button-td">
			<form action="chatting1" method="post" id="chatting-form1">
				<input type=hidden name="buyer_num" value="${sessionUser_num}">
				<input type=hidden name="seller_num" value="${product_dto.user_num}">
				<input type=hidden name="product_num" value="${product_dto.product_num}">
				<input type=hidden name="auction_check" value="${product_dto.auction_check}">
				<input type=submit id="chat-button" class="chatting-button" value="채팅하기"><br>
			</form>
			<a href="#list-modal" rel="modal:open"><input type=button id="list-button" class="chatting-button" value="채팅목록"></a>
			</td></tr>
		</table><hr>
		<div id="product_contents">
			${product_dto.product_contents}
		</div>
	</div>
</div>
<div id="list-div">
	<div id="list-modal" class="modal">
		<h1>채 팅 목 록</h1><hr id="chat-hr1">
		  <table id="list-table">
			<c:forEach items="${chattinglist}" var="chat" varStatus="status">
			<tr><td class="buyer-name">
			<form action="chatting2" method="post" id="list-form">
			<input type=hidden value="${chat.product_num}" name="product_num">
			<input type=hidden value="${chat.buyer_num}" name="buyer_num">
			<input type=hidden value="${chat.buyer_name}" name="buyer_name">
			<input type=hidden value="${chat.seller_num}" name="seller_num">
			<input type=hidden value="${chat.roomNumber}" name="roomNumber" id="roomNumber">
			<input type=submit value="${chat.buyer_name}" id="go-chat">
			</form></td>
			<td><div id="chat">${chat.last_chat}</div></td></tr>
			</c:forEach>
			</table>
	</div>
</div>
</body>
</html>