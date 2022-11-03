package WebSocketChatting;

public class ChattingDTO {
	
	int buyer_num , seller_num , roomNumber , product_num;
	String buyer_name;
	String fileName;
	String last_chat;
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public String getBuyer_name() {
		return buyer_name;
	}

	public void setBuyer_name(String buyer_name) {
		this.buyer_name = buyer_name;
	}

	public int getBuyer_num() {
		return buyer_num;
	}

	public void setBuyer_num(int buyer_num) {
		this.buyer_num = buyer_num;
	}

	public int getSeller_num() {
		return seller_num;
	}

	public void setSeller_num(int seller_num) {
		this.seller_num = seller_num;
	}

	public String getLast_chat() {
		return last_chat;
	}

	public void setLast_chat(String last_chat) {
		this.last_chat = last_chat;
	}

	public int getRoomNumber() {
		return roomNumber;
	}

	public void setRoomNumber(int roomNumber) {
		this.roomNumber = roomNumber;
	}
}
