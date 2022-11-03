package review;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import securepayment.SecurePaymentService;


@Controller
public class ReviewController {

	@Autowired
	@Qualifier("reviewservice")
	ReviewService reviewService;
	
	@Autowired
	@Qualifier("securepaymentservice")
	SecurePaymentService securePaymetService;
	
	// 리뷰 등록 
	@RequestMapping("/insertreviewajax")
	@ResponseBody
	public String insertReview(ReviewDTO dto, HttpServletRequest request) {
		// review_num에 product_num 저장됨
		// product_num으로 review_target_num 찾아옴
		int review_target_num = 0;
		
		System.out.println(dto);
		if(dto.getReviewer_role().equals("buyer")) {
			review_target_num = reviewService.findReviewTargetSellerNum(dto.getReview_num()); //구매자가 쓴 후기
		}else {
			review_target_num = reviewService.findReviewTargetBuyerNum(dto.getReview_num()); //판매자가 쓴 후기
		}
		
		//판매자가 쓴 후기 일 경우엔 결제테이블 user_num가져옴
		System.out.println(review_target_num);
		
		int insert_result=0;
		
		// 현재 로그인 된 user_num
		HttpSession session = request.getSession();
		if(session.getAttribute("sessionUser_num")!=null ||review_target_num!=0) { // 현재 로그인 중이고 리뷰 타겟이 존재하면 실행
			
			int user_num = (int) session.getAttribute("sessionUser_num");
			dto.setReview_target_num(review_target_num);
			dto.setReviewer_num(user_num);
			dto.setReview_rating(dto.getReview_rating()/2.0);
			insert_result = reviewService.insertReview(dto);
		}
		
		
		if(dto.getReviewer_role().equals("seller")) {
			int[] num = new int[]{2, dto.getReview_num()};
			securePaymetService.updateProductSell2(num);
		}
		System.out.println(dto);
		
		
		if(insert_result>0) {
			return "{\"result\" : \"success\"}";
		}else {
			return "{\"result\" : \"fail\"}";
		}
	}
	
	// 본인 후기 열람
	@RequestMapping("/myreview")
	public ModelAndView getMyReview(HttpServletRequest request) {
		List<HashMap<String, Object>> dto =null;
		ModelAndView mv= new ModelAndView();
		HttpSession session = request.getSession();
		if(session.getAttribute("sessionUser_num")!=null) {
			int user_num = (int) session.getAttribute("sessionUser_num");
			dto = reviewService.getUserReview(user_num);
			mv.addObject("reviewlist", dto);
		}
		mv.setViewName("review/reviewresult");
		return mv;
		
	}
	
	// 유저 거래 후기 열람
		@RequestMapping("/userreview")
		public String getUserReview(int user_num) {
			
			//해당 유저가 리뷰 타겟인 리뷰 리스트 가져오기
			//dto = reviewService.getUserReview(user_num);
			
			//해당 유저의 평점 평균 가져오기
			//Map<String, String> reviewAvg = reviewService.getUserReviewAvg(user_num);
			
			//mv.addObject("reviewlist", dto);
			//mv.addObject("avg", reviewAvg);
			return "review/reviewresult";
			
		}
		
	// 	유저 거래 후기 가져오기 
		@RequestMapping("/userreviewajax")
		@ResponseBody
		public String getUserOptionReview(ReviewDTO dto) {
			JSONArray jsonArr = new JSONArray();
			List<HashMap<String, Object>> reviewdto =null;
			HashMap<String,Object> reviewAvg = null;
			
			if(dto.getReviewer_role().equals("all")) { //전체 후기 (해당 유저가 리뷰 타겟인 리뷰 리스트 가져오기)
				reviewdto = reviewService.getUserReview(dto.getReview_target_num());
				reviewAvg = reviewService.getUserReviewAvg(dto.getReview_target_num());
			}else {
				//해당 유저가 리뷰 타겟인 구매자 or 판매자가 쓴 리뷰 리스트 가져오기
				reviewdto = reviewService.getUserOptionReview(dto);
			
				//해당 유저의 구매자 or 판매자 거래 평점 평균 가져오기
				reviewAvg = (HashMap<String, Object>) reviewService.getUserOptionReviewAvg(dto);
			}
			reviewdto.add(reviewAvg);
			
				for(HashMap<String,Object>map: reviewdto){ // hashMap -> json 변환
					jsonArr.put(convertMapToJson(map));
				}
			//System.out.println(jsonArr);
			return jsonArr.toString();
		}

		//hashmap to json
		public static JSONObject convertMapToJson(HashMap<String,Object> map){
			JSONObject json = new JSONObject();
			for(Map.Entry<String, Object>entry:map.entrySet()){
				String key = entry.getKey();
				Object value = entry.getValue();
				json.put(key, value);
			}
			return json;
		}
}
