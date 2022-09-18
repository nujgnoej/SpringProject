package com.spring.javagreenS_jjm.vo;

import lombok.Data;

public @Data class ProductVO {
	private int idx;
	private int pno;
	private String commodity;
	private int quantity;
	private int price;
	private int discount;
	private String size;
	private String fName;
	private String fSName;
	private int fSize;
	private String optionName;
	private String optionPrice;
	private String content;
	private String inputDay;
	
	private String product;
}
