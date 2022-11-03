	var ws;
	
	$(document).ready(function() {
//		var userName = $("#buyer_name").val();
		wsOpen();
		$.ajax({
			url : '/final/'+$("#roomNumber").val()+'.json',
			dataType : 'json',
			success : function(e) {
				
				for(var i=0; i<e.length; i++) {
					
					
					if($("#sessionUser_num").val() == e[i]["sessionUser_num"]) {
						$(".div1").append("<div class='div2'><div class='me'><div class='chat'>"+e[i]["msg"]+"</div></div><div class='my-time'>"+e[i]["time"]+"</div></div>");
					}
					else if (e[i]["userName"] == "SYSTEM") {
						$(".div1").append("<div class='system' id='system-msg'>채팅 시작 날짜 : "+e[i]["time"]+"</div>");
					}
					else {
						$(".div1").append("<div class='div2'><div class='you'><div class='chat'>"+e[i]["msg"]+"</div></div><div class='your-time'>"+e[i]["time"]+"</div></div>");
					}
					
				}
				
				$(".div1").scrollTop($('.div1')[0].scrollHeight);
			}
		});
		
		if($("#buyer_num").val() == $("#sessionUser_num").val()) {
			$("#title").html("<a href='aa' id='other'>"+$("#seller_name").val()+"</a> 님과의 채팅");
		}
		// 구매자 입장
		else {
			$("#title").html("<a href='aa' id='other'>"+$("#buyer_name").val()+"</a> 님과의 채팅");
		}
		// 판매자 입장
		
	});
	
	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
		wsEvt();
	}
		
	function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 동작
		}
		
		ws.onmessage = function(data) {
			//메시지를 받으면 동작
			var msg = data.data;
			if(msg != null && msg.trim() != ''){
				var d = JSON.parse(msg);
				if(d.type == "getId"){
					var si = d.sessionId != null ? d.sessionId : "";
					if(si != ''){
						$("#sessionId").val(si); 
					}
				}
				else if(d.type == "message"){
					
					if(d.sessionId == $("#sessionId").val()){
						$(".div1").append("<div class='div2'><div class='me'><div class='chat'>"+d.msg+"</div></div><div class='my-time'>"+d.time+"</div></div>");
					}
					else{
						$(".div1").append("<div class='div2'><div class='you'><div class='chat'>"+d.msg+"</div></div><div class='your-time'>"+d.time+"</div></div>");
					}
						
				}
				else{
					console.warn("unknown type!")
				}
				
				$(".div1").scrollTop($('.div1')[0].scrollHeight);

			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
	}

	function send() {

		var option = {
			type: "message",
			roomNumber: $("#roomNumber").val(),
			sessionUser_num : $("#sessionUser_num").val(),
			userName : $("#userName").val(),
			msg : $("#chatting").val(),
			time : $("#time").val()
		}
		
		ws.send(JSON.stringify(option));
		
		$('#chatting').val("");
		
	}