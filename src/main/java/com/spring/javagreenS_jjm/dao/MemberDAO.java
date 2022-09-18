package com.spring.javagreenS_jjm.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.QnaVO;

public interface MemberDAO {

	public int memOrderListTotRecCnt(@Param("mid") String mid);
	
	public ArrayList<BaesongVO> getBaesongList(@Param("mid") String mid, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public int getListSize(@Param("orderIdx") String orderIdx, @Param("mid") String mid);

	public ArrayList<BaesongVO> getOrderList(@Param("orderIdx") String orderIdx, @Param("mid") String mid);

	public void orderDelete(@Param("orderIdx") int orderIdx);

	public ArrayList<BaesongVO> getReviewCheck(@Param("mid") String mid, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int myQnaListTotRecCnt(@Param("mid") String mid);

	public ArrayList<QnaVO> getMyQnaList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public void memDelete(@Param("mid") String mid);
}
