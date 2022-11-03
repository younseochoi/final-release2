package securepayment;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import product.ProductDTO;

@Service("securepaymentservice")
public class SecurePaymentServiceImpl implements SecurePaymentService {

	@Autowired
	@Qualifier("securepaymentdao")
	SecurePaymentDAO securePaymentDAO;
	
	@Override
	public int securePaymentProcess(SecurePaymentDTO dto) {
		return securePaymentDAO.securePaymentProcess(dto);
	}

	@Override
	public int minusUserMoney(SecurePaymentDTO dto) {
		return securePaymentDAO.minusUserMoney(dto);
	}

	@Override
	public int registerBillingNumber(ProductDTO dto) {
		return securePaymentDAO.registerBillingNumber(dto);
	}

	@Override
	public int updateSellerCheck(int product_num) {
		return securePaymentDAO.updateSellerCheck(product_num);
	}

	@Override
	public List<Map<String,String>> getPurchaselist(int user_num) {
		return securePaymentDAO.getPurchaselist(user_num);
	}

	@Override
	public int refund(SecurePaymentDTO dto) {
		return securePaymentDAO.refund(dto);
	}

	@Override
	public int updateBuyerCheck(SecurePaymentDTO dto) {
		return securePaymentDAO.updateBuyerCheck(dto);
	}

	@Override
	public int updateProductSell(int product_num) {
		return securePaymentDAO.updateProductSell(product_num);
	}

	@Override
	public List<Map<String, String>> getMyProduct(int user_num) {
		return securePaymentDAO.getMyProduct(user_num);
	}

	@Override
	public int depositToSeller(SecurePaymentDTO dto) {
		return securePaymentDAO.depositToSeller(dto);
	}

	@Override
	public int updateProductSell2(int[] num) {
		return securePaymentDAO.updateProductSell2(num);
	}

	@Override
	public int getUserMoney(int user_num) {
		return securePaymentDAO.getUserMoney(user_num);
	}

	@Override
	public ProductDTO getProductOne(int product_num) {
		return securePaymentDAO.getProductOne(product_num);
	}

	@Override
	public int updateSellerMoney(ProductDTO dto) {
		return securePaymentDAO.updateSellerMoney(dto);
	}
	
	
	
}
