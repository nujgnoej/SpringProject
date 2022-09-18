package com.spring.javagreenS_jjm.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_jjm.dao.AdminDAO;
import com.spring.javagreenS_jjm.dao.CommodityDAO;
import com.spring.javagreenS_jjm.dao.MemberDAO;
import com.spring.javagreenS_jjm.dao.ProductDAO;
import com.spring.javagreenS_jjm.dao.QnaDAO;
import com.spring.javagreenS_jjm.dao.ReviewDAO;

@Service
public class PageProcess {
	
	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	ProductDAO productDAO;
	
	@Autowired
	CommodityDAO commodityDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	ReviewDAO reviewDAO;

	@Autowired
	QnaDAO qnaDAO;

	// 인자: 1.page번호, 2.page크기, 3.소속(예:게시판(board),회원(member),방명록(guest)..), 4.분류(part), 5.검색어(searchString)
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		int blockSize = 5;
		
		// section에 따른 레코드 갯수를 구해오기
		if(section.equals("admin")) {
			totRecCnt = adminDAO.totRecCnt();
		}
		else if(section.equals("product")) {
			totRecCnt = productDAO.totRecCnt();
			pageVO.setSection(section);
		}
		else if(section.equals("candle")) {
			totRecCnt = commodityDAO.candleTotRecCnt();
			pageVO.setSection(section);
		}
		else if(section.equals("diffuser")) {
			totRecCnt = commodityDAO.diffuserTotRecCnt();
			pageVO.setSection(section);
		}
		else if(section.equals("spray")) {
			totRecCnt = commodityDAO.sprayTotRecCnt();
			pageVO.setSection(section);
		}
		else if(section.equals("sachet")) {
			totRecCnt = commodityDAO.sachetTotRecCnt();
			pageVO.setSection(section);
		}
		else if(section.equals("hb")) {
			totRecCnt = commodityDAO.hbTotRecCnt();
			pageVO.setSection(section);
		}
		else if(section.equals("perfume")) {
			totRecCnt = commodityDAO.perfumeTotRecCnt();
			pageVO.setSection(section);
		}
		else if(section.equals("memOrder")) {
			totRecCnt = memberDAO.memOrderListTotRecCnt(part);
			pageVO.setSection(section);
		}
		else if(section.equals("review")) {
			totRecCnt = reviewDAO.reviewListTotRecCnt();
			pageVO.setSection(section);
		}
		else if(section.equals("order")) {
			totRecCnt = adminDAO.orderListTotRecCnt();
			pageVO.setSection(section);
		}
		else if(section.equals("qna")) {
			totRecCnt = qnaDAO.qnaListTotRecCnt();
			pageVO.setSection(section);
		}
		else if(section.equals("myQna")) {
			totRecCnt = memberDAO.myQnaListTotRecCnt(part);
			pageVO.setSection(section);
		}
		else if(section.equals("tempFile")) {
			totRecCnt = Integer.parseInt(part);
			pageVO.setSection(section);
		}
		
		int totPage = (totRecCnt%pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize)==0 ? (totPage / blockSize) - 1 : (totPage / blockSize);
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		return pageVO;
	}
	
	
}
