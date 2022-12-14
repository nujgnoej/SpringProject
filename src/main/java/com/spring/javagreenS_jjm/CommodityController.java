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
				optionAdd[i] = optionNames[i] + " (+" + df.format(Integer.parseInt(optionPrices[i])) + "???)";
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
		int deliveryFee = 0;	// ?????????????????? ?????? ?????????
		int totSavePoint = totPrice * 5 / 100;
		int exPrice = totPrice;
		int exTotSavePoint = totSavePoint;
		if(totPrice < 50000) {		// ??????????????? 5?????? ????????????
			deliveryFee = 3000;
			totPrice = totPrice + 3000;
			totSavePoint = totPrice * 5 / 100;
		}
		
		// ????????? ??????????????? ???????????? ?????? '??????????????????'??? ?????????????????????.
		// ??????????????????(idx) ?????????(?????? DB??? ????????????(idx) ????????? ?????? +1 ????????? ?????????) 
		OrderVO maxIdx = cartService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;

		//????????????(orderIdx) ?????????(->??????_idx)
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
		
		// CartView.jsp?????? ????????? ???????????? ??????????????? ????????? ????????? ????????????. ?????? ????????? ????????? name??? 'idxChecked'??????. ??????????????? ?????? 1??????, ??? true??? ?????? ????????????.
//		String[] idxChecked = request.getParameterValues("idxChecked");
		
		OrderVO orderVo = new OrderVO();
		List<OrderVO> orderVos = new ArrayList<OrderVO>();
		// ?????????????????? ?????? ??? orderVo????????? ??????????????? ?????????.
		orderVo.setOrderIdx(orderIdx);
		orderVo.setMid(mid);
		orderVo.setProductIdx(vo.getIdx());				// ????????????
		orderVo.setCommodity(vo.getCommodity());		// ?????????
		orderVo.setSalePrice(salePrice+optionPrice);	// ??????????????????(???????????????)
		orderVo.setOrderQuantity(orderQuantity);		// ????????????
		orderVo.setOptionName(optionName);				// ????????????
		orderVo.setDeliveryFee(deliveryFee);			// ?????????
		orderVo.setTotPrice(exPrice);					// ??? ????????????(?????????????????? + ????????????)
		orderVo.setTotSavePoint(exTotSavePoint);		// ??? ?????????
		orderVo.setFSName(vo.getFSName());				// ???????????????
		orderVos.add(orderVo);
		
		session.setAttribute("sOrderVos", orderVos); // ???????????? ???????????? ?????? ???????????? ????????? ??????????????? ???????????? model??? ??????, session????????????.
		
		// ?????? ???????????? ????????? ????????? login2??????????????? ????????????.
		JoinVO joinVo = joinService.getJoinIdCheck(mid);
		model.addAttribute("joinVo", joinVo);
		model.addAttribute("orderIdx", orderIdx);
		model.addAttribute("deliveryFee", deliveryFee);
		model.addAttribute("totPrice", totPrice);
		model.addAttribute("totSavePoint", totSavePoint);
		
		return "order/orderView";
	}
}
