package com.spring.javagreenS_jjm.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.ChartVO;
import com.spring.javagreenS_jjm.vo.JoinVO;
import com.spring.javagreenS_jjm.vo.OrderVO;

public interface AdminDAO {

	public ArrayList<JoinVO> getMemList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCnt();	// 회원리스트에 회원수를 계산

	public void levelUpdate(@Param("idx") int idx, @Param("level") int level);

	public int orderListTotRecCnt();

	public ArrayList<BaesongVO> getOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setOrderStatusUpdate(@Param("orderIdx") int orderIdx, @Param("orderStatus") String orderStatus);

	public void memInfoDelete(@Param("mid") String mid);

	public ArrayList<ChartVO> getOrderCount();

	public ArrayList<BaesongVO> getBaesongOkList();

	public ArrayList<OrderVO> getOrderCountByDate();

	public int getWatingReplyCount();

}
