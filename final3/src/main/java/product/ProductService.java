package product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ProductService {
	

	List<ProductDetailDTO> getpdtDetailTags(String keyword);
	int insertSales(ProductDTO dto);
	int getLastInsertNum();
	List<String> getforSale(HashMap<String, String> map);
	List<ProductDTO> getProducts(ProductDTO dto);
	int likeProduct(ProductDTO dto);
	int unlikeProduct(ProductDTO dto);
	List<Integer> getLikeProduct(int user_num);
	List<ProductDTO> getQuote(int detail_num);
	List<ProductDTO> getQuoteFilter(ProductDTO dto);
	int getProductDetailNum(String detail_name);
	
	List<ProductDTO> getSaleslist(int user_num);
	List<ProductDTO> getSaleslist2(int user_num);
	List<ProductDTO> getSaleslist3(int user_num);
	
	List<Map<String,String>> getBuyinglist(int buyer_num);

	List<ProductDTO> getAllProducts();
	List<ProductDTO> getProductsIdol(int idol_num);
	
	String getimagepath(int product_num);
	//수정폼
	ProductDTO getDetail(int product_num);
	//수정처리
	void updateSales(ProductDTO dto);
	//검색
	List<ProductDTO> searchSimple(ProductDTO dto);
	
	int updateBuyerNum(ProductDTO dto);
}
