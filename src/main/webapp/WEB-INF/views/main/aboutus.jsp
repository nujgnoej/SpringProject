<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - About Us</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		hr {
		  width : 90%;
		  height : 1px;
		  background-color : #bdbdbd;
		  border : 0;
		}
		.center-hr {
		  margin-left : auto;
		  margin-right : auto;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px;">
	<div style="text-align: center"><img src="${ctp}/images/aboutus.png"/></div>
	<hr class="center-hr mb-5"/>
	<br/>
	<div>
		<div style="font-size: 20px; font-weight: 700; text-align: center; margin-bottom: 30px;">INFORMATION</div>
		<div style="font-size: 12px; line-height: 18px; text-align: center; margin: 40px 0; text-align: center; overflow: hidden;">
			<div class="text-center" style="float: left; width: 33.33%;">
				STORE POINT
				<br/>
				충북 청주시 서원구 사직대로 109
			</div>
			<div class="text-center" style="float: left; border: solid #ccc; border-width: 0 1px 0 1px; width: calc(33.33% - 2px);">
				C/S CENTER
				<br/>
				010-4079-8492
			</div>
			<div class="text-center" style="float: left; width: 33.33%;">
				AM 09:00 - PM 18:00
				<br/>
				MONDAY - SUNDAY
			</div>
		</div>
		<div class="mb-5">
			<div id="map" style="width:90%; height:350px;" class="container"></div>
			
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2800aeee183ec57d1b8e41d56c88cb5e"></script>
			<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = { 
				        center: new kakao.maps.LatLng(36.635094996846895, 127.4595267180685), // 지도의 중심좌표
				        level: 6 // 지도의 확대 레벨
				    };
				
				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				
				// 마커가 표시될 위치입니다 
				var markerPosition  = new kakao.maps.LatLng(36.635094996846895, 127.4595267180685); 
				
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});
				
				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
				
				// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
				// marker.setMap(null);
			</script>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>