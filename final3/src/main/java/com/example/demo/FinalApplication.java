package com.example.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication

@ComponentScan
@ComponentScan(basePackages = "final_project")
@ComponentScan(basePackages = "product")
@ComponentScan(basePackages = "upload")
@ComponentScan(basePackages = "securepayment")
@ComponentScan(basePackages = "chatbot")
@ComponentScan(basePackages = "member")
@ComponentScan(basePackages = "WebSocketChatting")
@ComponentScan(basePackages = "review")
@ComponentScan(basePackages = "likeinfo")

@MapperScan(basePackages = "final_project")
@MapperScan(basePackages = "product")
@MapperScan(basePackages = "upload")
@MapperScan(basePackages = "member")
@MapperScan(basePackages = "securepayment")
@MapperScan(basePackages = "WebSocketChatting")
@MapperScan(basePackages = "review")
@MapperScan(basePackages = "likeinfo")

public class FinalApplication {

	public static void main(String[] args) {
		SpringApplication.run(FinalApplication.class, args);
	}

}
