package com.spring.javagreenS_jjm;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_jjm.pagination.PageProcess;
import com.spring.javagreenS_jjm.pagination.PageVO;
import com.spring.javagreenS_jjm.service.JoinService;
import com.spring.javagreenS_jjm.service.MemberService;
import com.spring.javagreenS_jjm.service.QnaService;
import com.spring.javagreenS_jjm.vo.JoinVO;
import com.spring.javagreenS_jjm.vo.QnaReplyVO;
import com.spring.javagreenS_jjm.vo.QnaTypeVO;
import com.spring.javagreenS_jjm.vo.QnaVO;

@Controller
@RequestMapping("/qna")
public class QnaController {
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	QnaService qnaService;
	
	@Autowired
	JoinService joinService;
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/qnaList", method = RequestMethod.GET)
	public String qnaListGet(Model model, HttpSession session,
			@RequestParam(name="flag", defaultValue = "qna", required = false) String flag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		// 질문등록을 완료하면 리스트화면으로 보낸다.
		if(flag.equals("mypage")) {
			String mid = (String) session.getAttribute("sMid");
			JoinVO joinVo = joinService.getJoinIdCheck(mid);
			PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myQna", mid, "");
			ArrayList<QnaVO> vos = memberService.getMyQnaList(pageVO.getStartIndexNo(), pageSize, mid);
			
			model.addAttribute("vo", joinVo);
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
			
			return "member/mypageView";
		}
		else {
			PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "qna", "", "");
			ArrayList<QnaVO> vos = qnaService.getQnaList(pageVO.getStartIndexNo(), pageSize);
			
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("vos", vos);
			
			return "qna/qnaList";
		}
	}
	
	@RequestMapping(value = "/qnaContent", method = RequestMethod.GET)
	public String qnaContentGet(Model model, int idx, HttpSession session,
			@RequestParam(name="flag", defaultValue = "qna", required = false) String flag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		QnaVO vo = qnaService.getQnaContent(idx);
		ArrayList<QnaReplyVO> replyVos = qnaService.getQnaReply(idx);		// 댓글 가져오기(replyVos)
		int replyVosSize = replyVos.size();
		
		model.addAttribute("vo", vo);
		model.addAttribute("replyVos", replyVos);
		model.addAttribute("replyVosSize", replyVosSize);
		model.addAttribute("flag", flag);
		model.addAttribute("idx", idx);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return "qna/qnaContent";
	}
	
	@RequestMapping(value = "/qnaWrite", method = RequestMethod.GET)
	public String qnaWriteGet(HttpSession session, Model model,
			@RequestParam(name="flag", defaultValue = "qna", required = false) String flag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		String name = (String)session.getAttribute("sName");
		ArrayList<QnaTypeVO> qnaTypeVos = qnaService.getQnaType();
		
		model.addAttribute("name", name);
		model.addAttribute("qnaTypeVos", qnaTypeVos);
		model.addAttribute("flag", flag);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "qna/qnaWrite";
	}
	
	@RequestMapping(value = "/qnaList", method = RequestMethod.POST)
	public String qnaListPost(QnaVO vo, Model model, HttpSession session,
			@RequestParam(name="flag", defaultValue = "qna", required = false) String flag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		qnaService.setQnaInput(vo);
		
		// 질문등록을 완료하면 리스트화면으로 보낸다.
		if(flag.equals("mypage")) {
			String mid = (String) session.getAttribute("sMid");
			JoinVO joinVo = joinService.getJoinIdCheck(mid);
			PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myQna", mid, "");
			ArrayList<QnaVO> vos = memberService.getMyQnaList(pageVO.getStartIndexNo(), pageSize, mid);
			
			model.addAttribute("vo", joinVo);
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
			
			return "redirect:/msg/myQnaInputOk";
		}
		else {
			PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "qna", "", "");
			ArrayList<QnaVO> vos = qnaService.getQnaList(pageVO.getStartIndexNo(), pageSize);
			
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("vos", vos);
			
			return "redirect:/msg/qnaInputOk";
		}
	}
	
	@RequestMapping(value = "/qnaDelete", method = RequestMethod.GET)
	public String qnaDeleteGet(int idx, Model model, HttpSession session,
			@RequestParam(name="flag", defaultValue = "qna", required = false) String flag,	// 마이페이지에서 qna삭제한경우 flag='mypage'로 넘어온다. 그렇지않을경우 flag='qna'
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		qnaService.qnaDelete(idx);
		
		// 질문삭제를 완료하면 리스트화면으로 보낸다.
		if(flag.equals("mypage")) {
			String mid = (String) session.getAttribute("sMid");
			JoinVO vo = joinService.getJoinIdCheck(mid);
			PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myQna", mid, "");
			ArrayList<QnaVO> vos = memberService.getMyQnaList(pageVO.getStartIndexNo(), pageSize, mid);
			
			model.addAttribute("vo", vo);
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);
			
			return "redirect:/msg/myQnaDeleteOk";
		}
		else {
			PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "qna", "", "");
			ArrayList<QnaVO> vos = qnaService.getQnaList(pageVO.getStartIndexNo(), pageSize);
			
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);
			
			return "redirect:/msg/qnaDeleteOk";
		}
	}
	
	@RequestMapping(value = "/qnaUpdate", method = RequestMethod.GET)
	public String qnaUpdateGet(int idx, Model model, HttpSession session,
			@RequestParam(name="flag", defaultValue = "qna", required = false) String flag,	// 마이페이지에서 qna삭제한경우 flag='mypage'로 넘어온다. 그렇지않을경우 flag='qna'
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		QnaVO vo = qnaService.getQnaContent(idx);
		ArrayList<QnaTypeVO> qnaTypeVos = qnaService.getQnaType();
		
		int contentLen = vo.getContent().replaceAll(System.getProperty("line.separator"), " ").length(); // System.getProperty("line.sepatator")가 줄바꿈 문자를 담고 있음
		
		model.addAttribute("vo", vo);
		model.addAttribute("contentLen", contentLen);
		model.addAttribute("qnaTypeVos", qnaTypeVos);
		model.addAttribute("flag", flag);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "qna/qnaUpdate";
	}
	
	@RequestMapping(value = "/qnaUpdate", method = RequestMethod.POST)
	public String qnaUpdatePost(QnaVO vo, Model model, HttpSession session,
			@RequestParam(name="flag", defaultValue = "qna", required = false) String flag,	// 마이페이지에서 qna삭제한경우 flag='mypage'로 넘어온다. 그렇지않을경우 flag='qna'
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		qnaService.setQnaUpdate(vo);
		
		// 질문수정을 완료하면 리스트화면으로 보낸다.
		if(flag.equals("mypage")) {
			String mid = (String) session.getAttribute("sMid");
			JoinVO joinVo = joinService.getJoinIdCheck(mid);
			PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myQna", mid, "");
			ArrayList<QnaVO> vos = memberService.getMyQnaList(pageVO.getStartIndexNo(), pageSize, mid);
			
			model.addAttribute("vo", joinVo);
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);

			return "redirect:/msg/myQnaUpdateOk";
		}
		else {
			PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "qna", "", "");
			ArrayList<QnaVO> vos = qnaService.getQnaList(pageVO.getStartIndexNo(), pageSize);
			
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("vos", vos);
			model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);

			return "redirect:/msg/qnaUpdateOk";
		}
	}

	// Q&A 답변입력
	@ResponseBody
	@RequestMapping(value = "/qnaReplyInput", method = RequestMethod.POST)
	public String qnaReplyInputPost(QnaReplyVO replyVo) {
		int levelOrder = 0;
		
		String strLevelOrder = qnaService.maxLevelOrder(replyVo.getQnaIdx());
		if(strLevelOrder != null) levelOrder =  Integer.parseInt(strLevelOrder) + 1;
		replyVo.setLevelOrder(levelOrder);
		
		qnaService.setQnaReplyInput(replyVo);
		qnaService.setQnaAdChkUpdate(replyVo.getQnaIdx());
		
		return "1";
	}
	
	// Q&A 답변삭제
	@ResponseBody
	@RequestMapping(value = "/qnaReplyDeleteOk", method = RequestMethod.POST)
	public String qnaReplyDeleteOkPost(int idx, int qnaIdx) {
		qnaService.setQnaReplyDeleteOk(idx);
		ArrayList<QnaReplyVO> replyVos = qnaService.getQnaReply(qnaIdx);
		int deleteSw = 0;
		for(int i=0; i<replyVos.size(); i++) {
			if(replyVos.get(i).getDeleteSw().equals("no")) {
				deleteSw = deleteSw + 1;
			}
		}
		if (deleteSw == 0) {
			qnaService.setQnaAdChkUpdate2(qnaIdx);
		}
		return "";
	}
	
	// 대댓글의 경우 나중에 쓴 댓글이 먼저 나오게 처리한것
	@ResponseBody
	@RequestMapping(value = "/qnaReplyInput2", method = RequestMethod.POST)
	public String qnaReplyInput2Post(QnaReplyVO replyVo) {
		qnaService.levelOrderPlusUpdate(replyVo);			// 부모글의 levelOrder(글순서)값보다 큰 모든 댓글의 levelOrder값을 +1 시켜준다(update)
		replyVo.setLevel(replyVo.getLevel()+1);  			// 자신의 level은 부모 level 보다 +1 시켜준다.
		replyVo.setLevelOrder(replyVo.getLevelOrder()+1);	// 자신의 levelOrder은 부모의 levelOrder보다 +1 시켜준다.
		qnaService.setQnaReplyInput2(replyVo);				// 대댓글 저장
		
		return "";
	}
}
