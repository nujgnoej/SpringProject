package com.spring.javagreenS_jjm;

import java.text.DecimalFormat;
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
import com.spring.javagreenS_jjm.service.CommodityService;
import com.spring.javagreenS_jjm.service.JoinService;
import com.spring.javagreenS_jjm.vo.CartVO;
import com.spring.javagreenS_jjm.vo.JoinVO;
import com.spring.javagreenS_jjm.vo.OrderVO;
import com.spring.javagreenS_jjm.vo.ProductVO;
import com.spring.javagreenS_jjm.vo.ReviewVO;

@Controller
@RequestMapping("/commodity")
public class CommodityController {
	
	@Autowired
	CommodityService commodityService;
	
	@Autowired
	CartService cartService;
	
	@Autowired
	JoinService joinService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/candleView", method = RequestMethod.GET)
	public String candleViewGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "9", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "candle", "", "");
		
		ArrayList<ProductVO> vos = commodityService.getCandleList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return"commodity/commodityView";
	}
	
	@RequestMapping(value = "/diffuserView", method = RequestMethod.GET)
	public String diffuserViewGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "9", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "diffuser", "", "");
		
		ArrayList<ProductVO> vos = commodityService.getDiffuserList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return"commodity/commodityView";
	}
	
	@RequestMapping(value = "/sprayView", method = RequestMethod.GET)
	public String sprayViewGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "9", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "spray", "", "");
		
		ArrayList<ProductVO> vos = commodityService.getSprayList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return"commodity/commodityView";
	}
	
	@RequestMapping(value = "/sachetView", method = RequestMethod.GET)
	public String sachetViewGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "9", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "sachet", "", "");
		
		ArrayList<ProductVO> vos = commodityService.getSachetList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return"commodity/commodityView";
	}
	
	@RequestMapping(value = "/hbView", method = RequestMethod.GET)
	public String hbViewGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "9", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "hb", "", "");
		
		ArrayList<ProductVO> vos = commodityService.getHbList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return"commodity/commodityView";
	}
	
	@RequestMapping(value = "/perfumeView", method = RequestMethod.GET)
	public String perfumeViewGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "9", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "perfume", "", "");
		
		ArrayList<ProductVO> vos = commodityService.getPerfumeList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return"commodity/commodityView";
	}
	
	@RequestMapping(value = "/commodityContent", method = RequestMethod.GET)
	public String commodityContentGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "9", required = false) int pageSize) {
		ProductVO vo = commodityService.getContent(idx);
		int salePrice = vo.getPrice()-vo.getDiscount();
		String[] optionNames = vo.getOptionName().split("/");
		String[] optionPrices = vo.getOptionPrice().split("/");
		String[] optionAdd = new String[100];
		int optionSize = optionNames.length;
		DecimalFormat df = new DecimalFormat("###,###");
		
		ArrayList<ReviewVO> reviewVos = commodityService.getReviewList(vo.getCommodity()); 
		if(optionSize > 1) {
			for(int i=0; i<optionSize; i++) {
				optionAdd[i] = optionNames[i] + " (+" + df.format(Integer.parseInt(optionPrices[i])) + "원)";
			}
			model.addAttribute("optionAdd", optionAdd);
			model.addAttribute("optionNames", optionNames);
			model.addAttribute("optionPrices", optionPrices);
		}
		model.addAttribute("optionSize", optionSize);
		model.addAttribute("vo", vo);
		model.addAttribute("reviewVos", reviewVos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("salePrice", salePrice);
		
		return "commodity/commodityContent";
	}
	
	@ResponseBody
	@RequestMapping(value = "/salePriceCalc", method = RequestMethod.POST)
	public int salePriceCalc(int quantityNum, int salePrice, Model model) {
		int productPrice = quantityNum * salePrice;
		
		return productPrice;
	}
	
	@ResponseBody
	@RequestMapping(value = "/cart", method = RequestMethod.POST)
	public String cartPost(CartVO vo, String flag,
			@RequestParam(name="selectOption", defaultValue = "", required = false) String selectOption,
			@RequestParam(name="optionSize", defaultValue = "0", required = false) int optionSize) {
		String options[] = selectOption.split("/");
		vo.setOptionName(options[0]);
		
		commodityService.cartInput(vo, optionSize);
		
		return "";
	}
	
	@RequestMapping(value = "/commodityContent", method = RequestMethod.POST)
	public String commodityContentPost(HttpServletRequest request, Model model, HttpSession session, int totPrice, ProductVO vo, int orderQuantity, int salePrice,
			@RequestParam(name="optionName", defaultValue = "", required = false) String optionName,
			@RequestParam(name="optionPrice", defaultValue = "0", required = false) int optionPrice) {
		String mid = (String) session.getAttribute("sMid");
		int deliveryFee = 0;	// 장바구니에서 받은 배송비
		int totSavePoint = totPrice * 5 / 100;
		int exPrice = totPrice;
		int exTotSavePoint = totSavePoint;
		if(totPrice < 50000) {		// 주문금액이 5만원 이하일때
			deliveryFee = 3000;
			totPrice = totPrice + 3000;
			totSavePoint = totPrice * 5 / 100;
		}
		
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
//		String[] idxChecked = request.getParameterValues("idxChecked");
		
		OrderVO orderVo = new OrderVO();
		List<OrderVO> orderVos = new ArrayList<OrderVO>();
		// 바로주문버튼 클릭 시 orderVo객체에 상품정보를 담는다.
		orderVo.setOrderIdx(orderIdx);
		orderVo.setMid(mid);
		orderVo.setProductIdx(vo.getIdx());				// 제품번호
		orderVo.setCommodity(vo.getCommodity());		// 제품명
		orderVo.setSalePrice(salePrice+optionPrice);	// 상품개당가격(옵션가포함)
		orderVo.setOrderQuantity(orderQuantity);		// 주문수량
		orderVo.setOptionName(optionName);				// 옵션이름
		orderVo.setDeliveryFee(deliveryFee);			// 배송비
		orderVo.setTotPrice(exPrice);					// 총 주문가격(상품개당가격 + 주문수량)
		orderVo.setTotSavePoint(exTotSavePoint);		// 총 적립금
		orderVo.setFSName(vo.getFSName());				// 상품이미지
		orderVos.add(orderVo);
		
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
}
