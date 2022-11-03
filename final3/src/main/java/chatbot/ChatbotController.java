package chatbot;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import product.ProductDTO;
import product.ProductService;

@Controller
public class ChatbotController {

	@Autowired
	@Qualifier("chatbotservice")
	ChatbotService chatbotService;
	
	@Autowired
	@Qualifier("productservice")
	ProductService pdtService;
	
	@RequestMapping("/chatbotform")
	public String getChatbotForm() {
		return "chatbot/chatbotform";
	}
	
	@RequestMapping("/chatbotresultajax")
	@ResponseBody
	public String getChatbotResult(String request,String event) {
		System.out.println(request+" : "+event);
		String response = "";
		if(event.equals("input_message")) {
			response = ((ChatbotService)chatbotService).test(request, "send");
		}
		else { //웰컴 메시지
			response = chatbotService.test(request);
		}
		return response;
	}
	
	@RequestMapping("/forsale")
	@ResponseBody
	public List<String> getforSale(String idol_name,String category_name) {
		System.out.println(idol_name+category_name);
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("idol_name", idol_name);
		map.put("category_name",category_name);
		List<String> result = pdtService.getforSale(map);
			
		return result;
	}
	
	@RequestMapping("/quotecheck")
	@ResponseBody
	public List<ProductDTO> quoteCheck(String detail_name) {
		List<ProductDTO> filterlist = null;
		String[] split_str = detail_name.split("시세");
		System.out.println(split_str[0]);
		//split_str[0]가 detail_name 이다. 최근 한달의 시세를 보여주자
		ProductDTO dto = new ProductDTO();
		dto.setProduct_time("1");
		dto.setProduct_status1(-1);
		dto.setProduct_status2(-1);
		dto.setProduct_status3(-1);
		dto.setProduct_status4("");
		dto.setProduct_status5(-1);
		String detail_name_str = "%"+split_str[0].substring(0, split_str[0].length() - 1)+"%";
		int detail_num = pdtService.getProductDetailNum(detail_name_str);
		if(detail_num!=0) {
			dto.setDetail_num(detail_num);
			filterlist = pdtService.getQuoteFilter(dto);
		}
		//split_str[0]로 시세 찾아 리턴해주는 모듈 연결 - 완료
		return filterlist;
	}
}
