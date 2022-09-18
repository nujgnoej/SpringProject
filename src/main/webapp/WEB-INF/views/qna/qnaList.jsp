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
		function qnaInput() {
			let pag = '${pageVO.pag}';
			let pageSize = '${pageVO.pageSize}';
			location.href = "${ctp}/qna/qnaWrite?pag="+pag+"&pageSize="+pageSize;
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:700px; min-width:1300px;">
	<div style="margin:auto;" class="mb-3 text-center">
		<img src='${ctp}/images/qna.png' width="50px" height="50px" style="margin-bottom:10px;"/>&nbsp;<font size="6pt"><b>Question and Answer</b></font>
	</div>
	<div style="float:left; height:50px;">
		<font color="red">*&nbsp;제목을 클릭하시면 상세보기페이지로 이동합니다.</font><br/>
		<font color="red">*&nbsp;비밀글은 작성회원만 열람 가능합니다.</font><br/>
	</div>
	<div style="float:right; margin-bottom:10px;"><input type="button" value="글쓰기" onclick="qnaInput()" class="btn btn-outline-dark btn-sm" /><br/></div>
	<table class="table mb-2 text-center">
		<tr>
			<th width="10%">번호</th>
			<th width="10%">질문유형</th>
			<th width="35%">제목</th>
			<th width="8%">작성자</th>
			<th width="22%">작성일</th>
			<th width="15%">상태</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td height="50px;">${curScrStartNo}</td>
				<td>${vo.qnaType}</td>
				<td class="text-left">
					<c:if test="${vo.openSw == '공개'}">
						<a href="${ctp}/qna/qnaContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title}</a>
					</c:if>
					<c:if test="${vo.openSw == '비공개' && vo.mid != sMid && sLevel != 1}">
						<img src="${ctp}/images/lock.png" width="19px" height="19px" style="margin-bottom:4px;"/>&nbsp;${vo.title}
					</c:if>
					<c:if test="${(vo.openSw == '비공개' && vo.mid == sMid) || (vo.openSw == '비공개' && sLevel == 1)}">
						<img src="${ctp}/images/lock.png" width="19px" height="19px" style="margin-bottom:4px;"/>&nbsp;<a href="${ctp}/qna/qnaContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title}</a>
					</c:if>
				</td>
				<td>${vo.name}</td>
				<td>
					<c:set var="wDate" value="${fn:split(vo.WDate,' ')}"/>
					<c:set var="wDate1" value="${fn:split(wDate[0],'-')}"/>
					<c:set var="wDate2" value="${fn:split(wDate[1],':')}"/>
					${wDate1[0]}년 ${wDate1[1]}월 ${wDate1[2]}일 ${wDate2[0]}시 ${wDate2[1]}분
				</td>
				<td>
					<c:if test="${vo.adChk == 'no'}"><span class="badge badge-secondary">답변대기중</span></c:if>
					<c:if test="${vo.adChk == 'yes'}"><span class="badge badge-info">답변완료</span></c:if>
				</td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		</c:forEach>
		<tr><td colspan="6" class="p-0"></td></tr>
	</table>
</div>
<jsp:include page="/WEB-INF/views/include/blockPaging.jsp"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>