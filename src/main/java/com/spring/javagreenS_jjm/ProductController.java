package com.spring.javagreenS_jjm;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_jjm.pagination.PageProcess;
import com.spring.javagreenS_jjm.pagination.PageVO;
import com.spring.javagreenS_jjm.service.ProductService;
import com.spring.javagreenS_jjm.vo.ProductTypeVO;
import com.spring.javagreenS_jjm.vo.ProductVO;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	ProductService productService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 제품리스트페이지 이동
	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public String productListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "product", "", "");
		ArrayList<ProductVO> vos = productService.getProductList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/product/productList";
	}
	
	
	// 제품등록페이지 이동
	@RequestMapping(value = "/productInput", method = RequestMethod.GET)
	public String productInputGet(Model model) {
		ArrayList<ProductTypeVO> vos = productService.getProductType();
		
		model.addAttribute("vos", vos);
		
		return "admin/product/productInput";
	}
	
	// 제품등록
	@RequestMapping(value = "/productInput", method = RequestMethod.POST)
	public String productInpuPost(MultipartHttpServletRequest file, ProductVO vo, String[] optionName, int[] optionPrice) {
		String optionNames = "";
		String optionPrices = "";
		
		for(int i=0; i<optionName.length; i++) {
			optionNames += optionName[i] + "/";
			optionPrices += optionPrice[i] + "/";
		}
		vo.setOptionName(optionNames);
		vo.setOptionPrice(optionPrices);
		
		// 이미지파일 업로드시에는 ckeditor폴더에서 product폴더로 복사작업처리
		productService.imgCheckProductInput(file, vo);
		
		return "redirect:/msg/productInputOk";
	}
	
	// 제품수정페이지 이동
	@RequestMapping(value = "/productUpdate", method = RequestMethod.GET)
	public String productUpdateGet(int idx, 
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			Model model) {
		ProductVO vo = productService.getProductInfo(idx);
		ArrayList<ProductTypeVO> typeVos = productService.getProductType();
		String[] optionNames = vo.getOptionName().split("/");
		String[] optionPrices = vo.getOptionPrice().split("/");
		String[] fSNames = vo.getFSName().split("/");
		int optionSize = optionNames.length;
		
		model.addAttribute("vo", vo);
		model.addAttribute("typeVos", typeVos);
		model.addAttribute("optionNames", optionNames);
		model.addAttribute("optionPrices", optionPrices);
		model.addAttribute("fSNames", fSNames);
		model.addAttribute("optionSize", optionSize);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "admin/product/productUpdate";
	}
	
	// 상품이미지 삭제
	@ResponseBody
	@RequestMapping(value = "/productImgDelete", method = RequestMethod.POST)
	public String productImgDelete(int idx, int imgIdx, String fName, String fSName) {
		productService.productImgDelete(idx, imgIdx, fName, fSName);
		
		return "";
	}
	
	// 제품수정처리
	@RequestMapping(value = "/productUpdate", method = RequestMethod.POST)
	public String productUpdatePost(MultipartHttpServletRequest file, ProductVO vo, int pag, int pageSize, Model model, String[] optionName, int[] optionPrice) {
		// 수정창으로 들어올때 원본파일에 그림파일이 존재한다면, 현재폴더(product)의 그림파일을 admin폴더로 복사시켜둔다.
		ProductVO oriVo = productService.getProductInfo(vo.getIdx());
		
		// content안에서 내용의 수정이 없을시는 아래작업을 처리할 필요가 없다.
		if(!oriVo.getContent().equals(vo.getContent()))	{
			// 수정버튼을 클릭하고 post 호출시에는 기존의 product폴더의 사진파일들을 모두 삭제처리한다.
			if(oriVo.getContent().indexOf("src=\"/") != -1) productService.imgDelete(oriVo.getContent());
			
			// 파일복사전에 원본파일의 위치가 'data/admin/product'폴더였던것을 'data/admin'폴더로 변경시켜두어야 한다.
			vo.setContent(vo.getContent().replace("/data/admin/product/", "/data/admin/"));
			
			// 앞의 준비작업이 완료되면, 수정된 그림(복사된그림)을 다시 product폴더에 복사처리한다.(/data/admin/ -> /data/admin/product/)
			// 이 작업은 처음 게시글을 올릴때의 파일복사 작업과 동일한 작업이다.
			productService.imgCheck(vo.getContent());
			
			// 다시 admin에 있는 그림파일의 경로를 admin/product폴더로 변경시켜준다.
			vo.setContent(vo.getContent().replace("/data/admin/", "/data/admin/product/"));
		}
		
		// 옵션값 정리
		String optionNames = "";
		String optionPrices = "";
		
		for(int i=0; i<optionName.length; i++) {
			optionNames += optionName[i] + "/";
			optionPrices += optionPrice[i] + "/";
		}
		vo.setOptionName(optionNames);
		vo.setOptionPrice(optionPrices);
		
		// 잘 정비된 vo를 DB에 저장시켜준다.
		productService.setProductUpdate(vo, file);
		
		model.addAttribute("flag", "?idx="+vo.getIdx()+"&pag="+pag+"&pageSize="+pageSize);
		
		return "redirect:/msg/productUpdateOk";
	}
	
	// 제품삭제처리
	@ResponseBody
	@RequestMapping(value = "/productDelete", method = RequestMethod.POST)
	public String productDelete(int idx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		ProductVO vo = productService.getProductInfo(idx);
		// 게시글 제품메인사진 삭제처리
		productService.productImgAllDelete(vo);
		
		// 게시글에 사진이 존재한다면 서버에 존재하는 사진파일을 먼저 삭제처리(content-제품설명사진).
		if(vo.getContent().indexOf("src=\"/") != -1) productService.imgDelete(vo.getContent());
		
		// DB에서 실제 게시글을 삭제처리한다.
		productService.setProductDelete(idx);
		
		return "";
	}
	
	// 제품주문처리
	@ResponseBody
	@RequestMapping(value = "/quantityOrder", method = RequestMethod.POST)
	public String quantityOrder(int idx, int orderQuantity) {
		productService.quantityOrder(idx, orderQuantity);
		return "";
	}
}
