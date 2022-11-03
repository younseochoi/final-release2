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
	//환불하기  - ajax 판매자가 3일 안에 운송장 번호 등록안함 
	// 구매자에게 결제 금액 돌려줌 -> 로그인한사람 구매자 
	$("#refundbtn").on("click",function(){
		$.ajax({
			url: "refund",
			type:	"post",
			data: {'pay_price' : $("#hiddenpay_price").val()},
			dataType: "json", //결과 타입
			success: function(server){
				if(server.result == 'success'){
					alert('성공');
				}else{
					alert('실패');
				}
			}//success end
		});//ajax end
	}); //click end 
	
	// 구매 확정
	$(".confirmpurchasebtn").on("click",function(){
		pdtnum = $(this).val();
		$.ajax({
			url: "confirmpurchase",
			type:	"post",
			data: {'product_num' : $(this).val()},
			dataType: "json", //결과 타입
			success: function(server){
				if(server.result == 'success'){
					alert('성공');
					//$('#popup_b').css("display","");
					openpop_b();
					
				}else{
					alert('실패');
				} 
				
			}//success end
		});//ajax end
	}); //click end 
	
	$('#drawStar_b').on('change',function(e){
		 $('.star_b span').css( 'width', $(this).val() * 10+'%' );
	});
	
	const popup_b = $('#popup_b');
	 var openpop_b = function(e){
		// $('#openpop').on('click',function(e){
	    	//e.preventDefault();
	    	
	    		$('#popup_b').css('display','');
	    		popup_b.removeClass('hide');
	    		popup_b.addClass('has-filter');
	    		
	    		if (popup_b.hasClass('has-filter')) {
	    		  	popup_b.addClass('has-filter');
	    		  } else {
	    		  	popup_b.removeClass('has-filter');
	    		  }
	    		
	    	
	  //  });
	 }
	    $('#closepopupbtn_b').on('click',function(e){
	    	e.preventDefault();
	    	popup_b.removeClass('has-filter');
    		popup_b.addClass('hide');
	    });
	    
	    $('#writepopupbtn_b').on('click',function(e){
	    	$.ajax({
				url: "insertreviewajax",
				type:	"post",
				data: {'review_num' : pdtnum,
					'review_contents' : $('#review_contents_b').val(),
					'review_rating' : $('#drawStar_b').val(),
					'reviewer_role' : 'buyer'
				},
				dataType: "json", //결과 타입
				success: function(server){
					if(server.result=='success'){
						alert('성공적으로 등록되었습니다.');
						popup_b.removeClass('has-filter');
			    		popup_b.addClass('hide');
					}
				}//success end
			});//ajax end
	    });
});//ready end
</script>
<style>
/* 팝업창  */
#popup_b {
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

#popup_b.hide {
  display: none;
}

#popup_b.has-filter {
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
}

#popup_b .content {
	width:450px;
 	 padding: 20px;
 	 background: #fff;
 	 border-radius: 5px;
 	 box-shadow: 1px 1px 3px rgba(0, 0, 0, .3);
 	 text-align: center;
}
#popup_b .termstitle{
	font-weight: 700;
	font-size: 18px;
	margin-bottom: 15px;
	
}
#popup_b .termscontent{
	margin-bottom: 45px;
	color: #6f7792;
	text-align: center;
}
.terms_highligt{
	color : black;
	font-weight: 700;
	margin-bottom: 10px;
}
#popupbtnarea{
	height: 50px;
}
#closepopupbtn{
 	width: 120px;
 	height: 35px;
 	border-radius: 8px;
	background-color: #5C75E6;
	color: white;
}
#openpop{
	border: none;
	text-decoration-line: underline;
	cursor :pointer;
	outline: none;
	background-color: #f5f5f5;
}
#openpop:hover{
	color: #5C75E6;
}
/* 평점 별 */
 .star_b {
    position: relative;
    font-size: 3rem;
    color: #ddd;
  }
  
  .star_b input {
    width: 100%;
    height: 20px;
    position: absolute;
    left: 0;
    bottom:2px;
	opacity: 0;
    cursor: pointer;
  }
  
  .star_b span {
    width: 0;
    position: absolute; 
    left: 0;
    color: #fd746c;
    overflow: hidden;
    pointer-events: none;
  }
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@800&display=swap');
button{
	outline: 0;
	border:none;
	transition: all 0.2s ;
	cursor: pointer;
}
.popupbtn{
 	width: 120px;
 	height: 35px;
 	border-radius: 8px;
	background-color: #5C75E6;
	color: white;
} 
.popupbtn:hover{
	
  	background-color:#6682FF;
  	box-shadow: 0px 0px 0px 5px rgba(192, 194, 250,0.7);
} 
textarea{
	border-radius: 8px;
	border : 2px solid rgb(92, 117, 230,0.3);
	background-color:  #fff;
}
</style>
</head>
<body>
<jsp:include page="../template/header.jsp" flush="true"/>
- 운송장 번호 null이고 구매자 구매목록 보기 페이지에서 3일 이후라면 환불 버튼띄우기 , 구매확정 비활성화<br>
- 구매확정은 payment_info seller_check가 not null 이면 구매확정버튼 활성화<br>
<c:forEach items="${purchaselist}" var="p">
${p.product_num }
<c:if test="${empty p.billing_number && p.elapsed_date>3 }"><button id="refundbtn">환불하기</button></c:if>
<c:if test="${not empty p.seller_check}"><button class="confirmpurchasebtn" value="${p.product_num }">구매 확정</button></c:if>
${p.seller_check } <br><hr>
<input type="hidden" value="${p.pay_price}" name="pay_price" id="hiddenpay_price">
<input type="hidden" value="${p.product_num}" name="product_num" id="hiddenproduct_num">
</c:forEach>

<!-- 리뷰 팝업 -->
<div id="popup_b" style="display: none;">
		<div class="content" style="overflow-y: scroll; height:550px;">
	    	<p style="font-size: 16px; font-weight: 500;"></p>
	    	<div>
		    	 <div class="termstitle">이번 거래는 어떠셨나요? 거래에 대한 후기를 남겨주세요!</div>
		    	 <div class="termscontent">
		    	 <span class="star_b"> ★★★★★
		    	 	<span>★★★★★</span>
 				 	<input type="range" id="drawStar_b" value="1" step="1" min="0" max="10" name="review_rating">
				 </span>
		    		<textarea rows="15" style="width:100%; margin-top:20px;" id="review_contents_b" name="review_contents"></textarea>
		    	</div>
				<!-- 구매자 후기 썼을 때 넘어가야하는 데이터 : user_num(현재 로그인 아이디), product_num, 평점, 리뷰내용 -->
				<!-- 판매자 후기 썼을 때 넘어가야하는 데이터 : user_num(현재 로그인 아이디), 구매자 user_num, 평점, 리뷰내용 -->
	    	</div> <!-- inner -->
		    <div id="popupbtnarea" style="text-align: center;">
				<button class="popupbtn" id="closepopupbtn_b">다음에 쓰기</button>		    
		    	<button class="popupbtn" id="writepopupbtn_b">작성</button>
		    </div>
 	 </div>
</div>
<!-- 리뷰팝업 end -->	
</body>
</html>