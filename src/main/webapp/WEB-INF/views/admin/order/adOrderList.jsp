<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 주문관리</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		function orderStatusUpdate(orderIdx, orderStatus) {
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/orderStatusUpdate",
				data : {
					orderIdx : orderIdx,
					orderStatus : orderStatus
				},
				success : function() {
					alert("주문현황을 '"+orderStatus+"'(으)로 변경하였습니다.");
				},
				error	: function() {
					
				}
			});
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminNav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px; min-width:1300px;">
	<div style="margin:auto;" class="text-center mb-5"><h3>주문리스트</h3></div>
	<div style="float:left; height:29px;">
		<font color="red">*&nbsp;제품명을 클릭하시면 상세보기페이지로 이동합니다.</font><br/>
	</div>
	<table class="table mb-4 text-center">
		<tr>
			<th width="6%">번호</th>
			<th width="11%">주문번호</th>
			<th width="29%">제품명</th>
			<th width="10%">주문금액</th>
			<th width="10%">성명</th>
			<th width="7%">결제수단</th>
			<th width="17">주문일</th>
			<th width="10%">기타</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${curScrStartNo}</td>
				<td>${vo.orderIdx}</td>
				<td>
					<c:if test="${listSize[st.count-1] > 1}"><a href="${ctp}/admin/orderContent?orderIdx=${vo.orderIdx}&mid=${vo.mid}">${vo.commodity} 외 ${listSize[st.count-1]-1}개</a></c:if>
					<c:if test="${listSize[st.count-1] == 1}"><a href="${ctp}/admin/orderContent?orderIdx=${vo.orderIdx}&mid=${vo.mid}">${vo.commodity}</a></c:if>
				</td>
				<td><fmt:formatNumber value="${vo.orderTotalPrice}" pattern="#,###"/>원</td>
				<td>${vo.name}</td>
				<td>${vo.payment}</td>
				<td>
					<c:set var="baesongDate" value="${fn:split(vo.baesongDate,' ')}"/>
					<c:set var="baesongDate1" value="${fn:split(baesongDate[0],'-')}"/>
					<c:set var="baesongDate2" value="${fn:split(baesongDate[1],':')}"/>
					${baesongDate1[0]-2000}년 ${baesongDate1[1]}월 ${baesongDate1[2]}일 ${baesongDate2[0]}시 ${baesongDate2[1]}분
				</td>
				<td>
					<select name="orderStatus" id="orderStatus" class="custom-select form-control" onChange="orderStatusUpdate('${vo.orderIdx}', this.value)">
						<option value="결제완료" <c:if test="${vo.orderStatus == '결제완료'}">selected</c:if>>결제완료</option>
						<option value="주문취소" <c:if test="${vo.orderStatus == '주문취소'}">selected</c:if>>주문취소</option>
						<option value="배송중" <c:if test="${vo.orderStatus == '배송중'}">selected</c:if>>배송중</option>
						<option value="배송완료" <c:if test="${vo.orderStatus == '배송완료'}">selected</c:if>>배송완료</option>
					</select>
				</td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		</c:forEach>
		<tr><td colspan="8" class="p-0"></td></tr>
	</table>
</div>
<jsp:include page="/WEB-INF/views/include/blockPaging.jsp"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>