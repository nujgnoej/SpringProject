package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_jjm.vo.ProductTypeVO;
import com.spring.javagreenS_jjm.vo.ProductVO;

public interface ProductService {

	public ArrayList<ProductVO> getProductList(int startIndexNo, int pageSize);
	
	public ArrayList<ProductTypeVO> getProductType();
	
	public void imgCheckProductInput(MultipartHttpServletRequest file, ProductVO vo);

	public ProductVO getProductInfo(int idx);

	public void productImgDelete(int idx, int imgIdx, String fName, String fSName);

	public void imgDelete(String content);

	public void imgCheck(String content);

	public void setProductUpdate(ProductVO vo, MultipartHttpServletRequest file);

	public void setProductDelete(int idx);

	public void productImgAllDelete(ProductVO vo);

	public void quantityOrder(int idx, int orderQuantity);

}
