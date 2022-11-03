package com.example.demo;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

@Component
public class WebSocket_config implements WebSocketMessageBrokerConfigurer {

	@Bean
	public ServerEndpointExporter serverEndpointExporter() {
		
		return new ServerEndpointExporter();
	}
	
	// @ServerEndpoint 어노테이션이 달린 클래스(WebSocket.java)들은 웹소켓이 생성될 때마다
	// 인스턴스가 생성되고 JWA에 의해 관리되기 때문에 @Autowired가 설정된 멤버들이 정상적으로 초기화 되지 않음
	// 이를 해결하기 위한 config ??
	

}
