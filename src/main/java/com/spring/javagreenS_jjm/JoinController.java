package com.spring.javagreenS_jjm;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_jjm.pagination.PageProcess;
import com.spring.javagreenS_jjm.service.CartService;
import com.spring.javagreenS_jjm.service.JoinService;
import com.spring.javagreenS_jjm.vo.JoinVO;

@Controller
@RequestMapping("/join")
public class JoinController {
	
	@Autowired
	JoinService joinService;
	
	@Autowired
	CartService cartService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/joinView", method = RequestMethod.GET)
	public String joinViewGet() {
		return "join/joinView";
	}
	
	// 회원 아이디 체크
	@ResponseBody
	@RequestMapping(value = "/joinIdCheck", method = RequestMethod.POST)
	public String joinIdCheckGet(String mid) {
		String res = "0";
		JoinVO vo = joinService.getJoinIdCheck(mid);
		if(vo != null) res = "1";
		
		return res;
	}
	
	// 회원 이메일 체크
	@ResponseBody
	@RequestMapping(value = "/joinEmailCheck", method = RequestMethod.POST)
	public String joinEmailCheckGet(String email, HttpSession session) {
		String sEmail = (String) session.getAttribute("sEmail");
		String res = "0";
		JoinVO vo = joinService.getJoinEmailCheck(email);
		// if(vo != null) res = "1";
		if(vo == null || vo.getEmail().equals(sEmail)) res = "0";
		else res = "1";
		
		return res;
	}
	
	// 회원가입처리하기
	@RequestMapping(value = "/joinView", method = RequestMethod.POST)
	public String joinViewPost(JoinVO vo, String birthday, Model model,
			@RequestParam(name="mailCheck", defaultValue = "", required = false) String mailCheck) {
		// 아이디 체크
		if(joinService.getJoinIdCheck(vo.getMid()) != null) {
			return "redirect:/msg/joinIdCheckNo";
		}
		
		// 이메일 체크
		if(joinService.getJoinEmailCheck(vo.getEmail()) != null) {
			return "redirect:/msg/joinEmailCheckNo";
		}
		
		// 비밀번호 암호화 처리
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 메일수신체크박스 선택 시 'YES'를 담는다.
		if(mailCheck.equals("on")) {
			vo.setMailCheck("YES");
		}
		else {
			vo.setMailCheck("NO");
		}
		
		// 생일을 입력하지 않을 시 '0000-00-00'을 DB에 저장한다.
		if(birthday.equals("-0월-00")) {
			vo.setBirthday("0000-00-00");
		}
		
		// 체크 완료된 자료를 다시 vo에 담았다면 DB에 저장시켜준다.(회원 가입처리)
		joinService.setJoinInputOk(vo);
		
		// 회원가입이 완료되면 적립금 3천원을 지급한다.
		joinService.setMemPointUpdate(vo.getMid());
		
		// ''님 회원가입을 환영합니다. 메세지를 띄우기위해 name을 메세지컨트롤러로 보낸다.
		String name = vo.getName();
		model.addAttribute("name", name);
		
		return "redirect:/msg/joinInputOk";
	}
	
	// 회원정보 수정화면 전 비밀번호 체크창 띄우기
	@RequestMapping(value = "/pwdCheck", method = RequestMethod.GET)
	public String pwdCheckGet() {
		return "join/pwdCheck";
	}
	
	// 회원정보 수정화면 전 비밀번호 체크후 페이지이동
	@RequestMapping(value = "/pwdCheck", method = RequestMethod.POST)
	public String pwdCheckPost(String pwd, HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		JoinVO vo = joinService.getJoinIdCheck(mid);
		
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			session.setAttribute("sPwd", pwd);
			model.addAttribute("vo", vo);
			return "redirect:/msg/pwdCheckOk";
		}
		else {
			return "redirect:/msg/pwdCheckNo";
		}
	}
	
	// 회원정보수정 페이지이동
	@RequestMapping(value = "/joinInfoUpdate", method = RequestMethod.GET)
	public String joinInfoUpdateGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		
		JoinVO vo = joinService.getJoinIdCheck(mid);

		// 비밀번호 암호화 처리
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		String[] addressArr = vo.getAddress().split("/");
		String[] addressArr1 = addressArr[1].split(", ");
		String[] telArr = vo.getTel().split("-");
		String[] emailArr = vo.getEmail().split("@");
		String[] birthdayArr = vo.getBirthday().split("-");
		
		model.addAttribute("vo", vo);
		model.addAttribute("addressArr", addressArr);
		model.addAttribute("addressArr1", addressArr1);
		model.addAttribute("telArr", telArr);
		model.addAttribute("emailArr", emailArr);
		model.addAttribute("birthdayArr", birthdayArr);
		
		return "join/joinInfoUpdate";
	}
	
	// 회원정보 수정처리
	@RequestMapping(value = "/joinInfoUpdate", method = RequestMethod.POST)
	public String joinInfoUpdatePost(JoinVO vo, String birthday,
			@RequestParam(name="mailCheck", defaultValue = "", required = false) String mailCheck) {

		// 비밀번호 암호화 처리
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 메일수신체크박스 선택 시 'YES'를 담는다.
		if(mailCheck.equals("on")) {
			vo.setMailCheck("YES");
		}
		else {
			vo.setMailCheck("NO");
		}
		
		// 생일을 입력하지 않을 시 '0000-00-00'을 DB에 저장한다.
		if(birthday.equals("-0월-00")) {
			vo.setBirthday("0000-00-00");
		}
		
		// 체크 완료된 자료를 다시 vo에 담았다면 DB에 저장시켜준다.(회원 가입처리)
		joinService.setJoinInfoUpdateOk(vo);
		
		return "redirect:/msg/joinInfoUpdateOk";
	}
	
}
