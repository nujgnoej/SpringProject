package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_jjm.dao.CartDAO;
import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.CartVO;
import com.spring.javagreenS_jjm.vo.OrderVO;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	CartDAO cartDAO;

	@Override
	public ArrayList<CartVO> getCartList(String mid) {
		return cartDAO.getCartList(mid);
	}

	@Override
	public int getCartListCnt(String mid) {
		return cartDAO.getCartListCnt(mid);
	}
	
	@Override
	public void setCartUpdate(CartVO vo) {
		cartDAO.setCartUpdate(vo);
	}

	@Override
	public void setCartDelete(int idx) {
		cartDAO.setCartDelete(idx);
	}

	@Override
	public OrderVO getOrderMaxIdx() {
		return cartDAO.getOrderMaxIdx();
	}

	@Override
	public CartVO getCartIdx(int idx) {
		return cartDAO.getCartIdx(idx);
	}

	@Override
	public void setOrderInput(OrderVO vo) {
		cartDAO.setOrderInput(vo);
	}

	@Override
	public void setCartDeleteAll(int cartIdx) {
		cartDAO.setCartDeleteAll(cartIdx);
	}

	@Override
	public void setMemberPointUpdate(int point, String mid, int usePoint) {
		cartDAO.setMemberPointUpdate(point, mid, usePoint);
	}

	@Override
	public void setBaesongInput(BaesongVO baesongVo) {
		cartDAO.setBaesongInput(baesongVo);
	}

	@Override
	public void setQuantityUpdate(int productIdx, int orderQuantity) {
		cartDAO.setQuantityUpdate(productIdx, orderQuantity);
	}
	
	
}
