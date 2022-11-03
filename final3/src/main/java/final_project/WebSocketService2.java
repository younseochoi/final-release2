package final_project;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Service;

@Service
@ServerEndpoint(value="/chat")
public class WebSocketService2 {
	
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	// 클라이언트의 세션 정보를 저장하기 위한 설정?
	
	@OnOpen
	public void onOpen(Session s) {
		
		System.out.println("open session : " + s.toString());
		if(!clients.contains(s)) {
			clients.add(s);
			System.out.println("session open : " + s);
		}else {
			System.out.println("이미 연결된 session 임!!!");
		}
	}
	// 채팅방에 접속할 때 클라이언트 정보를 session으로 전달받고, 정적 필드인 clients에
	// 해당 session이 존재하지 않으면 clients에 해당 session을 추가함
	
	@OnMessage
	public void onMessage(String msg, Session session) throws Exception {
		
		System.out.println("receive message : " + msg);
		for(Session s : clients) {
			System.out.println("send data : " + msg);
			s.getBasicRemote().sendText(msg);
		}
	}
	// 메세지를 보낼 때 clients에 있는 모든 session에 메세지를 전달함.
	// 모든 세션에 보내야 하므로 반복문 사용
	
	@OnClose
	public void onClose(Session s) {
		System.out.println("session close : " + s);
		clients.remove(s);
	}
	// 채팅방을 나갈 때, clients에서 해당 유저의 session 정보를 삭제함
}
