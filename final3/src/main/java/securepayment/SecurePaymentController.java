package securepayment;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import final_project.AuctionService;
import product.ProductDTO;
import product.ProductService;
import upload.UploadService;

@Controller
public class SecurePaymentController {
	
	@Autowired
	@Qualifier("productservice")
	ProductService productService;
	
	@Autowired
	@Qualifier("uploadservice")
	UploadService uploadService;
	
	@Autowired
	@Qualifier("securepaymentservice")
	SecurePaymentService securePaymentService;
	
	@Autowired
	@Qualifier("auctionservice")
	AuctionService auction_service;
	
	@RequestMapping("/getsecurepaymentform")
	public ModelAndView getPaymentForm(int product_num, HttpServletRequest request){
		HttpSession session = request.getSession();
		ModelAndView mv= new ModelAndView();
		int userMoney = 0;
		if(session.getAttribute("sessionUser_num")!=null) {
			int user_num = (int) session.getAttribute("sessionUser_num");
			userMoney = securePaymentService.getUserMoney(user_num);
		}
		System.out.println(product_num);
		//상품 하나 가져오는 모듈 써서 상품 정보 모델로 보내줄 것
		ProductDTO dto = securePaymentService.getProductOne(product_num);
		List<String> imagepath = auction_service.imagepath(product_num);
		System.out.println(dto);
		//지금은 임시 상품 모델
		//ProductDTO dto = new ProductDTO();
		//dto.setProduct_price(10000);
		//dto.setProduct_title("bts 스픽콘 부채");
		//String product_image = "/images/"+dto.getImage_path();
		mv.addObject("productdto",dto);
		mv.addObject("user_money", userMoney);
		if(imagepath.size()!=0) mv.addObject("image_path", "/images/"+imagepath.get(0));
		else mv.addObject("image_path", "/serverimg/logo.png");
		mv.setViewName("securepayment/securepaymentform");
		return mv;
	}
	
	@RequestMapping("/securepaymentprocess")
	public String securePaymentProcess(SecurePaymentDTO dto, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		int user_num = (int) session.getAttribute("sessionUser_num");
			
		dto.setUser_num(user_num);
		System.out.println(dto);
		int insert_result = securePaymentService.securePaymentProcess(dto);
		if(insert_result>0) {
			//해당유저 보유머니 - 결제 금액
			int insert_result2 = securePaymentService.minusUserMoney(dto);
			ProductDTO pdtdto = new ProductDTO();
			pdtdto.setUser_num(user_num);
			pdtdto.setProduct_num(dto.getProduct_num());
			productService.updateBuyerNum(pdtdto);
			int[] num = new int[]{3, dto.getProduct_num()}; //결제중 3
			securePaymentService.updateProductSell2(num);
		}
		//redirect 경로 설정 필요
		return "redirect:/getproducts";
	}
	
	@RequestMapping("/getbillingnumform")
	public ModelAndView getBillingnumForm() {
		int user_num=1;
		List<Map<String,String>> sellinglist = securePaymentService.getMyProduct(user_num);
		ModelAndView mv= new ModelAndView();
		mv.addObject("sellinglist", sellinglist);
		mv.setViewName( "securepayment/seller");
		return mv;
		//ajax로 구현할거라 product_num은 ajax로 넘겨받음
	}
	
	// 운송장 번호 등록
	@ResponseBody
	@RequestMapping(value = "/registerbillingnumber", produces= {"application/json;charset=utf-8"})
	public String registerBillingNumber(String billing_number,int product_num){
		
		System.out.println(billing_number);
		System.out.println(product_num);
		ProductDTO dto = new ProductDTO();
		dto.setBilling_number(billing_number);
		dto.setProduct_num(product_num);
		//product_info billing_number에 입력받은 billing_number로 바꿈
		int insert_result = securePaymentService.registerBillingNumber(dto);
		
		if(insert_result>0) { //payment_info seller_check true로 바꿈
			int[] num = new int[]{4, dto.getProduct_num()}; //운송장등록시 상태  4
			securePaymentService.updateProductSell2(num);
			//user_num과 product_num이 같은 곳 seller_chekc true로 update
			SecurePaymentDTO securepaymentdto = new SecurePaymentDTO();
			securepaymentdto.setProduct_num(product_num);
			//securepaymentdto.setUser_num(2); // 로그인 완성시 세션으로 user_num찾아올 것 이거 잘못했다. user_num은 구매자임
			
			int insert_result2 = securePaymentService.updateSellerCheck(product_num);
			//성공적으로 업데이트 시 구매자 구매확인 버튼 활성화 되어야함. 
			if(insert_result2>0) {
				return "{\"result\" : \"success\"}";
			}
		}
		return "{\"result\" : \"fail\"}";
	}

