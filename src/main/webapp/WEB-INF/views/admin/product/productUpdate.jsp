<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 제품정보수정</title>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		let submitFlag = 0;
		let cnt = ${optionSize-1};
		
		// 제품등록 유효성검사
		function fCheck() {
			let pno = $("#pno option:selected").val();		// 제품종류
			let commodity = myForm.commodity.value;	// 제품명
			let quantity = myForm.quantity.value;	// 재고량
			let price = myForm.price.value;			// 가격
			let discount = myForm.discount.value;	// 할인율
			let size = myForm.size.value;			// 사이즈(용량)
			let file = myForm.file.value;			// 파일명
			let ext = file.substring(file.lastIndexOf(".")+1);
			let uExt = ext.toUpperCase();			// 확장자를 구하기 위해 대문자로 치환
			let optionName = document.getElementById("optionName0").value;
			let optionPrice = document.getElementById("optionPrice0").value;
			let content = CKEDITOR.instances['CKEDITOR'].getData();		// ckeditor에 입력된 값을 받아 비교하려면 데이터값을 추출해야 한다.
			let regContent = "style=\"";		// 상세설명란에 이미지를 넣었는지 유효성검사
			let regContentName = "&amp;";			// 파일명에 &특수기호가 들어가는지 체크(연산자와 겹침)
			let regNum = /^[0-9|_]*$/;   		// 가격은 숫자로만 입력받음
			let fName = myForm.fName.value;
			
			if(pno == 0) {
				alert("상품종류를 선택해주세요!");
				myForm.pno.focus();
				return false;
			}
			else if(commodity.trim() == "") {
				alert("제품명을 입력하세요!");
				myForm.commodity.focus();
				return false;
			}
			else if(quantity.trim() == "") {
				alert("재고량을 입력하세요!");
				myForm.quantity.focus();
				return false;
			}
			else if(!regNum.test(quantity)) {
				alert("재고량은 숫자로 입력 가능합니다.");
				myForm.quantity.focus();
				return false;
			}
			else if(price.trim() == "") {
				alert("가격을 입력하세요!");
				myForm.price.focus();
				return false;
			}
			else if(!regNum.test(price)) {
				alert("가격은 숫자로 입력 가능합니다.");
				myForm.price.focus();
				return false;
			}
			else if(discount.trim() == "") {
				alert("할인율을 입력하세요!");
				myForm.discount.focus();
				return false;
			}
			else if(!regNum.test(discount)) {
				alert("할인율은 숫자로 입력 가능합니다.");
				myForm.discount.focus();
				return false;
			}
			else if(size.trim() == "") {
				alert("사이즈를(용량을) 입력하세요!");
				myForm.size.focus();
				return false;
			}
			else if(file == "" && fName == "") {
				alert("상품 이미지를 등록하세요!");
				return false;
			}
			else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && fName == "") {
				alert("업로드 가능한 파일이 아닙니다!");
				return false;
			}
			else {
				for(var i=1; i<=cnt; i++) {
		    		if($("#t"+i).length != 0 && document.getElementById("optionName"+i).value == "") {
		    			alert("빈칸 없이 상품 옵션명을 모두 등록하셔야 합니다");
		    			$("#optionName"+i).focus();
		    			return false;
		    		}
		    		else if($("#t"+i).length != 0 && document.getElementById("optionPrice"+i).value == "") {
		    			alert("빈칸 없이 상품 옵션가격을 모두 등록하셔야 합니다");
		    			$("#optionPrice"+i).focus();
		    			return false;
		    		}
		    	}
				if(content.trim() == "") {
					alert("제품설명란을 작성해주세요!");
					return false;
				}
				else if(content.indexOf(regContent) == -1) {
					alert("제품설명란에 이미지를 삽입해주세요!");
					return false;
				}
				else if(content.indexOf(regContentName) != -1) {
					alert("제품설명이미지명에 '&'는 포함될 수 없습니다.");
					return false;
				}
				else if(document.getElementById("file").value != "" || fName != "") {
					if(document.getElementById("file").value != "" && fName == "") {
						let maxSize = 1024 * 1024 * 30;  // 30MByte까지 허용
						let fileSize = document.getElementById("file").files[0].size;
						
						if(fileSize > maxSize) {
							alert("첨부파일의 크기는 30MB 이내로 등록하세요");
							return false;
						}
						else {
							submitFlag = 1;
						}
					}
					else {
						submitFlag = 1;
					}
				}
				// 전송전에 모든 체크가 끝나서 submitFlag가 1이되면 서버로 전송한다.
		    	if(submitFlag == 1) {
		    		let fileFlag = $("#fileFlag").val();
		    		if(fileFlag == "no") {
		    			alert("제품사진을 확인해주세요.");
		    		}
		    		else {
						myForm.submit();
		    		}
		    	}
		    	else {
		    		alert("제품등록에 실패하였습니다.")
		    	}
			}
		}
		
		// 제품사진 확장자체크
		function fileUpload(fis) {
			let file = fis.value;			// 파일명
			let ext = file.substring(file.lastIndexOf(".")+1);
			let uExt = ext.toUpperCase();			// 확장자를 구하기 위해 대문자로 치환
			
			if(uExt.trim() == "") {
				$('#file_none').css("display","inline-block");
                $('#file_ok').css("display","none"); 
                $('#file_already').css("display","none");
                myForm.fileFlag.value = "no";
			}
			else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
				$('#file_none').css("display","none");
                $('#file_already').css("display","inline-block");
                $('#file_ok').css("display", "none");
                myForm.fileFlag.value = "no";
			}
			else if(uExt == "JPG" || uExt == "GIF" || uExt == "PNG" || uExt == "JPEG") {
				$('#file_none').css("display","none");
                $('#file_already').css("display","none");
                $('#file_ok').css("display","inline-block"); 
                myForm.fileFlag.value = "yes";
			}
		}
		
		// 옵션추가
		function optionAdd() {
			cnt++;
			
			let num = "";
			let strOption = "";
			let test = "t" + cnt;
			
			strOption += '<div id="'+test+'">';
			strOption += '<div class="form-inline mb-2">';
			strOption += '옵션&nbsp;&nbsp;';
	    	strOption += '<input type="text" name="optionName" id="optionName'+cnt+'" class="form-control mr-3" placeholder="옵션명을 작성해주세요." />';
			strOption += '가격&nbsp;&nbsp;';
	    	strOption += '<input type="text" name="optionPrice" id="optionPrice'+cnt+'" class="form-control" placeholder="옵션가격을 작성해주세요." />&nbsp;&nbsp;';
	    	strOption += '<input type="button" value="옵션삭제" class="btn btn-outline-danger btn-sm" onclick="removeOption('+test+')"/><br/>'
	    	strOption += '</div>';
	    	strOption += '</div>';
	    	
	    	$("#optionType").append(strOption);
		}
		
		// 기존옵션항목 삭제
	    function removeBtn(section) {
	    	$('div').remove("#"+section);
	    }
		
		// 추가옵션항목 삭제
	    function removeOption(test) {
	    	$("#"+test.id).remove();
	    }
		
		// 상품이미지 삭제
		function imgDelete(idx, imgIdx) {
			let fName = myForm.fName.value;
			let fSName = myForm.fSName.value;
			let ans = confirm("선택한 이미지를 삭제하시겠습니까?");
			
			if(ans) {
				$.ajax({
					type : "post",
					url  : "productImgDelete",
					data : {
						idx : idx,
						imgIdx : imgIdx,
						fName : fName,
						fSName : fSName
					},
					success : function() {
						alert("이미지가 삭제되었습니다.");
						location.reload();
					},
					error : function() {
						alert("전송 실패!");
					}
				});
			}
		}
	</script>
	<style>
		.mainImg {
			background-size: 100px;
			width: 100px;
			height: 100px;
			margin: auto;
			z-index: -1;
		}
		#a {
			transition: all 0.1s linear;
		}
		#a:hover {
			transform: scale(2);
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminNav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px;">
	<div style="width:90%; margin:auto;" class="mb-5">
		<div class="text-center mb-3"><h2>제품정보수정</h2></div>
		<form name="myForm" method="post" enctype="multipart/form-data">
			<table class="table table-bordered text-center">
				<tr>
					<th style="width:10%">제품종류<font color="red">&nbsp;*</font></th>
					<td colspan="3">
						<select name="pno" id="pno" class="custom-select form-control">
							<option value="0">제품종류를 등록해주세요.</option>
							<option value="0">-------------------------------</option>
							<c:forEach var="typeVo" items="${typeVos}">
								<option value="${typeVo.pno}" <c:if test="${typeVo.pno == vo.pno}">selected</c:if>>${typeVo.product}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th style="width:10%">제품명<font color="red">&nbsp;*</font></th>
					<td style="width:40%"><input type="text" name="commodity" value="${vo.commodity}" placeholder="제품명을 입력하세요." class="form-control" required /></td>
					<th style="width:10%">재고량<font color="red">&nbsp;*</font></th>
					<td style="width:40%"><input type="text" name="quantity" value="${vo.quantity}" placeholder="제품의 수량을 입력하세요." class="form-control" required /></td>
				</tr>
				<tr>
					<th>가격<font color="red">&nbsp;*</font></th>
					<td><input type="text" name="price" value="${vo.price}" placeholder="가격을 입력하세요." class="form-control" required /></td>
					<th>할인가격<font color="red">&nbsp;*</font></th>
					<td><input type="text" name="discount" value="${vo.discount != '0' ? vo.discount : '0'}" class="form-control" required /></td>
				</tr>
				<tr>
					<th>사이즈<font color="red">&nbsp;*</font></th>
					<td colspan="3">
						<input type="text" name="size" value="${vo.size}" placeholder="제품 사이즈를(용량을) 입력하세요." class="form-control" />
					</td>
				</tr>
				<tr>
					<th>제품사진<font color="red">&nbsp;*</font></th>
					<td class="text-left" colspan="3">
						<c:if test="${vo.FName != ''}">
							<div class="form-inline">
								<c:forEach var="fSName" items="${fSNames}" varStatus="st">
									<div class="mb-2 mr-2 text-center" style="width:102px; height:138px; border: 1px solid gray;" >
										<%-- <img src="${ctp}/data/admin/product/${fSName}" width="100" height="100"/> --%>
										<div class="mainImg" id="a" style="background-image:url('${ctp}/data/admin/product/${fSName}');">
											<c:if test="${vo.quantity == 0}"><div class="soldoutImg" style="background-image:url('${ctp}/images/soldout50.png'"></div></c:if>
										</div>
										<input type="button" value="이미지삭제" class="btn btn-outline-danger" onclick="imgDelete(${vo.idx},${st.index})"/>
									</div>
								</c:forEach>
							</div>
						</c:if>
						<c:if test="${vo.FName == ''}">
							<div class="mb-2">등록된 제품이미지가 없습니다. 제품이미지를 등록해주세요.</div>
						</c:if>
						<div class="form-inline">
							<input type="file" id="file" name="file" multiple="multiple" class="form-control-file border" style="width:30%" placeholder="제품사진을 등록하세요." onchange="fileUpload(this)" accept=".jpg,.gif,.png,.jpeg" required />
							<span id="file_none" style="display:inline-block;">&nbsp;&nbsp;<font color="red">&nbsp;&nbsp;*&nbsp;jpg, gif, png, jpeg 확장자 사용가능.</font></span>
							<span id="file_ok" style="display:none;">&nbsp;&nbsp;<font color="red">등록 가능한 이미지입니다.</font></span>
							<span id="file_already" style="display:none;">&nbsp;&nbsp;<font color="red">잘못된 사진파일입니다.(jpg, gif, png, jpeg 확장자만 사용 가능합니다.)</font></span>
						</div>
					</td>
				</tr>
				<tr>
					<th>옵션</th>
					<td colspan="3">
						<div class="text-left">
							<input type="button" class="btn btn-outline-dark mb-2" onclick="optionAdd()" value="옵션추가"/>
						</div>
						<div class="form-inline mb-2">
							옵션&nbsp;&nbsp;
							<input type="text" name="optionName" id="optionName0" value="${optionNames[0]}" class="form-control mr-3" placeholder="옵션명을 작성해주세요." />
							가격&nbsp;&nbsp;
							<input type="text" name="optionPrice" id="optionPrice0" value="${optionPrices[0]}" class="form-control" placeholder="옵션가격을 작성해주세요." />
						</div>
						<c:forEach var="i" begin="1" end="${optionSize-1}">
							<div class="form-inline mb-2" id="section${i}">
								옵션&nbsp;&nbsp;
								<input type="text" name="optionName" id="optionName${i}" value="${optionNames[i]}" class="form-control mr-3" placeholder="옵션명을 작성해주세요." />
								가격&nbsp;&nbsp;
								<input type="text" name="optionPrice" id="optionPrice${i}" value="${optionPrices[i]}" class="form-control" placeholder="옵션가격을 작성해주세요." />
								<c:if test="${i >= 1}">&nbsp;&nbsp;<input type="button" value="옵션삭제" class="btn btn-outline-danger btn-sm" onclick="removeBtn('section${i}')" /></c:if>
							</div>
						</c:forEach>
						<div id="optionType"></div>
					</td>
				</tr>
				<tr>
					<th>제품설명</th>
					<td colspan="3"><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea></td>
					<script>
						CKEDITOR.replace("content",{
							uploadUrl : "${ctp}/imageUpload",     /* 그림파일 드래그&드롭 처리 */
							filebrowserUploadUrl : "${ctp}/imageUpload",  /* 이미지 업로드 */
							height:400
						});
					</script>
				</tr>
				<tr>
					<td colspan="4" class="text-center">
						<input type="button" value="수정완료" onclick="fCheck()" class="btn btn-outline-dark"/> &nbsp;
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/product/productList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-dark"/>
					</td>
				</tr>
			</table>
			<input type="hidden" name="mid" value="${sMid}"/>
	    	<input type="hidden" name="nickName" value="${sNickName}"/>
			<input type="hidden" name="fName" value="${vo.FName}"/>
			<input type="hidden" name="fSName" value="${vo.FSName}"/>
			<input type="hidden" name="fSize" value="${vo.FSize}"/>
			<input type="hidden" name="fileSize"/>
			<input type="hidden" name="fileFlag" id="fileFlag">
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>