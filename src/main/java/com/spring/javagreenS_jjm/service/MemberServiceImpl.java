package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_jjm.dao.MemberDAO;
import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.QnaVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public ArrayList<BaesongVO> getBaesongList(String mid, int startIndexNo, int pageSize) {
		return memberDAO.getBaesongList(mid, startIndexNo, pageSize);
	}
	
	@Override
	public int getListSize(String orderIdx, String mid) {
		return memberDAO.getListSize(orderIdx, mid);
	}

	@Override
	public ArrayList<BaesongVO> getOrderList(String orderIdx, String mid) {
		return memberDAO.getOrderList(orderIdx, mid);
	}

	@Override
	public void orderDelete(int orderIdx) {
		memberDAO.orderDelete(orderIdx);
	}

	@Override
	public ArrayList<BaesongVO> getReviewCheck(String mid, int startIndexNo, int pageSize) {
		return memberDAO.getReviewCheck(mid, startIndexNo, pageSize);
	}

	@Override
	public ArrayList<QnaVO> getMyQnaList(int startIndexNo, int pageSize, String mid) {
		return memberDAO.getMyQnaList(startIndexNo, pageSize, mid);
	}

	@Override
	public void memDelete(String mid) {
		memberDAO.memDelete(mid);
	}
}
