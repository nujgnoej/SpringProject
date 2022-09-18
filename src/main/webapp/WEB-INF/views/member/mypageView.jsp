<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 마이페이지</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		// 질문등록
		function qnaInput(flag) {
			let pag = '${pageVO.pag}';
			let pageSize = '${pageVO.pageSize}';
			location.href = "${ctp}/qna/qnaWrite?pag="+pag+"&pageSize="+pageSize+"&flag="+flag;
		}
		
		// 회원탈퇴 체크
		function memDelCheck() {
			let ans = confirm("회원탈퇴를 진행하시겠습니까?");
			if(ans) {
				location.href='${ctp}/member/memDelete';
			}
		}
	</script>
	<style>
		.btn-dark:hover {
			background-color: white;
			color: black;
		}
		.btn-danger:hover {
			background-color: white;
			color: #dd3245;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:677px; min-width:1300px;">
	<h2>My Page</h2><br/>
	<font color="red">*&nbsp;배송은 영업일기준 2~5일 정도 소요되며 백배사의 상황에 따라 지연될 수 있습니다.</font>
	<hr/>
	<table class="table table-borderless text-center">
		<tr>
			<td class="text-left pl-0" width="20%">
				<input type="button" style="margin-bottom:10px;" value="정보수정" class="btn btn-dark" onclick="location.href='${ctp}/join/pwdCheck'"/><br/>
				<input type="button" style="margin-bottom:10px;" value="주문조회" class="btn btn-dark" onclick="location.href='${ctp}/member/memOrderList'"/><br/>
				<input type="button" value="회원탈퇴" class="btn btn-danger" onclick="memDelCheck()"/><br/>
			</td>
			<td class="text-left" width="30%">
				<div style="margin-bottom:10px;">사용가능 적립금</div>
				<div><font size="5pt"><b><fmt:formatNumber value="${vo.point}" pattern="#,###"/></b>원</font></div>
			</td>
		</tr>
	</table>
	<hr/>
	<div style="width:100%; margin:auto;" class="mb-5 text-center mt-5"><h3>My Q&A List</h3></div>
	<div style="float:left; height:30px;"><font color="red">*&nbsp;제목을 클릭하시면 상세보기페이지로 이동합니다.</font></div>
	<div style="float:right; margin-bottom:10px;"><input type="button" value="글쓰기" onclick="qnaInput('mypage')" class="btn btn-outline-dark btn-sm" /><br/></div>
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
		<c:forEach var="qnaVo" items="${qnaVos}">
			<tr>
				<td height="50px;">${curScrStartNo}</td>
				<td>${qnaVo.qnaType}</td>
				<td class="text-left">
					<c:if test="${qnaVo.openSw == '공개'}">
						<a href="${ctp}/qna/qnaContent?idx=${qnaVo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&flag=mypage">${qnaVo.title}</a>
					</c:if>
					<c:if test="${qnaVo.openSw == '비공개'}">
						<img src="${ctp}/images/lock.png" width="19px" height="19px" style="margin-bottom:4px;"/>&nbsp;<a href="${ctp}/qna/qnaContent?idx=${qnaVo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&flag=mypage">${qnaVo.title}</a>
					</c:if>
				</td>
				<td>${qnaVo.name}</td>
				<td>
					<c:set var="wDate" value="${fn:split(qnaVo.WDate,' ')}"/>
					<c:set var="wDate1" value="${fn:split(wDate[0],'-')}"/>
					<c:set var="wDate2" value="${fn:split(wDate[1],':')}"/>
					${wDate1[0]}년 ${wDate1[1]}월 ${wDate1[2]}일 ${wDate2[0]}시 ${wDate2[1]}분
				</td>
				<td>
					<c:if test="${qnaVo.adChk == 'no'}"><span class="badge badge-secondary">답변대기중</span></c:if>
					<c:if test="${qnaVo.adChk == 'yes'}"><span class="badge badge-info">답변완료</span></c:if>
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