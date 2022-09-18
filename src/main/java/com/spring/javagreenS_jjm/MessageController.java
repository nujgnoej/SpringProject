package com.spring.javagreenS_jjm;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javagreenS_jjm.pagination.PageVO;
import com.spring.javagreenS_jjm.vo.JoinVO;
import com.spring.javagreenS_jjm.vo.QnaVO;

@Controller
public class MessageController {

	@RequestMapping(value="/msg/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,
			@RequestParam(value="flag", defaultValue = "", required=false) String flag,
			@RequestParam(value="name", defaultValue = "", required=false) String name,
			@RequestParam(value="mid", defaultValue = "", required=false) String mid,
			@RequestParam(value="idx", defaultValue = "0", required=false) int idx,
			PageVO pageVO, JoinVO vo, ArrayList<QnaVO> vos,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		if(msgFlag.equals("joinIdCheckNo")) {
			model.addAttribute("msg", "아이디가 중복되었습니다.");
			model.addAttribute("url", "join/joinView");
		}
		else if(msgFlag.equals("joinEmailCheckNo")) {
			model.addAttribute("msg", "이메일이 중복되었습니다.");
			model.addAttribute("url", "join/joinView");
		}
		else if(msgFlag.equals("joinInputOk")) {
			model.addAttribute("msg", name + "님 회원가입을 환영합니다. 적립금 3,000원이 지급되었습니다.");
			model.addAttribute("url", "login/loginView");
		}
		else if(msgFlag.equals("joinInputNo")) {
			model.addAttribute("msg", "회원가입에 실패하였습니다.");
			model.addAttribute("url", "join/joinView");
		}
		else if(msgFlag.equals("loginOk")) {
			model.addAttribute("msg", name + "님 로그인 되셧습니다.");
			model.addAttribute("url", "main");
		}
		else if(msgFlag.equals("loginNo")) {
			model.addAttribute("msg", "아이디/비밀번호를 확인해주세요.");
			model.addAttribute("url", "main");
		}
		else if(msgFlag.equals("logout")) {
			model.addAttribute("msg", name + "님 로그아웃 되셨습니다.");
			model.addAttribute("url", "main");
		}
		else if(msgFlag.equals("levelAdminNo")) {
			model.addAttribute("msg", "관리자계정으로 로그인 해주세요.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("pwdSearchOk")) {
			model.addAttribute("msg", "신규 비밀번호를 이메일로 전송했습니다.");
			model.addAttribute("url", "login/loginView");
		}
		else if(msgFlag.equals("pwdSearchNo")) {
			model.addAttribute("msg", "입력하신 정보를 다시한번 확인해주세요.");
			model.addAttribute("url", "login/idPwSearch");
		}
		else if(msgFlag.equals("pwdCheckOk")) {
			model.addAttribute("msg", "인증 되셨습니다.");
			model.addAttribute("url", "join/joinInfoUpdate");
		}
		else if(msgFlag.equals("pwdCheckNo")) {
			model.addAttribute("msg", "비밀번호를 확인하세요.");
			model.addAttribute("url", "join/pwdCheck");
		}
		else if(msgFlag.equals("joinInfoUpdateOk")) {
			model.addAttribute("msg", "회원정보를 수정하였습니다.");
			model.addAttribute("url", "join/pwdCheck");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "product/productInput");
		}
		else if(msgFlag.equals("productUpdateOk")) {
			model.addAttribute("msg", "제품정보가 수정되었습니다.");
			model.addAttribute("url", "product/productUpdate"+flag);
		}
		else if(msgFlag.equals("levelLoginNo")) {
			model.addAttribute("msg", "로그인 후 이용해주세요.");
			model.addAttribute("url", "login/loginView");
		}
		else if(msgFlag.equals("reviewInputOk")) {
			model.addAttribute("msg", "리뷰를 등록하였습니다.");
			model.addAttribute("url", "member/memOrderList"+flag);
		}
		else if(msgFlag.equals("reviewUpdateOk")) {
			model.addAttribute("msg", "리뷰를 수정하였습니다.");
			model.addAttribute("url", "member/memOrderList"+flag);
		}
		else if(msgFlag.equals("reviewDeleteOk")) {
			model.addAttribute("msg", "리뷰를 삭제하였습니다.");
			model.addAttribute("url", "member/memOrderList"+flag);
		}
		else if(msgFlag.equals("adReviewDeleteOk")) {
			model.addAttribute("msg", "리뷰를 삭제하였습니다.");
			model.addAttribute("url", "admin/reviewList"+flag);
		}
		else if(msgFlag.equals("myQnaInputOk")) {
			model.addAttribute("msg", "질문을 등록하였습니다.");
			model.addAttribute("url", "member/mypageView");
			model.addAttribute("vo", vo);
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
		}
		else if(msgFlag.equals("qnaInputOk")) {
			model.addAttribute("msg", "질문을 등록하였습니다.");
			model.addAttribute("url", "qna/qnaList");
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
		}
		else if(msgFlag.equals("myQnaDeleteOk")) {
			model.addAttribute("msg", "질문을 삭제하였습니다.");
			model.addAttribute("url", "member/mypageView"+flag);
			model.addAttribute("vo", vo);
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
		}
		else if(msgFlag.equals("qnaDeleteOk")) {
			model.addAttribute("msg", "질문을 삭제하였습니다.");
			model.addAttribute("url", "qna/qnaList"+flag);
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
		}
		else if(msgFlag.equals("myQnaUpdateOk")) {
			model.addAttribute("msg", "질문을 수정하였습니다.");
			model.addAttribute("url", "member/mypageView"+flag);
			model.addAttribute("vo", vo);
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
		}
		else if(msgFlag.equals("qnaUpdateOk")) {
			model.addAttribute("msg", "질문을 수정하였습니다.");
			model.addAttribute("url", "qna/qnaList"+flag);
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
		}
		else if(msgFlag.equals("adQnaDeleteOk")) {
			model.addAttribute("msg", "질문을 삭제하였습니다.");
			model.addAttribute("url", "admin/qnaList"+flag);
			model.addAttribute("vo", vo);
			model.addAttribute("pageVO", pageVO);
		}
		else if(msgFlag.equals("memDeleteOk")) {
			model.addAttribute("msg", "회원탈퇴 되었습니다.");
			model.addAttribute("url", "main");
		}
		else if(msgFlag.equals("memberOrderOk")) {
			model.addAttribute("msg", "");
			model.addAttribute("url", "member/mypageView");
			model.addAttribute("vo", vo);
			model.addAttribute("qnaVos", vos);
			model.addAttribute("pageVO", pageVO);
		}
		
		return "include/message";
	}
	
}
