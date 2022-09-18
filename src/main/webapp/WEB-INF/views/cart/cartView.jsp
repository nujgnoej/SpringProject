<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - Cart</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		// +/-버튼 클릭이벤트, 인풋박스 변경이벤트
		function quantityCheck(quantityFlag,cnt,pricePerPiece,idx) {
			for(let i=0; i<${cnt}; i++) {
				// 더하기빼기버튼 인풋처리
				let quantityNum = Number($("#orderQuantity"+cnt).val())
				if(quantityFlag == "+") {			// +버튼을 눌렀을때 입력값 더하기
					quantityNum = quantityNum + 1;
				}
				else if(quantityFlag == "-") {		// +버튼을 눌렀을때 입력값 빼기
					quantityNum = quantityNum - 1;
				}
				if(quantityNum < 1) {
					alert("최소 주문수량은 1개입니다.");
					$("#orderQuantity"+cnt).val(1);

					let totPricePerPiece = pricePerPiece*1;
					let totSavePointPerPiece = pricePerPiece*1*0.05;
					let strTotPricePerPiece = (totPricePerPiece).toLocaleString('ko-KR');
					let strTotSavePointPerPiece = (totSavePointPerPiece).toLocaleString('ko-KR');
					document.getElementById("totPricePerPiece"+cnt).innerHTML = "<b>"+strTotPricePerPiece+"원</b><input type=hidden id=totPPP"+cnt+" value="+totPricePerPiece+"/>";
					document.getElementById("totSavePointPerPiece"+cnt).innerHTML = strTotSavePointPerPiece+"원<input type=hidden id=totSPPP"+cnt+" value="+totSavePointPerPiece+"/>";
					$("#totPPP").val(totPricePerPiece);
					$("#totSPPP").val(totSavePointPerPiece);
					location.reload();
					return false;
				}
				if(quantityNum > 100) {
					alert("최대 주문수량은 100개입니다.");
					$("#orderQuantity"+cnt).val(1);

					let totPricePerPiece = pricePerPiece*1;
					let totSavePointPerPiece = pricePerPiece*1*0.05;
					let strTotPricePerPiece = (totPricePerPiece).toLocaleString('ko-KR');
					let strTotSavePointPerPiece = (totSavePointPerPiece).toLocaleString('ko-KR');
					document.getElementById("totPricePerPiece"+cnt).innerHTML = "<b>"+strTotPricePerPiece+"원</b><input type=hidden id=totPPP"+cnt+" value="+totPricePerPiece+"/>";
					document.getElementById("totSavePointPerPiece"+cnt).innerHTML = strTotSavePointPerPiece+"원<input type=hidden id=totSPPP"+cnt+" value="+totSavePointPerPiece+"/>";
					$("#totPPP").val(totPricePerPiece);
					$("#totSPPP").val(totSavePointPerPiece);
					location.reload();
					return false;
				}
				$("#orderQuantity"+cnt).val(quantityNum);	// 해당상품의 orderQuantity값을 변경처리
				$("#selectQuantity").val(quantityNum);	// 히든태그에 orderQuantity값을 넣는다(주문테이블에 수량을 가져가기 위함)
				
				let totPricePerPiece = pricePerPiece*quantityNum;
				let totSavePointPerPiece = pricePerPiece*quantityNum*0.05;
				let strTotPricePerPiece = (totPricePerPiece).toLocaleString('ko-KR');
				let strTotSavePointPerPiece = (totSavePointPerPiece).toLocaleString('ko-KR');
				document.getElementById("totPricePerPiece"+cnt).innerHTML = "<b>"+strTotPricePerPiece+"원</b><input type=hidden id=totPPP"+cnt+" value="+totPricePerPiece+"/>";
				document.getElementById("totSavePointPerPiece"+cnt).innerHTML = strTotSavePointPerPiece+"원<input type=hidden id=totSPPP"+cnt+" value="+totSavePointPerPiece+"/>";
				$("#totPPP").val(totPricePerPiece);
				$("#totSPPP").val(totSavePointPerPiece);
				
				onTotal();		// 재계산
				$.ajax ({
					type : "get",
					url  : "${ctp}/cart/cartUpdate",
					data : {
						idx : idx,
						salePrice : pricePerPiece,
						orderQuantity : quantityNum
					},
					success : function() {},
					error	: function() {
						alert("전송실패");
					}
				});
				/* location.href="${ctp}/cart/cartUpdate?idx="+idx+"&salePrice="+pricePerPiece+"&orderQuantity="+quantityNum; */
				return false;
			}
		}
		
		// all체크버튼을 클릭하면 모든 상품에 대하여 check버튼을 true 또는 false로 만들고 있다.
	    function allCheck() {
			if(document.getElementById("aCheck").checked){
				for(let i=1; i<=${cnt}; i++){
					if($("#check"+i).length != 0){
						document.getElementById("check"+i).checked = true;
					}
				}
			}
			else {
				for(let i=1; i<=${cnt}; i++){
					if($("#check"+i).length != 0){
						document.getElementById("check"+i).checked = false;
					}
				}
			}
			onTotal();		/* 다시 재계산한다. */
	    }
		
		// 원하는 제품 체크
		function onCheck() {
			let cnt = 0;
			for(let i=1; i<=${cnt}; i++){
				if($("#check"+i).length != 0 && document.getElementById("check"+i).checked == false){
					cnt++;
					break;
				}
			}
			
			if(cnt!=0){
				document.getElementById("aCheck").checked = false;
			} 
			else {
				document.getElementById("aCheck").checked = true;
			}
			onTotal();		/* 상품을 선택/취소했을때 수행하기에 다시 재개산(onTotal())처리한다. */
		}
		
		// 천단위마다 쉼표 표시하는 함수
	    function numberWithCommas(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
		
		// 체크된 제품 총금액 계산
		function onTotal() {
			let total = 0;
			for(let i=1; i<=${cnt}; i++){
				if($("#totPPP"+i).length != 0 && document.getElementById("check"+i).checked){  
					total = total + parseInt(document.getElementById("totPPP"+i).value);
					myForm.totPrice.value = total;
				}
			}
			let strTotCommodityPrice = total.toLocaleString('ko-KR');
			document.getElementById("totCommodityPrice").innerHTML = strTotCommodityPrice+"원";	// 총 상품금액
			
			let deliveryFee = 0;
			if(total >= 50000 || total == 0){
				deliveryFee = 0;
				document.getElementById("deliveryFee").innerHTML = "무료";
			} else {
				deliveryFee = 3000;
				let strDeliveryFee = deliveryFee.toLocaleString('ko-KR');
				document.getElementById("deliveryFee").innerHTML = strDeliveryFee+"원";
			}
			
			let totPrice = deliveryFee + total;		// totPrice는 배송비를 합산해준 총 주문금액변수이다.
			let totSavePoint = totPrice * 0.05;		// totSavePoint는 배송비를 뺀 합산해준 총주문금액의 5%이다.
			let strTotPrice = totPrice.toLocaleString('ko-KR');	// 총 주문금액 콤마처리
			let strTotSavePoint = totSavePoint.toLocaleString('ko-KR');	// 총 주문금액 콤마처리
			document.getElementById("totPrice").innerHTML = strTotPrice+"원";  // 화면에 보여주는 총 주문금액(콤마처리했다.)
			document.getElementById("totSavePoint").innerHTML = "<span class='badge badge-danger'>적립금</span>&nbsp;&nbsp;"+strTotSavePoint+"원";  // 화면에 보여주는 총 적립금액(콤마처리했다.)
			myForm.deliveryFee.value = deliveryFee;  // 배송비가 있는 경우 넘겨준다.
			myForm.totPrice.value = totPrice;  // 값을 넘겨주는 '총 주문금액'변수(totPrice) : 콤마처리하지 않았다. 정수값으로 넘겨야 400에러 막는다.
			myForm.totSavePoint.value = totSavePoint;  // 값을 넘겨주는 '총 주문금액'변수(totSavePoint) : 콤마처리하지 않았다. 정수값으로 넘겨야 400에러 막는다.
		}
		
		function cartDel(idx) {
			let ans = confirm("선택하신 재품을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url  : "${ctp}/cart/cartDelete",
				data : {idx : idx},
				success:function() {
					location.reload();
				},
				error : function() {
					alert("전송에러!");
				}
			});
		}
		
		function order() {
			// 구매하기위해 체크한 장바구니에만 아이디가 check상태인 필드의 값을 1로 셋팅(체크박스가 1인것, 즉 true값인것만 넘어가게된다.). 체크하지 않은것은 check아이디필드의 기본값은 0이다.
			for(let i=1; i<=${cnt}; i++){
				if($("#check"+i).length != 0 && document.getElementById("check"+i).checked){	// 구매한 상품이면 true이다.
					document.getElementById("checkItem"+i).value = "1";
				}
			}
			if(myForm.totPrice.value == 0){		// 계산된 최종금액이 0원이면 주문할수 없다.
				alert("장바구니에서 주문처리할 상품을 선택해주세요!");
				return false;
			} 
			else {
				myForm.submit();
			}
		}
	</script>
	<style>
		th {
			font-size: 10pt;
		}
		td {
			font-size: 9pt;
		}
		#totTable td {
			font-size: 25pt;
		}
		.btn-dark:hover {
			background-color: white;
			color: black;
		}
		.btn-danger:hover {
			background-color: white;
			color: #dd3245;
		}
		.mainImg {
			background-size: 80px;
			width: 80px;
			height: 80px;
			margin: auto;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px;">
	<form name="myForm" method="post" action="${ctp}/cart/orderView">
		<h3>My Cart</h3><br/>
		<table class="table text-center" style="margin-bottom:60px;">
			<tr>
				<th style="width:3%">
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="aCheck" name="aCheck" onclick="allCheck()">
						<label class="custom-control-label" for="aCheck"></label>
					</div>
				</th>
				<th style="width:10%">이미지</th>
				<th style="width:17%">상품정보</th>
				<th>선택옵션</th>
				<th>판매가(옵션포함)</th>
				<th style="width:11%">수량</th>
				<th>합계</th>
				<th>적립금</th>
				<th>선택</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" id="check${st.count}" name="idxChecked" value="${vo.idx}" onclick="onCheck()">
							<label class="custom-control-label" for="check${st.count}"></label>
						</div>
					</td>
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
					<td><fmt:formatNumber value="${vo.salePrice + vo.optionPrice}" pattern="#,###"/>원</td>
					<td>
						<div class="input-group" style="width:100px; margin:auto;">
							<input type="button" class="form-control btn btn-outline-dark" value="-" onclick="quantityCheck('-','${st.count}','${vo.salePrice+vo.optionPrice}','${vo.idx}')"/>
							<input type="text" class="form-control text-right" value="${vo.orderQuantity}" id="orderQuantity${st.count}" style="width:50%; border: 1px solid #000000;" onchange="quantityCheck('','${st.count}','${vo.salePrice+vo.optionPrice}','${vo.idx}')"/>
							<input type="button" class="form-control btn btn-outline-dark" value="+" onclick="quantityCheck('+','${st.count}','${vo.salePrice+vo.optionPrice}','${vo.idx}')"/>
						</div>
					</td>
					<td>
						<div id="totPricePerPiece${st.count}">
							<b><fmt:formatNumber value="${vo.totPrice}" pattern="#,###"/>원</b>
							<input type="hidden" id="totPPP${st.count}" value="${vo.totPrice}"/>
						</div>
					</td>
					<td>
						<div id="totSavePointPerPiece${st.count}">
							<fmt:formatNumber value="${vo.totSavePoint}" pattern="#,###"/>원
							<input type="hidden" id="totSPPP${st.count}" value="${vo.totSavePoint}"/>
						</div>
					</td>
					<td>
						<input type="button" class="btn btn-outline-dark btn-sm" value="삭제" style="width:80px" onclick="cartDel(${vo.idx})"/>
						<input type="hidden" name="checkItem" value="0" id="checkItem${st.count}"/>	<!-- 구매체크가 되지 않은 품목은 '0'으로 체크된것은 '1'로 처리하고자 한다. -->
						<input type="hidden" name="idx" value="${vo.idx}"/>
						<input type="hidden" name="fSName" value="${vo.FSName}"/>
						<input type="hidden" name="commodity" value="${vo.commodity}"/>
						<input type="hidden" id="selectQuantity"/>
						<input type="hidden" name="salePrice" value="${vo.salePrice + vo.optionPrice}"/>
						<input type="hidden" name="optionName" value="${vo.optionName}"/>
						<input type="hidden" name="mid" value="${sMid}"/>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${cnt < 1}"><tr height="350px;"><td colspan="9"><font size="5pt">장바구니가 비어있습니다.</font></td></tr></c:if>
			<tr><td class="p-0" colspan="9"></td></tr>
		</table>
		<table class="table text-center" style="margin-bottom:60px;" id="totTable">
			<tr>
				<th style="width:30%">총 상품금액</th>
				<th style="width:5%"></th>
				<th style="width:30%">총 배송비</th>
				<th style="width:5%"></th>
				<th style="width:30%">결제예정금액</th>
			</tr>
			<tr>
				<td><div id="totCommodityPrice">0원</div></td>
				<td>+</td>
				<td><div id="deliveryFee">5만원이상 무료</div></td>
				<td>=</td>
				<td><div id="totPrice">0원</div></td>
			</tr>
			<tr>
				<td class="p-2 text-right" colspan="5" style="border-top:none;">
					<div id="totSavePoint" style="font-size:15pt; padding-right:8%;">
						<span class="badge badge-danger">적립금</span>&nbsp;&nbsp;0원
					</div>
				</td>
			</tr>
			<tr><td class="p-0" colspan="5"></td></tr>
		</table>
		<div class="text-center" style="margin-bottom:60px;">
			<input type="button" value="선택상품 주문" class="btn btn-danger btn-sm mr-2" onclick="order()"/>
			<input type="button" value="쇼핑 계속하기" class="btn btn-dark btn-sm" onclick="location.href='${ctp}/'"/>
		</div>
		<input type="hidden" name="deliveryFee" value="0"/>
		<input type="hidden" name="totPrice" value="0"/>
		<input type="hidden" name="totSavePoint" value="0"/>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>