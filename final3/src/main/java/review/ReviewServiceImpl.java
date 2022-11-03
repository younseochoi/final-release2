package review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("reviewservice")
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	@Qualifier("reviewdao")
	ReviewDAO reviewDAO;
	
	@Override
	public int findReviewTargetSellerNum(int product_num) {
		return reviewDAO.findReviewTargetSellerNum(product_num);
	}

	
	@Override
	public int findReviewTargetBuyerNum(int product_num) {
		return reviewDAO.findReviewTargetBuyerNum(product_num);
	}


	@Override
	public int insertReview(ReviewDTO dto) {
		return reviewDAO.insertReview(dto);
	}


	@Override
	public  List<HashMap<String, Object>> getUserReview(int user_num) {
		return reviewDAO.getUserReview(user_num);
	}


	@Override
	public HashMap<String, Object> getUserReviewAvg(int user_num) {
		return reviewDAO.getUserReviewAvg(user_num);
	}


	@Override
	public List<HashMap<String, Object>> getUserOptionReview(ReviewDTO dto) {
		return reviewDAO.getUserOptionReview(dto);
	}


	
	@Override
	public HashMap<String, Object> getUserOptionReviewAvg(ReviewDTO dto) {
		return reviewDAO.getUserOptionReviewAvg(dto);
	}


	

	
	
}
