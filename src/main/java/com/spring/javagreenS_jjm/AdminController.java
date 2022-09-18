package com.spring.javagreenS_jjm;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_jjm.pagination.PageProcess;
import com.spring.javagreenS_jjm.pagination.PageVO;
import com.spring.javagreenS_jjm.service.AdminService;
import com.spring.javagreenS_jjm.service.MemberService;
import com.spring.javagreenS_jjm.service.ProductService;
import com.spring.javagreenS_jjm.service.QnaService;
import com.spring.javagreenS_jjm.service.ReviewService;
import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.ChartVO;
import com.spring.javagreenS_jjm.vo.JoinVO;
import com.spring.javagreenS_jjm.vo.OrderVO;
import com.spring.javagreenS_jjm.vo.ProductVO;
import com.spring.javagreenS_jjm.vo.QnaReplyVO;
import com.spring.javagreenS_jjm.vo.QnaVO;
import com.spring.javagreenS_jjm.vo.ReviewVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	String msgFlag = "";
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	QnaService qnaService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/adminView", method = RequestMethod.GET)
	public String adminViewGet(Model model) {
		int wrc = 0;
		wrc = adminService.getWatingReplyCount();
		ArrayList<ChartVO> vos = adminService.getOrderCount();
		int vosSize = vos.size();
		ArrayList<BaesongVO> bVos = adminService.getBaesongOkList();
		int bVosSize = bVos.size();
		int[] listSize = new int[100];
		for(int i=0; i<bVosSize; i++) {
			listSize[i] = memberService.getListSize(bVos.get(i).getOrderIdx(), bVos.get(i).getMid());
		}
		ArrayList<OrderVO> oVos = adminService.getOrderCountByDate();
		int oVosSize = oVos.size();
		String[] orderDate = new String[3];
		String[] strOrderDate = new String[100];
		for(int i=0; i<oVosSize; i++) {
			orderDate = oVos.get(i).getOrderDate().split("-");
			strOrderDate[i] = orderDate[0].substring(2,orderDate[0].length()) + "년 " + orderDate[1] + "월 " + orderDate[2] + "일";
		}
		
		model.addAttribute("wrc", wrc);
		model.addAttribute("vos", vos);
		model.addAttribute("vosSize", vosSize);
		model.addAttribute("bVos", bVos);
		model.addAttribute("listSize", listSize);
		model.addAttribute("oVos", oVos);
		model.addAttribute("oVosSize", oVosSize);
		model.addAttribute("strOrderDate", strOrderDate);
		
		return "admin/adminView";
	}
	
	// 회원리스트 출력
	@RequestMapping(value = "/memList", method = RequestMethod.GET)
	public String memListGet(JoinVO vo, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "admin", "", "");
		
		ArrayList<JoinVO> vos = adminService.getMemList(pageVO.getStartIndexNo(), pageSize);
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); // 탈퇴30일 이후부터 회원정보를 삭제하기 위하여 현재날짜 yyyy-MM-dd를 넘긴다.
		String nowDate = simpleDateFormat.format(new Date());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("nowDate", nowDate);
		
		return "admin/member/memList";
	}
	
	// 회원등급변경
	@ResponseBody
	@RequestMapping(value = "/levelUpdate", method = RequestMethod.POST)
	public String levelUpdatePost(int idx, String strLevel, Model model) {
		int level = 0;
		if (strLevel.equals("회원")) level = 4;
		else if (strLevel.equals("실버회원")) level = 3;
		else if (strLevel.equals("골드회원")) level = 2;
		
		adminService.levelUpdate(idx, level);
		
		return "";
	}
	
	// 리뷰리스트 출력
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
		
		return "admin/review/adReviewList";
	}
	
	// 리뷰삭제
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.POST)
	public String reviewDeletePost(int orderIdx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		// 리뷰글을 삭제하기 전 리뷰의 정보를 vo에 담아서 가져온다.(이미지 삭제를 위함)
		ReviewVO vo = reviewService.getReviewInfo(orderIdx);
		
		// 리뷰삭제(이미지삭제)
		reviewService.setReviewDelete(vo, orderIdx);
		
		model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);
		
		return "redirect:/msg/adReviewDeleteOk";
	}
	
	// 리뷰상세페이지
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
		
		return "admin/review/adReviewContent";
	}
	
	// 주문관리페이지
	@RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public String orderListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "order", "", "");
		ArrayList<BaesongVO> vos = adminService.getOrderList(pageVO.getStartIndexNo(), pageSize);
		int vosSize = vos.size();
		int[] listSize = new int[100];
		
		for(int i=0; i<vosSize; i++) {
			listSize[i] = memberService.getListSize(vos.get(i).getOrderIdx(), vos.get(i).getMid());
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vosSize", vosSize);
		model.addAttribute("listSize", listSize);
		
		return"admin/order/adOrderList";
	}
	
	// 주문현황변경
	@ResponseBody
	@RequestMapping(value = "/orderStatusUpdate", method = RequestMethod.POST)
	public String orderStatusUpdatePost(int orderIdx, String orderStatus) {
		adminService.setOrderStatusUpdate(orderIdx, orderStatus);
		
		return "";
	}
	
	// 주문상세페이지
	@RequestMapping(value = "/orderContent", method = RequestMethod.GET)
	public String orderContentGet(String orderIdx, String mid, Model model) {
		ArrayList<BaesongVO> vos = memberService.getOrderList(orderIdx, mid);
		int vosSize = vos.size();
		int totPrice = 0;
		
		for(int i=0; i<vosSize; i++) {
			totPrice += vos.get(i).getTotPrice();
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("vosSize", vosSize);
		model.addAttribute("orderTotPrice", vos.get(0).getOrderTotalPrice());
		model.addAttribute("totPrice", totPrice);
		
		return "admin/order/orderContent";
	}
	
	// Q&A리스트 출력
	@RequestMapping(value = "/qnaList", method = RequestMethod.GET)
	public String qnaListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "qna", "", "");
		ArrayList<QnaVO> vos = qnaService.getQnaList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/qna/adQnaList";
	}
	
	// Q&A 상세페이지
	@RequestMapping(value = "/qnaContent", method = RequestMethod.GET)
	public String qnaContentGet(Model model, int idx, HttpSession session,
			@RequestParam(name="flag", defaultValue = "qna", required = false) String flag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		QnaVO vo = qnaService.getQnaContent(idx);	// 원본글 가져오기
		ArrayList<QnaReplyVO> replyVos = qnaService.getQnaReply(idx);		// 댓글 가져오기(replyVos)
		int replyVosSize = replyVos.size();
		
		model.addAttribute("vo", vo);
		model.addAttribute("replyVos", replyVos);
		model.addAttribute("replyVosSize", replyVosSize);
		model.addAttribute("flag", flag);
		model.addAttribute("idx", idx);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "admin/qna/adQnaContent";
	}
	
	// Q&A 삭제
	@RequestMapping(value = "/qnaDelete", method = RequestMethod.GET)
	public String qnaDeleteGet(int idx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		qnaService.qnaDelete(idx);
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "qna", "", "");
		ArrayList<QnaVO> vos = qnaService.getQnaList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);
		
		return "redirect:/msg/adQnaDeleteOk";
	}
	
	// Q&A 답변입력
	@ResponseBody
	@RequestMapping(value = "/qnaReplyInput", method = RequestMethod.POST)
	public String qnaReplyInputPost(QnaReplyVO replyVo) {
		int levelOrder = 0;
		
		String strLevelOrder = qnaService.maxLevelOrder(replyVo.getQnaIdx());
		if(strLevelOrder != null) levelOrder =  Integer.parseInt(strLevelOrder) + 1;
		replyVo.setLevelOrder(levelOrder);
		
		qnaService.setQnaReplyInput(replyVo);
		qnaService.setQnaAdChkUpdate(replyVo.getQnaIdx());
		
		return "1";
	}
	
	// Q&A 답변삭제
	@ResponseBody
	@RequestMapping(value = "/qnaReplyDeleteOk", method = RequestMethod.POST)
	public String qnaReplyDeleteOkPost(int idx, int qnaIdx) {
		qnaService.setQnaReplyDeleteOk(idx);
		ArrayList<QnaReplyVO> replyVos = qnaService.getQnaReply(qnaIdx);
		int deleteSw = 0;
		for(int i=0; i<replyVos.size(); i++) {
			if(replyVos.get(i).getDeleteSw().equals("no")) {
				deleteSw = deleteSw + 1;
			}
		}
		if (deleteSw == 0) {
			qnaService.setQnaAdChkUpdate2(qnaIdx);
		}
		return "";
	}
	
	// 대댓글의 경우 나중에 쓴 댓글이 먼저 나오게 처리한것
	@ResponseBody
	@RequestMapping(value = "/qnaReplyInput2", method = RequestMethod.POST)
	public String qnaReplyInput2Post(QnaReplyVO replyVo) {
		qnaService.levelOrderPlusUpdate(replyVo);			// 부모글의 levelOrder(글순서)값보다 큰 모든 댓글의 levelOrder값을 +1 시켜준다(update)
		replyVo.setLevel(replyVo.getLevel()+1);  			// 자신의 level은 부모 level 보다 +1 시켜준다.
		replyVo.setLevelOrder(replyVo.getLevelOrder()+1);	// 자신의 levelOrder은 부모의 levelOrder보다 +1 시켜준다.
		qnaService.setQnaReplyInput2(replyVo);				// 대댓글 저장
		
		return "";
	}
	
	// 회원탈퇴이후 마지막접속일이 30일이상 지난 회원 DB삭제처리
	@ResponseBody
	@RequestMapping(value = "/memInfoDelete", method = RequestMethod.POST)
	public String memInfoDeletePost(String mid) {
		adminService.memInfoDelete(mid);
		return "";
	}
	
	// 사진 임시저장된 경로 이미지삭제
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/tempDelete", method = RequestMethod.GET)
	public String tempDeleteGet(HttpServletRequest request, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) throws IOException {
		String realPath = request.getRealPath("/resources/data/admin/");
		
		String[] files = new File(realPath).list();
		String strFilesSize = Integer.toString(files.length);
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "tempFile", strFilesSize, "");
		
		model.addAttribute("files", files);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/temp/tempDelete";
	}
	
	// 임시폴더 이미지 삭제
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "/imgDel", method = RequestMethod.POST)
	public String imgDelPost(HttpServletRequest request, int indexNo) {
		String realPath = request.getRealPath("/resources/data/admin/");
		String[] files = new File(realPath).list();
		String realPathFile = realPath + files[indexNo];
		new File(realPathFile).delete();
		
		return "";
	}
	
	// 임시폴더 이미지 전체삭제
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "/imgAllDel", method = RequestMethod.POST)
	public String imgAllDelPost(HttpServletRequest request) {
		String realPath = request.getRealPath("/resources/data/admin/");
		String[] files = new File(realPath).list();
		for(String fileName : files) {
			if(fileName.indexOf(".") != -1) {
				String[] fileNames = fileName.split("[.]");
				if(fileNames[fileNames.length-1].toUpperCase().equals("JPG") || 
						fileNames[fileNames.length-1].toUpperCase().equals("JPEG") || 
						fileNames[fileNames.length-1].toUpperCase().equals("PNG") || 
						fileNames[fileNames.length-1].toUpperCase().equals("GIF")) {
					
					String realPathFile = realPath + fileName;
					new File(realPathFile).delete();
				}
			}
			else {
				continue;
			}
		}
		
		return "";
	}
}
