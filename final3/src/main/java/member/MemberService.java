package member;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import likeinfo.LikeInfoDTO;
import product.ProductDTO;

public interface MemberService {

	public int login(String user_id , String user_password);
	// 로그인 확인
	public int user_num(String user_id);
	// 임시 유저 고유 번호 호출
	public String user_id(int user_num);
	// 임시 유저 아이디 호출
	
	//회원정보
	public List<MemberDTO> onemember(String user_id);
	//회원가입
	public int registerMember(MemberDTO dto);
	//[승희] 판매글모아보기
	//public List<ProductDTO> getProductList(int user_num);
	List<Map<String,String>> getProductList(int user_num);
	// 마이페이지
	public MemberDTO getUser(int user_num);

    public List<LikeInfoDTO> getWishList(int user_num);
    
    public String getmyid(String user_email);
    public int countmyid(String user_email);
    public String getmypw(String user_id);
    
    MimeMessage createMessage1(String email , String user_id) throws MessagingException, UnsupportedEncodingException;
	// 아이디 찾기를 위한 내용 작성
    MimeMessage createMessage2(String email , String user_id , String key) throws MessagingException, UnsupportedEncodingException;
    // 비밀번호 초기화를 위한 내용 작성
	String createKey();
	// 랜덤 인증 코드 생성
	
	public void addmoney(int pay_price , int user_num);
	// 계좌 충전
}
