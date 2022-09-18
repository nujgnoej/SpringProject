package com.spring.javagreenS_jjm.vo;

import lombok.Data;

@Data
public class QnaReplyVO {
	private int idx;
	private int qnaIdx;
	private String mid;
	private String name;
	private String content;
	private String wDate;
	private int level;
	private int levelOrder;
	private String deleteSw;
}
