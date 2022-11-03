package product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("productdao")
public interface ProductDAO {

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
	List<ProductDTO> getQuoteFilter_NoOption(ProductDTO dto);
	List<ProductDTO> getQuoteFilter2(ProductDTO dto);
	List<ProductDTO> getQuoteFilter2_NoOption(ProductDTO dto);
	int getProductDetailNum(String detail_name);
	List<ProductDTO> getSaleslist(int user_num);
	
	List<Map<String,String>> getBuying_list(int buyer_num);
	// 구매목록과 구매목록에 표시될 리스트의 count

	List<ProductDTO> getAllProducts();
	List<ProductDTO> getProductsIdol(int idol_num);
	
	String getImage_path(int product_num);
	ProductDTO getDetail(int product_num);
	void updateSales(ProductDTO dto);
	//검색결과
	List<ProductDTO> searchSimple(ProductDTO dto);
	
	List<ProductDTO> getSaleslist2(int user_num);
	List<ProductDTO> getSaleslist3(int user_num);
	
	int updateBuyerNum(ProductDTO dto);
}
