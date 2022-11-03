package review;

public class ReviewDTO {

	int review_num;
	int reviewer_num;
	int review_target_num;
	String review_contents;
	String review_date;
	String reviewer_role;
	double review_rating;
	
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public int getReviewer_num() {
		return reviewer_num;
	}
	public void setReviewer_num(int reviewer_num) {
		this.reviewer_num = reviewer_num;
	}
	public int getReview_target_num() {
		return review_target_num;
	}
	public void setReview_target_num(int review_target_num) {
		this.review_target_num = review_target_num;
	}
	public String getReview_contents() {
		return review_contents;
	}
	public void setReview_contents(String review_contents) {
		this.review_contents = review_contents;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	public String getReviewer_role() {
		return reviewer_role;
	}
	public void setReviewer_role(String reviewer_role) {
		this.reviewer_role = reviewer_role;
	}
	public double getReview_rating() {
		return review_rating;
	}
	public void setReview_rating(double review_rating) {
		this.review_rating = review_rating;
	}
	
	@Override
	public String toString() {
		return review_num+", "+reviewer_num+", "+review_target_num+", "+review_date+", "+reviewer_role+", "+review_rating+", "+review_contents;
	}
	
	
	
}
