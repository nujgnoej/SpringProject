package com.spring.javagreenS_jjm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import com.spring.javagreenS_jjm.service.CartService;
import com.spring.javagreenS_jjm.service.JoinService;
import com.spring.javagreenS_jjm.service.MemberService;
import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.CartVO;
import com.spring.javagreenS_jjm.vo.JoinVO;
import com.spring.javagreenS_jjm.vo.OrderVO;
import com.spring.javagreenS_jjm.vo.PayMentVO;
import com.spring.javagreenS_jjm.vo.QnaVO;

@Controller
@RequestMapping("/cart")
public class CartController {

	@Autowired
	CartService cartService;
	
	@Autowired
	JoinService joinService;
	
	@Autowired
	MemberService memberService;

	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/cartView", method = RequestMethod.GET)
	public String cartViewGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		ArrayList<CartVO> vos = cartService.getCartList(mid);	// 해당 아이디로 장바구니테이블에 저장된 정보를 vos에 담아서 온다.
		
		int cnt = cartService.getCartListCnt(mid);	// 해당 아이디로 장바구니테이블에 저장된 갯수를 받아온다.
		
		model.addAttribute("vos", vos);
		model.addAttribute("cnt", cnt);
		
		return "cart/cartView";
	}
	
	@RequestMapping(value = "/cartUpdate", method = RequestMethod.GET)
	public String cartUpdateGet(int idx, int orderQuantity, int salePrice, HttpSession session, Model model) {
		int totPrice = orderQuantity * salePrice;
		int totSavePoint = totPrice * 5 / 100;
		CartVO vo = new CartVO();
		vo.setIdx(idx);
		vo.setOrderQuantity(orderQuantity);
		vo.setTotPrice(totPrice);
		vo.setTotSavePoint(totSavePoint);
		
		cartService.setCartUpdate(vo);
		
		String mid = (String) session.getAttribute("sMid");
		ArrayList<CartVO> vos = cartService.getCartList(mid);	// 해당 아이디로 장바구니테이블에 저장된 정보를 vos에 담아서 온다.
		
		int cnt = cartService.getCartListCnt(mid);	// 해당 아이디로 장바구니테이블에 저장된 갯수를 받아온다.
		
		model.addAttribute("vos", vos);
		model.addAttribute("cnt", cnt);
		
		return "cart/cartView";
	}
	
	@ResponseBody
	@RequestMapping(value = "/cartDelete", method = RequestMethod.POST)
	public String cartDeletePost(int idx) {
		cartService.setCartDelete(idx);
		return "";
	}
	
	// 카트에서 담겨있는 품목들중에서, 주문한 품목들을 읽어와서 세션에 담고, 고객의 정보도 가져와서 담고, 주문번호도 만들어서 model에 담아서 다음단계(결제)로 넘겨준다.
	@RequestMapping(value = "/orderView", method = RequestMethod.POST)
	public String orderViewPost(HttpServletRequest request, Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		int deliveryFee = Integer.parseInt(request.getParameter("deliveryFee"));	// 장바구니에서 받은 배송비
		int totPrice = Integer.parseInt(request.getParameter("totPrice"));	// 총금액
		int totSavePoint = Integer.parseInt(request.getParameter("totSavePoint"));	// 총적립금
		
		// 아래는 주문작업이 들어오면 그때 '주문고유번호'를 만들어주면된다.
		// 주문고유번호(idx) 만들기(기존 DB의 고유번호(idx) 최대값 보다 +1 시켜서 만든다) 
		OrderVO maxIdx = cartService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;

		//주문번호(orderIdx) 만들기(->날짜_idx)
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
		
		// CartView.jsp에서 선택한 상품들이 여러개일수 있기에 배열로 넘어온다. 이때 선택한 상품의 name은 'idxChecked'이다. 체크된것은 값이 1인것, 즉 true인 것만 넘어온다.
		String[] idxChecked = request.getParameterValues("idxChecked");
		
		CartVO cartVo = new CartVO();
		List<OrderVO> orderVos = new ArrayList<OrderVO>();
		
		for(String strIdx : idxChecked) {	// idxChecked배열변수에 들어있는 값은 idxChecked의 값이 1인것(true)의 idx값만 담겨있다. 즉, cart의 고유번호를 이용해서 카트에 담긴 삼품의 정보를 가져오려한다.
			cartVo = cartService.getCartIdx(Integer.parseInt(strIdx));		// 장바구니에서 선택된 카트고유번호(idx)를 이용해서 선택된 상품의 정보를 가져온다.
			OrderVO orderVo = new OrderVO();
			orderVo.setOrderIdx(orderIdx);						// 앞에서 '만들어준 주문고유번호'를 저장시켜준다.
			orderVo.setMid(mid);								// 로그인한 아이디를 저장시켜준다.
			orderVo.setProductIdx(cartVo.getProductIdx());		// 제품번호
			orderVo.setCommodity(cartVo.getCommodity());		// 제품명
			orderVo.setSalePrice(cartVo.getSalePrice()+cartVo.getOptionPrice());	// 상품개당가격(옵션가포함)
			orderVo.setOrderQuantity(cartVo.getOrderQuantity());// 주문수량
			orderVo.setOptionName(cartVo.getOptionName());		// 옵션이름
			orderVo.setDeliveryFee(deliveryFee);				// 배송비
			orderVo.setTotPrice(cartVo.getTotPrice());			// 총 주문가격(상품개당가격 + 주문수량)
			orderVo.setTotSavePoint(cartVo.getTotSavePoint());	// 총 적립금
			orderVo.setFSName(cartVo.getFSName());				// 상품이미지
			orderVo.setCartIdx(cartVo.getIdx());				// 장바구니 고유번호
			
			orderVos.add(orderVo);
		}
//		System.out.println("orderVos : " + orderVos);
		session.setAttribute("sOrderVos", orderVos); // 주문에서 보여준후 다시 그대로를 담아서 결제창으로 보내기에 model이 아닌, session처리했다.
		
		// 현재 로그인된 고객의 정보를 login2테이블에서 가져온다.
		JoinVO joinVo = joinService.getJoinIdCheck(mid);
		model.addAttribute("joinVo", joinVo);
		model.addAttribute("orderIdx", orderIdx);
		model.addAttribute("deliveryFee", deliveryFee);
		model.addAttribute("totPrice", totPrice);
		model.addAttribute("totSavePoint", totSavePoint);
		
		return "order/orderView";
	}
	
	// 결제시스템 연습하기(결제창 호출하기) - API이용
	@RequestMapping(value="/payment", method = RequestMethod.POST)
	public String paymentPost(OrderVO orderVo, PayMentVO payMentVo, BaesongVO baesongVo, HttpSession session, Model model) {
		payMentVo.setBuyer_email(baesongVo.getEmail());
		payMentVo.setBuyer_name(baesongVo.getName());
		payMentVo.setBuyer_tel(baesongVo.getTel());
		payMentVo.setBuyer_addr(baesongVo.getAddress());
		String[] address = baesongVo.getAddress().split("/");
		payMentVo.setBuyer_postcode(address[0]);
		payMentVo.setAmount(baesongVo.getOrderTotalPrice());
		
		model.addAttribute("payMentVo", payMentVo);
		
		session.setAttribute("sPayMentVo", payMentVo);
		session.setAttribute("sBaesongVo", baesongVo);
//		System.out.println("payMentVo : " + payMentVo);
//		System.out.println("baesongVo : " + baesongVo);
		
		return "order/paymentOk";
	}
	
	// 결제시스템 연습하기(결제창 호출하기) - API이용
	// 주문 완료후 주문내역을 '주문테이블(order2)에 저장
	// 주문이 완료되었기에 주문된 물품은 장바구니(cart2)에서 내역을 삭제처리한다.
	// 사용한 세션은 제거시킨다.
	// 작업처리후 오늘 구매한 상품들의 정보(구매품목,결제내역,배송지)들을 model에 담아서 확인창으로 넘겨준다.
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/paymentResult", method = RequestMethod.GET)
	public String paymentResultGet(HttpSession session, PayMentVO receivePayMentVo, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		// 주문내역 dbOrder/dbBaesong 테이블에 저장하기(앞에서 저장했던 세션에서 가져왔다.)
		List<OrderVO> orderVos = (List<OrderVO>) session.getAttribute("sOrderVos");
		PayMentVO payMentVo = (PayMentVO) session.getAttribute("sPayMentVo");
		BaesongVO baesongVo = (BaesongVO) session.getAttribute("sBaesongVo");
		// 사용된 세션은 반환한다.
		session.removeAttribute("sOrderVos");
		session.removeAttribute("sPayMentVo");
		session.removeAttribute("sBaesongVo");
		for(OrderVO vo : orderVos) {
			vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8))); // 주문테이블에 고유번호를 셋팅한다.	
			vo.setOrderIdx(vo.getOrderIdx());        				// 주문번호를 주문테이블의 주문번호필드에 지정처리한다.
			vo.setMid(vo.getMid());							
			cartService.setOrderInput(vo);                 	// 주문내용을 주문테이블(order2)에 저장.
			cartService.setCartDeleteAll(vo.getCartIdx()); // 주문이 완료되었기에 장바구니(cart2)에서 주문한 내역을 삭체처리한다.
			cartService.setQuantityUpdate(vo.getProductIdx(),vo.getOrderQuantity());
		}
		// 주문된 정보를 배송테이블에 담기위한 처리(기존 baesongVo에 담기지 않은 내역들을 담아주고 있다.)
		baesongVo.setOIdx(orderVos.get(0).getIdx());
		baesongVo.setOrderIdx(orderVos.get(0).getOrderIdx());
		baesongVo.setAddress(payMentVo.getBuyer_addr());
		baesongVo.setTel(payMentVo.getBuyer_tel());
		cartService.setBaesongInput(baesongVo);  // 배송내용을 배송테이블(baesong2)에 저장
		cartService.setMemberPointUpdate((int)(baesongVo.getTotPrice() * 0.05), orderVos.get(0).getMid(), baesongVo.getUsePoint());	// 회원테이블에 포인트 적립하기(5%)
		
		String mid = (String) session.getAttribute("sMid");
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myQna", mid, "");
		ArrayList<QnaVO> qnaVos = memberService.getMyQnaList(pageVO.getStartIndexNo(), pageSize, mid);
		JoinVO vo = joinService.getJoinIdCheck(mid); // 회원 적립금구하여 마이페이지로 넘김
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		
		model.addAttribute("vos", qnaVos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vo", vo);
//		return "member/mypageView";
		return "redirect:/msg/memberOrderOk";
	}
}
