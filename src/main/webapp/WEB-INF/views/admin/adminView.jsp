<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 관리자페이지</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.jb-wrap {
			width: 50px;
			margin: auto;
			position: relative;
			vertical-align: middle;
		}
		.jb-wrap img {
			width: 50px;
			height: 50px;
			vertical-align: middle;
		}
		.jb-text {
			padding: 5px 10px;
			font-size: 20pt;
			text-align: center;
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate( -50%, -50% );
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminNav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px; min-width:1300px;">
	<div style="margin-bottom:30px;" class="text-center"><h2>Order Status</h2></div>
	<div class="text-left">
		<h4>Q&A </h4><font size="6pt">&nbsp;&nbsp;${wrc}</font> 개의 문의글이 답변 대기중 입니다.<a href="${ctp}/admin/qnaList">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+ 답변하러 가기</a>
	</div>
	<hr/>
	<div style="float:left;">
		<div style="margin-bottom:15px;">
			<h5 style="float:left;">New order</h5>
			<div style="float:right; height:24px; padding-top:20px;"><a href="${ctp}/admin/orderList">+ 더보기</a></div>
		</div>
		<table class="table text-center" style="font-size:10pt;">
			<tr>
				<th>주문번호</th>
				<th>주문자</th>
				<th>주문품목</th>
				<th>주문날짜</th>
				<th>주문상태</th>
			</tr>
			<c:forEach var="vo" items="${bVos}" varStatus="st">
				<tr>
					<td>${vo.orderIdx}</td>
					<td>${vo.name}</td>
					<td>
						<c:if test="${listSize[st.index] > 1}">${vo.commodity} 외 ${listSize[st.index]-1}개</c:if>
						<c:if test="${listSize[st.index] == 1}">${vo.commodity}</c:if>
					</td>
					<td>
						<c:set var="orderDate" value="${fn:split(vo.orderDate,' ')}"/>
						<c:set var="orderDate1" value="${fn:split(orderDate[0],'-')}"/>
						<c:set var="orderDate2" value="${fn:split(orderDate[1],':')}"/>
						${orderDate1[0]}년 ${orderDate1[1]}월 ${orderDate1[2]}일 ${orderDate2[0]}시
					</td>
					<td>
						<c:if test="${vo.orderStatus == '배송완료'}"><span class="badge badge-success">${vo.orderStatus}</span><br/></c:if>
						<c:if test="${vo.orderStatus == '배송중'}"><span class="badge badge-warning">${vo.orderStatus}</span><br/></c:if>
						<c:if test="${vo.orderStatus == '주문취소'}"><span class="badge badge-danger">${vo.orderStatus}</span><br/></c:if>
						<c:if test="${vo.orderStatus == '결제완료'}"><span class="badge badge-info">${vo.orderStatus}</span><br/></c:if>
					</td>
				</tr>
			</c:forEach>
			<tr><td colspan="5" class="p-0"></td></tr>
		</table>
	</div>
	<h5 class="text-center" style="padding-top:10px;">Order quantity by product</h5>
	<div><jsp:include page="orderQuantityByProductChart.jsp"/></div>
	<div style="clear: both;"></div>
	<hr class="mb-5"/>
	<h5>Order count by date</h5>
	<div class="mt-4 mb-5 text-center"><jsp:include page="orderCountByDateChart.jsp"/></div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>