package upload;


public class UploadDTO {
	
	int product_num;
	String image_path;
	
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	
	@Override
	public String toString() {
		return product_num+": "+image_path;
	}
	
	

}
