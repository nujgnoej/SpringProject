package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.ChartVO;
import com.spring.javagreenS_jjm.vo.JoinVO;
import com.spring.javagreenS_jjm.vo.OrderVO;

public interface AdminService {

	public ArrayList<JoinVO> getMemList(int startIndexNo, int pageSize);

	public int totRecCnt();

	public void levelUpdate(int idx, int level);

	public ArrayList<BaesongVO> getOrderList(int startIndexNo, int pageSize);

	public void setOrderStatusUpdate(int orderIdx, String orderStatus);

	public void memInfoDelete(String mid);

	public ArrayList<ChartVO> getOrderCount();

	public ArrayList<BaesongVO> getBaesongOkList();

	public ArrayList<OrderVO> getOrderCountByDate();

	public int getWatingReplyCount();
	
}
