package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import com.spring.javagreenS_jjm.vo.CartVO;
import com.spring.javagreenS_jjm.vo.ProductVO;
import com.spring.javagreenS_jjm.vo.ReviewVO;

public interface CommodityService {

	public ArrayList<ProductVO> getCandleList(int startIndexNo, int pageSize);

	public ArrayList<ProductVO> getDiffuserList(int startIndexNo, int pageSize);

	public ArrayList<ProductVO> getSprayList(int startIndexNo, int pageSize);

	public ArrayList<ProductVO> getSachetList(int startIndexNo, int pageSize);

	public ArrayList<ProductVO> getHbList(int startIndexNo, int pageSize);

	public ArrayList<ProductVO> getPerfumeList(int startIndexNo, int pageSize);

	public ProductVO getContent(int idx);

	public void cartInput(CartVO vo, int optionSize);

	public ArrayList<ReviewVO> getReviewList(String commodity);

}
