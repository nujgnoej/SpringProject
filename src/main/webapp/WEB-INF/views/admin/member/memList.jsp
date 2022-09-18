<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 회원리스트</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		// 회원등급변경
		function levelUpdate(idx, name, level) {
			let strLevel = level;
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/levelUpdate",
				data : {
					idx : idx,
					strLevel : strLevel
					},
				success : function(data) {
					alert("\' "+name+" \' 님의 회원등급이 \' "+level+" \' 으로 변경되었습니다.");
					location.reload();
				},
				error	: function() {
					alert("전송오류!");
				}
			});
		}
		
		// 회원탈퇴이후 접속일이 30일이 지나면 회원정보 삭제가능
		function userDel(mid, name) {
			let ans = confirm("회원정보를 완전히 삭제하시겠습니까?");
			if(!ans) {
				alert("회원정보삭제를 취소하였습니다.");
				return false;
			}
			else {
				$.ajax({
					type : "post",
					url  : "${ctp}/admin/memInfoDelete",
					data : { mid : mid },
					success : function() {
						alert("\' "+name+" \' 님의 회원정보를 완전히 삭제하였습니다.");
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
		.btn-dark:hover {
			background-color: white;
			color: black;
		}
		.btn-danger:hover {
			background-color: white;
			color: #dd3245;
		}
		td {
			font-size: 10pt;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminNav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:700px; min-width:1300px;">
	<div style="margin:auto;" class="text-center mb-5"><h3>회원리스트</h3></div>
	<font color="red">*&nbsp;회원탈퇴 이후 최종접속일 기준 30일이 지나면 회원정보를 완전히 삭제할 수 있습니다.</font>
	<table class="table table-bordered text-center">
		<tr>
			<th width="5%">번호</th>
			<th width="8%">이름</th>
			<th width="30%">주소</th>
			<th width="12%">연락처</th>
			<th width="7%">성별</th>
			<th width="10%">등급</th>
			<th width="18%">마지막접속일</th>
			<th width="10%">탈퇴유무</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${curScrStartNo}</td>
				<td>${vo.name}</td>
				<td>${fn:split(vo.address,'/')[1]}</td>
				<td>${vo.tel}</td>
				<td>
					<c:if test="${!empty vo.gender}">${vo.gender}</c:if>
					<c:if test="${empty vo.gender}">미선택</c:if>
				</td>
				<td>
					<select name="level" id="level" class="custom-select form-control" onchange="levelUpdate('${vo.idx}', '${vo.name}', this.value)">
						<option value="골드회원" ${vo.level == '2' ? 'selected' : ''}>골드회원</option>
						<option value="실버회원" ${vo.level == '3' ? 'selected' : ''}>실버회원</option>
						<option value="회원" ${vo.level == '4' ? 'selected' : ''}>회원</option>
					</select>
				</td>
				<td>
					<c:set var="lastDate" value="${fn:split(vo.lastDate,' ')}"/>
					<c:set var="lastDate1" value="${fn:split(lastDate[0],'-')}"/>
					<c:set var="lastDate2" value="${fn:split(lastDate[1],':')}"/>
					${lastDate1[0]}년 ${lastDate1[1]}월 ${lastDate1[2]}일 ${lastDate2[0]}시 ${lastDate2[1]}분
				</td>
				<td>
					<c:if test="${vo.userDel == 'NO'}">${vo.userDel}</c:if>
					<c:if test="${vo.userDel == 'OK'}"><font color="red">${vo.userDel}</font></c:if>
					<!-- 회원탈퇴 30일이후부터 회원정보 삭제가능 -->
					<fmt:parseDate var="strLastDate" value="${vo.lastDate}" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber var="strDate" value="${strLastDate.time / (1000*60*60*24)}" integerOnly="true"/>
					<fmt:parseDate var="strNowDate" value="${nowDate}" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber var="endDate" value="${strNowDate.time / (1000*60*60*24)}" integerOnly="true"/>
					<c:if test="${vo.userDel == 'OK'}">
						<br/><font color="red">탈퇴 ${endDate-strDate}일경과</font>
						<c:if test="${endDate-strDate >= 30}">
							<input type="button" value="정보삭제" onClick="userDel('${vo.mid}','${vo.name}')" class="btn btn-danger btn-sm"/>
						</c:if>
					</c:if>
				</td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
		</c:forEach>
	</table>
</div>
<!-- 블록 페이징 처리 시작 -->
<div class="w3-center mb-4">
	<div class="w3-bar">
		<c:if test="${pageVO.pag >= 1}">
			<a href="memList?pag=1" class="w3-bar-item w3-button">&lt;&lt;</a>
		</c:if>
		<c:if test="${pageVO.curBlock > 0}">
			<a href="memList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}" class="w3-button">&lt;</a>
		</c:if>
		<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
			<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
				<a href="memList?pag=${i}" class="w3-button w3-dark-grey">${i}</a>
			</c:if>
			<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
				<a href='memList?pag=${i}' class="w3-button">${i}</a>
			</c:if>
		</c:forEach>
		<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
			<a href="memList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}" class="w3-button">&gt;</a>
		</c:if>
		<c:if test="${pageVO.pag <= pageVO.totPage}">
			<a href="memList?pag=${pageVO.totPage}" class="w3-button">&gt;&gt;</a>
		</c:if>
	</div>
</div>
<!-- 블록 페이징 처리 끝 -->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>