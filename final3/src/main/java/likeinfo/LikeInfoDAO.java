package likeinfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("likeinfodao")
public interface LikeInfoDAO {
	
	List<LikeInfoDTO> selectMemberWishList(int user_num);
}
