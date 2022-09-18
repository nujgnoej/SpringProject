<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	#menu {
		margin: 0px 10px;
	}
	#bg {
		background-color:transparent;
	}
</style>
<div class="text-right p-4 mr-3 w3-top" id="bg" style="float:right; display:fixed !important;">
	<c:if test="${empty sLevel}">
		<span id="menu"><a href="${ctp}/login/loginView">LOGIN</a></span> | 
	</c:if>
	<c:if test="${!empty sLevel}">
		<span>[ ' ${sName} ' 님 환영합니다.]</span>&nbsp;&nbsp;&nbsp;|
		<span id="menu"><a href="${ctp}/login/logout">LOGOUT</a></span> | 
	</c:if>
	<c:if test="${empty sLevel}">
		<span id="menu"><a href="${ctp}/join/joinView">JOIN US</a></span><c:if test="${!empty sLevel && sLevel != 1}"> | </c:if>
	</c:if>
	<c:if test="${!empty sLevel && sLevel != 1}">
		<%-- <span id="menu"><a href="${ctp}/member/pwdCheck">MY PAGE</a></span> |  --%>
		<span id="menu"><a href="${ctp}/member/mypageView">MY PAGE</a></span> | 
	</c:if>
	<c:if test="${!empty sLevel && sLevel == 1}">
		<span id="menu"><a href="${ctp}/admin/adminView">ADMIN PAGE</a></span><c:if test="${!empty sLevel && sLevel != 1}"> | </c:if>
	</c:if>
	<c:if test="${!empty sLevel && sLevel != 1}">
		<span id="menu"><a href="${ctp}/cart/cartView">CART</a></span>
	</c:if>
</div>