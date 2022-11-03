<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리별 보기</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
	$('.idol_name_btn_e').on('mouseover', function(){
		var idol =$(this).val();
		if(idol=='bts'){
			$('#product_category_list1').css('display','block');
			$('#product_category_list1').on('mouseover',function(){
				$('#product_category_list1').css('display','block');
			}); //하위목록 이벤트 end
		}else if(idol='nct'){
			$('#product_category_list2').css('display','block');
			$('#product_category_list2').on('mouseover',function(){
				$('#product_category_list2').css('display','block');
			}); //하위목록 이벤트 end 
		}
	}); //mouseover end
	$('.idol_name_btn').on('mouseleave', function(){
		var idol =$(this).val();
		if(idol=='bts'){
			$('#product_category_list1').css('display','none');
		/* 	 $('#product_category_list1').on('mouseover',function(){
				$('#product_category_list1').css('display','none');
			}); //하위목록 이벤트 end  */
		}else if(idol='nct'){
			$('#product_category_list2').css('display','none');
			/* $('#product_category_list2').on('mouseover',function(){
				$('#product_category_list2').css('display','none');
			}); //하위목록 이벤트 end  */
		}
	}); //mouseover end
	
	//찜 버튼 클릭 시 작동 함수 
	$('.likebtn').on('click',function(e){
		var tg =  $(this).html();
		// 찜 X 상태 -> 찜하고 버튼 색 바꿈 
		if(tg == "🤍"){
			$(this).html('❤️');
			$(this).css('font-size', '20px');
			$.ajax({
				url:'likeclickajax',
				data: {'product_num' : $(this).val()},
				type:"get",
				dataType:'json',
				success:function(server){
					alert(server.result);
				}//success end
			}); //ajax end	
		}else{ // 이미 찜된 상태 -> 찜 취소  
			$(this).html('🤍');
			$(this).css('font-size', '20px');
			$.ajax({
				url:'unlikeclickajax',
				data: {'product_num' : $(this).val()},
				type:"get",
				dataType:'json',
				success:function(server){
					//alert(server.result);
				}//success end
			}); //ajax end	
		}
	});
	
	$('.price').each(function(){ // 가격 표시 , 세자리마다 콤마 찍기
		  var price = $(this).text();
		  price = price.slice(0,-1); //맨 마지막 글자 짜르기 (원)
		  let result = price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		  result+='원';
		  $(this).html(result);
	});
	/*   e.preventDefault();  
	  $(this).css('background-color', 'gold');
	   $('.a').not($(this)).css('background-color', '#fff'); */
	
	
	   
});//ready end
</script>
<style>
button{
transition: all 0.2s ;
cursor: pointer;
}
.product_list, .section1{
	position: relative;
	display: flex;
	flex-flow: row;
	min-height: 80vh;
	width: 100%;
	/* border : 1px solid black; */
	justify-content: center;
}
.left{
	position: relative;
	display: flex;
	flex-flow: column;
	width: 15%;
	/* border : 1px solid black; */
	border-radius: 8px 0 0 8px;
}
.right{
	position: relative;
	display: flex;
	flex-flow: column;
	width: 70%;
	border : 2px solid #eaeef5;
	border-radius: 0 8px 8px 8px;
	padding: 10px;
}

