package final_project;

import org.springframework.stereotype.Component;

@Component("auctionthread")
public class AuctionThread extends Thread {

	
	int time;
	int product_num;
	int auction_method;
	int user_num;
	
	AuctionService auction_service;
	
	AuctionThread() {}
	
	AuctionThread(int time, int product_num, int auction_method , AuctionService auction_service){
		this.time = time*3000;
		this.product_num = product_num;
		this.auction_method = auction_method;
		this.auction_service = auction_service;
		}
	// 기존에 controller에서 했던 것 처럼 Autowired로 하면 받아오지를 못함.
	// 그래서 서비스를 controller에서 직접 받아옴
	
	
	public void run() {
		
		try {
			Thread.sleep(time);
			
			if(auction_method == 0) { // 공개 경매
				
				int auction_num = auction_service.getAuction_num(product_num);
				int user_num = auction_service.lastbid(auction_num); // 1순위 입찰자의 user_num
				AuctionDTO dto = auction_service.auction_info(product_num);
				int final_price = dto.final_price;
				// auction_info에서 입찰 정보를 통해 최종 금액 산정

				auction_service.soldout(final_price, user_num, product_num);
				// product_info의 product_price 업데이트
			}
			else if(auction_method == 1) { // 비공개 경매
				int auction_num = auction_service.getAuction_num(product_num); // auction_num
				int user_num = auction_service.lastbid(auction_num); // 1순위 입찰자의 user_num
				int second = auction_service.secondbid(auction_num); // 2순위 입찰가
				
				AuctionDTO dto = auction_service.auction_info(product_num);
				int bid_unit = dto.bid_unit; // 1호가
				int final_price = bid_unit + second; // 최종 가격
		
				auction_service.soldout(final_price, user_num, product_num);
				// product_info의 product_price 업데이트
			}


		}
		catch (Exception e) {
			System.out.println(e);
		}
	}
}
