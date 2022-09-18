package com.spring.javagreenS_jjm.vo;

import lombok.Data;

@Data
public class CartVO {
	private int idx;
	private int productIdx;
	private int pno;
	private String mid;
	private String commodity;
	private int salePrice;
	private String optionName;
	private int optionPrice;
	private int orderQuantity;
	private int totPrice;
	private int totSavePoint;
	private String fSName;
	private String cartDay;
}
