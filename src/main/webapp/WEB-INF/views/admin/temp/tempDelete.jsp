<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 임시이미지삭제</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		// 선택이미지 삭제
		function imgDel(indexNo) {
			let ans = confirm("해당 이미지를 삭제하시겠습니까?");
			if(ans) {
				$.ajax({
					type : "post",
					url  : "${ctp}/admin/imgDel",
					data : {indexNo : indexNo},
					success : function() {
						alert("해당 이미지를 삭제하였습니다.");
						location.reload();
					},
					error	: function() {
						alert("전송오류!");
					}
				});
			}
		}
		
		// 이미지 전체삭제
		function imgAllDel() {
			let ans = confirm("이미지를 전체 삭제하시겠습니까?");
			if(ans) {
				$.ajax({
					type : "post",
					url  : "${ctp}/admin/imgAllDel",
					success : function() {
						alert("이미지를 모두 삭제하였습니다.");
						location.reload();
					},
					error	: function() {
						alert("전송오류!");
					}
				});
			}
		}
	</script>
	<style>
		.btn-danger:hover {
			background-color: white;
			color: #dd3245;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminNav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px;">
	<div style="margin:auto;" class="text-center mb-5"><h3>임시이미지삭제</h3></div>
	<div class="text-right mb-2"><input type="button" value="이미지전체삭제" onClick="imgAllDel()" class="btn btn-danger btn-sm" /></div>
	<table class="table text-center">
		<tr>
			<th>번호</th>
			<th>파일명</th>
			<th>이미지/폴더</th>
			<th>기타</th>
		</tr>
		<c:set var="startIndexNo" value="${pageVO.startIndexNo}"/>
		<c:forEach var="i" begin="${startIndexNo}" end="${startIndexNo+9}" varStatus="st">
			<c:if test="${!empty files[i]}">
				<tr>
					<td>${startIndexNo+1}</td>
					<td>${files[i]}</td>
					<td class="text-center">
						<c:set var="fileName" value="${fn:split(files[i],'.')}"/>
						<c:if test="${fn:toUpperCase(fileName[1]) == 'JPG' || fn:toUpperCase(fileName[1]) == 'PNG' || fn:toUpperCase(fileName[1]) == 'JPEG' || fn:toUpperCase(fileName[1]) == 'GIF'}">
							<a href="${ctp}/data/admin/${files[i]}" download="${file}"><img src="${ctp}/data/admin/${files[i]}" width="100px" height="100px"/></a>
						</c:if>
						<c:if test="${fn:indexOf(files[i],'.') == -1}">이미지파일이 아닙니다.</c:if>
					</td>
					<td>
						<c:if test="${fn:indexOf(files[i],'.') != -1}">
							<input type="button" value="이미지삭제" onclick="imgDel(${startIndexNo})" class="btn btn-outline-danger btn-sm"/>
						</c:if>
					</td>
				</tr>
				<c:set var="startIndexNo" value="${startIndexNo+1}"/>
			</c:if>
		</c:forEach>
		<tr><td colspan="4" class="p-0"></td></tr>
	</table>
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="tempDelete?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="tempDelete?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="tempDelete?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="tempDelete?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="tempDelete?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="tempDelete?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>