<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		google.charts.load("current", {packages:["corechart"]});
		google.charts.setOnLoadCallback(drawChart);
		function drawChart() {
			var data = google.visualization.arrayToDataTable([
				['품목', '품목별 주문수량'],
				<c:forEach var="i" begin="0" end="${vosSize-1}" varStatus="st">
					['${vos[i].product}', ${vos[i].orderCount}],
				</c:forEach>
			]);
			
			var options = {
				is3D: true
			};
			
			var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
			chart.draw(data, options);
		}
	</script>
</head>
<body>
	<div id="piechart_3d" style="width: 540px; height: 300px; float: right;"></div>
</body>
</html>