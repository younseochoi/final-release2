package product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("productservice")
public class ProductServiceImpl implements ProductService{

	@Autowired
	@Qualifier("productdao")
	ProductDAO productDAO;
	
	@Override
	public List<ProductDetailDTO> getpdtDetailTags(String keyword) {
		return productDAO.getpdtDetailTags(keyword);
	}

	@Override
	public int insertSales(ProductDTO dto) {
		return productDAO.insertSales(dto);
	}

	@Override
	public int getLastInsertNum() {
		return productDAO.getLastInsertNum();
	}

	@Override
	public List<String> getforSale(HashMap<String, String> map) {
		return productDAO.getforSale(map);
	}

	@Override
	public List<ProductDTO> getProducts(ProductDTO dto) {
		return productDAO.getProducts(dto);
	}

	@Override
	public int likeProduct(ProductDTO dto) {
		return productDAO.likeProduct(dto);
	}
	
	@Override
	public int unlikeProduct(ProductDTO dto) {
		return productDAO.unlikeProduct(dto);
	}

	@Override
	public List<Integer> getLikeProduct(int user_num) {
		return productDAO.getLikeProduct(user_num);
	}


	@Override
	public List<ProductDTO> getQuote(int detail_num) {
		return productDAO.getQuote(detail_num);
	}

	@Override
	public List<ProductDTO> getQuoteFilter(ProductDTO dto) {
		if(Integer.parseInt(dto.getProduct_time())<7) { //2개월 이내 데이터 가져오기
			if(dto.getProduct_status1()==-1 && dto.getProduct_status2() == -1 && dto.getProduct_status3() == -1&&
					 (dto.getProduct_status4() == ""|| dto.getProduct_status4() == null) && dto.getProduct_status5() == -1) {
				return productDAO.getQuoteFilter2_NoOption(dto);
			}else {
				
				return productDAO.getQuoteFilter2(dto);
			}
				
		}else { // 6개월 이내 데이터 가져오기
			if(dto.getProduct_status1()==-1 && dto.getProduct_status2() == -1 && dto.getProduct_status3() == -1&&
					 (dto.getProduct_status4() == ""|| dto.getProduct_status4() == null) && dto.getProduct_status5() == -1) {
				return productDAO.getQuoteFilter_NoOption(dto);
			}else {
				
				return productDAO.getQuoteFilter(dto); 
			}
			
		}
	}

	@Override
	public int getProductDetailNum(String detail_name) {
		return productDAO.getProductDetailNum(detail_name);
	}

	@Override
	public List<ProductDTO> getSaleslist(int user_num) {
		return productDAO.getSaleslist(user_num);
	}

	@Override
	public List<Map<String,String>> getBuyinglist(int buyer_num) {
		return productDAO.getBuying_list(buyer_num);
	}
	
	public List<ProductDTO> getAllProducts() {
		return productDAO.getAllProducts();
	}

	@Override
	public List<ProductDTO> getProductsIdol(int idol_num) {
		return productDAO.getProductsIdol(idol_num);
	}

	@Override
	public String getimagepath(int product_num) {
		return productDAO.getImage_path(product_num);
	}

	public ProductDTO getDetail(int product_num) {
		return productDAO.getDetail(product_num);
	}
	
	@Override
	public void updateSales(ProductDTO dto) {
		productDAO.updateSales(dto);
	}
	
//	@Override
//	public List<HashMap<Integer, String>> getpdtDetailTags(String keyword) {
//		return productDAO.getpdtDetailTags(keyword);
//	}
	@Override
	public List<ProductDTO> searchSimple(ProductDTO dto) { //메인페이지 검색
		return productDAO.searchSimple(dto);
	}

	@Override
	public List<ProductDTO> getSaleslist2(int user_num) {
		return productDAO.getSaleslist2(user_num);
	}
	
	@Override
	public List<ProductDTO> getSaleslist3(int user_num) {
		return productDAO.getSaleslist3(user_num);
	}

	@Override
	public int updateBuyerNum(ProductDTO dto) {
		return productDAO.updateBuyerNum(dto);
	}
	
	
}