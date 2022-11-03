package review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ReviewService {
	
	int findReviewTargetSellerNum(int product_num);
	
	int findReviewTargetBuyerNum(int product_num);

	int insertReview(ReviewDTO dto);

	 List<HashMap<String, Object>> getUserReview(int user_num);
	 
	 HashMap<String,Object> getUserReviewAvg(int user_num);
	 
	 List<HashMap<String, Object>> getUserOptionReview(ReviewDTO dto);
	 
	 HashMap<String, Object> getUserOptionReviewAvg(ReviewDTO dto);
}
