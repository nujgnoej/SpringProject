<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 제품리스트</title>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		// 제품삭제
		function productDelete(idx) {
			let ans = confirm("선택한 제품을 삭제하시겠습니까?");
			
			if(ans) {
				$.ajax({
					type : "post",
					url  : "${ctp}/product/productDelete",
					data : {idx : idx},
					success : function() {
						alert("선택하신 제품이 삭제처리 되었습니다.");
						location.reload();
					},
					error : function() {
						alert("전송 오류!");
					}
				});
			}
		}
		
		// 재고주문
		function quantityOrder(idx) {
			let regNum = /^[0-9|_]*$/;   // 숫자로만 입력받음
			let ans = prompt("선택하신 상품의 주문하실 재고량을 입력하세요.","숫자로 입력해주세요.");
			
			if(ans == null) {
				alert("재고주문이 취소되었습니다.");
				return false;
			}
			else if(!regNum.test(ans)) {
				alert("숫자로 입력해주세요.");
				return false;
			}
			else {
				$.ajax({
					type : "post",
					url  : "${ctp}/product/quantityOrder",
					data : {
						idx : idx,
						orderQuantity : ans
						},
					success : function() {
						alert("주문이 완료되었습니다.");
						location.reload();
					},
					error	: function() {
						alert("전송오류.");
					}
				});
			}
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminNav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px; min-width:1300px;">
	<div style="margin:auto;" class="mb-5">
		<div style="margin:auto;" class="text-center mb-5"><h3>제품리스트</h3></div>
		<div class="text-right"><img src="${ctp}/images/exclamation-mark.png" height="13" width="13" style="margin-bottom:3px;"/> 재고가 30개 이하입니다.</div>
		<table class="table table table-bordered text-center">
			<tr>
				<th width="5%">번호</th>
				<th width="8%">종류</th>
				<th width="25%">제품명</th>
				<th width="4%">재고량</th>
				<th width="9%">판매가격</th>
				<th width="10%">사이즈(용량)</th>
				<th width="23%">제품등록일</th>
				<th width="15%">기타</th>
			</tr>
			<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
			<c:forEach var="vo" items="${vos}">
				<tr>
					<td>${curScrStartNo}</td>
					<td>${vo.product}</td>
					<td>${vo.commodity}</td>
					<td>
					<c:if test="${vo.quantity > 30}">
						${vo.quantity}
					</c:if>
					<c:if test="${vo.quantity <= 30}">
						<font color="red">${vo.quantity}</font>&nbsp;<img src="${ctp}/images/exclamation-mark.png" height="13" width="13" style="margin-bottom:2px;" /><br/>
						<input type="button" value="재고주문" class="btn btn-outline-danger" onclick="quantityOrder(${vo.idx})"/>
					</c:if>
					</td>
					<td class="text-right"><fmt:formatNumber value="${vo.price-vo.discount}" pattern="#,##0"/>원</td>
					<td>${vo.size}</td>
					<td>
						<c:set var="inputDay" value="${fn:split(vo.inputDay,' ')}"/>
						<c:set var="inputDay1" value="${fn:split(inputDay[0],'-')}"/>
						<c:set var="inputDay2" value="${fn:split(inputDay[1],':')}"/>
						${inputDay1[0]}년 ${inputDay1[1]}월 ${inputDay1[2]}일 ${inputDay2[0]}시 ${inputDay2[1]}분
					</td>
					<td>
						<input type="button" class="btn btn-outline-dark" onclick="location.href='${ctp}/product/productUpdate?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}'" value="수정" />
						<input type="button" class="btn btn-outline-danger" onclick="productDelete(${vo.idx})" value="삭제" />
					</td>
				</tr>
				<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
			</c:forEach>
		</table>
	</div>
</div>
<!-- 블록 페이징 처리 시작 -->
<div class="w3-center mb-4">
	<div class="w3-bar">
		<c:if test="${pageVO.pag >= 1}">
			<a href="productList?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button">&lt;&lt;</a>
		</c:if>
		<c:if test="${pageVO.curBlock > 0}">
			<a href="productList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
		</c:if>
		<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
			<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
				<a href="productList?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
			</c:if>
			<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
				<a href='productList?pag=${i}&pagSize=${pageVO.pageSize}' class="w3-button">${i}</a>
			</c:if>
		</c:forEach>
		<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
			<a href="productList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
		</c:if>
		<c:if test="${pageVO.pag <= pageVO.totPage}">
			<a href="productList?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
		</c:if>
	</div>
</div>
<!-- 블록 페이징 처리 끝 -->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>