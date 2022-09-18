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
		google.charts.load('current', {'packages':['bar']});
		google.charts.setOnLoadCallback(drawChart);
		
		function drawChart() {
			var data = google.visualization.arrayToDataTable([
				['주문일', '최근 일일 주문량'],
				<c:forEach var="i" begin="0" end="${oVosSize-1}" varStatus="st">
					['${strOrderDate[oVosSize-1-i]}', ${oVos[6-i].orderCount}],
				</c:forEach>
			]);
			
			var options = {
				chart: {
				}
			};
		
			var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
			
			chart.draw(data, google.charts.Bar.convertOptions(options));
		}
	</script>
</head>
<body>
  <div id="columnchart_material" style="width: 1270px; height: 540px;"></div>
</body>
</html>