package final_project;

import java.util.List;

import product.ProductDTO;

public interface AuctionService {

	public int auction_request(int product_num , int user_num);
	public int cancle_request(int product_num, int user_num);
	// 경매 요청 및 요청 취소
	
	public int request_num(int product_num);
	public int request_num2(int product_num, int user_num);
	
	public int requestAccept(AuctionDTO dto);
	public int auctionCheck(int product_num);
	
	public int auctionChecking(int product_num);
	
	public AuctionDTO auction_info(int product_num);
	public int getAuction_num(int product_num);
	
	public ProductDTO product_info(int product_num);
	
	public String detail_name(int detail_num);
	// detail_name 호출
	
	public int bid_request(int auction_num , int user_num , int bid_price);
	// 입찰
	
	public int checkbid(int auction_num , int user_num);
	// 비공개 입찰에서 입찰여부 조회
	public int muchbid(int auction_num);
	// 경매 입찰 수
	
	public int lastbid(int auction_num);
	// 최신 입찰자 user_num 호출
	public int secondbid(int auction_num);
	// 2순위 입찰가
	public int firstbid(int auction_num);
	// 판매자의 user_num 호출
	
	public int updateprice(int bid_price , int auction_num);
	// auction_info의 fianl_price 값 update
	
	public int mybid(int auction_num , int user_num);
	// 어떤 경매에 대한 내 제시가
	public int usermoney(int user_num);
	// 유저 보유 머니 호출
	public int updatemoney(int final_price , int user_num);
	// 입찰자의 보유 머니 차감
	public int refundmoney(int final_price , int user_num);
	// 입찰자의 보유 머니 환불
	
	public int soldout(int final_price , int user_num , int product_num);
	// 최종 결제를 위한 product_info 테이블 update
	
	public int getBuyer_num(int product_num);
	// 구매자 번호 호출

	//[승희] img_path 가져오기
	public List<String> imagepath(int product_num);
	

	public int muchimages(int product_num);

}
