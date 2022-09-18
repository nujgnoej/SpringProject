<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - Q&A</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		// 리뷰 내용기입란 글자수체크
		function contentCheck() {
			var content = $("#content").val(); //입력한 것
		    $('#counter').html("("+content.length+" / 최대 100자)");  //글자수 카운팅

		    if (content.length > 100){ //100자 이상일 때
		        alert("최대 100자까지 입력 가능합니다.");
		        $("#content").val(content.substring(0, 100)); //넘어간 글자 자르기
		        $('#counter').html("(100 / 최대 100자)");
		    }
		}
		
		// 리뷰등록 유효성체크
		function qnaUpdate() {
			let qnaTypeIdx = $('#qnaTypeIdx').val();
			let title = myForm.title.value;
			let content = myForm.content.value;
			
			if(qnaTypeIdx == 0) {
				alert("질문유형을 선택해주세요.");
				myForm.qnaTypeIdx.focus();
				return false;
			}
			else if(title.trim() == "") {
				alert("제목을 입력해주세요.");
				myForm.title.focus();
				return false;
			}
			else if(content.trim() == "") {
				alert("내용을 입력해주세요.");
				myForm.content.focus();
				return false;
			}
			else {
				myForm.action = "${ctp}/qna/qnaUpdate";
				myForm.submit();
			}
		}
	</script>
	<style>
		td {
			text-align:left;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px;">
	<div style="width:100px; margin:auto;" class="mb-5"><h3>Q&A</h3></div>
	<form name="myForm" method="post">
		<table class="table mb-4 text-center">
			<tr>
				<th width="20%">작성자</th>
				<td width="30%">${sName}</td>
				<th width="20%">글 공개여부</th>
				<td width="30%">
					<div class="form-group" style="margin:auto;">
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="openSw" value="공개" <c:if test="${vo.openSw == '공개'}">checked</c:if>>공개
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="openSw" value="비공개" <c:if test="${vo.openSw == '비공개'}">checked</c:if>>비공개
							</label>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>질문유형</th>
				<td colspan="3">
					<select name="qnaTypeIdx" id="qnaTypeIdx" class="custom-select form-control">
						<option value="0">질문유형을 선택해주세요.</option>
						<option value="0">-------------------------------</option>
						<c:forEach var="qnaTypeVo" items="${qnaTypeVos}">
							<option value="${qnaTypeVo.idx}" <c:if test="${qnaTypeVo.idx == vo.qnaTypeIdx}">selected</c:if>>${qnaTypeVo.qnaType}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3"><input type="text" name="title" id="title" value="${vo.title}" class="form-control" placeholder="제목을 입력해주세요."/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<textarea rows="5" name="content" id="content" class="form-control content1" onkeyup="contentCheck()" placeholder="내용을 입력해주세요.(최대 100자)" required>${vo.content}</textarea>
					<span style="color:#aaa;" id="counter">(${contentLen} / 최대 100자)</span>
				</td>
			</tr>
			<tr><td colspan="4" class="p-0"></td></tr>
		</table>
		<div class="text-center">
			<input type="button" value="수정" onclick="qnaUpdate()" class="btn btn-outline-dark"/>
			<c:if test="${flag == 'qna'}"><input type="button" value="취소" onclick="location.href='${ctp}/qna/qnaList?pag=${pag}&pageSize=${pageSize}'" class="btn btn-outline-danger"/></c:if>
			<c:if test="${flag == 'mypage'}"><input type="button" value="취소" onclick="location.href='${ctp}/member/mypageView?pag=${pag}&pageSize=${pageSize}'" class="btn btn-outline-danger"/></c:if>
		</div>
		<input type="hidden" name="idx" value="${vo.idx}" />
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="name" value="${sName}" />
		<input type="hidden" name="flag" value="${flag}" />
		<input type="hidden" name="pag" value="${pag}" />
		<input type="hidden" name="pageSize" value="${pageSize}" />
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>