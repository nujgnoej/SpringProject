package com.spring.javagreenS_jjm.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CartInterceptor extends HandlerInterceptorAdapter {
	@Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
  	HttpSession session = request.getSession();
  	int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
  	if(level > 4) {		// 1:관리자, 2:골드회원, 3:실버회원, 4:회원, 99:비회원(관리자외 사용불가)
  		RequestDispatcher dispatcher = null;
  		dispatcher = request.getRequestDispatcher("/msg/levelLoginNo");
  		
  		dispatcher.forward(request, response);
  		return false;
  	}
  	
  	return true;
  }
}
