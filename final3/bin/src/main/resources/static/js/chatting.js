	var ws;
	
	$(document).ready(function() {
		var userName = $("#userName").val();
		wsOpen();
		$.ajax({
			url : 'http://localhost:8092/final/'+$("#roomNumber").val()+'.json',
			dataType : 'json',
			success : function(e) {
				
				for(var i=0; i<e.length; i++) {
					
					if($("#sessionUser_num").val() == e[i]["sessionUser_num"]) {
						$("#chating").append("<p class='me'>나 :" + e[i]["msg"] + "</p>");
						}
					else {
						$("#chating").append("<p class='others'>" + e[i]["userName"] + " :" + e[i]["msg"] + "</p>");
					}
					
				}
			}
		});		
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
						$("#chating").append("<p class='me'>나 :" + d.msg + "</p>");	
					}
					else{
						$("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
					}
						
				}
				else{
					console.warn("unknown type!")
				}
			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
	}

	function send() {
		
		var option ={
			type: "message",
			roomNumber: $("#roomNumber").val(),
			sessionUser_num : $("#sessionUser_num").val(),
			userName : $("#userName").val(),
			msg : $("#chatting").val()
		}
		ws.send(JSON.stringify(option))
		$('#chatting').val("");
		
	}