<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<c:if test="${pageVO.section == 'candle'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="candleView?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="candleView?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="candleView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="candleView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="candleView?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="candleView?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>

<c:if test="${pageVO.section == 'diffuser'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="diffuserView?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="diffuserView?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="diffuserView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="diffuserView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="diffuserView?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="diffuserView?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>

<c:if test="${pageVO.section == 'spray'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="sprayView?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="sprayView?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="sprayView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="sprayView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="sprayView?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="sprayView?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>

<c:if test="${pageVO.section == 'sachet'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="sachetView?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="sachetView?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="sachetView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="sachetView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="sachetView?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="sachetView?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>

<c:if test="${pageVO.section == 'hb'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="hbView?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="hbView?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="hbView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="hbView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="hbView?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="hbView?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>

<c:if test="${pageVO.section == 'perfume'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="perfumeView?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="perfumeView?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="perfumeView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="perfumeView?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="perfumeView?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="perfumeView?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>

<c:if test="${pageVO.section == 'memOrder'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="memOrderList?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="memOrderList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="memOrderList?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="memOrderList?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="memOrderList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="memOrderList?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>

<c:if test="${pageVO.section == 'review'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="reviewList?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="reviewList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="reviewList?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="reviewList?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="reviewList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="reviewList?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>

<c:if test="${pageVO.section == 'order'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="orderList?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="orderList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="orderList?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="orderList?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="orderList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="orderList?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>

<c:if test="${pageVO.section == 'qna'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="qnaList?pag=1&pagSize=${pageVO.pageSize}" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="qnaList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="qnaList?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="qnaList?pag=${i}&pagSize=${pageVO.pageSize}" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="qnaList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="qnaList?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>

<c:if test="${pageVO.section == 'myQna'}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="w3-center mb-4 mt-4">
		<div class="w3-bar">
			<c:if test="${pageVO.pag >= 1}">
				<a href="mypageView?pag=1&pagSize=${pageVO.pageSize}&flag=mypage" class="w3-bar-item w3-button mr-1">&lt;&lt;</a>
			</c:if>
			<c:if test="${pageVO.curBlock > 0}">
				<a href="mypageView?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}&flag=mypage" class="w3-button">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					<a href="mypageView?pag=${i}&pagSize=${pageVO.pageSize}&flag=mypage" class="w3-button w3-dark-grey">${i}</a>
				</c:if>
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					<a href="mypageView?pag=${i}&pagSize=${pageVO.pageSize}&flag=mypage" class="w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
				<a href="mypageView?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pagSize=${pageVO.pageSize}&flag=mypage" class="w3-button">&gt;</a>
			</c:if>
			<c:if test="${pageVO.pag <= pageVO.totPage}">
				<a href="mypageView?pag=${pageVO.totPage}&pagSize=${pageVO.pageSize}&flag=mypage" class="w3-button">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</c:if>
