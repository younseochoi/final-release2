<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- 상단바 업데이트 소식 추가 - 윤서 -->

<link href="/css/font.css" rel="stylesheet">
<script>
$(document).ready(function(){
	alarm();
	 $('#news').on('click',function(e){
	    	e.preventDefault();
	    	if($('#newsbox').css('display')=='none'){
		    	$('#newsbox').css('display','');
		    	alarm();
		
	    	}else{
	    		$('#newsbox').css('display','none');
	    	}
	    });
	 
	 // update된 구매확정 글 가져옴
	 function alarm(){
		 $.ajax({
				url: "getSaleslist",
				type:	"post",
				dataType: "json", //결과 타입
				success: function(server){
					$('#newsinnerbox').html('');
					if(server.length==0){
						$('.circle').css('display','none');
						$('#newsinnerbox').append('<div id="newsitem"> 업데이트된 소식이 없습니다. </div>');
					}else{
						$('.circle').css('display','');
						for(var i = 0 ; i< server.length;i++){
							$('#newsinnerbox').append('<div id="newsitem">'+server[i].product_title+'의 거래가 확정되었습니다. <button id="openpop" value="'+server[i].product_num+'">리뷰쓰기</button></div>');
						}
							openpop();
						
					}
				}//success end
			});//ajax end
	 }; //alarm function end 
	 
	const popup = $('#popup');
	var product_num=0;
	var openpop = function() {
		$('#openpop').on('click',function(e){
				product_num=$(this).val();
	    		$('#popup').css('display','');
	    		popup.removeClass('hide');
	    		popup.addClass('has-filter');
	    		if (popup.hasClass('has-filter')) {
	    		  	popup.addClass('has-filter');
	    		  } else {
	    		  	popup.removeClass('has-filter');
	    		  }
	    		
	    	
	    });
	};
	
	    $('#closepopupbtn').on('click',function(e){
	    	e.preventDefault();
	    	popup.removeClass('has-filter');
    		popup.addClass('hide');
	    });
	
	
	    $('#writepopupbtn').on('click',function(e){
	    	alert(product_num);
	    	$.ajax({
				url: "insertreviewajax",
				type:	"post",
				data: {'review_num' : product_num,
					'review_contents' : $('#review_contents').val(),
					'review_rating' : $('#drawStar').val(),
					'reviewer_role' : 'seller'
				},
				dataType: "json", //결과 타입
				success: function(server){
					if(server.result=='success'){
						alert('성공적으로 등록되었습니다.');
						popup.removeClass('has-filter');
			    		popup.addClass('hide');
					}
				}//success end
			});//ajax end
	    });
	
	    $('#drawStar').on('change',function(e){
			 $('.star span').css( 'width', $(this).val() * 10+'%' );
		});
});//ready end
</script>
<!-- 상단바 업데이트 소식 end -->

	<style>
        .header {
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            background-color: #fff;
        }

        .main_inner {
            display: flex;
            padding: 0 40px;
            height: 68px;
            min-width: 320px;
            -webkit-box-align: center;
            align-items: center;
        }

        .top_inner {
            display: flex;
            padding: 8px 40px;
            border-bottom: 1px solid #cbd3da;
        }

        .top_list {
            display: flex;
            -webkit-box-align: center;
            align-items: center;
            margin-left: auto;
            margin-top: 0;
            margin-bottom: 0;
        }

        .gnb_area {
            display: flex;
            -webkit-box-align: center;
            align-items: center;
            margin-left: auto;
        }

        .gnb_list {
            display: flex;
            position:relative;
            -webkit-box-align: center;
            align-items: center;
        }

        li {
            list-style: none;
        }

        a {
            text-decoration: none;
            color: gray;
        }

        .ml-15 {
            margin-left: 15px;
        }
        
        .search_area {
        	margin-right: 300px;
        }
        /* 윤서 추가 css */
         #newsbox{
        	position:absolute;
        	align-content:flex-end;
        	right:0;
        	display:flex;
        	justify-content:flex-end;
        	width: 20%;
        	/* border:1px solid black; */
        	
        } 
        #newsbox #newsinnerbox{
        	position:relative;
        	/* width: 300px; */
        	max-height: 300px;
        	margin-right: 10px; 
        	z-index: 1;
        	/* border: 1px solid black;  */
        	animation: fadeInDown 0.7s;
        	
        }
        #newsbox #newsinnerbox #newsitem{
        	height: 70px;
        	/* border: 1px solid black; */
        	border-radius:8px;
        	background-color: rgb(220,220,220);
        	border : 2px solid rgb(190,190,190);
        	padding :10px;
        }
        @keyframes fadeInDown {
	        0% {
	            opacity: 0;
	            transform: translate3d(0, -100%, 0);
	        }
	        50% {
	        	opacity: 0;
	        	 transform: translate3d(0, -50%, 0);
	        }
	        100% {
	            opacity: 1;
	            transform: translateZ(0);
	        }
		}
		/* 팝업창  */
