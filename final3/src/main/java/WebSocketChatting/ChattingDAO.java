package WebSocketChatting;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("chattingdao")
public interface ChattingDAO {
	
	public int getCount_log(int buyer_num , int seller_num , int roomNumber);
	// chatting_info 테이블에서 조건에 따라 count 수 값 조회
	
	public int insertChatting_log(ChattingDTO dto);
	// chatting_info 테이블에 insert
	
	public List<ChattingDTO> getChatting_list(int seller_num , int product_num);
	// 판매자의 채팅 목록 조회를 위한 roomNumber list
	
	public int getCount_log2(int seller_num , int product_num);
	// 판매자의 채팅 목록의 갯수
	
	public int updateLast_chat(String last_chat , String rN);
	
	public int buyerNotice(String rN);
	public int sellerNotice(String rN);
	public int getUser_num(String rN);
	public void updateSeller_notice1(String rN);
	public void updateSeller_notice2(String rN);
	public void updateBuyer_notice1(String rN);
	public void updateBuyer_notice2(String rN);
	// 채팅 알림을 위한것들
	
	public List<ChattingDTO> chat_As_buyer(int user_num);
	public List<ChattingDTO> chat_As_seller(int user_num);
	// 알림값을 가져오기 위해 구매자 혹은 판매자로써 참여한 채팅방의 notice 값 가져오기

}
