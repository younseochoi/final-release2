package product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.NaverInform;

import final_project.AuctionService;
import upload.UploadDTO;
import upload.UploadService;

@Controller
public class ProductController {
	
	@Autowired
	@Qualifier("productservice")
	ProductService pdtService;
	
	@Autowired
	@Qualifier("uploadservice")
	UploadService uploadService;
	
	@Autowired
	@Qualifier("auctionservice")
	AuctionService auction_service;
	
	//사진 저장할 폴더 경로 
	String savePath=NaverInform.yssaveimgpath; //이거 수정하세용~!! C://final_images/
	
	
	@RequestMapping("/getsalesform")
	public String getSalesForm() {
		
		return "product/salesform";
	}
	
	// 판매글 등록 프로세스 
		@RequestMapping("/insertsales")
		public String insertSales(ProductDTO dto,HttpServletRequest request) throws IOException {
			
			
				HttpSession session = request.getSession();
				int user_num=0;
				if(session.getAttribute("sessionUser_num")!=null) {
					user_num = (int) session.getAttribute("sessionUser_num");
					
				}
			
			int last_insert_pdt_num = 0;
			dto.setUser_num(user_num);
			UploadDTO uploaddto = new UploadDTO();
			int insert_result = pdtService.insertSales(dto);
			String [] imgexp = {"jpg","jfif","png","jpeg"}; //업로드 가능한 이미지 확장자들
			
			if(dto.getImages()[0].getSize() !=0) {   //---파일이 있을 경우만 저장 수정완료 
				if(insert_result>0) { // 파일이 있고 게시물이 성공적으로 저장되었을 때 파일 저장
					last_insert_pdt_num = pdtService.getLastInsertNum();
					uploaddto.setProduct_num(last_insert_pdt_num); //마지막 저장된 테이블의 PK가져옴
					
					for(int i=0;i<dto.getImages().length;i++) {
						String filename = dto.getImages()[i].getOriginalFilename();   //--- 파일명을 얻어옴. a.txt
						System.out.println(filename);
						String beforeext1 = filename.substring(0, filename.indexOf("."));  //a
						String ext1 = filename.substring(filename.indexOf("."));  //.txt
						ext1 = ext1.substring(1); //txt
						
						//확장자가 이미지일때만 난수 붙여 파일 저장후 DB에 기록
						for(int j=0;j<imgexp.length;j++) {
							if(imgexp[j].equals(ext1)) {
								String newname1 = beforeext1 +"(" +UUID.randomUUID().toString() +")"+ ext1;
								uploaddto.setImage_path(newname1);
								File servefile1 = new File(savePath+newname1);
								dto.getImages()[i].transferTo(servefile1); 
								uploadService.insertFile(uploaddto);
							} //if end
						} //inner end
					} //outer end
				}
			}
			
			return "redirect:/getproducts";
		}
		
		//상품판매글 등록시 디테일 태그 보여주기
		@RequestMapping(value="/getpdtdetailtags", produces= {"application/json;charset=utf-8"})
		@ResponseBody
		public List<ProductDetailDTO> getpdtDetailTags(String keyword) {
			keyword = "%"+keyword+"%";
			List<ProductDetailDTO> tag_result = pdtService.getpdtDetailTags(keyword);
			return tag_result;
		}

		// 카테고리별 상품 보기 
		@RequestMapping("/getproducts")
		public ModelAndView getProducts(@RequestParam(value= "idol_num", defaultValue = "0") int idol_num, @RequestParam(value= "category_num", defaultValue = "0") int category_num, HttpServletRequest request){

			ModelAndView mv = new ModelAndView();
			HttpSession session = request.getSession();
			if(session.getAttribute("sessionUser_num")!=null) { //로그인 된 상태 -> 찜한 목록을 가져와 버튼에 표시한다.
				int user_num = (int) session.getAttribute("sessionUser_num");
				if(user_num != 0) {
				List<Integer> like_product = pdtService.getLikeProduct(user_num);
				mv.addObject("likeproduct", like_product);
				}
			}
			List<ProductDTO> productlist =null ;
		
			if(idol_num==0 && category_num ==0) { // 기본 전체 상품 보여주기 
				productlist = pdtService.getAllProducts();
			}else if(category_num==0) { //해당 아이돌의 전체 상품 보여주기
				productlist = pdtService.getProductsIdol(idol_num);
			}else {
				ProductDTO dto = new ProductDTO();
				dto.setIdol_num(idol_num);
				dto.setCategory_num(category_num);
				//상품 리스트가지고 오기 
				productlist = pdtService.getProducts(dto);
				
			}
			
			mv.setViewName("product/productlist");
			mv.addObject("productlist", productlist);
			return mv;
		}
		
