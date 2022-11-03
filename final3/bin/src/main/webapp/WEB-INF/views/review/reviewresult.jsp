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
	getUserOptionReview('all');
	location.href = "#tab1";
	$('.star_r span').css( 'width', $('#totalrating').val() * 10+'%' );
	
	// 구매자 / 판매자 별 후기 보여주기
	$('li').on('click',function(e){
		var clicktab = $(this).attr('id');
		
		if(clicktab == 'tab2'){ //해당 유저에 대한 구매자가 쓴 거래 후기
			getUserOptionReview('buyer');
		}else if(clicktab == 'tab3'){ //해당 유저에 대한 판매자가 쓴 거래 후기
			getUserOptionReview('seller');
		}else{
			getUserOptionReview('all');
		}
	}); //li click end
	

	function getUserOptionReview(role){
		$.ajax({
			url:'userreviewajax',
			data: {'review_target_num' : ${param.user_num },
					'reviewer_role'	: role
			},
			type:"get",
			dataType:'json',
			success:function(server){
				console.log(server);
				var str='';
				if(role == 'buyer'){
					for(let i=0;i<server.length-1;i++){
						str+='<div class="tabitem"><div class="tabitem_1"><span style="color:#fd7b6a;">★</span>'+server[i].review_rating+'<br></div>'+
						'<div class="tabitem_2">'+server[i].review_contents+'<div class="smalltextarea"><div class="smalltext" style="width: 10%;"><a href="userreview?user_num='+
								server[i].reviewer_num+'" id="small_link">'+server[i].user_id+'</a></div><div class="smalltext" style="width: 90%; text-align:right;">'+
								server[i].review_date+'</div></div></div></div>	';
					}
					$('#tab2 .tabCon').html(str);
				}
				else if(role == 'seller'){
					for(let i=0;i<server.length-1;i++){
						str+='<div class="tabitem"><div class="tabitem_1"><span style="color:#fd7b6a;">★</span>'+server[i].review_rating+'<br></div>'+
						'<div class="tabitem_2">'+server[i].review_contents+'<div class="smalltextarea"><div class="smalltext" style="width: 10%;"><a href="userreview?user_num='+
								server[i].reviewer_num+'" id="small_link">'+server[i].user_id+'</a></div><div class="smalltext" style="width: 90%; text-align:right;">'+
								server[i].review_date+'</div></div></div></div>	';
					}
					$('#tab3 .tabCon').html(str);
				}else{
					for(let i=0;i<server.length-1;i++){
						str+='<div class="tabitem"><div class="tabitem_1"><span style="color:#fd7b6a;">★</span>'+server[i].review_rating+'<br></div>'+
						'<div class="tabitem_2">'+server[i].review_contents+'<div class="smalltextarea"><div class="smalltext" style="width: 10%;"><a href="userreview?user_num='+
								server[i].reviewer_num+'" id="small_link">'+server[i].user_id+'</a></div><div class="smalltext" style="width: 90%; text-align:right;">'+
								server[i].review_date+'</div></div></div></div>	';
					}
					$('#tab1 .tabCon').html(str);
				}
				$('#review_target_id').html(server[server.length-1].review_target_id);
				$('#tradeCount').html('받은 거래 후기('+(server.length-1)+')');	
				var avg_rating = parseFloat(server[server.length-1].review_rating_avg);
				$('#avg').html(avg_rating);
				$('#totalrating').val(avg_rating*2);
				$('.star_r span').css( 'width', $('#totalrating').val() * 10+'%' );
			}//success end
		}); //ajax end	
	};
});//ready end
</script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400&display=swap');
*{
font-family: 'Nanum Gothic', sans-serif;
  margin:0; padding:0;
  font-size:15px; 
  line-height:1.3;
  margin:0 auto;
  
}
#reviewresultform{
	position: relative;
	display: flex;
	flex-flow: column;
	text-align:center;
	border: 1px solid black;
	min-height: 65vh;
	padding : 10px 20px 20px 20px;
	width: 600px;
	border-radius: 8px;
}
#reviewresultitem1{
	position: relative;
	display: flex;
	flex-flow:column;
	border-bottom: 1px solid black;
	margin-bottom: 20px;
	min-height: 100px;
	width: 100%;
}
#reviewresultitem2{
	position: relative;
	display:flex;
	flex-flow:column;
}
#reviewresultdetailitem{
	display: block;
}
ul{list-style:none;}

