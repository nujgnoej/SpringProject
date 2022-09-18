package com.spring.javagreenS_jjm;

import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_jjm.service.JoinService;
import com.spring.javagreenS_jjm.vo.JoinVO;

@Controller
@RequestMapping("/login")
public class LoginController {

	@Autowired
	JoinService joinService;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	// 로그인화면보이기(아이디저장 되어있으면 자동기입)
	@RequestMapping(value = "/loginView", method = RequestMethod.GET)
	public String loginViewGet(HttpServletRequest request) {
		// 로그인폼 호출시 기존에 저장된 쿠키가 있다면 불러와서 mid에 담아서 넘겨준다.
		Cookie[] cookies = request.getCookies();
		String mid = "";
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}
		
		return "login/loginView";
	}
	
	// 로그인처리
	@RequestMapping(value = "/loginView", method = RequestMethod.POST)
	public String loginViewPost(
			Model model, HttpServletRequest request, HttpServletResponse response,
			String mid, String pwd,
			@RequestParam(name="idCheck", defaultValue = "", required = false) String idCheck,
			HttpSession session) {

		// 아이디를 찾아서 있다면 vo객체에 담는다.
		JoinVO vo = joinService.getJoinIdCheck(mid);
		
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("NO")) {
			// 회원 인증처리된경우에 수행할 내용들을 기술한다.(session에 저장할자료 처리, 쿠키값처리...)
			String strLevel = "";
			if(vo.getLevel() == 1) strLevel = "관리자";
			else if(vo.getLevel() == 2) strLevel = "골드회원";
			else if(vo.getLevel() == 3) strLevel = "실버회원";
			else if(vo.getLevel() == 4) strLevel = "회원";
			
			String name = vo.getName();
			session.setAttribute("sMid", mid);
			session.setAttribute("sName", name);
			session.setAttribute("sEmail", vo.getEmail());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);
			
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cMid", mid);
				cookie.setMaxAge(60*60*24*30);		// 쿠키의 만료시간을 30일로 정함(단위:초)
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);		// 기존에 저장된 현재 mid값을 삭제한다.
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
			model.addAttribute("name", name);
			return "redirect:/msg/loginOk";
		}
		else {
			return "redirect:/msg/loginNo";
		}
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutGet(HttpSession session, Model model) {
		String name = (String) session.getAttribute("sName");
		session.invalidate();
		
		model.addAttribute("name", name);
		return "redirect:/msg/logout";
	}
	
	// 아이디/비밀번호찾기 페이지이동
	@RequestMapping(value = "/idPwSearch", method = RequestMethod.GET)
	public String idPwSearchGet() {
		return "login/idPwSearch";
	}
	
	// 아이디찾기
	@ResponseBody
	@RequestMapping(value = "/idSearch", method = RequestMethod.POST)
	public String idSearchGet(String name, String email) {
		String mid = joinService.getIdSearch(name, email);
		
		return mid;
	}
	
	// 비밀번호찾기
	@RequestMapping(value = "/pwdSearch", method = RequestMethod.GET)
	public String pwdSearchGet(String mid, String email) {
		JoinVO vo = joinService.getPwdSearch(mid, email);
		if(vo != null) {
			// 회원정보가 맞으면 임시비밀번호를 만든다.
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			
			// 발급받은 임시비밀번호를 DB에 저장한다.
			joinService.setPwdChange(mid, passwordEncoder.encode(pwd));
			
			// 임시비밀번호를 메일로 전송한다.
			String content = pwd;
			String res = mailSend(email, content);
			
			if(res.equals("1")) return "redirect:/msg/pwdSearchOk";
			else return "redirect:/msg/pwdSearchNo";
		}
		else {
			return "redirect:/msg/pwdSearchNo";
		}
	}
	
	// 임시 비밀번호 메일로 발송하기
	public String mailSend(String toMail, String content) {
		try {
			String title = "신규 비밀번호가 발급되었습니다.";
			
			// 메세지를 변환시켜서 보관함(messageHelper)에 저장하여 준비한다.
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 메일보관함에 회원이 보낸온 메세지를 모두 저장시켜둔다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			// 메세지 보관함의 내용을 편집해서 다시 보관함에 담아둔다.
			content = "<hr>신규 비밀번호는 : <font color='red'><b>" + content + "</b></font>";
			content += "<br><hr>아래 주소로 다시 로그인하셔서 비밀번호를 변경하시기 바랍니다.<hr><br>";
			content += "<p><img src=\"cid:main.jpg\" width='500px'></p><hr>";
			content += "<p style='font-family:\"Montserrat\", sans-serif;'>방문하기 : <a href='http://49.142.157.251:9090/javagreenS_jjm/'>Mood Ritual 홈페이지</a></p>";
			content += "<hr>";
			messageHelper.setText(content, true);
			
			// 본문에 기재된 그림파일의 경로를 따로 표시시켜준다.
			FileSystemResource file = new FileSystemResource("D:\\JavaGreen\\springframework\\project\\javagreenS_jjm\\javagreenS_jjm\\src\\main\\webapp\\resources\\images\\main.jpg");
			messageHelper.addInline("main.jpg", file);
			
			// 메일 전송하기
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "1";
	}
	
}
