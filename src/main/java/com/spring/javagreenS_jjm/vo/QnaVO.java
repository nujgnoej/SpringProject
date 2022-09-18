package com.spring.javagreenS_jjm.vo;

import lombok.Data;

@Data
public class QnaVO {
	private int idx;
	private String mid;
	private String name;
	private int qnaTypeIdx;
	private String title;
	private String content;
	private String wDate;
	private String openSw;
	private String adChk;
	
	private String qnaType;
}
