<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 나의주문조회</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		// 리뷰작성
		function review(orderIdx) {
			myForm.orderIdx.value = orderIdx;
			myForm.action = "${ctp}/review/reviewWrite";
			myForm.submit();
		}
		
		// 리뷰수정
		function reviewUpdate(orderIdx) {
			myForm.orderIdx.value = orderIdx;
			myForm.action = "${ctp}/review/reviewUpdate";
			myForm.submit();
		}
		
		// 리뷰삭제
		function reviewDelete(orderIdx) {
			let ans = confirm("리뷰를 삭제하시겠습니까?");
			if(ans) {
				myForm.orderIdx.value = orderIdx;
				myForm.action = "${ctp}/review/reviewDelete";
				myForm.submit();
			}
		}
	</script>
	<style>
		.mainImg {
			background-size: 80px;
			width: 80px;
			height: 80px;
			margin: auto;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px;">
	<h2>Order Status</h2><br/>
	<div style="height:43px;">
		<font color="red">*&nbsp;배송은 영업일기준 2~5일 정도 소요되며 백배사의 상황에 따라 지연될 수 있습니다.</font><br/>
		<font color="red">*&nbsp;배송완료 처리된 7일 이후부터 리뷰를 작성할 수 있습니다.</font>
	</div>
	<hr/>
	<table class="table table bordered text-center" style="margin-bottom:60px;">
		<tr>
			<th>주문번호</th>
			<th>제품이미지</th>
			<th width="25%">제품명</th>
			<th width="17%">결제금액</th>
			<th width="8%">결제수단</th>
			<th>결제일</th>
			<th>주문현황</th>
		</tr>
		<c:if test="${vosSize >= 1}">
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${vo.orderIdx}</td>
					<td>
						<%-- <img src="${ctp}/data/admin/product/${vo.FSName}" width="80px" height="80px"/> --%>
						<div class="mainImg" style="background-image:url('${ctp}/data/admin/product/${vo.FSName}');"></div>
					</td>
					<td>
						<c:if test="${listSize[st.count-1] > 1}">
							${vo.commodity} 외 ${listSize[st.count-1]-1}개
						</c:if>
						<c:if test="${listSize[st.count-1] == 1}">
							${vo.commodity}
						</c:if>
					</td>
					<td><font size="5pt"><b><fmt:formatNumber value="${vo.orderTotalPrice}" pattern="#,###"/></b></font>&nbsp;원</td>
					<td>${vo.payment}</td>
					<td>
						<c:set var="orderDate" value="${fn:split(vo.orderDate,' ')}"/>
						<c:set var="orderDate1" value="${fn:split(orderDate[0],'-')}"/>
						${orderDate1[0]}년 ${orderDate1[1]}월 ${orderDate1[2]}일
					</td>
					<td>
						<c:if test="${vo.orderStatus == '배송완료'}"><span class="badge badge-success">${vo.orderStatus}</span><br/></c:if>
						<c:if test="${vo.orderStatus == '배송중'}"><span class="badge badge-warning">${vo.orderStatus}</span><br/></c:if>
						<c:if test="${vo.orderStatus == '주문취소'}"><span class="badge badge-danger">${vo.orderStatus}</span><br/></c:if>
						<c:if test="${vo.orderStatus == '결제완료'}"><span class="badge badge-info">${vo.orderStatus}</span><br/></c:if>
						<c:if test="${reviewVos[st.count-1].reviewDate != null}"><span class="badge badge-secondary">리뷰작성완료</span><br/></c:if>
						<a href="${ctp}/member/memOrderDetail?orderIdx=${vo.orderIdx}">[상세내역]</a><br/>
						<!-- 배송완료 7일이후부터 리뷰작성가능 -->
						<fmt:parseDate var="strBaesongDate" value="${baesongDateList[st.count-1]}" pattern="yyyy-MM-dd"/>
						<fmt:parseNumber var="strDate" value="${strBaesongDate.time / (1000*60*60*24)}" integerOnly="true"/>
						<fmt:parseDate var="strNowDate" value="${nowDate}" pattern="yyyy-MM-dd"/>
						<fmt:parseNumber var="endDate" value="${strNowDate.time / (1000*60*60*24)}" integerOnly="true"/>
						<c:if test="${endDate-strDate >= 7 && vos[st.count-1].orderStatus == '배송완료' && reviewVos[st.count-1].reviewDate == null}">
							<a href="javascript:review(${vo.orderIdx})">[리뷰작성]</a><br/>
						</c:if>
						<c:if test="${reviewVos[st.count-1].reviewDate != null}">
							<a href="javascript:reviewUpdate(${vo.orderIdx})">[리뷰수정]</a><br/>
							<a href="javascript:reviewDelete(${vo.orderIdx})">[리뷰삭제]</a><br/>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${vosSize < 1}">
			<tr>
				<td colspan="7" height="100px;">주문 내역이 없습니다.</td>
			</tr>
		</c:if>
		<tr><td colspan="7" class="p-0"></td></tr>
	</table>
	<form name="myForm" method="post">
		<input type="hidden" name="orderIdx" />
		<input type="hidden" name="pag" value="${pageVO.pag}"/>
		<input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/blockPaging.jsp"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>