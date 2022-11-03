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
	
	if("${sessionUser_num}" == "") {
		window.location.replace("temp_mainpage");
	}
	// 오랜시간이 지나서 자동으로 로그아웃시 메인페이지로
	
	/* const drawStar = (target) => {
		  $('.star span').css({ width: '${target.value * 10}%' });
		} ; */
	$('#drawStar').on('change',function(e){
		 $('.star span').css( 'width', $(this).val() * 10+'%' );
	});
	 $('#openpop').on('click',function(e){
	    	e.preventDefault();
	    	
	    		$('#popup').css('display','');
	    		//$(this).val('true');
	    		popup.classList.remove('hide');
	    		popup.classList.add('has-filter');
	    		if (hasFilter) {
	    		  	popup.classList.add('has-filter');
	    		  } else {
	    		  	popup.classList.remove('has-filter');
	    		  }
	    		
	    	
	    });
	    $('#closepopupbtn').on('click',function(e){
	    	e.preventDefault();
	    	popup.classList.remove('has-filter');
	    	popup.classList.add('hide');
	    	alert(clickbtn);
	    });
	    
	/* const drawStar = (target) => {
		  $('.star span').css({ width: '${target.value * 10}%' });
		} */
});//ready end
</script>
<style>
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
    font-size: 2rem;
    color: #ddd;
  }
  
  .star input {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
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
#closepopupbtn{
 	width: 120px;
 	height: 35px;
 	border-radius: 8px;
	background-color: #5C75E6;
	color: white;
} 
#closepopupbtn:hover{
	
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
<% String clickbtn = (String) request.getParameter("clickbtn");%>
<!-- <div id="popup" style="display: none;" > -->

<div id="popup">
		<div class="content" style="overflow-y: scroll; height:550px;">
	    	<p style="font-size: 16px; font-weight: 500;"></p>
	    	<div>
		    	 <div class="termstitle">이번 거래는 어떠셨나요? 거래에 대한 후기를 남겨주세요!</div>
		    	 <div class="termscontent">
		    	 <span class="star"> ★★★★★
		    	 	<span>★★★★★</span>
 				 	<input type="range" id="drawStar" value="1" step="1" min="0" max="10">
				 </span>
		    		<textarea rows="15" style="width:100%; margin-top:20px;"></textarea>
		    	</div>
				<!-- 구매자 후기 썼을 때 넘어가야하는 데이터 : user_num(현재 로그인 아이디), product_num, 평점, 리뷰내용 -->
				<!-- 판매자 후기 썼을 때 넘어가야하는 데이터 : user_num(현재 로그인 아이디), 구매자 user_num, 평점, 리뷰내용 -->
	    	</div> <!-- inner -->
		    <div id="popupbtnarea" style="text-align: center;"><button id="closepopupbtn">작성</button>
		    	<button id="closepopupbtn" onclick="closePopup()">다음에 쓰기</button>
		    </div>
 	 </div>
	</div>	


</body>
</html>