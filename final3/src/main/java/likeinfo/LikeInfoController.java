package likeinfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import member.MemberService;

@Controller
public class LikeInfoController {

	
	@Autowired
	@Qualifier("memberservice")
	MemberService member_service;
	
	@Autowired
	@Qualifier("likeinfoservice")
	LikeInfoService likeinfoservice;
	
	/**
	 * 찜목록
	 * TODO: 현재 likeinfo-mapping.xml 에러남 확인 후 뿌려줘야함
	 * @param user_num 유저 식별자
	 */

	@GetMapping("/wish")
	public ModelAndView getMemberWishList(int user_num) {
		
		ModelAndView mv = new ModelAndView();
		List<LikeInfoDTO> dtos = likeinfoservice.getWishList(user_num);
		
		mv.addObject("dtos",dtos);
//		model.addAttribute("dtos", dtos);
		
		mv.setViewName("likeinfo/wishlist");
		
		return mv;
	}

	
}
