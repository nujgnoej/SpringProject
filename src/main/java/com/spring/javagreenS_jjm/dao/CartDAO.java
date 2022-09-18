package com.spring.javagreenS_jjm.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.CartVO;
import com.spring.javagreenS_jjm.vo.OrderVO;

public interface CartDAO {
	
	public ArrayList<CartVO> getCartList(@Param("mid") String mid);

	public int getCartListCnt(@Param("mid") String mid);

	public void setCartDelete(@Param("idx") int idx);

	public OrderVO getOrderMaxIdx();

	public CartVO getCartIdx(@Param("idx") int idx);

	public void setCartUpdate(@Param("vo") CartVO vo);

	public void setOrderInput(@Param("vo") OrderVO vo);

	public void setCartDeleteAll(@Param("cartIdx") int cartIdx);

	public void setMemberPointUpdate(@Param("point") int point, @Param("mid") String mid, @Param("usePoint") int usePoint);

	public void setBaesongInput(@Param("baesongVo") BaesongVO baesongVo);

	public void setQuantityUpdate(@Param("productIdx") int productIdx, @Param("orderQuantity") int orderQuantity);
}
