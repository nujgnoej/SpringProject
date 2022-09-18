package com.spring.javagreenS_jjm.vo;

import lombok.Data;

@Data
public class ReviewVO {
	private int idx;
	private String orderIdx;
	private String commodity;
	private String mid;
	private String name;
	private String title;
	private String content;
	private int rating;
	private String fSName;
	private int fSize;
	private String reviewDate;
}
