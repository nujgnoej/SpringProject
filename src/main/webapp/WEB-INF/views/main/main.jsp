<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style> 
		.paging { position: fixed; right: 80px; top: 50%; z-index: 10; }
    	.paging li span { background:url("https://cosmicmansion.co.kr/web/upload/ddongrim/slidebt.png") no-repeat center center; width:20px; height:25px; cursor: pointer; display: inline-block; text-indent: -9999px; }
    	.paging li.on span {background:url("https://cosmicmansion.co.kr/web/upload/ddongrim/slidebt_ov.png") no-repeat center center;}
		ul {list-style:none;}	
	</style>
	<script>
		'use strict';
		
		$(document).on("click", ".page", function() {
			$(".page").removeClass("on");
			$(this).addClass("on");
		});
		
		$(window).scroll(function(event) {
			let scroll = $(this).scrollTop();
			let imgSize = 935;
			if(scroll > 3273) {
				$(".page").removeClass("on");
				$("#page5").addClass("on");
			}
			else if(scroll > 2338) {
				$(".page").removeClass("on");
				$("#page4").addClass("on");
			}
			else if(scroll > 1403) {
				$(".page").removeClass("on");
				$("#page3").addClass("on");
			}
			else if(scroll > 468) {
				$(".page").removeClass("on");
				$("#page2").addClass("on");
			}
			else {
				$(".page").removeClass("on");
				$("#page1").addClass("on");
			}
		});
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container-fluid p-0" style="height:auto;" data-spy="scroll" data-target=".paging" data-offset="50">
	<div class="row m-0">
	 	<div class="paging" style="margin-top: -62.5px;">
			<ul>
				<li id="page1" class="page on"><a href="#main_visual1"><span>1</span></a></li>
				<li id="page2" class="page"><a href="#main_visual2"><span>2</span></a></li>
				<li id="page3" class="page"><a href="#main_visual3"><span>3</span></a></li>
				<li id="page4" class="page"><a href="#main_visual4"><span>4</span></a></li>
				<li id="page5" class="page"><a href="#main_visual5"><span>5</span></a></li>
			</ul>
		</div>
		<div id="main_visual1"><img src="https://cosmicmansion.co.kr/web/upload/ddongrim/main2_01.jpg" width="1903px"></div>
		<div id="main_visual2"><img src="https://cosmicmansion.co.kr/web/upload/ddongrim/main2_02.jpg" width="1903px"></div>
		<div id="main_visual3"><img src="https://cosmicmansion.co.kr/web/upload/ddongrim/main2_03.jpg" width="1903px"></div>
		<div id="main_visual4"><img src="https://cosmicmansion.co.kr/web/upload/ddongrim/main2_04.jpg" width="1903px"></div>
		<div id="main_visual5"><img src="https://cosmicmansion.co.kr/web/upload/ddongrim/main2_05.jpg" width="1903px"></div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
