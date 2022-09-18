<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - ${vo.commodity}</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		// 수량증가버튼 클릭이벤트
		function quantityUp() {
			let quantity = Number($("#quantity").val());
			let quantityNum = quantity+1;			 // 삼품수량
			myForm.orderQuantity.value = quantityNum;
			let salePrice = myForm.salePrice.value;	 // 상품가격(개당)
			
			let optionSize = myForm.optionSize.value; // 컨트롤러에서 보내준 옵션사이즈
			
			let selectOption = document.getElementById("selectOption");
			let optionValue = selectOption.options[selectOption.selectedIndex].value;	// 옵션value(optionName + optionPrice)값을 받아옴
			let option = optionValue.split("/");		// 받아온 옵션value값을 잘라 0번인덱스에 optionName, 1번인덱스에 optionPrice를 넣어둠
			let optionPrice = option[1]*quantityNum;	// 옵션가격계산
			let optionSavePoint = (optionPrice*0.05).toLocaleString('ko-KR');	// 옵션적립금
			
			if(quantityNum > 100) {
				alert("최대 주문수량은 100개입니다.");
				myForm.quantity.value = 100;
				return false;
			}
			
			$.ajax({
				type : "post",
				url  : "${ctp}/commodity/salePriceCalc",
				data : {
					quantityNum : quantityNum,
					salePrice : salePrice
				},
				success : function(productPrice) {
					// 상품갯수 증가할때마다 실시간 금액변경
					let strProductPrice = productPrice.toLocaleString('ko-KR');
					let strOptionPrice = optionPrice.toLocaleString('ko-KR');
					let allTotPrice = (productPrice + optionPrice).toLocaleString('ko-KR');
					document.getElementById("productPrice").innerHTML = strProductPrice+"원<br/>";
					if(isNaN(optionPrice) == false) {
						myForm.totPrice.value = productPrice+optionPrice;
					}
					else if(isNaN(optionPrice) == true) {
						myForm.totPrice.value = productPrice;
					}
					
					// 상품갯수 증가할때마다 실시간 적립포인트변경
					let strProductSavePoint = (productPrice*0.05).toLocaleString('ko-KR');
					let strOptionSavePoint = (optionPrice*0.05).toLocaleString('ko-KR');
					let allTotSavePoint = ((productPrice*0.05) + (optionPrice*0.05)).toLocaleString('ko-KR');
					document.getElementById("productSavePoint").innerHTML = "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strProductSavePoint+"원)";
					if(isNaN(optionPrice) == false) {
						myForm.totSavePoint.value = (productPrice*0.05)+(optionPrice*0.05);
					}
					else if(isNaN(optionPrice) == true) {
						myForm.totSavePoint.value = productPrice*0.05;
					}
					
					// 선택옵션 수량 및 금액변경
					if(optionValue != 0) {
						let inputOptionView = "";
						
						inputOptionView += "<table style='width:100%' class='mt-3'>";
						inputOptionView += "<tr>";
						inputOptionView += "<td style='width:60%'><font size='2'>선택옵션&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;"+option[0]+"</font></td>";
						inputOptionView += "<td style='width:10%; text-align:center;'><font size='2'>"+quantityNum+"개</font></td>";
						inputOptionView += "<td class='text-right'>"+strOptionPrice+"원<br/>(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strOptionSavePoint+"원)</td>";
						inputOptionView += "</tr>";
						inputOptionView += "</table>";
						
						document.getElementById("optionView").innerHTML = inputOptionView;
						myForm.orderQuantity.value = quantityNum;
					}
					
					// 총 상품금액 및 수량 표기
					if(isNaN(optionPrice) == false) {
						let inputTotPriceView = "";
						
						inputTotPriceView += "<span class='text-left mb-2'>";
						inputTotPriceView += "총 상품금액(수량)&nbsp;&nbsp;:&nbsp;&nbsp;<font size='5pt'><b>"+allTotPrice+"원&nbsp;</b></font>("+quantityNum+"개)";
						inputTotPriceView += "</span>&nbsp;&nbsp;&nbsp;&nbsp;";
						inputTotPriceView += "<span class='text-left'>";
						inputTotPriceView += "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+allTotSavePoint+"원)";
						inputTotPriceView += "</span><br/>";
						
						document.getElementById("totPriceView").innerHTML = inputTotPriceView;
					}
					else if(isNaN(optionPrice) == true) {
						let inputTotPriceView = "";
						
						inputTotPriceView += "<span class='text-left mb-2'>";
						inputTotPriceView += "총 상품금액(수량)&nbsp;&nbsp;:&nbsp;&nbsp;<font size='5pt'><b>"+strProductPrice+"원&nbsp;</b></font>("+quantityNum+"개)";
						inputTotPriceView += "</span>&nbsp;&nbsp;&nbsp;&nbsp;";
						inputTotPriceView += "<span class='text-left'>";
						inputTotPriceView += "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strProductSavePoint+"원)";
						inputTotPriceView += "</span><br/>";
						
						document.getElementById("totPriceView").innerHTML = inputTotPriceView;
					}
				},
				error : function() {
					alert("전송실패");
				}
			});
			
			myForm.quantity.value = quantityNum;
		}
		
		// 수량감소버튼 클릭이벤트
		function quantityDown() {
			let quantity = Number($("#quantity").val());
			let quantityNum = quantity-1;			 // 삼품수량
			myForm.orderQuantity.value = quantityNum;
			let salePrice = myForm.salePrice.value;	 // 상품가격(개당)

			let optionSize = myForm.optionSize.value; // 컨트롤러에서 보내준 옵션사이즈
			
			let selectOption = document.getElementById("selectOption");
			let optionValue = selectOption.options[selectOption.selectedIndex].value;	// 옵션value(optionName + optionPrice)값을 받아옴
			let option = optionValue.split("/");		// 받아온 옵션value값을 잘라 0번인덱스에 optionName, 1번인덱스에 optionPrice를 넣어둠
			let optionPrice = option[1]*quantityNum;	// 옵션가격계산
			let optionSavePoint = (optionPrice*0.05).toLocaleString('ko-KR');	// 옵션적립금
			
			if(quantityNum < 1) {
				alert("최소 주문수량은 1개입니다.");
				myForm.quantity.value = 1;
				return false;
			}

			$.ajax({
				type : "post",
				url  : "${ctp}/commodity/salePriceCalc",
				data : {
					quantityNum : quantityNum,
					salePrice : salePrice
				},
				success : function(productPrice) {
					// 상품갯수 증가할때마다 실시간 금액변경
					let strProductPrice = productPrice.toLocaleString('ko-KR');
					let strOptionPrice = optionPrice.toLocaleString('ko-KR');
					let allTotPrice = (productPrice + optionPrice).toLocaleString('ko-KR');
					document.getElementById("productPrice").innerHTML = strProductPrice+"원<br/>";
					if(isNaN(optionPrice) == false) {
						myForm.totPrice.value = productPrice+optionPrice;
					}
					else if(isNaN(optionPrice) == true) {
						myForm.totPrice.value = productPrice;
					}
					
					// 상품갯수 증가할때마다 실시간 적립포인트변경
					let strProductSavePoint = (productPrice*0.05).toLocaleString('ko-KR');
					let strOptionSavePoint = (optionPrice*0.05).toLocaleString('ko-KR');
					let allTotSavePoint = ((productPrice*0.05) + (optionPrice*0.05)).toLocaleString('ko-KR');
					document.getElementById("productSavePoint").innerHTML = "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strProductSavePoint+"원)";
					if(isNaN(optionPrice) == false) {
						myForm.totSavePoint.value = (productPrice*0.05)+(optionPrice*0.05);
					}
					else if(isNaN(optionPrice) == true) {
						myForm.totSavePoint.value = productPrice*0.05;
					}
					
					// 선택옵션 수량 및 금액변경
					if(optionValue != 0) {
						let inputOptionView = "";
						
						inputOptionView += "<table style='width:100%' class='mt-3'>";
						inputOptionView += "<tr>";
						inputOptionView += "<td style='width:60%'><font size='2'>선택옵션&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;"+option[0]+"</font></td>";
						inputOptionView += "<td style='width:10%; text-align:center;'><font size='2'>"+quantityNum+"개</font></td>";
						inputOptionView += "<td class='text-right'>"+strOptionPrice+"원<br/>(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strOptionSavePoint+"원)</td>";
						inputOptionView += "</tr>";
						inputOptionView += "</table>";
						
						document.getElementById("optionView").innerHTML = inputOptionView;
					}
					
					// 총 상품금액 및 수량 표기
					if(isNaN(optionPrice) == false) {
						let inputTotPriceView = "";
						
						inputTotPriceView += "<span class='text-left mb-2'>";
						inputTotPriceView += "총 상품금액(수량)&nbsp;&nbsp;:&nbsp;&nbsp;<font size='5pt'><b>"+allTotPrice+"원&nbsp;</b></font>("+quantityNum+"개)";
						inputTotPriceView += "</span>&nbsp;&nbsp;&nbsp;&nbsp;";
						inputTotPriceView += "<span class='text-left'>";
						inputTotPriceView += "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+allTotSavePoint+"원)";
						inputTotPriceView += "</span><br/>";
						
						document.getElementById("totPriceView").innerHTML = inputTotPriceView;
					}
					else if(isNaN(optionPrice) == true) {
						let inputTotPriceView = "";
						
						inputTotPriceView += "<span class='text-left mb-2'>";
						inputTotPriceView += "총 상품금액(수량)&nbsp;&nbsp;:&nbsp;&nbsp;<font size='5pt'><b>"+strProductPrice+"원&nbsp;</b></font>("+quantityNum+"개)";
						inputTotPriceView += "</span>&nbsp;&nbsp;&nbsp;&nbsp;";
						inputTotPriceView += "<span class='text-left'>";
						inputTotPriceView += "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strProductSavePoint+"원)";
						inputTotPriceView += "</span><br/>";
						
						document.getElementById("totPriceView").innerHTML = inputTotPriceView;
					}
				},
				error : function() {
					alert("전송실패");
				}
			});
			
			myForm.quantity.value = quantityNum;
		}
		
		// 직접 입력했을때 이벤트
		function quantityCheck() {
			let quantityNum = Number($("#quantity").val());
			myForm.orderQuantity.value = quantityNum;
			let salePrice = myForm.salePrice.value;
			
			let selectOption = document.getElementById("selectOption");
			let optionValue = selectOption.options[selectOption.selectedIndex].value;	// 옵션value(optionName + optionPrice)값을 받아옴
			let option = optionValue.split("/");		// 받아온 옵션value값을 잘라 0번인덱스에 optionName, 1번인덱스에 optionPrice를 넣어둠
			let optionPrice = option[1]*quantityNum;	// 옵션가격계산
			let optionSavePoint = (optionPrice*0.05).toLocaleString('ko-KR');	// 옵션적립금
			
			if(quantityNum < 1) {
				alert("최소 주문수량은 1개입니다.");
				myForm.quantity.value = 1;
				location.reload();
				return false;
			}
			else if(quantityNum > 100) {
				alert("최대 주문수량은 100개입니다.")
				myForm.quantity.value = 1;
				location.reload();
				return false;
			}
			
			$.ajax({
				type : "post",
				url  : "${ctp}/commodity/salePriceCalc",
				data : {
					quantityNum : quantityNum,
					salePrice : salePrice
				},
				success : function(productPrice) {
					// 상품갯수 변경될때마다 실시간 금액변경
					let strProductPrice = productPrice.toLocaleString('ko-KR');
					let strOptionPrice = optionPrice.toLocaleString('ko-KR');
					let allTotPrice = (productPrice + optionPrice).toLocaleString('ko-KR');
					document.getElementById("productPrice").innerHTML = strProductPrice+"원<br/>";
					if(isNaN(optionPrice) == false) {
						myForm.totPrice.value = productPrice+optionPrice;
					}
					else if(isNaN(optionPrice) == true) {
						myForm.totPrice.value = productPrice;
					}
					
					// 상품갯수 변경될때마다 실시간 적립포인트변경
					let strProductSavePoint = (productPrice*0.05).toLocaleString('ko-KR');
					let strOptionSavePoint = (optionPrice*0.05).toLocaleString('ko-KR');
					let allTotSavePoint = ((productPrice*0.05) + (optionPrice*0.05)).toLocaleString('ko-KR');
					document.getElementById("productSavePoint").innerHTML = "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strProductSavePoint+"원)";
					if(isNaN(optionPrice) == false) {
						myForm.totSavePoint.value = (productPrice*0.05)+(optionPrice*0.05);
					}
					else if(isNaN(optionPrice) == true) {
						myForm.totSavePoint.value = productPrice*0.05;
					}
					
					// 선택옵션 수량 및 금액변경
					if(optionValue != 0) {
						let inputOptionView = "";
						
						inputOptionView += "<table style='width:100%' class='mt-3'>";
						inputOptionView += "<tr>";
						inputOptionView += "<td style='width:60%'><font size='2'>선택옵션&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;"+option[0]+"</font></td>";
						inputOptionView += "<td style='width:10%; text-align:center;'><font size='2'>"+quantityNum+"개</font></td>";
						inputOptionView += "<td class='text-right'>"+strOptionPrice+"원<br/>(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strOptionSavePoint+"원)</td>";
						inputOptionView += "</tr>";
						inputOptionView += "</table>";
						
						document.getElementById("optionView").innerHTML = inputOptionView;
					}
					
					// 총 상품금액 및 수량 표기
					if(isNaN(optionPrice) == false) {
						let inputTotPriceView = "";
						
						inputTotPriceView += "<span class='text-left mb-2'>";
						inputTotPriceView += "총 상품금액(수량)&nbsp;&nbsp;:&nbsp;&nbsp;<font size='5pt'><b>"+allTotPrice+"원&nbsp;</b></font>("+quantityNum+"개)";
						inputTotPriceView += "</span>&nbsp;&nbsp;&nbsp;&nbsp;";
						inputTotPriceView += "<span class='text-left'>";
						inputTotPriceView += "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+allTotSavePoint+"원)";
						inputTotPriceView += "</span><br/>";
						
						document.getElementById("totPriceView").innerHTML = inputTotPriceView;
					}
					else if(isNaN(optionPrice) == true) {
						let inputTotPriceView = "";
						
						inputTotPriceView += "<span class='text-left mb-2'>";
						inputTotPriceView += "총 상품금액(수량)&nbsp;&nbsp;:&nbsp;&nbsp;<font size='5pt'><b>"+strProductPrice+"원&nbsp;</b></font>("+quantityNum+"개)";
						inputTotPriceView += "</span>&nbsp;&nbsp;&nbsp;&nbsp;";
						inputTotPriceView += "<span class='text-left'>";
						inputTotPriceView += "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strProductSavePoint+"원)";
						inputTotPriceView += "</span><br/>";
						
						document.getElementById("totPriceView").innerHTML = inputTotPriceView;
					}
				},
				error : function() {
					alert("전송실패");
				}
			});
		}
		
		// 옵션선택
		function optionChange() {
			let selectOption = document.getElementById("selectOption");
			let optionValue = selectOption.options[selectOption.selectedIndex].value;
			let option = optionValue.split("/");
			
			let quantityNum = Number($("#quantity").val());		// 삼품수량
			let salePrice = myForm.salePrice.value;				// 상품가격(개당)
			let productTotPrice = quantityNum*salePrice;		// 상품총 가격
			let optionPrice = option[1]*quantityNum;			// 옵션가격
			myForm.optionPrice.value = option[1];
			let strOtionSavePoint = (optionPrice*0.05).toLocaleString('ko-KR');	// 옵션적립금
			myForm.optionSavePoint.value = option[1]*0.05;
			
			if(optionValue == 0) {
				alert("옵션을 선택해주세요.");
				location.reload();
			}
			
			$.ajax({
				type : "post",
				url  : "${ctp}/commodity/salePriceCalc",
				data : {
					quantityNum : quantityNum,
					salePrice : salePrice
				},
				success : function(productPrice) {
					// 상품갯수 변경될때마다 실시간 금액변경
					let strProductPrice = productPrice.toLocaleString('ko-KR');
					let strOptionPrice = optionPrice.toLocaleString('ko-KR');
					let allTotPrice = (productPrice + optionPrice).toLocaleString('ko-KR');
					document.getElementById("productPrice").innerHTML = strProductPrice+"원<br/>";
					myForm.totPrice.value = productPrice+optionPrice;
					
					// 상품갯수 변경될때마다 실시간 적립포인트변경
					let strProductSavePoint = (productPrice*0.05).toLocaleString('ko-KR');
					let strOptionSavePoint = (optionPrice*0.05).toLocaleString('ko-KR');
					let allTotSavePoint = ((productPrice*0.05) + (optionPrice*0.05)).toLocaleString('ko-KR');
					document.getElementById("productSavePoint").innerHTML = "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strProductSavePoint+"원)";
					myForm.totSavePoint.value = (productPrice*0.05)+(optionPrice*0.05);
					
					// 선택옵션 수량 및 금액변경
					if(optionValue != 0) {
						let inputOptionView = "";
						
						inputOptionView += "<table style='width:100%' class='mt-3'>";
						inputOptionView += "<tr>";
						inputOptionView += "<td style='width:60%'><font size='2'>선택옵션&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;"+option[0]+"</font></td>";
						inputOptionView += "<td style='width:10%; text-align:center;'><font size='2'>"+quantityNum+"개</font></td>";
						inputOptionView += "<td class='text-right'>"+strOptionPrice+"원<br/>(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strOptionSavePoint+"원)</td>";
						inputOptionView += "</tr>";
						inputOptionView += "</table>";
						
						document.getElementById("optionView").innerHTML = inputOptionView;
					}
					
					// 총 상품금액 및 수량 표기
					if(isNaN(optionPrice) == false) {
						let inputTotPriceView = "";
						
						inputTotPriceView += "<span class='text-left mb-2'>";
						inputTotPriceView += "총 상품금액(수량)&nbsp;&nbsp;:&nbsp;&nbsp;<font size='5pt'><b>"+allTotPrice+"원&nbsp;</b></font>("+quantityNum+"개)";
						inputTotPriceView += "</span>&nbsp;&nbsp;&nbsp;&nbsp;";
						inputTotPriceView += "<span class='text-left'>";
						inputTotPriceView += "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+allTotSavePoint+"원)";
						inputTotPriceView += "</span><br/>";
						
						document.getElementById("totPriceView").innerHTML = inputTotPriceView;
					}
					else if(isNaN(optionPrice) == true) {
						let inputTotPriceView = "";
						
						inputTotPriceView += "<span class='text-left mb-2'>";
						inputTotPriceView += "총 상품금액(수량)&nbsp;&nbsp;:&nbsp;&nbsp;<font size='5pt'><b>"+strProductPrice+"원&nbsp;</b></font>("+quantityNum+"개)";
						inputTotPriceView += "</span>&nbsp;&nbsp;&nbsp;&nbsp;";
						inputTotPriceView += "<span class='text-left'>";
						inputTotPriceView += "(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;"+strProductSavePoint+"원)";
						inputTotPriceView += "</span><br/>";
						
						document.getElementById("totPriceView").innerHTML = inputTotPriceView;
					}
				},
				error : function() {
					alert("전송실패");
				}
			});
		}
		
		// 장바구니 호출
		function cart() {
			let productIdx = myForm.productIdx.value;
			let pno = myForm.pno.value;
			let mid = myForm.mid.value;
			let commodity = myForm.commodity.value;
			let salePrice = myForm.salePrice.value;
			let selectOption = myForm.selectOption.value;
			let optionPrice = myForm.optionPrice.value;
			let orderQuantity = myForm.quantity.value;
			let totPrice = myForm.totPrice.value;
			let totSavePoint = myForm.totSavePoint.value;
			let fSName = myForm.fSName.value;
			let flag = myForm.flag.value;
			let optionSize = myForm.optionSize.value;
			
			if('${sMid}' == "") {
	    		alert("로그인 후 이용 가능합니다.");
	    		location.href = "${ctp}/login/loginView";
	    	}
			else if('${optionSize}' > 1) {
				if(document.getElementById("optionPrice").value == "") {
		    		alert("옵션을 선택해주세요.");
		    		return false;
		    	}
		    	else {
		    		$.ajax({
		    			type : "post",
		    			url  : "${ctp}/commodity/cart",
		    			data : {
		    				productIdx : productIdx,
		    				pno : pno,
		    				mid : mid,
		    				commodity : commodity,
		    				salePrice : salePrice,
		    				selectOption : selectOption,
		    				optionPrice : optionPrice,
		    				orderQuantity : orderQuantity,
		    				totPrice : totPrice,
		    				totSavePoint : totSavePoint,
		    				fSName : fSName,
		    				optionSize : optionSize
		    			},
		    			success : function() {
				    		let ans = confirm("상품을 장바구니에 담았습니다. 장바구니로 이동하시겠습니까?");
				    		if(ans) {
					    		location.href="${ctp}/cart/cartView";
				    		}
				    		else {
				    			location.reload();
				    		}
		    			},
		    			error : function() {
		    				alert("전송오류");
		    			}
		    		});
		    	}
			}
			else {
				$.ajax({
	    			type : "post",
	    			url  : "${ctp}/commodity/cart",
	    			data : {
	    				productIdx : productIdx,
	    				pno : pno,
	    				mid : mid,
	    				commodity : commodity,
	    				salePrice : salePrice,
	    				selectOption : selectOption,
	    				orderQuantity : orderQuantity,
	    				totPrice : totPrice,
	    				totSavePoint : totSavePoint,
	    				fSName : fSName,
	    			},
	    			success : function() {
			    		let ans = confirm("상품을 장바구니에 담았습니다. 장바구니로 이동하시겠습니까?");
			    		if(ans) {
				    		location.href="${ctp}/cart/cartView";
			    		}
			    		else {
			    			location.reload();
			    		}
	    			},
	    			error : function() {
	    				alert("전송오류");
	    			}
	    		});
			}
		}
		
		// 직접주문
		function buyNow() {
	    	if('${sMid}' == "") {
	    		alert("로그인 후 이용 가능합니다.");
	    		location.href = "${ctp}/login/loginView";
	    	}
	    	else if('${optionSize}' > 1) {
	    		if(document.getElementById("optionPrice").value == "") {
		    		alert("옵션을 선택해주세요.");
		    		return false;
		    	}
		    	else {
		    		myForm.orderQuantity.value = myForm.quantity.value;
		    		document.getElementById("flag").value = "order";
		    		document.myForm.submit();
		    	}
	    	}
	    	else {
	    		document.getElementById("flag").value = "order";
	    		document.myForm.submit();
	    	}
	    }
		
		// 리뷰상세보기페이지이동
		function reviewContent(orderIdx) {
			$("#orderIdx").val(orderIdx);
			reviewForm.action="${ctp}/review/reviewContent";
			reviewForm.submit();
		}
	</script>
	<style>
		#blackBox a {
			color: white;
		}
		#blackBox a:hover {
			color: #424242;
		}
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
		#ratingForm{
		    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
		    direction: rtl; /* 이모지 순서 반전 */
		    border: 0; /* 필드셋 테두리 제거 */
		    padding: 0;
		    margin: 0;
		}
		#ratingForm legend{
		    text-align: left;
		}
		#ratingForm{
		    font-size: 1em; /* 이모지 크기 */
		    color: transparent; /* 기존 이모지 컬러 제거 */
		    text-shadow: 0 0 0 #EB1D36; /* 새 이모지 색상 부여 */
		}
		.reviewImg {
			background-size: 100px;
			width: 100px;
			height: 100px;
			margin: auto;
		}
		.btn-danger:hover {
			background-color: white;
			color: #dd3245;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px; min-width:1200px;">
	<form name="myForm" method="post">
		<div>
			<div style="float:left; width:40%; margin-left:5%;" class="text-center mb-5">
				<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
				<c:set var="fSNameSize" value="${fn:length(fSNames)}"/>
				<div id="demo" class="carousel slide mb-2" data-ride="carousel">
					<c:if test="${fSNameSize == 1}">
						<div class="mainImg" style="background-image:url('${ctp}/data/admin/product/${fSNames[0]}');">
							<c:if test="${vo.quantity == 0}"><div class="soldoutImg" style="background-image:url('${ctp}/images/soldout50.png'"></div></c:if>
						</div>
					</c:if>
					<c:if test="${fSNameSize > 1}">
						<!-- Indicators -->
						<ul class="carousel-indicators">
							<c:forEach var="i" begin="0" end="${fSNameSize-1}">
								<li data-target="#demo" data-slide-to="${i}" <c:if test="${i==0}">class="active"</c:if>></li>
							</c:forEach>
						</ul>
						<!-- The slideshow -->
						<div class="carousel-inner">
							<c:forEach var="i" begin="0" end="${fSNameSize-1}">
								<div class="carousel-item mainImage<c:if test="${i==0}"> active</c:if>" id="mainImage">
									<%-- <img src="${ctp}/data/admin/product/${fSNames[i]}" width="300px" height="300px"/> --%>
									<div class="mainImg" style="background-image:url('${ctp}/data/admin/product/${fSNames[i]}');">
										<c:if test="${vo.quantity == 0}"><div class="soldoutImg" style="background-image:url('${ctp}/images/soldout50.png'"></div></c:if>
									</div>
								</div>
							</c:forEach>
						</div>
						<!-- Left and right controls -->
						<a class="carousel-control-prev" href="#demo" data-slide="prev">
							<img src="${ctp}/images/left-arrow.png" style="width:50px; height:50px;"/>
						</a>
						<a class="carousel-control-next" href="#demo" data-slide="next">
							<img src="${ctp}/images/right-arrow.png" style="width:50px; height:50px;"/>
						</a>
					</c:if>
				</div>
				<%-- <c:if test="${fn:length(fSNames)!=1}">
					<div style="text-align:center">
						<c:forEach var="i" begin="0" end="${fSNameSize-1}">
							<span class="m-1 smallImage" id="a">
								<a><img src="${ctp}/data/admin/product/${fSNames[i]}" width="80px" height="80px"/></a>
							</span>
						</c:forEach>
					</div>
				</c:if> --%>
			</div>
			<div style="float:left; width:40%;" class="text-center ml-5 mb-5">
				<div class="text-left"><font size="4pt"><b>${vo.commodity}</b></font>&nbsp;&nbsp;&nbsp;<font size="3pt">${vo.size}</font></div>
				<hr/>
				<div class="text-left">
					<table style="width:100%">
						<tr>
							<th style="width:30%; padding: 8px 0px 8px 6px;">price</th>
							<td style="padding: 8px 6px 8px 0px;">
								<c:if test="${vo.discount != 0}">
									<del><font color="red"><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</font></del>&nbsp;→&nbsp;
									<fmt:formatNumber value="${vo.price-vo.discount}" pattern="#,###"/>원&nbsp;&nbsp;&nbsp;
								</c:if>
								<c:if test="${vo.discount == 0}">
									<fmt:formatNumber value="${vo.price}" pattern="#,###"/>원&nbsp;&nbsp;&nbsp;
								</c:if>
								<c:set var="salePrice" value="${vo.price-vo.discount}"/>
							</td>
						</tr>
						<tr>
							<th style="padding: 8px 0px 8px 6px;">keep point</th>
							<td style="padding: 8px 6px 8px 0px;"><fmt:formatNumber value="${salePrice*0.05}" pattern="#,###"/>원 (5%)</td>
						</tr>
					</table>
				</div>
				<c:if test="${vo.quantity==0}">
					<hr/><br/>
					<h3>재고가 소진되어 준비중입니다.</h3>
				</c:if>
				<c:if test="${vo.quantity!=0}">
					<div <c:if test="${optionSize <= 1}">style="display:none"</c:if>>
						<hr/>
						<div>
							<select name="selectOption" id="selectOption" class="custom-select form-control" onchange="optionChange()">
								<option value="0">옵션을 선택해주세요.</option>
								<option value="0">-------------------------------</option>
								<c:forEach var="i" begin="0" end="${optionSize-1}">
									<c:if test="${optionPrices[i] != 0}">
										<option value="${optionNames[i]}/${optionPrices[i]}">${optionAdd[i]}</option>
									</c:if>
									<c:if test="${optionPrices[i] == 0}">
										<option value="${optionNames[i]}/${optionPrices[i]}">${optionNames[i]}</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
					</div>
					<hr/>
					<div class="text-left"><font size="2pt">(최소주문수량 1개 이상)</font></div>
					<div class="text-left">
						<table style="width:100%">
							<tr>
								<td style="padding: 8px 0px 8px 0px; width:30%"><font size="2pt">수량을 선택하세요.</font></td>
								<td style="padding: 8px 0px 8px 0px; width:25%">
									<div class="input-group">
										<input type="button" class="form-control btn btn-outline-dark" value="-" onclick="quantityDown()"/>
										<input type="text" class="form-control text-right" value="1" id="quantity" name="quantity" style="width:40%; border: 1px solid #000000;" onchange="quantityCheck()"/>
										<input type="button" class="form-control btn btn-outline-dark" value="+" onclick="quantityUp()"/>
									</div>
								</td>
								<td style="padding: 8px 0px 8px 0px; width: 30%;">
									<div style="text-align: right;">
										<div id="productPrice"><fmt:formatNumber value="${salePrice}" pattern="#,###"/>원<br/></div>
										<div id="productSavePoint">(<span class="badge badge-danger">적</span>&nbsp;&nbsp;<fmt:formatNumber value="${salePrice*0.05}" pattern="#,###"/>원)</div>
									</div>
								</td>
							</tr>
						</table>
						<div id="optionView"></div>
					</div>
					<hr/>
					<div id="totPriceView" style="text-align: left;">
						총 상품금액(수량)&nbsp;&nbsp;:&nbsp;&nbsp;<font size="5pt"><b><fmt:formatNumber value="${salePrice}" pattern="#,###"/>원&nbsp;</b></font>(1개)
						&nbsp;&nbsp;&nbsp;&nbsp;(<span class='badge badge-danger'>적</span>&nbsp;&nbsp;<fmt:formatNumber value="${salePrice*0.05}" pattern="#,###"/>원)
					</div>
					<br/>
					<div class="text-center" style="background-color:black; width:100%; min-height:30px; padding-top:4px;" id="blackBox">
						<span style="margin:0px 50px;">
							<a href="javascript:buyNow()">BUY NOW</a>
						</span>
						<span style="margin:0px 50px;">
							<a href="javascript:cart()">ADD TO CART</a>
						</span>
					</div>
				</c:if>
			</div><br/>
			<div class="text-center mb-5">
				${vo.content}
			</div>
			<div class="text-center mb-4"><h3>Product Review</h3></div>
			<table class="table text-center" style="margin-bottom:60px;">
				<tr>
					<th width="10%">리뷰이미지</th>
					<th width="8%">작성자</th>
					<th width="20%">제목</th>
					<th width="20%">내용</th>
					<th width="12%">평점</th>
					<th width="20%">올린날짜</th>
					<th width="10%">기타</th>
				</tr>
				<c:forEach var="reviewVo" items="${reviewVos}">
					<tr>
						<td><div class="reviewImg" style="background-image:url('${ctp}/data/review/${reviewVo.FSName}');"></div></td>
						<td>${reviewVo.name}</td>
						<td>${reviewVo.title}</td>
						<td class="text-left">${fn:replace(reviewVo.content,newLine,"<br/>")}</td>
						<td>
							<div id="ratingForm">
								<c:forEach begin="1" end="${reviewVo.rating}">
									<div id="rating" style="float:left">⭐</div>
								</c:forEach>
							</div>
						</td>
						<td>
							<c:set var="reviewDate" value="${fn:split(reviewVo.reviewDate,' ')}"/>
							<c:set var="reviewDate1" value="${fn:split(reviewDate[0],'-')}"/>
							<c:set var="reviewDate2" value="${fn:split(reviewDate[1],':')}"/>
							${reviewDate1[0]}년 ${reviewDate1[1]}월 ${reviewDate1[2]}일 ${reviewDate2[0]}시 ${reviewDate2[1]}분
						</td>
						<td><input type="button" value="리뷰상세보기" onClick="reviewContent(${reviewVo.orderIdx})" class="btn btn-danger btn-sm" /></td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(reviewVos) == 0}"><tr><td colspan="7" style="height:100px;">해당상품의 리뷰가 없습니다.</td></tr></c:if>
				<tr><td colspan="7" class="p-0"></td></tr>
			</table>
		</div>
		<input type="hidden" name="productIdx" value="${vo.idx}" />
		<input type="hidden" name="pno" value="${vo.pno}" />
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="commodity" value="${vo.commodity}" />
		<input type="hidden" name="salePrice" value="${salePrice}" />
		<input type="hidden" name="optionPrice" id="optionPrice"/>
		<input type="hidden" name="totPrice" value="${salePrice}"/>
		<input type="hidden" name="orderQuantity" value="1"/>
		<input type="hidden" name="savePoint" value="<fmt:formatNumber value="${salePrice*0.05}" pattern="###"/>"/>
		<input type="hidden" name="optionSavePoint"/>
		<input type="hidden" name="totSavePoint" value="<fmt:formatNumber value="${salePrice*0.05}" pattern="###"/>"/>
		<input type="hidden" name="optionSize" value="${optionSize}"/>
		<input type="hidden" name="fSName" value="${fSNames[0]}"/>
		<input type="hidden" name="flag" id="flag"/>	<!-- 장바구니담지않고 직접주문시에 flag='order'을 넘겨주기위한 변수 -->
	</form>
	<form name="reviewForm" method="post">
		<input type="hidden" name="orderIdx" id="orderIdx"/>	<!-- 리뷰상세보기페이지 이동하기위해 주문번호를 들고 이동 -->
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>