		// 찜하기 
		@RequestMapping("/likeclickajax")
		@ResponseBody
		public String likeProduct(int product_num, HttpServletRequest request) {

			HttpSession session = request.getSession();
			int user_num = (int) session.getAttribute("sessionUser_num");
			
			ProductDTO dto = new ProductDTO();
			dto.setUser_num(user_num);
			dto.setProduct_num(product_num);
			
			int insert_result = pdtService.likeProduct(dto);
			if(insert_result>0) return "{\"result\" : \"success\"}";
			else return "{\"result\" : \"fail\"}";
		}
		
		// 찜 취소 
		@RequestMapping("/unlikeclickajax")
		@ResponseBody
		public String unlikeProduct(int product_num, HttpServletRequest request) {

			HttpSession session = request.getSession();
			int user_num = (int) session.getAttribute("sessionUser_num");
			
			ProductDTO dto = new ProductDTO();
			dto.setUser_num(user_num);
			dto.setProduct_num(product_num);
			
			int insert_result = pdtService.unlikeProduct(dto);
			if(insert_result>0) return "{\"result\" : \"success\"}";
			else return "{\"result\" : \"fail\"}";
		}
		
		// 시세확인 
		@RequestMapping("/quote")
		public ModelAndView getQuoteform(int detail_num,HttpServletRequest request) {
			ModelAndView mv = new ModelAndView();
//			List<ProductDTO> dto = pdtService.getQuote(detail_num);
//			mv.addObject("quotelist", dto);
			mv.setViewName("product/quote");
			return mv;
		}
		
		@RequestMapping("/quoteajax")
		@ResponseBody
		public List<ProductDTO> getQuote(int detail_num,HttpServletRequest request) {
			List<ProductDTO> dto = pdtService.getQuote(detail_num);
			return dto;
		}
		
		@RequestMapping("/quotefilterajax")
		@ResponseBody
		public List<ProductDTO> getQuoteFilter(ProductDTO dto) {
			//System.out.println("받아온거 ::"+dto.getProduct_status1()+dto.getProduct_status2()+dto.getProduct_status3()+dto.getProduct_status4()+dto.getProduct_status5());
			List<ProductDTO> filterlist = pdtService.getQuoteFilter(dto);
//			for(int i=0;i<filterlist.size();i++) {
//				System.out.println("결과::: "+filterlist.get(i));
//			}
			return filterlist;
		}
		
		// 판매자 상단바에 알림 띄울 때 가져오는 정보 - 구매확정된 건 있는지, 결제 완료된 건 있는지 가져와서 알림으로 보여줌
		@RequestMapping("/getSaleslist")
		@ResponseBody
		public List<ProductDTO> getSaleslist(HttpServletRequest request){
			HttpSession session = request.getSession();
			List<ProductDTO> dto = null;
			List<ProductDTO> dto2 = null;
			List<ProductDTO> dto3 = null;
			List<ProductDTO> joined =null;
			if(session.getAttribute("sessionUser_num")!=null) {
				int user_num = (int) session.getAttribute("sessionUser_num");
				dto = pdtService.getSaleslist(user_num); // 구매 확정 건 
				dto2 = pdtService.getSaleslist2(user_num); // 결제 완료 건 
				dto3 = pdtService.getSaleslist3(user_num); // 운송장 번호 등록 완료건 
				
				joined = Stream.concat(dto.stream(), dto2.stream())
                        .collect(Collectors.toList());
				
				joined = Stream.concat(joined.stream(), dto3.stream())
                        .collect(Collectors.toList());
			}
			return joined;
		}
	
//	@RequestMapping("/buyinglist")
//	public ModelAndView buyinglist(int buyer_num) {
//		
//		ModelAndView mv = new ModelAndView();
//		//List<ProductDTO> buyinglist = pdtService.getBuyinglist(buyer_num);
//		List<Map<String,String>> buyinglist = pdtService.getBuyinglist(buyer_num);
//		for(Map<String,String> s:buyinglist) {
//			System.out.println(s);
//		}
//		mv.addObject("buyinglist",buyinglist);
//		
//		mv.setViewName("product/buyinglist");
//		
//		return mv;
//	}
		