#popup {
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

#popup.hide {
  display: none;
}

#popup.has-filter {
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
}

#popup .content {
	width:450px;
 	 padding: 20px;
 	 background: #fff;
 	 border-radius: 5px;
 	 box-shadow: 1px 1px 3px rgba(0, 0, 0, .3);
 	 text-align: center;
}
#popup .termstitle{
	font-weight: 700;
	font-size: 18px;
	margin-bottom: 15px;
	
}
#popup .termscontent{
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
.star {
    position: relative;
    font-size: 3rem;
    color: #ddd;
  }
  
  .star input {
    width: 100%;
    height: 20px;
    position: absolute;
    left: 0;
    bottom:2px;
	opacity: 0;
    cursor: pointer;
  }
  
  .star span {
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
.circle{
	position:absolute;
	margin-left:27px;
	bottom:12px;
	width:4px;
	height: 4px;
	background-color: red;
	border-radius: 50%;
}
    </style>
</head>
<body>
<div class="header lg">
    <div class="header_top">
        <div class="top_inner">
            <ul class="top_list">
                <li class="top_item"><a href="/my" class="top_link">마이페이지</a></li>
                <li class="top_item ml-15"><a href="loginform" class="top_link">로그인</a></li>
            </ul>
        </div>
    </div>
    <div class="header_main">
        <div class="main_inner">
            <div>
                <img alt="header logo" src="/serverimg/logo2.png" style="width:70px; height:70px;">
            </div>
            <div class="gnb_area">
                <div class="search_area">
                    <div class="search">
                        <input type="text" placeholder="" title="검색창" class="input_search show_placeholder_on_focus">
                    </div>
                </div>
            
                <nav class="gnb">
                    <ul class="gnb_list">
                        <li class="gnb_item"><a href="getsalesform" class="gnb_link ml-15">판매등록</a></li>
                        <li class="gnb_item"><a href="#" class="gnb_link ml-15" id="news"><img alt="알림" src="/serverimg/alarmicon.png" width="15px" height="15px"></a><div class="circle" style="display:none;"></div></li>
                    </ul>
                </nav>
            </div>
        </div>
                   <div id="newsbox" style="display: none; ">
                   	<div id="newsinnerbox" style="overflow-y: scroll;" >
                   		<div id="newsitem">구매완료 확인 알람 띄울 거임!</div>
                   		
                   	</div>
                   </div>
    </div>
</div>
<!-- 리뷰 팝업 -->
<div id="popup" style="display: none;">
		<div class="content" style="overflow-y: scroll; height:550px;">
	    	<p style="font-size: 16px; font-weight: 500;"></p>
	    	<div>
		    	 <div class="termstitle">이번 거래는 어떠셨나요? 거래에 대한 후기를 남겨주세요!</div>
		    	 <div class="termscontent">
		    	 <span class="star"> ★★★★★
		    	 	<span>★★★★★</span>
 				 	<input type="range" style="background-color:pink;" id="drawStar" value="1" step="1" min="0" max="10" name="review_rating">
				 </span>
		    		<textarea rows="15" style="width:100%; margin-top:20px;" id="review_contents" name="review_contents"></textarea>
		    	</div>
				<!-- 구매자 후기 썼을 때 넘어가야하는 데이터 : user_num(현재 로그인 아이디), product_num, 평점, 리뷰내용 -->
				<!-- 판매자 후기 썼을 때 넘어가야하는 데이터 : user_num(현재 로그인 아이디), 구매자 user_num, 평점, 리뷰내용 -->
	    	</div> <!-- inner -->
		    <div id="popupbtnarea" style="text-align: center;">
				<button class="popupbtn" id="closepopupbtn" >다음에 쓰기</button>		    
		    	<button class="popupbtn" id="writepopupbtn">작성</button>
		    </div>
 	 </div>
</div>
<!-- 리뷰팝업 end -->	
</body>
</html>