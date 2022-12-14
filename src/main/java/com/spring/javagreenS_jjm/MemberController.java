package com.spring.javagreenS_jjm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
import com.spring.javagreenS_jjm.service.CartService;
import com.spring.javagreenS_jjm.service.JoinService;
import com.spring.javagreenS_jjm.service.MemberService;
import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.JoinVO;
import com.spring.javagreenS_jjm.vo.QnaVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	JoinService joinService;
	
	@Autowired
	CartService cartService;
	
	@Autowired
	PageProcess pageProcess;
	

	@RequestMapping(value = "/mypageView", method = RequestMethod.GET)
	public String mypageViewGet(Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		String mid = (String) session.getAttribute("sMid");
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myQna", mid, "");
		ArrayList<QnaVO> qnaVos = memberService.getMyQnaList(pageVO.getStartIndexNo(), pageSize, mid);
		JoinVO vo = joinService.getJoinIdCheck(mid);
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		
		model.addAttribute("qnaVos", qnaVos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vo", vo);
		
		return "member/mypageView";
	}
	
	@RequestMapping(value = "/memOrderList", method = RequestMethod.GET)
	public String memOrderListGet(Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		String mid = (String) session.getAttribute("sMid");
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "memOrder", mid, "");
		
		ArrayList<BaesongVO> vos = memberService.getBaesongList(mid, pageVO.getStartIndexNo(), pageSize);
		int vosSize = vos.size();	// ???????????? ????????????????????? ??????
		int[] listSize = new int[100];		// ????????? ????????? ??????????????? ????????????
		String[] baesongDate = new String[100];	// ??????????????? ????????? ?????????????????? ????????????
		
		for(int i=0; i<vosSize; i++) {	// ???????????? ???????????? ???????????? ??????
			listSize[i] = memberService.getListSize(vos.get(i).getOrderIdx(), mid);
			baesongDate[i] = vos.get(i).getBaesongDate().substring(0, 10);
		}
		ArrayList<BaesongVO> reviewVos = memberService.getReviewCheck(mid, pageVO.getStartIndexNo(), pageSize);	// ????????????????????? ??????????????? ???????????? ???????????? reviewVos??? ????????????.
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); // ?????? 7??????????????? ??????????????? ??????????????? ???????????? yyyy-MM-dd??? ???????????? ?????????.
		String nowDate = simpleDateFormat.format(new Date());
		
		model.addAttribute("vos", vos);
		model.addAttribute("vosSize", vosSize);
		model.addAttribute("listSize", listSize);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("baesongDateList", baesongDate);
		model.addAttribute("reviewVos", reviewVos);
		
		return "member/memOrderList";
	}
	
	@RequestMapping(value = "/memOrderDetail", method = RequestMethod.GET)
	public String memOrderDetailGet(Model model, HttpSession session, String orderIdx) {
		String mid = (String) session.getAttribute("sMid");
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
		
		return "member/memOrderDetail";
	}
	
	@ResponseBody
	@RequestMapping(value = "/orderDel", method = RequestMethod.POST)
	public String orderDelPost(int orderIdx) {
		memberService.orderDelete(orderIdx);
		return "";
	}
	
	@RequestMapping(value = "/memDelete", method = RequestMethod.GET)
	public String memDelete(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		memberService.memDelete(mid);
		session.invalidate();
		return "redirect:/msg/memDeleteOk";
	}
}
