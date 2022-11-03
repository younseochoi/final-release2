package WebSocketChatting;

import java.io.IOException;
import java.util.List;

public interface ChattingService {

	
	public int countlog(int buyer_num , int seller_num , int roomNumber);
	public int chattinglog(ChattingDTO dto);
	public List<ChattingDTO> chattinglist(int seller_num , int product_num);
	public int countlog2(int seller_num , int product_num);
	
	public void createFile(int roomNumber) throws IOException;
	
	public int lastchat(String last_chat , String rN);
	
	public int getuser_num(String rN);
	public int buyernotice(String rN);
	public int sellernotice(String rN);
	public void updateseller1(String rN);
	public void updatebuyer1(String rN);
	public void updateseller2(String rN);
	public void updatebuyer2(String rN);
	
	public List<ChattingDTO> chatasbuyer(int user_num);
	public List<ChattingDTO> chatasseller(int user_num);
	
}
