<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 아이디/비밀번호 찾기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
	  	// 아이디 검색하기
	    function midSearch() {
	    	let name = $("#idName").val();
	    	let email = $("#idEmail").val();
	    	
	    	if(name.trim() == "") {
	    		alert("이름을 입력하세요.");
	    		$("#idName").focus();
	    		return false;
	    	}
	    	else if(email.trim() == "") {
	    		alert("이메일을 입력하세요.");
	    		$("#idEmail").focus();
	    		return false;
	    	}
	    	
	    	$.ajax({
	    		type   : "post",
	    		url    : "${ctp}/login/idSearch",
	    		data   : {
	    			name : name,
	    			email : email
	    		},
	    		success: function(mid) {
	    			if(mid == "") {
	    				alert("등록된 자료가 없습니다.");
	    			}
	    			else {
	    				$("#mid2").html("<h5>찾으시는 아이디는 \" <b>"+mid+"</b> \"입니다.</h5>");
	    			}
	    		},
	    		error : function() {
	    			alert("전송오류~~");
	    		}
	    	});
	    }
	  	
	 	// 비밀번호 검색하기
	    function pwdSearch() {
	    	let mid = $("#pwdMid").val();
	    	let email = $("#pwdEmail").val();
	    	
	    	if(mid.trim() == "") {
	    		alert("아이디를 입력하세요.");
	    		$("#pwdMid").focus();
	    		return false;
	    	}
	    	else if(email.trim() == "") {
	    		alert("이메일을 입력하세요.");
	    		$("#pwdEmail").focus();
	    		return false;
	    	}
	    	else {
	    		location.href = "${ctp}/login/pwdSearch?mid="+mid+"&email="+email;
	    	}
	    	
	    }
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container p-0" style="height:770px;">
	<div style="width:70%; margin:auto; padding-top:12%;">
		<form>
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li class="nav-item">
					<a class="nav-link active btn-outline-dark" data-toggle="tab" href="#midSearch" id="idTab">아이디찾기</a>
				</li>
				<li class="nav-item">
					<a class="nav-link btn-outline-dark" data-toggle="tab" href="#pwdSearch" id="pwdTab">비밀번호찾기</a>
				</li>
			</ul>
			
			<!-- Tab panes -->
			<div class="tab-content p-5" style="border: 1px solid #343a40;">
				<div id="midSearch" class="container tab-pane active text-center"><br/>
					<h2>아이디 찾기</h2>
					<br/>
					<div id="mid1"><h5>아이디는 가입 시 입력하신 이메일을 통해 찾을 수 있습니다.</h5></div>
					<div id="mid2"></div>
					<br/>
					<div style="width:60%; margin:auto;">
						<input type="text" name="name" id="idName" placeholder="이름을 입력하세요." class="form-control mb-3" autofocus >
						<input type="text" name="email" id="idEmail" placeholder="이메일을 입력하세요." class="form-control mb-3">
						<input type="button" value="아이디찾기" onclick="midSearch()" class="form-control btn btn-outline-secondary mb-5"/>
					</div>
				</div>
				<div id="pwdSearch" class="container tab-pane fade text-center"><br/>
					<h2>비밀번호 찾기</h2>
					<br/>
					<h5>비밀번호는 가입 시 입력하신 아이디, 이메일을 통해 찾을 수 있습니다.</h5>
					<br/>
					<div style="width:60%; margin:auto;">
						<input type="text" name="mid" id="pwdMid" placeholder="아이디를 입력하세요." class="form-control mb-3">
						<input type="text" name="email" id="pwdEmail" placeholder="이메일을 입력하세요." class="form-control mb-3">
						<input type="button" value="비밀번호찾기" id="passwordBtn" onclick="pwdSearch()" class="form-control btn btn-outline-secondary mb-5"/>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>