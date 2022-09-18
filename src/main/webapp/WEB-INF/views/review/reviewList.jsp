<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - Review</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		function reviewContent(orderIdx) {
			myForm.orderIdx.value = orderIdx;
			myForm.action = "${ctp}/review/reviewContent";
			myForm.submit();
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:700px; min-width:1300px;">
	<div style="margin:auto;" class="mb-3 text-center">
		<img src='${ctp}/images/thumbs-up.png' width="40px" height="40px" style="margin-bottom:19px;"/>&nbsp;<font size="6pt"><b>Review</b></font>
	</div>
	<div style="height:30px; margin:auto;"><font color="red">*&nbsp;상품명 또는 제목을 클릭하시면 상세보기페이지로 이동합니다.</font><br/></div>
	<table class="table text-center">
		<tr>
			<th width="5%">번호</th>
			<th width="30%">상품명</th>
			<th width="30%">제목</th>
			<th width="10%">작성자</th>
			<th width="5%">별점</th>
			<th width="20%">글쓴날짜</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td height="50px;">${curScrStartNo}</td>
				<td>
					<c:set var="commodity" value="${fn:split(vo.commodity,'/')}"/>
					<c:if test="${commoditySize[st.count-1] > 1}"><a href="javascript:reviewContent(${vo.orderIdx})">${commodity[0]} 외 ${commoditySize[st.count-1]-1}개</a></c:if>
					<c:if test="${commoditySize[st.count-1] == 1}"><a href="javascript:reviewContent(${vo.orderIdx})">${commodity[0]}</a></c:if>
				</td>
				<td class="text-left" style="padding-left:25px;"><a href="javascript:reviewContent(${vo.orderIdx})">${vo.title}</a></td>
				<td>${vo.name}</td>
				<td>${vo.rating}</td>
				<td>
					<c:set var="reviewDate" value="${fn:split(vo.reviewDate,' ')}"/>
					<c:set var="reviewDate1" value="${fn:split(reviewDate[0],'-')}"/>
					<c:set var="reviewDate2" value="${fn:split(reviewDate[1],':')}"/>
					${reviewDate1[0]}년 ${reviewDate1[1]}월 ${reviewDate1[2]}일 ${reviewDate2[0]}시 ${reviewDate2[1]}분
				</td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		</c:forEach>
		<tr><td colspan="6" class="p-0"></td></tr>
	</table>
	<form name="myForm" method="post">
		<input type="hidden" name="orderIdx"/>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/blockPaging.jsp"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>