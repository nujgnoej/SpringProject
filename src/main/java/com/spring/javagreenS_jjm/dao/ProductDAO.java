package com.spring.javagreenS_jjm.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jjm.vo.ProductTypeVO;
import com.spring.javagreenS_jjm.vo.ProductVO;

public interface ProductDAO {
	
	public ArrayList<ProductVO> getProductList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public int totRecCnt();
	
	public ArrayList<ProductTypeVO> getProductType();

	public void imgCheckProductInput(@Param("vo") ProductVO vo);

	public ProductVO getProductInfo(@Param("idx") int idx);

	public void productImgDelete(@Param("idx") int idx, @Param("fName") String fName, @Param("fSName") String fSName);

	public void setProductUpdate(@Param("vo") ProductVO vo);

	public void setProductDelete(@Param("idx") int idx);

	public void quantityOrder(@Param("idx") int idx, @Param("orderQuantity") int orderQuantity);
	
}
