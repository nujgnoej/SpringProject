package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.ProductVO;
import com.spring.javagreenS_jjm.vo.ReviewVO;

public interface ReviewService {

	public ArrayList<BaesongVO> getOrderInfo(int orderIdx);

	public void setReviewInput(MultipartFile file, ReviewVO vo);

	public ReviewVO getReviewInfo(int orderIdx);

	public void reviewImgDelete(int orderIdx, String fSName);

	public void setReviewUpdate(MultipartFile file, ReviewVO vo);

	public void setReviewDelete(ReviewVO vo, int orderIdx);

	public ArrayList<ReviewVO> getReviewList(int startIndexNo, int pageSize);

	public ProductVO getProductInfo(String commodity);
	
}
