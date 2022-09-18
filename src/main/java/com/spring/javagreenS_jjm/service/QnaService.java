package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import com.spring.javagreenS_jjm.vo.QnaReplyVO;
import com.spring.javagreenS_jjm.vo.QnaTypeVO;
import com.spring.javagreenS_jjm.vo.QnaVO;

public interface QnaService {

	public ArrayList<QnaVO> getQnaList(int startIndexNo, int pageSize);

	public QnaVO getQnaContent(int idx);

	public ArrayList<QnaTypeVO> getQnaType();

	public void setQnaInput(QnaVO vo);

	public void qnaDelete(int idx);

	public void setQnaUpdate(QnaVO vo);

	public String maxLevelOrder(int qnaIdx);

	public void setQnaReplyInput(QnaReplyVO replyVo);

	public void setQnaAdChkUpdate(int qnaIdx);

	public ArrayList<QnaReplyVO> getQnaReply(int idx);

	public void setQnaReplyDeleteOk(int idx);

	public void levelOrderPlusUpdate(QnaReplyVO replyVo);

	public void setQnaReplyInput2(QnaReplyVO replyVo);

	public void setQnaAdChkUpdate2(int qnaIdx);

}
