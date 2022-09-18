package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_jjm.dao.AdminDAO;
import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.ChartVO;
import com.spring.javagreenS_jjm.vo.JoinVO;
import com.spring.javagreenS_jjm.vo.OrderVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public ArrayList<JoinVO> getMemList(int startIndexNo, int pageSize) {
		return adminDAO.getMemList(startIndexNo, pageSize);
	}

	@Override
	public int totRecCnt() {
		return adminDAO.totRecCnt() ;
	}

	@Override
	public void levelUpdate(int idx, int level) {
		adminDAO.levelUpdate(idx, level);
	}

	@Override
	public ArrayList<BaesongVO> getOrderList(int startIndexNo, int pageSize) {
		return adminDAO.getOrderList(startIndexNo, pageSize);
	}

	@Override
	public void setOrderStatusUpdate(int orderIdx, String orderStatus) {
		adminDAO.setOrderStatusUpdate(orderIdx, orderStatus);
	}

	@Override
	public void memInfoDelete(String mid) {
		adminDAO.memInfoDelete(mid);
	}

	@Override
	public ArrayList<ChartVO> getOrderCount() {
		return adminDAO.getOrderCount();
	}

	@Override
	public ArrayList<BaesongVO> getBaesongOkList() {
		return adminDAO.getBaesongOkList();
	}

	@Override
	public ArrayList<OrderVO> getOrderCountByDate() {
		return adminDAO.getOrderCountByDate();
	}

	@Override
	public int getWatingReplyCount() {
		return adminDAO.getWatingReplyCount();
	}

	
}
