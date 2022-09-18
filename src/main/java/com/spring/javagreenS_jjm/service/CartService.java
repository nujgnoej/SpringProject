package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.CartVO;
import com.spring.javagreenS_jjm.vo.OrderVO;

public interface CartService {

	public ArrayList<CartVO> getCartList(String mid);

	public int getCartListCnt(String mid);
	
	public void setCartUpdate(CartVO vo);

	public void setCartDelete(int idx);

	public OrderVO getOrderMaxIdx();

	public CartVO getCartIdx(int idx);

	public void setOrderInput(OrderVO vo);

	public void setCartDeleteAll(int cartIdx);

	public void setMemberPointUpdate(int point, String mid, int usePoint);

	public void setBaesongInput(BaesongVO baesongVo);

	public void setQuantityUpdate(int productIdx, int orderQuantity);
	
}
