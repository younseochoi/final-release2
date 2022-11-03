package final_project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import product.ProductDTO;

@Service("auctionservice")
public class AuctionService_Impl implements AuctionService {

	@Autowired
	AuctionDAO dao;
	
	@Override
	public int auction_request(int product_num, int user_num) {
		return dao.requestAuction(product_num,user_num);
	}
	// 경매 요청
	
	@Override
	public int cancle_request(int product_num, int user_num) {
		return dao.cancleRequest(product_num, user_num);
	}
	// 경매 요청 취소
	
	@Override
	public int request_num(int product_num) {
		return dao.requestNumber(product_num);
	}
	// 어떤 제품에 대한 요청 횟수
	
	@Override
	public int request_num2(int product_num, int user_num) {
		return dao.requestNumber2(product_num,user_num);
	}
	
	@Override
	public int auctionCheck(int product_num) {
		return dao.auctionCheck(product_num);
	}
	
	@Override
	public int auctionChecking(int product_num) {
		return dao.auctionChecking(product_num);
	}

	@Override
	public int requestAccept(AuctionDTO dto) {
		return dao.requestAccept(dto);
	}	
	
	@Override
	public AuctionDTO auction_info(int product_num) {
		return dao.getAuction_info(product_num);
	}
	// 경매 정보 호출
	
	@Override
	public int getAuction_num(int product_num) {
		return dao.getAuction_num(product_num);
	}
	// 경매 고유번호 호출

	@Override
	public ProductDTO product_info(int product_num) {
		
		return dao.getProduct_info(product_num);
	}
	// 임시 제품 정보

	@Override
	public String detail_name(int detail_num) {
		return dao.getDetail_name(detail_num);
	}
	// 상품 이름

	@Override
	public int usermoney(int user_num) {
		return dao.getUser_money(user_num);
	}
	// 유저 보유 머니 호출
	
	@Override
	public int lastbid(int auction_num) {
		return dao.getLast_bid(auction_num);
	}
	// 최신 입찰 유저의 user_num 호출
	
	@Override
	public int secondbid(int auction_num) {
		return dao.getSecond_bid(auction_num);
	}
	
	@Override
	public int firstbid(int auction_num) {
		return dao.getFirst_bid(auction_num);
	}
	// 판매자의 user_num 호출
	
	@Override
	public int bid_request(int auction_num , int user_num , int bid_price) {
		return dao.requestBid(auction_num , user_num, bid_price);
	}
	// 입찰

	@Override
	public int updateprice(int bid_price, int auction_num) {
		return dao.updatePrice(bid_price , auction_num);
	}
	// 경매 최신가 업데이트
	
	@Override
	public int mybid(int auction_num, int user_num) {
		return dao.getMy_bid(auction_num, user_num);
	}
	// 어떤 경매에 대한 내 제시가

	@Override
	public int updatemoney(int final_price  , int user_num) {
		return dao.updateUser_money(final_price , user_num);
	}
	// 입찰자의 보유머니 차감

	@Override
	public int refundmoney(int final_price, int user_num) {
		return dao.refundUser_money(final_price, user_num);
	}
	// 상위입찰시 이전 입찰자에게 환불

	@Override
	public int checkbid(int auction_num, int user_num) {
		return dao.Check_bid(auction_num, user_num);
	}
	// 비공개 입찰시 입찰여부 검사

	@Override
	public int muchbid(int auction_num) {
		return dao.getMuch_bid(auction_num);
	}
	// 어떤 경매의 입찰 수

	@Override
	public int soldout(int final_price, int user_num, int product_num) {
		return dao.soldOut(final_price, user_num, product_num);
	}
	// 최종 결제를 위한 product_info 테이블 update

	@Override
	public int getBuyer_num(int product_num) {
		return dao.getBuyer_num(product_num);
	}
	//[승희] 이미지 파일 가져오기
	public List<String> imagepath(int product_num) {
		return dao.getImage_path(product_num);
	}


	@Override
	public int muchimages(int product_num) {
		return dao.muchImages(product_num);
	}


}