.category_list{
	padding: 10px;
	border:2px solid #eaeef5;
	border-right: none;
	border-radius: 8px 0 0 8px;
}
.category_list_item{
	margin-bottom: 5px;
	/* border:1px solid #eaeef5; */
	 border-radius: 4px;
/* 	background-color: pink; */
}
#product_category_list1, #product_category_list2{
	border:2px solid #dde4ee;
	border-top:none;
	padding:10px;
}
.idol_name_btn{
	background-color:transparent;
	border: none;
	color:#5C75E6;
	font-weight:700;
	font-size:18px;
	width: 100px;
	height: 35px;
}
a{
	text-decoration: none;
	color: black;
}
a:hover{
	color:#5C75E6;
}
.idol_name{
	color:#5C75E6;
	font-size:24px;
	background: linear-gradient(145deg,#a1c4fd, #dde4ee);
	border-radius: 8px 0 0 0;
}

.idol_name:hover{
    background: linear-gradient(88deg, #8eb9ff, #eaeef5, #8eb9ff);
    background-size: 800% 800%;

    -webkit-animation: blink2 5s ease infinite;
    -moz-animation: blink2 5s ease infinite;
    animation: blink2 5s ease infinite;
}

@-webkit-keyframes blink2 {
    0%{background-position:0% 84%}
    50%{background-position:100% 17%}
    100%{background-position:0% 84%}
}
@-moz-keyframes blink2 {
    0%{background-position:0% 84%}
    50%{background-position:100% 17%}
    100%{background-position:0% 84%}
}
@keyframes blink2 {
    0%{background-position:0% 84%}
    50%{background-position:100% 17%}
    100%{background-position:0% 84%}
}

.idol_name_btn:hover{
	text-decoration: underline;
}
@keyframes fadeInUp {
        0% {
            opacity: 0;
            /* transform: translate3d(0, 100%, 0); */
            translate3d(0, -100%, 0);
        }
        to {
            opacity: 1;
            transform: translateZ(0);
        }
}
#product_category_list1, #product_category_list2 {
    position: relative;
    animation: fadeInUp 1.5s;
}
.product_items{
	position: relative;
	display: flex;
	flex-flow : column nowrap;
	justify-content:center;
	/* border:2px solid #dde4ee; */
	border-radius: 8px;
	padding:20px 20px 20px 20px;
}
.product_item_box{
	position: relative;
	display: flex;
	flex-flow : row wrap;
	justify-content:flex-start;
	border:2px solid #dde4ee;
	border-radius: 0 0 8px 8px;
	padding:20px 20px 20px 20px;
}

.product_item{
	position:relative;
	display:flex;
	flex-flow:column nowrap;
	justify-content:center;
	align-items:center;
	background-color: #eaeef5; 
	width: 200px;
	min-height:300px;
	border-radius:8px;
	margin-right: 20px;
	margin-bottom: 20px;
}
.product_item img{
	width: 120px;
	height: 120px;
	margin: 5px 0 5px 0;
}
#category_title_box{
	height: 30px;
	border:2px solid #dde4ee;
	border-radius: 8px 8px 0 0;
	border-bottom: none;
	padding: 5px 5px 0 5px;
	text-align: right;
}
.likebtn{
	position: absolute;
	z-index: 0.5;
	top:3px;
	right:1px;
	background-color:transparent;
	border: none;
	cursor: pointer; 
	font-size: 20px;
}
.likebtn:hover{
	/* transform : scale(1.5); */
	animation: .8s beat infinite;
}

@keyframes beat {
  0% {
    transform: scale(1);
  }
  25% {
    transform: scale(1.3);
  }
  40% {
    transform: scale(1.1);
  }
  60% {
    transform: scale(1.3);
  }
  100% {
    transform: scale(1);
  }
 }