.tabmenu{ 
  width:550px; 
  margin: 0 auto; 
  position:relative; 
}
.tabmenu ul li{
  display:  inline-block;
  width:33.33%; 
  float:left;  
  text-align:center; 
  background :#f9f9f9;
  border-radius: 8px 8px 0 0;
}
.tabmenu ul li a{
  display:block;
  line-height:40px;
  height:40px;
  text-decoration:none; 
  color: #000;
}
.tabCon{
  display:none; 
  text-align:left; 
  padding: 20px;
  width:100%;
  height:300px;
  position:absolute; 
  left:0; top:40px; 
  box-sizing: border-box; 
  border : 5px solid #f9f9f9;
  border-top:none;
  border-radius: 0 0 8px 8px;
}
.tabitem{
	position: relative;
	display: flex;
	flex-flow: row;
	align-items:flex-start;
	border-bottom: 2px solid rgb(220,220,220);
	padding-top: 10px;
}
.tabitem_1{
	width: 8%;
}
.tabitem_2{
	width: 85%;
}
.btnCon:target  {
  background : #ccc;
}
.btnCon:target .tabCon{
  display: block;
}
/* 평점 별 */
.star_r {
    position: relative;
    font-size: 2rem;
    color: #ddd;
 }
  
  .star_r input {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    opacity: 0;
    cursor: pointer;
  }
  
  .star_r span {
    /* width: 0; */
   	position: absolute;
   	font-size: 2rem;
    left: 0;
    color: #fd746c;
    overflow: hidden;
    pointer-events: none;
  }
  .profiletitle{
  	width:100%;
  	text-align:left;
  	font-size: 22px;
  	font-weight: 1000;
  }
  .smalltextarea{
  	display: flex;
    position: relative;
    flex-flow:row;
    align-items: center;
    height:20px;
    text-align:left;
    margin-top:5px;
    margin-bottom:5px;
  }
  .smalltext,  #small_link{
  	font-size: 12px; 
  	color:rgb(200,200,200);
  	width: 200px;
  }
  .smalltextarea #small_link:hover{
  	color: rgb(150,150,150);
  	text-decoration: underline;
  }
</style>
</head>
<body>
<jsp:include page="../template/header.jsp" flush="true"/>
<div id="reviewresultform">
	<div id="reviewresultitem1">
		<div class ="profiletitle">
		<span style="color:#5C75E6; font-size: 22px;" id="review_target_id"></span>님의 프로필
		</div>
		<div id="reviewresultdetailitem">
			거래 후기 평점 : 
			<span class="star_r"> ★★★★★
			   <span>★★★★★</span>
	 			<input type="range" id="totalrating" value="" step="1" min="0" max="10" readonly="readonly">
			</span> (<span id="avg">${avg.review_rating_avg }</span> / 5.0)	
		</div>
	</div>
	<div id="reviewresultitem2">
		<div class ="profiletitle" id="tradeCount" style="font-size: 16px; margin-bottom:3px;">받은 거래 후기(${reviewlist.size() })</div>
		
		 <div class="tabmenu">
		  <ul>
		    <li id="tab1" class="btnCon"><a class="btn first" href="#tab1">전체후기</a>
				 <div class="tabCon" style="overflow-y: scroll;">
				<c:forEach items="${reviewlist }" var="r">
					<div class="tabitem">
						<div class="tabitem_1"><span style="color:#fd7b6a;">★</span> ${r.review_rating }<br></div>
						<div class="tabitem_2">${r.review_contents }
							<div class="smalltextarea">
								<div class="smalltext" style="width: 10%;"><a href="userreview?user_num=${r.user_num }" id="small_link">${r.user_id }</a></div>
								<div class="smalltext" style="width: 90%; text-align:right;">${r.review_date }</div>
							</div>
						</div>	
					</div>
				</c:forEach>
				</div>
		    </li>
		    <li id="tab2" class="btnCon"><a class="btn first" href="#tab2">구매자 후기</a>
		    	 <div class="tabCon" style="overflow-y: scroll;"></div>
		    </li>
		     <li id="tab3" class="btnCon"><a class="btn first" href="#tab3">판매자 후기</a>
		     	<div class="tabCon" style="overflow-y: scroll;"></div>
		     </li>
  		</ul>
</div>
	</div>
</div>
</body>
</html>