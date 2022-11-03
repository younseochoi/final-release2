package likeinfo;

import java.util.List;

import org.springframework.stereotype.Service;

public interface LikeInfoService {

	public List<LikeInfoDTO> getWishList(int user_num);
}