.product_info{
	text-align: center;
}
.product_option, .top, .bottom{
	position: relative;
	display: flex;
	flex-flow: column;
	border-radius: 8px;
	justify-content: center;
}
.top, .bottom{
	position: relative;
	display: flex;
	flex-flow: row wrap;
}
.top{
	margin-bottom: 3px;
}
.trade_type{
	padding:2px;
	background-color:#0ab194;
	color:white;
	font-size: 14px;
	border-radius: 4px;
	margin-right: 10px;
	/*#1eb588  */ 
}
.auction_type{
	padding:3px;
	font-size: 14px;
	background-color:#c43950 ;
	color:white;
	border-radius: 4px;
}
.product_status{
	padding:3px;
	background-color:#c43950 ;
	color:white;
	border-radius: 4px;
	font-size: 14px;
	margin-right: 3px;
	margin-bottom: 3px;
}
.product_status1{
	background-color: #be93c5;
}
.product_status2{
	background-color: #a7a4c7;
}
.product_status3{
	background-color: #8cb8ca;
}
.product_status4{
	background-color: #f0b9c0;
}
.product_status5{
	background-color: #f6a180;
}
</style>
</head>
<body>
<!-- <jsp:include page="../template/header.jsp" flush="true"/> -->
<br>
<main class="product_list">
	<section class="section1">
		<div class="left">
			<div class="category_list">
				<div class="category_list_item">
					<div class="idol_name" id="idol_name"><button class="idol_name_btn" id="heart" onclick="location.href='getproducts';">ALL</button></div>
				</div>	
				<div class="category_list_item">
					<div class="idol_name" id="idol_name"><button class="idol_name_btn idol_name_btn_e" value="bts" onclick="location.href='getproducts?idol_num=1';" >BTS</button></div>
					<div class="product_category_list" id="product_category_list1" style="display:none;">
						<div class="product_category_list_item1"><a href="getproducts?idol_num=1&category_num=1">DVD</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=1&category_num=2">콘서트 굿즈</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=1&category_num=3">앨범</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=1&category_num=4">포스터</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=1&category_num=5">포토북</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=1&category_num=6">포토카드</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=1&category_num=7">패션</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=1&category_num=8">문구류</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=1&category_num=9">기타</a></div>
					</div>	
				</div>
				<div class="category_list_item">
					<div class="idol_name" id="idol_name"><button class="idol_name_btn idol_name_btn_e" value="nct" onclick="location.href='getproducts?idol_num=2';">NCT</button></div>
					<div class="product_category_list" id="product_category_list2" style="display:none;">
						<div class="product_category_list_item1"><a href="getproducts?idol_num=2&category_num=1">DVD</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=2&category_num=2">콘서트 굿즈</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=2&category_num=3">앨범</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=2&category_num=4">포스터</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=2&category_num=5">포토북</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=2&category_num=6">포토카드</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=2&category_num=7">패션</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=2&category_num=8">문구류</a></div>
						<div class="product_category_list_item1"><a href="getproducts?idol_num=2&category_num=9">기타</a></div>
					</div>	
				</div>
			</div>
		</div>
		<div class="right">
			<div class="product_items">
				<div id="category_title_box">
					<select>
						<option>최신순</option>			
					</select>
				</div>
				<div class="product_item_box">
				<!-- 	<div class="product_item">
						<div> <img alt="오류" src="/images/Proof(Collector’s Edition)(6c25a897-161d-47b0-833f-8f0003cd9b56)png"><span><button class="likebtn" style="color: red; font-size: 20px; ">♡</button></span></div>
						<div class="product_info">
							<div class="product_title" style="font-weight: 700;margin-bottom: 5px;">방탄 픽셀콘 티켓</div>
							<div class="product_price" style="margin-bottom: 5px;">10000원</div>
							<div class="product_option">
								<span class="trade_type">안전거래</span>
								<span class="auction_type">경매</span>
							</div>
						</div>					
					</div> -->
						<c:forEach items="${search_result }" var="p">
							<div class="product_item">
						<div> <c:if test="${not empty p.image_path }"><img alt="등록된 이미지 없음" src="/images/${p.image_path}"  OnClick="location.href ='productdetail?product_num=${p.product_num}'" style="cursor: pointer;"></c:if>
						<c:if test="${empty p.image_path }"><img alt="등록된 이미지 없음" src="/serverimg/noimage.png"  OnClick="location.href ='productdetail?product_num=${p.product_num}'" style="cursor: pointer;"></c:if>
						<%
							/* 세션아이디값이 있을 때만 찜할 수 있는 버튼 띄움 */
							if(session.getAttribute("sessionUser_num") != null){%>
							 <span><button class="likebtn" style="color: red; font-size: 20px; " value="${p.product_num}">🤍</button></span>
								<%
							}
						%>
						<c:set var="loop_flag" value="false" />
						<!-- inner for문에서 해당 상품이 현재 로그인한 유저가 찜한 상품인지 확인해주고 버튼 상태를 바꿔준다. -->
						 <c:forEach items="${likeproduct}" var="l">
						<c:if test="${not loop_flag }">
							<c:if test="${p.product_num == l }">
								<span class="likebtnarea"><button class="likebtn" style="color: red; font-size: 20px; " value="${p.product_num}">❤️</button></span>
								<c:set var="loop_flag" value="true" />
							</c:if>
							<%-- <c:if test="${p.product_num != l}">
								<span><button class="likebtn" style="color: red; font-size: 20px; " value="${p.product_num}">🤍</button></span>
							</c:if> --%>
						</c:if>
						</c:forEach>
						</div>
						<div class="product_info"  OnClick="location.href ='productdetail?product_num=${p.product_num}'" style="cursor: pointer;">
							<div class="product_title" style="font-weight: 700;margin-bottom: 5px;"><a>${p.product_title }</a></div>
							<div class="product_price price" style="margin-bottom: 5px;">${p.product_price }원</div>
							<%-- ${p.safe_trade} ${p.auction_check} --%>
							<div class="product_option">
								<div class="top">
								<c:if test="${p.safe_trade==true}"><span class="trade_type">안전거래</span></c:if>
								<c:if test="${p.auction_check==true}"><span class="auction_type">경매</span></c:if>
								</div>
								<div class="bottom">
									<c:if test="${p.product_status1==1}"><span class="product_status product_status1">미개봉</span></c:if>
									<c:if test="${p.product_status1==0}"><span class="product_status product_status1">개봉</span></c:if>
									<c:if test="${p.product_status2==1}"><span class="product_status product_status2">공식</span></c:if>
									<c:if test="${p.product_status2==0}"><span class="product_status product_status2">공식</span></c:if>
									<c:if test="${p.product_status3==1}"><span class="product_status product_status3">단종</span></c:if>
									<c:if test="${p.product_status4=='좋음'}"><span class="product_status product_status4">상태좋음</span></c:if>
									<c:if test="${p.product_status4=='보통'}"><span class="product_status product_status4">상태보통</span></c:if>
									<c:if test="${p.product_status4=='나쁨'}"><span class="product_status product_status4">상태나쁨</span></c:if>
									<c:if test="${p.product_status5==1}"><span class="product_status product_status5">구성품포함</span></c:if>
									<c:if test="${p.product_status5==0}"><span class="product_status product_status5">구성품미포함</span></c:if>
								</div>
										<!-- 1. 미개봉/개봉
										2. 공식/비공식
										3. 단종/단종아님
										4. 좋음/보통/나쁨
										5. 구성품 포함 / 미포함 -->
							</div>
						</div>					
					</div>
						</c:forEach>
				</div>			
			</div>
		</div>
	</section>
</main>
</body>
</html>