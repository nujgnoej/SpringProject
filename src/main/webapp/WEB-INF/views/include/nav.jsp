<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- Sidebar/menu -->
<style>
	#mySidebar {
		background-color:transparent;
	}
	a:hover {
		text-decoration:none;
		color:gray;
	}
	#bg {
		background-color:transparent;
	}
</style>
<nav class="w3-sidebar w3-bar-block w3-collapse w3-top" style="z-index:3;width:250px;display:fixed;margin-left:50px;" id="mySidebar">
	<div class="w3-container w3-display-container w3-padding-16">
		<i onclick="w3_close()" class="fa fa-remove w3-hide-large w3-button w3-display-topright"></i>
		<h3 class="w3-wide"><a href="${ctp}"><b>Mood Ritual</b></a></h3>
	</div>
	<div class="w3-padding-64 w3-large w3-text-black" style="font-weight:bold" id="smallScrMenu">
		<div class="mb-2">
			<a href="${ctp}/aboutus">ABOUT US</a>
		</div>
		<div class="mb-2">
			<a class="w3-left-align" id="myBtn">
				SHOP <i class="fa fa-caret-down"></i>
			</a>
			<div id="demoAcc" class="w3-medium pl-3">
				<div style="padding:4px 8px;"><a href="${ctp}/commodity/candleView">CANDLE</a></div>
				<div style="padding:4px 8px;"><a href="${ctp}/commodity/diffuserView">DIFFUSER</a></div>
				<div style="padding:4px 8px;"><a href="${ctp}/commodity/sprayView">ROOM SPRAY</a></div>
				<div style="padding:4px 8px;"><a href="${ctp}/commodity/sachetView">SACHET</a></div>
				<div style="padding:4px 8px;"><a href="${ctp}/commodity/hbView">HAND & BODY</a></div>
				<div style="padding:4px 8px;"><a href="${ctp}/commodity/perfumeView">PERFUME</a></div>
			</div>
		</div>
		<div class="mb-2">
			<a class="w3-left-align" id="myBtn1">
				COMMUNITY <i class="fa fa-caret-down"></i>
			</a>
			<div id="demoAcc1" class="w3-bar-block w3-medium pl-3" style="display:none;">
				<div style="padding:4px 8px;"><a href="${ctp}/qna/qnaList">Q&A</a></div>
				<div style="padding:4px 8px;"><a href="${ctp}/review/reviewList">REVIEW</a></div>
			</div>
		</div>
	</div>
</nav>

<!-- Top menu on small screens -->
<header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
	<div class="w3-bar-item w3-padding-24 w3-wide">Mood Ritual</div>
	<a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-24 w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
	<div class="w3-right p-4 mr-3" id="bg" style="display:fixed !important; width:auto;">
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
			<span id="menu"><a href="${ctp}/join/pwdCheck">MY PAGE</a></span> | 
		</c:if>
		<c:if test="${!empty sLevel && sLevel == 1}">
			<span id="menu"><a href="${ctp}/admin/adminView">ADMIN PAGE</a></span><c:if test="${!empty sLevel && sLevel != 1}"> | </c:if>
		</c:if>
		<c:if test="${!empty sLevel && sLevel != 1}">
			<span id="menu"><a href="#">CART</a></span>
		</c:if>
	</div>
</header>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<script>
	$(document).ready(function () {
		$("#myBtn").on("click", function() {
			$("#demoAcc").slideToggle(500);
		});
		
		$("#myBtn1").on("click", function() {
			$("#demoAcc1").slideToggle(500);
		});
	});
</script>