	//구매자 - 구매 목록확인에서 각 상품별 구매버튼이 활성화 되있거나 안되어있는 상태다. 결제 DTO의 리스트를 뿌려주는 상태일것임
	@RequestMapping("/confirmpurchase")
	@ResponseBody
	public String updateBuyerCheck(int product_num, HttpServletRequest request){
		HttpSession session = request.getSession();
		int user_num = 0;
		if(session.getAttribute("sessionUser_num")!=null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		
		System.out.println("구매 목록 - pdtnum"+product_num);
		SecurePaymentDTO dto = new SecurePaymentDTO();
		dto.setUser_num(user_num);
		dto.setProduct_num(product_num);
		//payment_info buyer_check now() 업데이트 시켜주고
		securePaymentService.updateBuyerCheck(dto);
		int[] num = new int[]{1, product_num}; //
		securePaymentService.updateProductSell2(num);
		// product_info product_sell true로 업뎃 시켜줌 
		// productService로하는게 나은지 ..?
		//판매자에게 돈 넣어줌
		ProductDTO pdtdto = securePaymentService.getProductOne(product_num);
		securePaymentService.updateSellerMoney(pdtdto);
		int result = securePaymentService.updateProductSell(product_num);
		if(result>0) {
			return "{\"result\" : \"success\"}";
		}
		return "{\"result\" : \"fail\"}";
	}
	
	@RequestMapping("/getpurchaselist")
	public ModelAndView getPurchaselist( HttpServletRequest request){
		HttpSession session = request.getSession();
		int user_num = 0;
		if(session.getAttribute("sessionUser_num")!=null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		//구매자 로그인 세션으로 user_num가져 올 것''
		// 구매상품의 운송장등록 기간이 3일을 넘겼다 -> 환불 버튼 띄워줌 
		//버튼이 운송장등록 3일지나 환불받기 버튼 떠있다 
		List<Map<String,String>> purchaselist = securePaymentService.getPurchaselist(user_num);
		ModelAndView mv= new ModelAndView();
		mv.addObject("purchaselist", purchaselist);
		mv.setViewName("securepayment/buyer");
		return mv;
	}
	
	@RequestMapping("/refund")
	@ResponseBody
	public String refund(int pay_price,int product_num, HttpServletRequest request){
		HttpSession session = request.getSession();
		int user_num = 0;
		if(session.getAttribute("sessionUser_num")!=null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		System.out.println(pay_price+" 넘버"+product_num);
		//지금 로그인되어있는 user_num 세션으로 받아옴
		SecurePaymentDTO dto = new SecurePaymentDTO();
		dto.setPay_price(pay_price);
		dto.setUser_num(user_num);
		int update_result = securePaymentService.refund(dto);
		int[] num = new int[]{0, product_num}; //
		securePaymentService.updateProductSell2(num);
		if(update_result>0) {
			return "{\"result\" : \"success\"}";
		}
		return "{\"result\" : \"fail\"}";
		
	}
	
	@RequestMapping(value="/depositseller", produces= {"application/json;charset=utf-8"})
	@ResponseBody
	public String depositToSeller(int pay_price ,int product_num, HttpServletRequest request){
		HttpSession session = request.getSession();
		int user_num = 0;
		if(session.getAttribute("sessionUser_num")!=null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		System.out.println(pay_price);
		SecurePaymentDTO dto = new SecurePaymentDTO();
		dto.setPay_price(pay_price);
		dto.setUser_num(user_num);
		int update_result = securePaymentService.depositToSeller(dto);
		int[] num = new int[]{1, product_num}; //결제 완료 1
		int update_result2 = securePaymentService.updateProductSell2(num);
		if(update_result>0) {
			return "{\"result\" : \"success\"}";
		}
		return "{\"result\" : \"fail\"}";
	}
	
	@RequestMapping("/review")
	public String getReviewForm() {
		return "review/reviewform";
	}
	
	@RequestMapping("/confirmsell")
	@ResponseBody
	public String confirmSell(int product_num) {
		System.out.println(product_num);
		int[] num = new int[]{1, product_num}; //결제 완료 1
		int update_result = securePaymentService.updateProductSell2(num);
		if(update_result>0) {
			return "{\"result\" : \"success\"}";
		}
		return "{\"result\" : \"fail\"}";
	}
}
