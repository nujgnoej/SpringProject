<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 나의주문내역</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		function orderDel(orderIdx) {
			let ans = confirm("해당 상품들의 주문을 취소하시겠습니까?");
			if(ans) {
				$.ajax ({
					type : "post",
					url  : "${ctp}/member/orderDel",
					data : {orderIdx : orderIdx},
					success : function() {
						alert("해당주문이 취소되었습니다.");
						location.reload();
					},
					error	: function() {
						alert("전송오류");
					}
				});
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
		.btn-danger:hover {
			background-color: white;
			color: #dd3245;
		}
		#orderTable th {
			border-right: 1px solid #e0e4e7;
		}
		#orderTable td {
			text-align: left;
			padding-left: 20px;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px; margin-bottom:60px;">
	<h3>주문 상세내역</h3><br/>
	<div style="width:100%; height:43px;">
		<div style="float:left; height:43px;">
			<font color="red">*&nbsp;배송은 영업일기준 2~5일 정도 소요되며 백배사의 상황에 따라 지연될 수 있습니다.</font><br/>
			<font color="red">*&nbsp;배송완료 처리된 7일 이후부터 리뷰를 작성할 수 있습니다.</font>
		</div>
		<c:if test="${vos[0].orderStatus == '결제완료'}"><div style="float:right;"><input type="button" value="주문취소" onclick="orderDel(${vos[0].orderIdx})" class="btn btn-danger mr-2"/></div></c:if>
	</div>
	<hr/>
	<table class="table text-center" style="margin-bottom:30px;" id="orderTable">
		<tr><th width="20%">배송단계</th><td width="80%">${vos[0].orderStatus}</td></tr>
		<tr>
			<th>배송단계 변경일</th>
			<td>
				<c:set var="baesongDate" value="${fn:split(vos[0].baesongDate,' ')}"/>
				<c:set var="baesongDate1" value="${fn:split(baesongDate[0],'-')}"/>
				<c:set var="baesongDate2" value="${fn:split(baesongDate[1],':')}"/>
				${baesongDate1[0]}년 ${baesongDate1[1]}월 ${baesongDate1[2]}일&nbsp;&nbsp;&nbsp;${baesongDate2[0]}시 ${baesongDate2[1]}분
			</td>
		</tr>
		<tr>
			<th>배송메세지</th>
			<td>
				<c:if test="${vos[0].message == ''}">배송메세지 없음</c:if>
				<c:if test="${vos[0].message != ''}">${vos[0].message}</c:if>
			</td>
		</tr>
		<tr><td colspan="2" class="p-0"></td></tr>
	</table>
	<table class="table text-center" style="margin-bottom:60px;">
		<tr>
			<th style="width:11%">주문번호</th>
			<th style="width:10%">이미지</th>
			<th style="width:17%">상품정보</th>
			<th style="width:17%">선택옵션</th>
			<th style="width:15%">판매가<br/>(옵션포함)</th>
			<th style="width:7%">수량</th>
			<th style="width:15%">합계</th>
			<th style="width:8%">적립금</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<c:if test="${st.count == 1}"><td rowspan='<c:if test="${totPrice>=50000}">${vosSize}</c:if><c:if test="${totPrice<50000}">${vosSize+1}</c:if>' style="border-right: 1px solid #e0e4e7;">${vo.orderIdx}</td></c:if>
				<td>
					<%-- <img src="${ctp}/data/admin/product/${vo.FSName}" width="80px" height="80px"/> --%>
					<div class="mainImg" style="background-image:url('${ctp}/data/admin/product/${vo.FSName}');"></div>
				</td>
				<td>${vo.commodity}</td>
				<c:if test="${vo.optionName != ''}">
					<td>${vo.optionName}</td>
				</c:if>
				<c:if test="${vo.optionName == ''}">
					<td>선택옵션없음</td>
				</c:if>
				<td><fmt:formatNumber value="${vo.salePrice}" pattern="#,###"/>원</td>
				<td>${vo.orderQuantity}</td>
				<td><fmt:formatNumber value="${vo.totPrice}" pattern="#,###"/>원</td>
				<td><fmt:formatNumber value="${vo.totSavePoint}" pattern="#,###"/>원</td>
			</tr>
		</c:forEach>
		<c:if test="${totPrice < 50000}"><tr><td colspan="5" style="text-align:center; height:100px;">배송비(주문금액 5만원이하)</td><td>3,000원</td><td>150원</td></tr></c:if>
		<tr>
			<td colspan="7" style="text-align:right; font-size:15pt">
				총액 : <br/>
				적립금 사용 : <br/>
				결제액 : <br/>
				적립금 누적 : <br/>
			</td>
			<td class="text-right" style="font-size:15pt; padding-right:50px; min-width:200px;">
				<c:if test="${totPrice < 50000}">
					<c:set var="totPrice1" value="${totPrice+3000}"/>
					<b><fmt:formatNumber value="${totPrice1}" pattern="#,###"/></b>원<br/>
					<b><fmt:formatNumber value="${totPrice1-orderTotPrice}" pattern="#,###"/></b>원<br/>
					<b><fmt:formatNumber value="${orderTotPrice}" pattern="#,###"/></b>원<br/>
					<b><fmt:formatNumber value="${totPrice1*0.05}" pattern="#,###"/></b>원
				</c:if>
				<c:if test="${totPrice >= 50000}">
					<b><fmt:formatNumber value="${totPrice}" pattern="#,###"/></b>원<br/>
					<b><fmt:formatNumber value="${totPrice-orderTotPrice}" pattern="#,###"/></b>원<br/>
					<b><fmt:formatNumber value="${orderTotPrice}" pattern="#,###"/></b>원<br/>
					<b><fmt:formatNumber value="${totPrice*0.05}" pattern="#,###"/></b>원
				</c:if>
			</td>
		</tr>
		<tr><td colspan="8" class="p-0"></td></tr>
	</table>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>