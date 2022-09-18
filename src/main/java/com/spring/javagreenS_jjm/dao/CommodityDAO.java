package com.spring.javagreenS_jjm.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jjm.vo.CartVO;
import com.spring.javagreenS_jjm.vo.ProductVO;
import com.spring.javagreenS_jjm.vo.ReviewVO;

public interface CommodityDAO {

	public int candleTotRecCnt();

	public ArrayList<ProductVO> getCandleList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int diffuserTotRecCnt();

	public ArrayList<ProductVO> getDiffuserList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int sprayTotRecCnt();

	public ArrayList<ProductVO> getSprayList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int sachetTotRecCnt();

	public ArrayList<ProductVO> getSachetList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public int hbTotRecCnt();

	public ArrayList<ProductVO> getHbList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int perfumeTotRecCnt();

	public ArrayList<ProductVO> getPerfumeList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ProductVO getContent(int idx);

	public void cartInput(@Param("vo") CartVO vo, @Param("optionSize") int optionSize);

	public ArrayList<ReviewVO> getReviewList(@Param("commodity") String commodity);

	
}
