<%@page import="product.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시세그래프 확인</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script>
$(document).ready(function(){
	var mydata= new Array();

	
	var quotefilterajax = function(){
		
		var data = {'detail_num' : ${param.detail_num}, 
				'product_status1' : $("#product_status1 option:selected").val(),
				'product_status2' : $("#product_status2 option:selected").val(),
				'product_status3' : $("#product_status3 option:selected").val(),
				'product_status5' : $("#product_status5 option:selected").val(),
				'product_status4' : $("#product_status4 option:selected").val(),
				'product_time' : $("#period option:selected").val(),	
				};
		
		$.ajax({
			url:'quotefilterajax',
			data: data,
			type:"get",
			dataType:'json',
			success:function(server){
				if(server.length==0){
					$('#chart_div').html('등록된 데이터가 없습니다.');
				}
				else{
					var str;
					var str_title ='last '+$("#period option:selected").val()+' months';
					var str_x_title ;
					var str_color;
					var avg=0;
					if($("#period option:selected").val()<7){
						str = '일';
						str_x_title = 'Day';
						str_color = '#ffbda7';
					}else{
						str = '월';
						str_x_title = 'Month';
						str_color = '#a561bd';
					}
					 mydata.splice(0);
					 mydata.push([str_title , '시세'],['',0]);
					 
					for(var i=0;i<server.length;i++){
						var s = server[i].product_time.substring(5)+str;
						avg = avg + Number(server[i].product_price);
						s = s.replace('-', '/');
						if(s[0]=='0'){
							s = s.substring(1);
						}
						mydata.push([ s, server[i].product_price ]);
					}	    
					//console.log(avg);		
					avg/=server.length;
					avg = parseInt(avg);
					avg = avg.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
					$('#avg_div').html('최근 '+$("#period option:selected").val()+'달간 판매 가격 평균은 '+avg+'원 입니다.');
					
						  google.charts.load('current', {'packages':['corechart']});
						    google.charts.setOnLoadCallback(drawChart);  
						  	  
						    function drawChart() {
						  	  var data = google.visualization.arrayToDataTable(mydata);
						  	
						     
						      var options = {
						        title: str_title,
						        
						        hAxis: {title: str_x_title,  titleTextStyle: {color: '#333'}},
						        vAxis: {minValue: 0},
						        series: {
						            0: { color: str_color }
						          }
						      };
	
						      var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
						      chart.draw(data, options);
						    }
				}//else end
			}//success end
		}); //ajax end	
	};

	quotefilterajax();
	
	$('.filter').on('change',function(){
		quotefilterajax();
	})
	
	$('#resetbtn').on('click',function(){
		/* $('#period').prop('selectedIndex',0); */
		$('#product_status1').prop('selectedIndex',0);
		$('#product_status2').prop('selectedIndex',0);
		$('#product_status3').prop('selectedIndex',0);
		$('#product_status4').prop('selectedIndex',0);
		$('#product_status5').prop('selectedIndex',0);
		quotefilterajax();
	});
  
});//ready end
</script>
<style>
#quoteform{
}

select{
	height: 25px;
	border : 2px solid rgb(92, 117, 230,0.3);
	border-radius: 8px;
}
</style>
</head>
<body>
<div id="quoteform">
<div>
<select name="product_time" id="period" class="filter">
	<option value="12" selected="selected">최근 일년</option>
	<option value="10" >최근 10개월</option>
	<option value="8">최근 8개월</option>
	<option value="6">최근 6개월</option>
	<option value="3">최근 3개월</option>
	<option value="2">최근 2개월</option>
	<option value="1">최근 1개월</option>
</select>
<select name="product_status4"  id="product_status4"  class="filter">
	<option value='' selected="selected">상품 상태</option>
	<option value="좋음">상태 좋음</option>
	<option value="보통">상태 보통</option>
	<option value="나쁨">상태 나쁨</option>
</select>
<select name="product_status1"  id="product_status1"  class="filter">
	<option value="-1" selected="selected">개봉/미개봉</option>
	<option value='1'>개봉</option>
	<option value=0>미개봉</option>
</select>
<select name="product_status2"  id="product_status2"  class="filter">
	<option value="-1" >공식/비공식</option>
	<option value="1">공식</option>
	<option value="0">비공식</option>
</select>
<select name="product_status3"  id="product_status3"  class="filter">
	<option value="-1">단종 여부</option>
	<option value="1">단종</option>
	<option value="0">단종품X</option>
</select>
<select name="product_status5"  id="product_status5"  class="filter">
	<option value="-1">구성품 포함 여부</option>
	<option value="1">구성품 전부 포함</option>
	<option value="0">구성품 미포함</option>
</select>
<button id="resetbtn">리셋</button>
</div>
<!--   - product_status1 TINYINT - 개봉 1/ 미개봉0
- product_status2 TINYINT - 공식 1/ 비공식 0
- product_status3 TINYINT - 단종 1/ 노단종 0
- product_status4 Varchar(4) - 상품 상태  {‘좋음’, ‘보통’, ‘나쁨’ }
- product_status5 TINYINT - 공식 1/ 비공식 0 -->
<div id="chart_div" style="width: 70%; height: 500px;"></div>
<div id="avg_div"></div>
</div>
</body>
</html>