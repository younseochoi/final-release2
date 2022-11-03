package member;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import final_project.AuctionService;
import likeinfo.LikeInfoDTO;
import product.ProductDTO;

@Controller
public class MemberController {
	
	@Autowired
	@Qualifier("auctionservice")
	AuctionService auction_service;
	
	@Autowired
	@Qualifier("memberservice")
	MemberService member_service;
	
	
	@GetMapping("/loginform")
	public String login() {
		return "member/loginform";
	}
	
	@ResponseBody
	@PostMapping("/login")
	public int loginprocess(String id, String password , HttpServletRequest request) {

		int check = member_service.login(id, password);
		
		if(check == 1) {
			HttpSession session = request.getSession();
			int user_num = member_service.user_num(id);
			session.setAttribute("sessionUser_num", user_num);
			return 1;
		}
		// 해당 아이디와 비밀번호가 맞는 계정이 있다면 로그인 성공
		
		else {
			return 0;
		}
	}
	// 로그인
	
	@ResponseBody
	@PostMapping("/logout")
	public int logout(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("sessionUser_num") != null) {
			session.removeAttribute("sessionUser_num");
		}
		else {
			session.setAttribute("sessionUser_num", null);
		}
		return 1;
	}
	// 로그아웃

	//회원가입
	@GetMapping("/memberjoin")
	public String writingform() {
		return "member/joinform";
	}
	
	@RequestMapping("/memberjoin" )
	public ModelAndView memberjoin(MemberDTO dto) {
		int insertcount = member_service.registerMember(dto);
		ModelAndView mv = new ModelAndView();
		mv.addObject("insertcount", insertcount);
		mv.setViewName("member/joinprocess");
		return mv;
	}
	
	//[승희] 본인 판매글 모아보기
	@RequestMapping("/sellproductlist")
	@ResponseBody
	public ModelAndView sellproductlist(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		ProductDTO dto = new ProductDTO();
		
		HttpSession session = request.getSession();
		int user_num = Integer.parseInt(String.valueOf(session.getAttribute("sessionUser_num")));
		String user_id = String.valueOf(session.getAttribute("sessionUser_id"));
		
		//List<ProductDTO> productlist = member_service.getProductList(user_num);
		List<Map<String,String>> productlist = member_service.getProductList(user_num);
		
		if(user_id != null) {
			mv.addObject("sellproductlist", productlist);
			mv.setViewName("member/sellproductlist");
		}
		else {
			mv.setViewName("temp_mainpage");
		}
		return mv;
	}
		
		@GetMapping("/getmyid")
		public String getmyid() {
			return "member/getmyid";
		}
		
		@ResponseBody
		@PostMapping("/getMyID")
		public int getMyID(String user_email) throws Exception {
			
			int check = member_service.countmyid(user_email);
			
			if(check != 0) {
				String user_id = member_service.getmyid(user_email);
				member_service.createMessage1(user_email, user_id);
				
				return 1;
			}
			else {
				return 0;
			}
		}
		
		@ResponseBody
		@PostMapping("/getMyPW1")
		public String resetPW1(String user_id , String user_email) throws Exception {
			
			int check = member_service.countmyid(user_email);
			
			if(check != 0) {
				
				if(user_id.equals(member_service.getmyid(user_email))) {
					
					String key = member_service.createKey();
					member_service.createMessage2(user_email, user_id, key);
					// 인증번호 이메일 전송
					
					return key;
				}
				else {
					return "none";
				}
			}
			else {
				return "none";
			}
		}
		// 본인확인을 위한 인증번호 전송
		
		@ResponseBody
		@PostMapping("/getMyPW2")
		public String resetPW2(String user_id) throws Exception {

			String password = member_service.getmypw(user_id);
			return password;
		}
		// 본인확인 후 임시 비밀번호 전송
		
		@ResponseBody
		@PostMapping("/my")
		public MemberDTO getMemberMyPage(int user_num) {
			MemberDTO dto = member_service.getUser(user_num);
			return dto;
		}
		
		@PostMapping("/addMoneyform")
		public ModelAndView addMoneyform(int user_num) {
			
			ModelAndView mv = new ModelAndView();
			MemberDTO dto = member_service.getUser(user_num);
			String key = member_service.createKey();
			// 유저 정보와 거래를 위한 고유 번호
			
			mv.addObject("key",key);
			mv.addObject("dto",dto);
			mv.setViewName("member/addmoney");
			return mv;
		}
		// 계좌 충전 과정 1
		
		@ResponseBody
		@PostMapping("/addMoney")
		public int addMoney(int pay_price , int user_num) {
			
			member_service.addmoney(pay_price, user_num);
			return 0;
		}
		// 계좌 충전 과정 2
		
/*		
		@GetMapping("/wish/{user_num}")
		public String getMemberWishList(@PathVariable int user_num, Model model) {
			List<LikeInfoDTO> dtos = member_service.getWishList(user_num);
			return "member/wishlist";
		}
*/
		
}
