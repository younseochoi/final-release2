package securepayment;

import java.util.List;
import java.util.Map;

import product.ProductDTO;

public interface SecurePaymentService  {
	int securePaymentProcess(SecurePaymentDTO dto);
	int minusUserMoney(SecurePaymentDTO dto);
	int registerBillingNumber(ProductDTO dto);
	int updateSellerCheck(int product_num);
	List<Map<String,String>> getPurchaselist(int user_num);
	int refund(SecurePaymentDTO dto);
	int updateBuyerCheck(SecurePaymentDTO dto);
	int updateProductSell(int product_num);
	List<Map<String,String>> getMyProduct(int user_num);
	int depositToSeller(SecurePaymentDTO dto);
	int updateProductSell2(int[] num);

	int getUserMoney(int user_num);
	ProductDTO getProductOne(int product_num);
	
	int updateSellerMoney(ProductDTO dto);
}
