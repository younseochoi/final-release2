package product;

public class ProductDetailDTO {
	int detail_num;
	String detail_name;
	public int getDetail_num() {
		return detail_num;
	}
	public void setDetail_num(int detail_num) {
		this.detail_num = detail_num;
	}
	public String getDetail_name() {
		return detail_name;
	}
	public void setDetail_name(String detail_name) {
		this.detail_name = detail_name;
	}
	@Override
	public String toString() {
		
		return detail_num+": "+detail_name;
	}
	
	
	
}
