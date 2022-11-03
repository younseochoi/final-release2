package likeinfo;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("likeinfoservice")
public class LikeInfoServiceImpl implements LikeInfoService {
	
	@Autowired
	LikeInfoDAO dao;
	
	@Override
	public List<LikeInfoDTO> getWishList(int user_num) {
		return dao.selectMemberWishList(user_num);
	}

}
