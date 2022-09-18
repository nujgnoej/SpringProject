package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.QnaVO;

public interface MemberService {
	
	public ArrayList<BaesongVO> getBaesongList(String mid, int startIndexNo, int pageSize);
	
	public int getListSize(String orderIdx, String mid);

	public ArrayList<BaesongVO> getOrderList(String orderIdx, String mid);

	public void orderDelete(int orderIdx);

	public ArrayList<BaesongVO> getReviewCheck(String mid, int startIndexNo, int pageSize);

	public ArrayList<QnaVO> getMyQnaList(int startIndexNo, int pageSize, String mid);

	public void memDelete(String mid);
}
