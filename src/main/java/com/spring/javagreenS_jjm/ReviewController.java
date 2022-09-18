package com.spring.javagreenS_jjm;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_jjm.pagination.PageProcess;
import com.spring.javagreenS_jjm.pagination.PageVO;
import com.spring.javagreenS_jjm.service.ReviewService;
import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.ProductVO;
import com.spring.javagreenS_jjm.vo.ReviewVO;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 리뷰작성화면 출력
	@RequestMapping(value = "/reviewWrite", method = RequestMethod.POST)
	public String reviewWritePost(int orderIdx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		ArrayList<BaesongVO> vos = reviewService.getOrderInfo(orderIdx);
		int vosSize = vos.size();
//		System.out.println("vos : " + vos);
		model.addAttribute("vos", vos);
		model.addAttribute("vosSize", vosSize);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "review/reviewWrite";
	}
	
	// 리뷰작성
	@RequestMapping(value = "/reviewInput", method = RequestMethod.POST)
	public String reviewInputPost(MultipartFile file, ReviewVO vo, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		int orderIdx = Integer.parseInt(vo.getOrderIdx());
		ArrayList<BaesongVO> vos = reviewService.getOrderInfo(orderIdx);
		String commoditys = "";
		for(int i=0; i<vos.size(); i++) {
			commoditys += vos.get(i).getCommodity() + "/";
		}
		vo.setCommodity(commoditys);
//		System.out.println("vo : " + vo);
		reviewService.setReviewInput(file, vo);

		model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);
		
		return "redirect:/msg/reviewInputOk";
	}
	
	// 리뷰수정화면 출력
	@RequestMapping(value = "/reviewUpdate", method = RequestMethod.POST)
	public String reviewUpdatePost(int orderIdx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		ReviewVO vo = reviewService.getReviewInfo(orderIdx);
		
		int contentLen = vo.getContent().replaceAll(System.getProperty("line.separator"), " ").length();
		
		model.addAttribute("vo", vo);
		model.addAttribute("contentLen", contentLen);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "review/reviewUpdate";
	}
	
	// 리뷰이미지삭제
	@ResponseBody
	@RequestMapping(value = "/reviewImgDelete", method = RequestMethod.POST)
	public String reviewImgDeletePost(int orderIdx, String fSName) {
		reviewService.reviewImgDelete(orderIdx, fSName);
		return "";
	}
	
	// 리뷰수정
	@RequestMapping(value = "/reviewUpdateOk", method = RequestMethod.POST)
	public String reviewUpdateOkPost(MultipartFile file, ReviewVO vo, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		ReviewVO rVo = reviewService.getReviewInfo(Integer.parseInt(vo.getOrderIdx()));
		reviewService.setReviewUpdate(file, rVo);
		
		model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);
		
		return "redirect:/msg/reviewUpdateOk";
	}
	
	// 리뷰삭제
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.POST)
	public String reviewDeletePost(int orderIdx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		// 리뷰글을 삭제하기 전 리뷰의 정보를 vo에 담아서 가져온다.(이미지 삭제를 위함)
		ReviewVO vo = reviewService.getReviewInfo(orderIdx);
		
		// 리뷰삭제(이미지삭제)
		reviewService.setReviewDelete(vo, orderIdx);
		
		model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);
		
		return "redirect:/msg/reviewDeleteOk";
	}
	
	// 리뷰 전체리스트
	@RequestMapping(value = "/reviewList", method = RequestMethod.GET)
	public String reviewListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "review", "", "");
		ArrayList<ReviewVO> vos = reviewService.getReviewList(pageVO.getStartIndexNo(), pageSize);
		int vosSize = vos.size();
		int[] commoditySize = new int[100];
		
		for(int i=0; i<vosSize; i++) {	// 한사람당 각주문한 상품갯수 계산
			commoditySize[i] = vos.get(i).getCommodity().split("/").length;
		}
		model.addAttribute("vos", vos);
		model.addAttribute("commoditySize", commoditySize);
		model.addAttribute("pageVO", pageVO);
		
		return "review/reviewList";
	}
	
	// 리뷰 상세보기
	@RequestMapping(value = "/reviewContent", method = RequestMethod.POST)
	public String reviewContentPost(Model model, int orderIdx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		ReviewVO vo = reviewService.getReviewInfo(orderIdx);
		String[] commoditys = new String[100];
		commoditys = vo.getCommodity().split("/");
		ArrayList<ProductVO> productVos = new ArrayList<ProductVO>();
		for(String commodity : commoditys) {
			ProductVO productVo = reviewService.getProductInfo(commodity);
			
			productVos.add(productVo);
		}
		int pVosSize = productVos.size();
		model.addAttribute("vo", vo);
		model.addAttribute("productVos", productVos);
		model.addAttribute("pVosSize", pVosSize);
		
		return "review/reviewContent";
	}
}