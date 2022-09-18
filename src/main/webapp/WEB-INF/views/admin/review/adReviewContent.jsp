<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - Review</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		function productGo(idx) {
			location.href='${ctp}/commodity/commodityContent?idx='+idx;
		}
		
		function myPage() {
			location.href='${ctp}/member/memOrderList';
		}
	</script>
	<style>
		.mainImg {
			background-size: 100px;
			width: 100px;
			height: 100px;
			margin: auto;
		}
		.reviewImg {
			background-size: 100px;
			width: 100px;
			height: 100px;
			margin: auto;
			transition: all 0.1s linear;
		}
		.reviewImg:hover {
			transform: scale(2.5);
		}
		#ratingForm{
		    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
		    direction: rtl; /* 이모지 순서 반전 */
		    border: 0; /* 필드셋 테두리 제거 */
		    padding: 0;
		    margin: 0;
		}
		#ratingForm legend{
		    text-align: left;
		}
		#ratingForm{
		    font-size: 2em; /* 이모지 크기 */
		    color: transparent; /* 기존 이모지 컬러 제거 */
		    text-shadow: 0 0 0 #EB1D36; /* 새 이모지 색상 부여 */
		}
		#rcTable td {
			text-align: left;
			padding-left: 40px;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminNav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px;">
	<div style="width:100px; margin:auto;" class="mb-5"><h3>Review</h3></div>
	<c:if test="${sLevel != 1}"><div style="height:30px; margin:auto; margin-bottom:10px;"><font color="red">*&nbsp;리뷰수정/삭제는 마이페이지에서 가능합니다.&nbsp;&nbsp;</font><input type="button" value="마이페이지" onclick="myPage()" class="btn btn-outline-danger btn-sm mb-1"/><br/></div></c:if>
	<table class="table mb-4 text-center" id="rcTable">
		<tr>
			<th width="10%">주문번호</th>
			<td width="40%">${vo.orderIdx}</td>
			<th width="10%">작성일</th>
			<td width="40%">
				<c:set var="reviewDate" value="${fn:split(vo.reviewDate,' ')}"/>
				<c:set var="reviewDate1" value="${fn:split(reviewDate[0],'-')}"/>
				<c:set var="reviewDate2" value="${fn:split(reviewDate[1],':')}"/>
				${reviewDate1[0]-2000}년 ${reviewDate1[1]}월 ${reviewDate1[2]}일 ${reviewDate2[0]}시 ${reviewDate2[1]}분
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${vo.name}</td>
			<th>제품명</th>
			<td>
			<c:forEach var="pVo" items="${productVos}" varStatus="st">
				<c:if test="${pVosSize > 1}">${st.count}.&nbsp;&nbsp;${pVo.commodity}<br/></c:if>
				<c:if test="${pVosSize == 1}">${pVo.commodity}<br/></c:if>
			</c:forEach>
			</td>
		</tr>
		<tr>
			<th>별점</th>
			<td colspan="3">
				<div id="ratingForm">
					<c:forEach begin="1" end="${vo.rating}">
						<div id="rating" style="float:left">⭐</div>
					</c:forEach>
				</div>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3">${vo.title}</td>
		</tr>
		<tr>
			<td><div class="reviewImg" style="background-image:url('${ctp}/data/review/${vo.FSName}');"></div></td>
			<td colspan="3">
				<div style="min-height:50px;">${fn:replace(vo.content,newLine,"<br/>")}</div>
			</td>
		</tr>
		<tr><td colspan="4" class="p-0"></td></tr>
	</table>
	<h3>Product List↓</h3>
	<table class="table text-center mb-5">
		<c:forEach var="pVo" items="${productVos}" varStatus="st">
			<tr>
				<c:set var="fSName" value="${fn:split(pVo.FSName,'/')}"/>
				<th width="10%"><div class="mainImg" style="background-image:url('${ctp}/data/admin/product/${fSName[0]}');"></div></th>
				<td class="text-left">
					제품명&nbsp;:&nbsp;${pVo.commodity}&nbsp;&nbsp;/&nbsp;&nbsp;사이즈&nbsp;:&nbsp;${pVo.size}<br/>
					가격&nbsp;:&nbsp;<font size="5pt"><b><fmt:formatNumber value="${pVo.price}" pattern="#,###"/></b></font>&nbsp;원<br/>
					<input type="button" value="상품바로가기" onclick="productGo(${pVo.idx})" class="btn btn-outline-dark btn-sm" />
				</td>
			</tr>
		</c:forEach>
		<tr><th colspan="2" class="p-0"></th></tr>
	</table>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>