package WebSocketChatting;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.demo.NaverInform;

import product.ProductDTO;

@Service("chattingservice")
public class ChattingService_Impl implements ChattingService {

	@Autowired
	ChattingDAO chatdao;

	@Override
	public int countlog(int buyer_num,  int seller_num, int roomNumber) {
		return chatdao.getCount_log(buyer_num, seller_num, roomNumber);
	}
	
	@Override
	public int chattinglog(ChattingDTO dto) {
		return chatdao.insertChatting_log(dto);
	}

	@Override
	public List<ChattingDTO> chattinglist(int seller_num , int product_num) {
		return chatdao.getChatting_list(seller_num , product_num);
	}

	@Override
	public int countlog2(int seller_num, int product_num) {
		return chatdao.getCount_log2(seller_num, product_num);
	}

	@Override
	public void createFile(int roomNumber) throws IOException {
		
		String fileName = roomNumber+".json";
		String pathName = NaverInform.path + fileName;
		//String pathName = NaverInform.yspath + fileName;
		
		File txtFile = new File(pathName);
		txtFile.createNewFile();
		
		Calendar time1 = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");

		String time2 = sdf.format(time1.getTime());
		
		FileWriter file = new FileWriter(txtFile , true);
		file.write("[{\"msg\":\"안전거래 규칙을 지켜주세요!\",\"roomNumber\":"+roomNumber+",\"type\":\"message\",\"sessionUser_num\":\"0\",\"userName\":\"SYSTEM\",\"time\":\""+time2+"\"}]");
		file.flush();
		file.close();
		
	}

	@Override
	public int lastchat(String last_chat , String rN) {
		return chatdao.updateLast_chat(last_chat , rN);
	}

	@Override
	public int getuser_num(String rN) {
		return chatdao.getUser_num(rN);
	}

	@Override
	public int buyernotice(String rN) {
		return chatdao.buyerNotice(rN);
	}

	@Override
	public int sellernotice(String rN) {
		return chatdao.sellerNotice(rN);
	}

	@Override
	public void updateseller1(String rN) {
		chatdao.updateSeller_notice1(rN);
	}
	@Override
	public void updateseller2(String rN) {
		chatdao.updateSeller_notice2(rN);
	}

	@Override
	public void updatebuyer1(String rN) {
		chatdao.updateBuyer_notice1(rN);
	}
	@Override
	public void updatebuyer2(String rN) {
		chatdao.updateBuyer_notice2(rN);
	}

	@Override
	public List<ChattingDTO> chatasbuyer(int user_num) {
		return chatdao.chat_As_buyer(user_num);
	}

	@Override
	public List<ChattingDTO> chatasseller(int user_num) {
		return chatdao.chat_As_seller(user_num);
	}



	
	

	
}
