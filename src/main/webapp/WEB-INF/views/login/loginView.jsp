<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 로그인</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/login.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container-fluid p-0" style="height:770px;">
	<div class="login" id="inner">
		<h1><b>LOGIN</b></h1>
		<br/>
		<form method="post">
			<input type="text" name="mid" id="mid" placeholder="Username" value="${mid}" required="required" />
			<input type="password" name="pwd" id="pwd" placeholder="Password" required="required" />
			<div style="font-size:12px;" class="mb-2">
				<label for="agree" class="chk_box">
					<input type="checkbox" name="idCheck" id="agree" checked="checked" />
					<span class="on"></span>
					아이디 저장
				</label>
			</div>
			<button type="submit" class="btn btn-primary btn-block btn-large mb-1">SIGN IN</button>
			<div class="cover p-2" style="display:flex; justify-content:space-between;">
				<div><a href="${ctp}/join/joinView">회원가입</a></div>
				<div><a href="${ctp}/login/idPwSearch">아이디/비밀번호찾기</a></div>
			</div>
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>