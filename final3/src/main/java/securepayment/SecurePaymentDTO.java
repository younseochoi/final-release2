package securepayment;

public class SecurePaymentDTO {
	int pay_num;
	int user_num;
	int product_num;
	int pay_price;
	String pay_time;
	boolean seller_check;
	boolean buyer_check;
	
	public int getPay_num() {
		return pay_num;
	}
	public void setPay_num(int pay_num) {
		this.pay_num = pay_num;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public int getPay_price() {
		return pay_price;
	}
	public void setPay_price(int pay_price) {
		this.pay_price = pay_price;
	}
	public String getPay_time() {
		return pay_time;
	}
	public void setPay_time(String pay_time) {
		this.pay_time = pay_time;
	}
	public boolean isSeller_check() {
		return seller_check;
	}
	public void setSeller_check(boolean seller_check) {
		this.seller_check = seller_check;
	}
	public boolean isBuyer_check() {
		return buyer_check;
	}
	public void setBuyer_check(boolean buyer_check) {
		this.buyer_check = buyer_check;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "결제 가격: "+pay_price+" 상품 번호: "+product_num+" 유저 번호: "+user_num;
	}
	
	
}
