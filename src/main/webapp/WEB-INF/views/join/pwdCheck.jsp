<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memPwdCheck.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		function fCheck() {
			let pwd = myForm.pwd.value;
			if(pwd.trim() == "") {
				alert("비밀번호를 확인하세요.");
				myForm.pwd.focus();
				return false;
			}
			else {
				myForm.submit();
			}
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:150px; height:767px;">
	<form name="myForm" method="post">
		<div class="text-center">
			<h2>비밀번호 확인</h2>
		</div>
		<table class="table table-bordered" style="margin-bottom:30px;">
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd" class="form-control" placeholder="비밀번호를 입력하세요." required autofocus /></td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="비밀번호확인" onclick="fCheck()" class="btn btn-outline-dark"/> &nbsp;
					<input type="reset" value="다시입력" class="btn btn-outline-dark"/> &nbsp;
				</td>
			</tr>
		</table>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>