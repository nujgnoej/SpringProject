package com.spring.javagreenS_jjm.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.ProductVO;
import com.spring.javagreenS_jjm.vo.ReviewVO;

public interface ReviewDAO {

	public ArrayList<BaesongVO> getOrderInfo(@Param("orderIdx") int orderIdx);

	public void setReviewInput(@Param("vo") ReviewVO vo);

	public ReviewVO getReviewInfo(@Param("orderIdx") int orderIdx);

	public void productImgDelete(@Param("orderIdx") int orderIdx);

	public void setReviewUpdate(@Param("vo") ReviewVO vo);

	public void setReviewDelete(@Param("orderIdx") int orderIdx);

	public int reviewListTotRecCnt();

	public ArrayList<ReviewVO> getReviewList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ProductVO getProductInfo(@Param("commodity") String commodity);

}
