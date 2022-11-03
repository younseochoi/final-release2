package final_project;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import product.ProductDTO;

@Mapper
@Repository("auctiondao")
public interface AuctionDAO {

	public int requestAuction(int product_num , int user_num);
	// 경매 요청. auction_gauge 에 insert 함
	public int cancleRequest(int product_num, int user_num);
	// 경매 요청 취소
	public int requestNumber(int product_num);
	// 경매 요청 횟수. auction_gauge의 count 값 리턴
	public int requestNumber2(int product_num, int user_num);
	// 특정 유저에 대한 요청 횟수. 1 또는 0
	public int requestAccept(AuctionDTO dto);
	// 경매로 전환. product_num과 auction_check 값을 확인 후, auction_info 테이블에 insert
	public int auctionCheck(int product_num);
	// 경매 유무 값. product_info의 auction_check 값 1로 바꿈
	public int auctionChecking(int product_num);
	// 경매 유무 값 확인. product_num을 통해 select 하여 auction_check 값이 1인지 아닌지 확인
	public int getMuch_bid(int auction_num);
	// 경매 입찰 수
	
	public AuctionDTO getAuction_info(int product_num);
	// 경매 상세 정보 호출
	public int getAuction_num(int product_num);
	// 경매 고유 번호 호출
	
	public ProductDTO getProduct_info(int product_num);
	// 임시 제품 상세 정보 호출

	public String getDetail_name(int detail_num);
	// 상품 이름 호출
	
	public int Check_bid(int auction_num , int user_num);
	// 비공개 입찰에서 두 조건으로 count 값 리턴
	public int getLast_bid(int auction_num);
	// 최신 입찰자의 user_num 호출
	public int getSecond_bid(int auction_num);
	// 2순위 입찰가 호출
	public int getFirst_bid(int auction_num);
	// 판매자의 user_num 호출
	
	public int requestBid(int auction_num , int user_num , int bid_price);
	// 입찰. auction_bid에 insert
	public int updatePrice(int bid_price , int auction_num);
	// final_price update
	
	public int getMy_bid(int auction_num , int user_num);
	// 어떤 경매에 대한 내 제시가
	public int getUser_money(int user_num);
	// 입찰자의 보유 머니 호출
	public int updateUser_money(int final_price , int user_num);
	// 입찰자의 보유 머니 차감
	public int refundUser_money(int final_price , int user_num);
	// 입찰자의 보유 머니 환불
	
	public int soldOut(int final_price , int user_num , int product_num);
	// 최종 결제를 위해 product_info 테이블 update
	

	public int getBuyer_num(int product_num);
	// 구매자 번호 호출
	//[승희] product_num에 따라 imgpath 가져오기
	public List<String> getImage_path(int product_num);
	
	public int muchImages(int product_num);
}
