package com.spring.javagreenS_jjm.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_jjm.dao.QnaDAO;
import com.spring.javagreenS_jjm.vo.QnaReplyVO;
import com.spring.javagreenS_jjm.vo.QnaTypeVO;
import com.spring.javagreenS_jjm.vo.QnaVO;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	QnaDAO qnaDAO;

	@Override
	public ArrayList<QnaVO> getQnaList(int startIndexNo, int pageSize) {
		return qnaDAO.getQnaList(startIndexNo, pageSize);
	}

	@Override
	public QnaVO getQnaContent(int idx) {
		return qnaDAO.getQnaContent(idx);
	}

	@Override
	public ArrayList<QnaTypeVO> getQnaType() {
		return qnaDAO.getQnaType();
	}

	@Override
	public void setQnaInput(QnaVO vo) {
		qnaDAO.setQnaInput(vo);
	}

	@Override
	public void qnaDelete(int idx) {
		qnaDAO.qnaDelete(idx);
	}

	@Override
	public void setQnaUpdate(QnaVO vo) {
		qnaDAO.setQnaUpdate(vo);
	}

	@Override
	public String maxLevelOrder(int qnaIdx) {
		return qnaDAO.maxLevelOrder(qnaIdx);
	}

	@Override
	public void setQnaReplyInput(QnaReplyVO replyVo) {
		qnaDAO.setQnaReplyInput(replyVo);
	}

	@Override
	public void setQnaAdChkUpdate(int qnaIdx) {
		qnaDAO.setQnaAdChkUpdate(qnaIdx);
	}

	@Override
	public ArrayList<QnaReplyVO> getQnaReply(int idx) {
		return qnaDAO.getQnaReply(idx);
	}

	@Override
	public void setQnaReplyDeleteOk(int idx) {
		qnaDAO.setQnaReplyDeleteOk(idx);
	}

	@Override
	public void levelOrderPlusUpdate(QnaReplyVO replyVo) {
		qnaDAO.levelOrderPlusUpdate(replyVo);
	}

	@Override
	public void setQnaReplyInput2(QnaReplyVO replyVo) {
		qnaDAO.setQnaReplyInput2(replyVo);
	}

	@Override
	public void setQnaAdChkUpdate2(int qnaIdx) {
		qnaDAO.setQnaAdChkUpdate2(qnaIdx);
	}
	
}
