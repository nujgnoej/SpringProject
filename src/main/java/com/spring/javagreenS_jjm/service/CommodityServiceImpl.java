package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_jjm.dao.CommodityDAO;
import com.spring.javagreenS_jjm.vo.CartVO;
import com.spring.javagreenS_jjm.vo.ProductVO;
import com.spring.javagreenS_jjm.vo.ReviewVO;

@Service
public class CommodityServiceImpl implements CommodityService {
	
	@Autowired
	CommodityDAO commodityDAO;

	@Override
	public ArrayList<ProductVO> getCandleList(int startIndexNo, int pageSize) {
		return commodityDAO.getCandleList(startIndexNo, pageSize);
	}

	@Override
	public ArrayList<ProductVO> getDiffuserList(int startIndexNo, int pageSize) {
		return commodityDAO.getDiffuserList(startIndexNo, pageSize);
	}

	@Override
	public ArrayList<ProductVO> getSprayList(int startIndexNo, int pageSize) {
		return commodityDAO.getSprayList(startIndexNo, pageSize);
	}

	@Override
	public ArrayList<ProductVO> getSachetList(int startIndexNo, int pageSize) {
		return commodityDAO.getSachetList(startIndexNo, pageSize);
	}

	@Override
	public ArrayList<ProductVO> getHbList(int startIndexNo, int pageSize) {
		return commodityDAO.getHbList(startIndexNo, pageSize);
	}

	@Override
	public ArrayList<ProductVO> getPerfumeList(int startIndexNo, int pageSize) {
		return commodityDAO.getPerfumeList(startIndexNo, pageSize);
	}

	@Override
	public ProductVO getContent(int idx) {
		return commodityDAO.getContent(idx);
	}

	@Override
	public void cartInput(CartVO vo, int optionSize) {
		commodityDAO.cartInput(vo, optionSize);
	}

	@Override
	public ArrayList<ReviewVO> getReviewList(String commodity) {
		return commodityDAO.getReviewList(commodity);
	}

}
