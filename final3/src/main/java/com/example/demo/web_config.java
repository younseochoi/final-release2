package com.example.demo;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class web_config implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		// 저는 맥이라 경로가 저런데 윈도우이신 분들은 수정하셔야할 것 같습니다. c://images/ 
		registry.addResourceHandler("/css/**").addResourceLocations("classpath:/static/css/"); 
		registry.addResourceHandler("/serverimg/**").addResourceLocations("classpath:/static/images/"); 
		registry.addResourceHandler("/images/**").addResourceLocations("/root/final_images/"); 
		registry.addResourceHandler("/final/**").addResourceLocations("file:///"+NaverInform.path);
		// file: ~~ 경로에 있는걸(이미지 등) 호출하는 URL은 8092/final/~~~ 이다.
	
	}
	
	// 외부 경로에 저장된 파일 불러오기

}
