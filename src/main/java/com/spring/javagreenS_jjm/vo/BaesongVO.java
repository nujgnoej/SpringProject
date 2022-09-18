package com.spring.javagreenS_jjm.vo;

import lombok.Data;

@Data
public class BaesongVO {
	private int idx;			// 배송테이블인덱스번호
	private int oIdx;			// 주문테이블인덱스번호
	private String orderIdx;	// 주문번호
	private int orderTotalPrice;// 주문 총금액(사용포인트합산함)
	private String mid;			// 주문자 아이디
	private String name;		// 성명
	private String address;		// 주소
	private String tel;			// 전화번호
	private String email;		// 이메일
	private String message;		// 배송요청사항
	private String payment;		// 결재종류
	private String payMethod;	// 결재종류에 따른방법(카드번호)
	private String orderStatus;	// 결재유무,배송단계
	private String baesongDate;	// 배송단계변경날짜(결제완료/취소,배송중,배송완료)
	
	// 아래는 주문테이블에서 사용된 필드리스트이다.
	private int productIdx;
	private String commodity;
	private int salePrice;
	private int orderQuantity;
	private String optionName;
	private int deliveryFee;
	private int usePoint;		// 사용한 적립금
	private int totPrice;		// 주문 총금액(사용포인트합산안함)
	private int totSavePoint;
	private String fSName;
	private String orderDate;
	
	// 아래는 리뷰테이블에서 사용된 필드리스트이다.
	
	private String reviewDate;
}