		@RequestMapping("/buyinglist")
		public ModelAndView buyinglist(HttpServletRequest request){
			HttpSession session = request.getSession();
			int buyer_num=0;
			if(session.getAttribute("sessionUser_num")!=null) {
				 buyer_num = (int) session.getAttribute("sessionUser_num");
			}
			ModelAndView mv = new ModelAndView();
			//List<ProductDTO> buyinglist = pdtService.getBuyinglist(buyer_num);
			List<Map<String,String>> buyinglist = pdtService.getBuyinglist(buyer_num);
			for(Map<String,String> s:buyinglist) {
				System.out.println(s);
			}
			mv.addObject("buyinglist",buyinglist);
			
			mv.setViewName("product/buyinglist");
			
			return mv;
		}		
	

	//[승희] 판매글 수정하기
	@GetMapping("/updatesales")
	ModelAndView updateBoard(int product_num) {
		//product_num 글 조회 - ProductDTO - 뷰 폼 보여주자
		ProductDTO dto = pdtService.getDetail(product_num);
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("dto", dto);
		mv.setViewName("product/updateform");
		return mv;
	}

	@PostMapping("/updatesales")
	String updateBoard(ProductDTO dto)throws IOException {
		//글 내용 수정
		pdtService.updateSales(dto);
		//기존에 있던 사진 삭제
		uploadService.deleteFile(dto.product_num);
		//사진 다시 등록
		UploadDTO uploaddto = new UploadDTO();
		
		//사진 등록 경로 : 본인에 맞게 수정
		String savePath="C:\\Users\\LEE\\Desktop\\final_project\\final\\src\\main\\webapp\\resources\\images\\";
		String [] imgexp = {"jpg","jfif","png","jpeg"}; //업로드 가능한 이미지 확장자들
		int last_insert_pdt_num = 0;

		if(dto.getImages()[0].getSize() !=0) {   //—파일이 있을 경우만 저장 수정완료 

			//if(update_result>0) { // 파일이 있고 게시물이 성공적으로 저장되었을 때 파일 저장
				last_insert_pdt_num = pdtService.getLastInsertNum();
				uploaddto.setProduct_num(last_insert_pdt_num); //마지막 저장된 테이블의 PK가져옴
				
				for(int i=0;i<dto.getImages().length;i++) {

					String filename = dto.getImages()[i].getOriginalFilename();   //--- 파일명을 얻어옴. a.txt

					System.out.println(filename);
					String beforeext1 = filename.substring(0, filename.indexOf("."));  //a
					String ext1 = filename.substring(filename.indexOf("."));  //.txt
					ext1 = ext1.substring(1); //txt
					
					//확장자가 이미지일때만 난수 붙여 파일 저장후 DB에 기록
					for(int j=0;j<imgexp.length;j++) {
						if(imgexp[j].equals(ext1)) {
							String newname1 = beforeext1 +"(" +UUID.randomUUID().toString() +")"+ ext1;
							uploaddto.setImage_path(newname1);
							File servefile1 = new File(savePath+newname1);
							dto.getImages()[i].transferTo(servefile1); 
							uploadService.insertFile(uploaddto);
						} //if end
					} //inner end
				} //outer end
			//}
		}
		return "/temp_mainpage";
	}
	
	//[승희] 메인페이지 검색 토글
	@RequestMapping("/search")
//	@ResponseBody
	public ModelAndView searchSimple(@RequestParam(value="search_select",required =true)String search_select ,  @RequestParam(value="keyword" , required = true) String keyword){
		ModelAndView mv = new ModelAndView();
		ProductDTO dto = new ProductDTO();

		System.out.println(search_select+" : "+keyword);

		if(search_select.equals("product_title")) {
			dto.setProduct_title(keyword);
		}else if(search_select.equals("product_contents")) {
			dto.setProduct_contents(keyword);
		}
		List<ProductDTO> product_list = pdtService.searchSimple(dto);

		System.out.println(dto);
		
		mv.setViewName("product/simplesearchresult");
		mv.addObject("search_result", product_list);
		return mv;
	}
}
