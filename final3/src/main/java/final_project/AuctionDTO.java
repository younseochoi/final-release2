package final_project;

public class AuctionDTO {

	int auction_num;
	int product_num;
	int bid_unit;
	int final_price;
	int auction_method;
	int user_num;
	String start_time , end_time;
	
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	
	public int getAuction_num() {
		return auction_num;
	}
	public void setAuction_num(int auction_num) {
		this.auction_num = auction_num;
	}
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public int getBid_unit() {
		return bid_unit;
	}
	public void setBid_unit(int bid_unit) {
		this.bid_unit = bid_unit;
	}
	public int getFinal_price() {
		return final_price;
	}
	public void setFinal_price(int final_price) {
		this.final_price = final_price;
	}
	public int getAuction_method() {
		return auction_method;
	}
	public void setAuction_method(int auction_method) {
		this.auction_method = auction_method;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	

	
}
