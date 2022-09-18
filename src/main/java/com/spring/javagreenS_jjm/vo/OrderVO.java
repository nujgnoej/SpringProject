package com.spring.javagreenS_jjm.vo;

import lombok.Data;

@Data
public class OrderVO {
	private int idx;			// 주문고유번호
	private String orderIdx;	// 배송번호(날짜+번호)
	private String mid;			// 주문자 아이디
	private int productIdx;		// 제품번호
	private String commodity;	// 제품이름
	private int salePrice;		// 상품 개당가격
	private int orderQuantity;	// 주문수량
	private String optionName;	// 옵션이름
	private int deliveryFee;	// 배송비
	private int totPrice;		// 합계금액(배송비포함)
	private int totSavePoint;	// 적립금
	private String fSName;		// 상품이미지
	private String orderDate;	// 주문일자
	
	private int cartIdx;		// 장바구니 고유번호.
	private int maxIdx;			// 주문번호를 구하기위한 기존 최대인덱스번호
	
	private int orderCount;		// 하루에 몇개의 주문을 했는지 받아온다
}
