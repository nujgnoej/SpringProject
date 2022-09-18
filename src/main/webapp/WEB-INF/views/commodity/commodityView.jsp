<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<c:if test="${pageVO.section == 'candle'}"><title>Mood Ritual - Candle</title></c:if>
	<c:if test="${pageVO.section == 'diffuser'}"><title>Mood Ritual - Diffuser</title></c:if>
	<c:if test="${pageVO.section == 'spray'}"><title>Mood Ritual - Room Spray</title></c:if>
	<c:if test="${pageVO.section == 'sachet'}"><title>Mood Ritual - Sachet</title></c:if>
	<c:if test="${pageVO.section == 'hb'}"><title>Mood Ritual - Hand & Body</title></c:if>
	<c:if test="${pageVO.section == 'perfume'}"><title>Mood Ritual - Perfume</title></c:if>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.mainImg {
			background-size: 300px;
			width: 300px;
			height: 300px;
			margin: auto;
			z-index: -1;
		}
		.soldoutImg {
			background-size: 300px;
			width: 300px;
			height: 300px;
			z-index: 2;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px;">
	<c:set var="cnt" value="0"/>
	<div class="row mt-4">
		<c:forEach var="vo" items="${vos}">
			<div class="col-md-4">
				<div style="text-align:center">
					<a href="${ctp}/commodity/commodityContent?pag=${pageVO.pag}&pagSize=${pageVO.pageSize}&idx=${vo.idx}">
						<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
						<%-- <img src="${ctp}/data/admin/product/${fSNames[0]}" width="300px" height="300px"/> --%>
						<div class="mainImg" style="background-image:url('${ctp}/data/admin/product/${fSNames[0]}');">
							<c:if test="${vo.quantity == 0}"><div class="soldoutImg" style="background-image:url('${ctp}/images/soldout50.png'"></div></c:if>
						</div>
						<div><font size="2">${vo.commodity}</font></div>
						<div>
							<c:if test="${vo.discount != 0}">
								<font size="2" color="red"><del><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</del></font>&nbsp;→&nbsp;
								<font size="2"><fmt:formatNumber value="${vo.price-vo.discount}" pattern="#,###"/>원</font>&nbsp;&nbsp;&nbsp;
							</c:if>
							<c:if test="${vo.discount == 0}">
								<font size="2"><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</font>&nbsp;&nbsp;&nbsp;
							</c:if>
							<font size="2">${vo.size}</font>
						</div>
					</a>
				</div>
			</div>
			<c:set var="cnt" value="${cnt+1}"/>
			<c:if test="${cnt%3 == 0}">
				</div>
				<div class="row mt-5">
			</c:if>
		</c:forEach>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/blockPaging.jsp"/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>