package com.spring.javagreenS_jjm.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jjm.vo.QnaReplyVO;
import com.spring.javagreenS_jjm.vo.QnaTypeVO;
import com.spring.javagreenS_jjm.vo.QnaVO;

public interface QnaDAO {

	public int qnaListTotRecCnt();

	public ArrayList<QnaVO> getQnaList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public QnaVO getQnaContent(@Param("idx") int idx);

	public ArrayList<QnaTypeVO> getQnaType();

	public void setQnaInput(@Param("vo") QnaVO vo);

	public void qnaDelete(@Param("idx") int idx);

	public void setQnaUpdate(@Param("vo") QnaVO vo);

	public String maxLevelOrder(@Param("qnaIdx") int qnaIdx);

	public void setQnaReplyInput(@Param("replyVo") QnaReplyVO replyVo);

	public void setQnaAdChkUpdate(@Param("qnaIdx") int qnaIdx);

	public ArrayList<QnaReplyVO> getQnaReply(@Param("idx") int idx);

	public void setQnaReplyDeleteOk(@Param("idx") int idx);

	public void levelOrderPlusUpdate(@Param("replyVo") QnaReplyVO replyVo);

	public void setQnaReplyInput2(@Param("replyVo") QnaReplyVO replyVo);

	public void setQnaAdChkUpdate2(@Param("qnaIdx") int qnaIdx);

}
