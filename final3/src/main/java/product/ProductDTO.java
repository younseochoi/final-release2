package product;

import org.springframework.web.multipart.MultipartFile;

public class ProductDTO {
	int product_num;
	int idol_num;
	int category_num;
	int user_num;
	int detail_num;
	String product_title;
	String product_contents;
	int product_price;
	String product_time;
	boolean safe_trade;
	boolean auction_check;
	int product_sell;
	int product_status1;
	int product_status2;
	int product_status3;
	String product_status4;
	int product_status5;
	String user_name;
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	MultipartFile[] images;
	String image_path;
	
	String billing_number;
	
	public String getBilling_number() {
		return billing_number;
	}
	public void setBilling_number(String billing_number) {
		this.billing_number = billing_number;
	}
	public MultipartFile[] getImages() {
		return images;
	}
	public void setImages(MultipartFile[] images) {
		this.images = images;
	}
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public String getProduct_title() {
		return product_title;
	}
	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}
	public int getIdol_num() {
		return idol_num;
	}
	public void setIdol_num(int idol_num) {
		this.idol_num = idol_num;
	}
	public int getCategory_num() {
		return category_num;
	}
	public void setCategory_num(int category_num) {
		this.category_num = category_num;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getProduct_contents() {
		return product_contents;
	}
	public void setProduct_contents(String product_contents) {
		this.product_contents = product_contents;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public String getProduct_time() {
		return product_time;
	}
	public void setProduct_time(String product_time) {
		this.product_time = product_time;
	}
	public boolean isSafe_trade() {
		return safe_trade;
	}
	public void setSafe_trade(boolean safe_trade) {
		this.safe_trade = safe_trade;
	}
	public boolean isAuction_check() {
		return auction_check;
	}
	public void setAuction_check(boolean auction_check) {
		this.auction_check = auction_check;
	}
	public int getProduct_status1() {
		return product_status1;
	}
	public void setProduct_status1(int product_status1) {
		this.product_status1 = product_status1;
	}
	public int getProduct_status2() {
		return product_status2;
	}
	public void setProduct_status2(int product_status2) {
		this.product_status2 = product_status2;
	}
	public int getProduct_status3() {
		return product_status3;
	}
	public void setProduct_status3(int product_status3) {
		this.product_status3 = product_status3;
	}
	public String getProduct_status4() {
		return product_status4;
	}
	public void setProduct_status4(String product_status4) {
		this.product_status4 = product_status4;
	}
	public int getProduct_status5() {
		return product_status5;
	}
	public void setProduct_status5(int product_status5) {
		this.product_status5 = product_status5;
	}
	public int getProduct_sell() {
		return product_sell;
	}
	public void setProduct_sell(int product_sell) {
		this.product_sell = product_sell;
	}
	public int getDetail_num() {
		return detail_num;
	}
	public void setDetail_num(int detail_num) {
		this.detail_num = detail_num;
	}
	
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	@Override
	public String toString() {
		return product_num+". 제목: "+product_title+" 내용: "+product_contents+" 상태: "+product_status1+", "+""+product_status2+", "+product_status3+
				", "+product_status4+", "+product_status5+" 카테고리 번호: "+category_num+" 안전거래: "+safe_trade+" 경매전환: "+auction_check
				+" 디테일넘버: "+detail_num+" 가격: "+product_price+" 이미지: "+images+image_path+"날짜 "+product_time;
	}
	
	
	
}
