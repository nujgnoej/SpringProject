<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - Order</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js"></script>
	<script>
		'use strict';
		// 배송지 정보에서 주문자정보와 동일버튼 체크시 주문자의 정보를 똑같이 배송지정보에 뿌려준다
		function fCheck() {
			let infoCheck = $("#infoCheck").val();
			let address = '${joinVo.address}'.split("/");
			let address1 = address[1].split(", ");
			let tel = '${joinVo.tel}'.split("-");
			
			if(infoCheck=='on') {
				myForm.name.value = '${joinVo.name}';
				myForm.postcode.value = address[0];
				myForm.roadAddress.value = address1[0];
				if(typeof address1[1] != "undefined") {
					myForm.detailAddress.value = address1[1];
				}
				myForm.extraAddress.value = address[2];
				myForm.tel1.value = tel[0];
				myForm.tel2.value = tel[1];
				myForm.tel3.value = tel[2];
			}
		}
		
		// 적립금 체크
		function pointCheck() {
			let point = Number('${joinVo.point}');			// 계정의 적립금(기존)
			let strPoint = numberWithCommas(point);	// 적립금 천단위콤마
			let savePoint = Number($("#savePoint").val());	// 사용자가 입력하여 사용할 적립금
			let regNum = /^[0-9|_-]*$/;   					// 가격은 숫자로만 입력받음
			let totPrice = Number('${totPrice}');	// 개당 총 금액
			
			if(!regNum.test(savePoint)) {
				alert("적립금은 숫자로 입력해주세요.");
				$("#savePoint").val('0');
				document.getElementById("discount").innerHTML = "0원";
				document.getElementById("aTotPrice").innerHTML = numberWithCommas(totPrice)+"원";
				document.getElementById("aTotPrice1").innerHTML = "<font size='6pt'><b>"+numberWithCommas(totPrice)+"원</b></font>";
				myForm.savePoint.focus();
				return false;
			}
			else if(savePoint > point) {
				if(point >= 1000) {
					alert("고객님의 최대 사용가능 적립금은 " + strPoint + "원 입니다.");
					$("#savePoint").val('0');
					document.getElementById("discount").innerHTML = "0원";
					document.getElementById("aTotPrice").innerHTML = numberWithCommas(totPrice)+"원";
					document.getElementById("aTotPrice1").innerHTML = "<font size='6pt'><b>"+numberWithCommas(totPrice)+"원</b></font>";
					myForm.savePoint.focus();
					return false;
				}
				else {
					alert("최소 사용가능 금액은 1,000원이므로 다음에 사용해주세요.");
					$("#savePoint").val('0');
					document.getElementById("discount").innerHTML = "0원";
					document.getElementById("aTotPrice").innerHTML = numberWithCommas(totPrice)+"원";
					document.getElementById("aTotPrice1").innerHTML = "<font size='6pt'><b>"+numberWithCommas(totPrice)+"원</b></font>";
					myForm.savePoint.focus();
					return false;
				}
			}
			else if(savePoint < 1000 && savePoint != 0) {
				alert("최소 사용가능 금액은 1,000원입니다.");
				$("#savePoint").val('0');
				document.getElementById("discount").innerHTML = "0원";
				document.getElementById("aTotPrice").innerHTML = numberWithCommas(totPrice)+"원";
				document.getElementById("aTotPrice1").innerHTML = "<font size='6pt'><b>"+numberWithCommas(totPrice)+"원</b></font>";
				myForm.savePoint.focus();
				return false;
			}
			else if(savePoint == "") {
				alert("사용적립금을 입력해주세요.(0원 또는 1,000원이상)");
				$("#savePoint").val('0');
				document.getElementById("discount").innerHTML = "0원";
				document.getElementById("aTotPrice").innerHTML = numberWithCommas(totPrice)+"원";
				document.getElementById("aTotPrice1").innerHTML = "<font size='6pt'><b>"+numberWithCommas(totPrice)+"원</b></font>";
				myForm.savePoint.focus();
				return false;
			}
			
			let aTotPrice = totPrice - savePoint;	// 사용할 적립금을 제외한 최종 결제액
			myForm.orderTotalPrice.value = aTotPrice;
			document.getElementById("discount").innerHTML = numberWithCommas(savePoint)+"원";
			document.getElementById("aTotPrice").innerHTML = numberWithCommas(aTotPrice)+"원";
			document.getElementById("aTotPrice1").innerHTML = "<font size='6pt'><b>"+numberWithCommas(aTotPrice)+"원</b></font>";
		}
		
		// 천단위마다 쉼표 표시하는 함수
	    function numberWithCommas(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
		
		// 결제하기 버튼 클릭시 유효성 검사 이후 값을 넘긴다.
		function orderCheck() {
			let regName = /^[가-힣a-zA-Z]+$/;
			let regTel = /\d{3}-\d{3,4}-\d{4}$/g;
			let regAddress = /[,]/g;
			
			let name = $("#name").val();
			
			// 전송전에 주소를 하나로 묶어서 준비한다.
			let postcode = myForm.postcode.value;
			let roadAddress = myForm.roadAddress.value;
			let detailAddress = myForm.detailAddress.value;
			let extraAddress = myForm.extraAddress.value;
			let address = "";
			if(detailAddress == "") {
		  		address = postcode + "/" + roadAddress + "" + detailAddress + "/" + extraAddress + "/";
			}
			else {
		  		address = postcode + "/" + roadAddress + ", " + detailAddress + "/" + extraAddress + "/";
			}
			
	  		// 전송전에 전화번호를 하나로 묶어서 준비한다.
			let tel1 = myForm.tel1.value;
			let tel2 = myForm.tel2.value;
			let tel3 = myForm.tel3.value;
			let tel = tel1 + "-" + tel2 + "-" + tel3;
			
			let message = myForm.message.value;
			
			if(!regName.test(name)) {
				alert("이름을 확인해주세요!");
				myForm.name.focus();
				return false;
			}
			else if(postcode == "") {
				alert("주소를 확인해주세요!");
				myForm.addressBtn.focus();
				return false;
			}
			else if(regAddress.test(detailAddress)) {
				alert("상세주소에 \' , \'는 사용할 수 없습니다.");
				myForm.detailAddress.focus();
				return false;
			}
			else if(tel2.trim() == "") {
				alert("전화번호를 확인해주세요!");
				myForm.tel2.focus();
				return false;
			}
			else if(tel3.trim() == "") {
				alert("전화번호를 확인해주세요!");
				myForm.tel3.focus();
				return false;
			}
			else if(!regTel.test(tel)) {
				alert("전화번호를 확인해주세요!");
				myForm.tel2.focus();
				return false;
			}
			else {
				myForm.address.value = address;
	  			myForm.tel.value = tel;
				myForm.action = "${ctp}/cart/payment";
		    	myForm.submit();
			}
		}
	</script>
	<style>
		#orderTable1 th {
			font-size: 10pt;
		}
		#orderTable1 td {
			font-size: 9pt;
		}
		#orderTable td{
			text-align: left;
			padding-left: 20px;
		}
		.grid {
			position: relative;
			top: 2px;
			margin: 0px 0px 0px 6px;
			float: left;
		}
		#paymentTable td {
			font-size: 25pt;
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
	<form name="myForm" method="post">
		<h3>My Order</h3><br/>
		<table class="table text-center" style="margin-bottom:60px;" id="orderTable1">
			<tr>
				<th>번호</th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>선택옵션</th>
				<th>판매가(옵션포함)</th>
				<th>수량</th>
				<th>합계</th>
				<th>적립금</th>
			</tr>
			<c:forEach var="vo" items="${sOrderVos}" varStatus="st">
				<tr>
					<td>${st.count}</td>
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
					<td><fmt:formatNumber value="${vo.salePrice}" pattern="#,###"/>원</td>
					<td style="width:15%">${vo.orderQuantity}</td>
					<td>
						<b><fmt:formatNumber value="${vo.totPrice}" pattern="#,###"/>원</b>
					</td>
					<td>
						<fmt:formatNumber value="${vo.totSavePoint}" pattern="#,###"/>원
					</td>
				</tr>
			</c:forEach>
			<c:if test="${(totPrice-deliveryFee) < 50000}"><tr height="100px;"><td colspan="6" class="text-right">배송비(주문금액 5만원이하)</td><td><b>3,000원</b></td><td>150원</td></tr></c:if>
			<tr>
				<td colspan="8" class="text-right">
					상품구매금액&nbsp;&nbsp;<fmt:formatNumber value="${totPrice-deliveryFee}" pattern="#,###"/>원&nbsp;&nbsp;+&nbsp;&nbsp;배송비&nbsp;&nbsp;<fmt:formatNumber value="${deliveryFee}" pattern="#,###"/>원&nbsp;&nbsp;=&nbsp;&nbsp;합계&nbsp;&nbsp;:&nbsp;&nbsp;<font size="4pt"><b><fmt:formatNumber value="${totPrice}" pattern="#,###"/>원</b></font>
				</td>
			</tr>
			<tr><td class="p-0" colspan="8"></td></tr>
			<tr>
				<td colspan="8" class="text-left">
					<img src="${ctp}/images/exclamation-mark.png" style="width:13px; margin-bottom:2px;"/>&nbsp;
					<font color="red">상품의 수량 변경은 장바구니 페이지에서 가능합니다.&nbsp;&nbsp;&nbsp;&nbsp;</font>
					<input type="button" value="My Cart" onclick="location.href='${ctp}/cart/cartView'" class="btn btn-outline-danger btn-sm"/>
				</td>
			</tr>
		</table>
		<div style="margin:10px;"><font size="3pt"><b>주문자 정보</b></font></div>
		<table class="table text-center" style="margin-bottom:80px;" id="orderTable">
			<tr>
				<th width="15%">주문하시는 분</th>
				<td>${joinVo.name}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td style="font-size:9pt;">
					<c:set var="address" value="${fn:split(joinVo.address,'/')}"/>
					<c:set var="addressMiddle" value="${fn:split(address[1],',')}"/>
					<div style="width:60%;">
						<div style="width:70px; float:left; margin:0px 10px 7px 0px;" class="form-control">
							${address[0]}
						</div>
						<div style="float:left; height:35.75px; line-height:35.75px;">우편번호</div>
						
						<div style="width:400px; float:left; clear:both; margin:0px 10px 7px 0px;" class="form-control">
							${addressMiddle[0]}
						</div>
						<div style="float:left; height:35.75px; line-height:35.75px;">기본주소</div>
						
						<div class="input-group mb-1" style="width:470px; float:left; clear:both;">
							<div class="form-control">
								${addressMiddle[1]}
							</div>&nbsp;&nbsp;
							<div class="form-control" style="margin:0px 10px 0px 0px;">
								${address[2]}
							</div>
							<div style="float:left; height:35.75px; line-height:35.75px;">나머지주소</div>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>${joinVo.tel}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${joinVo.email}</td>
			</tr>
			<tr><td colspan="2" class="p-0"></td></tr>
		</table>
		<div style="margin:10px;"><font size="3pt"><b>배송지 정보</b></font></div>
		<table class="table text-center" style="margin-bottom:80px;" id="orderTable">
			<tr>
				<th width="15%">배송지 선택</th>
				<td>
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="infoCheck" name="infoCheck" onclick="fCheck()">
						<label class="custom-control-label" for="infoCheck">주문자 정보와 동일</label>
					</div>
				</td>
			</tr>
			<tr>
				<th width="15%">주문하시는 분</th>
				<td><input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요."/></td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<div style="width:50%;">
						<div class="input-group mb-1">
							<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" readonly>
							<div class="input-group-append">
								<input type="button" onclick="sample6_execDaumPostcode()" name="addressBtn" id="addressBtn" value="우편번호 찾기" class="btn btn-secondary">
							</div>
						</div>
						<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" readonly>
						<div class="input-group mb-1">
							<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
							<div class="input-group-append">
								<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control" readonly>
							</div>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<div class="form-inline">
						<div style="float:left;">
							<select name="tel1" id="tel1" class="custom-select form-control">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>&nbsp;&nbsp;-&nbsp;&nbsp;
						</div>
						<input type="text" class="form-control" id="tel2" name="tel2" size=4 maxlength=4 style="width:10%;"/>&nbsp;&nbsp;-&nbsp;&nbsp;
						<input type="text" class="form-control" id="tel3" name="tel3" size=4 maxlength=4 style="width:10%;"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>요청사항</th>
				<td>
					<textarea rows="2" name="message" id="message" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="p-0"></td>
			</tr>
		</table>
		<div style="margin:10px;"><font size="3pt"><b>결제 예정 금액</b></font></div>
		<table class="table text-center" style="margin-bottom:80px;" id="paymentTable">
			<tr>
				<th width="30%">총 주문금액</th>
				<th width="5%"></th>
				<th width="30%">총 할인 + 부가결제 금액</th>
				<th width="5%"></th>
				<th width="30%">총 결제예정 금액</th>
			</tr>
			<tr>
				<td><div id="totPrice"><fmt:formatNumber value="${totPrice}" pattern="#,###"/>원</div></td>
				<td>-</td>
				<td><div id="discount">0원</div></td>
				<td>=</td>
				<td><div id="aTotPrice"><fmt:formatNumber value="${totPrice}" pattern="#,###"/>원</div></td>
			</tr>
			<tr><td colspan="5" class="p-0"></td></tr>
		</table>
		<table class="table text-center" style="margin-bottom:80px;">
			<tr>
				<th width="20%">적립금사용</th>
				<td class="text-left">
					<div style="width:200px; float:left;"><input type="text" class="form-control" name="usePoint" id="savePoint" value="0" onchange="pointCheck()"/></div>
					<div style="float:left; height:35.75px; line-height:35.75px;">&nbsp;원</div>
					<div style="float:left; clear:both; height:35.75px; line-height:35.75px;">최대 사용가능 적립금 : <font color="orange"><b><fmt:formatNumber value="${joinVo.point}" pattern="#,###"/></b></font>원</div>
					<pre style="clear:both; padding-top:10px; margin:0px;"><font size="2pt">- 최소사용금액은 1,000원 이상입니다.<br/>- 최대사용금액은 제한이 없습니다.</font></pre>
				</td>
				<td style="border-left: 1px solid gray; width:30%; text-align:right; padding-bottom:15px;">
					<font size="2pt">카드 결제 최종결제 금액</font>
					<div id="aTotPrice1" style="margin:10px 0px;"><font size="6pt"><b><fmt:formatNumber value="${totPrice}" pattern="#,###"/>원</b></font></div>
					<input type="button" class="btn btn-danger" onclick="orderCheck()" value="결제하기"/>
					<hr/>
					<div style="padding:0px 20px;">
						<div style="float:left;"><font size="3pt">총 적립예정금액</font></div>
						<div style="float:right;"><font size="3pt" color="orange"><b><fmt:formatNumber value="${totSavePoint}" pattern="#,###"/>원</b></font></div>
					</div>
				</td>
			</tr>
			<tr><td colspan="3" class="p-0"></td></tr>
		</table>
		<input type="hidden" name="orderVos" value="${sOrderVos}"/>
		<input type="hidden" name="orderIdx" value="${orderIdx}"/>  	<!-- 주문번호 -->
		<input type="hidden" name="totPrice" value="${totPrice}"/>		<!-- 최종 결제금액(사용적립금제외) -->
		<input type="hidden" name="orderTotalPrice" value="${totPrice}"/>		<!-- 최종 결제금액 -->
		<input type="hidden" name="mid" value="${sMid}"/>
		<input type="hidden" name="address" value="${joinVo.address}">
    	<input type="hidden" name="tel" value="${joinVo.tel}"/>
		<input type="hidden" name="email" value="${joinVo.email}"/>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>