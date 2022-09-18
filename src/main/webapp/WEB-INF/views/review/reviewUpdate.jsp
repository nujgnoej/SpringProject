<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - Review</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		let submitFlag = 0;
		
		function reviewUpdate() {
			let rating = myForm.rating.value;	// 별점
			let title = myForm.title.value;		// 글제목
			let fSName = '${vo.FSName}';		// 기존 등록된 파일이름
			let file = myForm.file.value;		// 파일명
			let content = myForm.content.value;	// 글내용
			let ext = file.substring(file.lastIndexOf(".")+1);
			
			if(rating == "") {
				alert("별점을 선택해주세요.");
				return false;
			}
			else if(title.trim() == "") {
				alert("제목을 입력해주세요.");
				return false;
			}
			else if(file == "" && fSName == "") {
				alert("상품 이미지를 등록하세요!");
				return false;
			}
			else if(fSName != "" && file != "") {
				alert("리뷰이미지는 한개만 등록 가능합니다. 기존 이미지를 삭제해주세요.");
				location.reload();
				return false;
			}
			else if(content.trim() == "") {
				alert("내용을 입력해주세요.");
				return false;
			}
			else if(document.getElementById("file").value != "" || fSName != "") {
				if(document.getElementById("file").value != "" && fSName == "") {
					let maxSize = 1024 * 1024 * 3;  // 3MByte까지 허용
					let fileSize = document.getElementById("file").files[0].size;
					if(fileSize > maxSize) {
						alert("첨부파일의 크기는 3MB 이내로 등록하세요");
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
			if(submitFlag == 1) {
				let fileFlag = $("#fileFlag").val();
	    		if(fileFlag == "no" && FSName == "") {
	    			alert("제품사진을 확인해주세요.");
	    			return false;
	    		}
				myForm.action = "${ctp}/review/reviewUpdateOk";
				myForm.submit();
			}
			else {
				alert("리뷰등록에 실패하였습니다.");
			}
		}
		
		// 제품사진 확장자체크
		function fileUpload(fis) {
			let file = fis.value;			// 파일명
			let ext = file.substring(file.lastIndexOf(".")+1);
			let uExt = ext.toUpperCase();			// 확장자를 구하기 위해 대문자로 치환
			let maxSize = 1024 * 1024 * 3;  // 3MByte까지 허용
			let fileSize = document.getElementById("file").files[0].size;
			
			if(uExt.trim() == "" || fileSize > maxSize) {
				$('#file_none').css("display","inline-block");
                $('#file_ok').css("display","none"); 
                $('#file_already').css("display","none");
                myForm.fileFlag.value = "no";
			}
			else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
				$('#file_none').css("display","none");
                $('#file_ok').css("display", "none");
                $('#file_already').css("display","inline-block");
                myForm.fileFlag.value = "no";
			}
			else if((uExt == "JPG" || uExt == "GIF" || uExt == "PNG" || uExt == "JPEG") || fileSize <= maxSize) {
				$('#file_none').css("display","none");
                $('#file_ok').css("display","inline-block"); 
                $('#file_already').css("display","none");
                myForm.fileFlag.value = "yes";
			}
		}
		
		// 리뷰이미지 삭제
		function imgDelete(orderIdx) {
			let fSName = myForm.fSName.value;
			let ans = confirm("선택한 이미지를 삭제하시겠습니까?");
			
			if(ans) {
				$.ajax({
					type : "post",
					url  : "${ctp}/review/reviewImgDelete",
					data : {
						orderIdx : orderIdx,
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
		
		// 리뷰 내용기입란 글자수체크
		function contentCheck() {
			var content = $("#content").val(); //입력한 것
		    $('#counter').html("("+content.length+" / 최대 100자)");  //글자수 카운팅

		    if (content.length > 100){ //100자 이상일 때
		        alert("최대 100자까지 입력 가능합니다.");
		        $("#content").val(content.substring(0, 100)); //넘어간 글자 자르기
		        $('#counter').html("(100 / 최대 100자)");
		    }
		}
		
		// 리뷰리셋
		function reviewReset() {
			$('input:radio[name="rating"]').prop('checked', false);
			$('#title').val('');
			$('#content').val('');
		}
	</script>
	<style>
		#myForm fieldset{
		    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
		    direction: rtl; /* 이모지 순서 반전 */
		    border: 0; /* 필드셋 테두리 제거 */
		    padding: 0;
		    margin: 0;
		}
		#myForm fieldset legend{
		    text-align: left;
		}
		#myForm input[type=radio]{
		    display: none; /* 라디오박스 감춤 */
		}
		#myForm label{
		    font-size: 2em; /* 이모지 크기 */
		    color: transparent; /* 기존 이모지 컬러 제거 */
		    text-shadow: 0 0 0 #e0e0e0; /* 새 이모지 색상 부여 */
		}
		#myForm label:hover{
		    text-shadow: 0 0 0 #EB1D36; /* 마우스 호버 */
		}
		#myForm label:hover ~ label{
		    text-shadow: 0 0 0 #EB1D36; /* 마우스 호버 뒤에오는 이모지들 */
		}
		#myForm input[type=radio]:checked ~ label{
		    text-shadow: 0 0 0 #EB1D36; /* 마우스 클릭 체크 */
		}
		table td {
			text-align: left;
			padding-left: 40px;
		}
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
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:100px; min-height:767px;">
	<h3>Review 수정</h3><br/>
	<form name="myForm" id="myForm" method="post" enctype="multipart/form-data">
		<table class="table mb-4 text-center">
			<tr>
				<th width="20%">주문번호</th>
				<td width="30%">${vo.orderIdx}</td>
				<th width="20%">작성자</th>
				<td width="30%">${vo.name}</td>
			</tr>
			<tr>
				<th>상품명</th>
				<td colspan="3">
					<c:set var="commoditys" value="${fn:split(vo.commodity,'/')}"/>
					<c:forEach var="commodity" items="${commoditys}">
						${commodity}<br/>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th>별점</th>
				<td colspan="3">
					<fieldset class="text-right">						<input type="radio" name="rating" value="5" id="rate1" <c:if test="${vo.rating == 5}">checked</c:if>><label for="rate1">⭐</label>						<input type="radio" name="rating" value="4" id="rate2" <c:if test="${vo.rating == 4}">checked</c:if>><label for="rate2">⭐</label>
						<input type="radio" name="rating" value="3" id="rate3" <c:if test="${vo.rating == 3}">checked</c:if>><label for="rate3">⭐</label>
						<input type="radio" name="rating" value="2" id="rate4" <c:if test="${vo.rating == 2}">checked</c:if>><label for="rate4">⭐</label>
						<input type="radio" name="rating" value="1" id="rate5" <c:if test="${vo.rating == 1}">checked</c:if>><label for="rate5">⭐</label>
					</fieldset>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">
					<input type="text" name="title" id="title" value="${vo.title}" class="form-control" placeholder="제목을 입력해주세요." required/>
				</td>
			</tr>
			<tr>
				<th>사진등록</th>
				<td colspan="3">
					<c:if test="${vo.FSName != ''}">
						<div class="form-inline">
							<div class="mb-2 mr-2 text-center" style="width:102px; height:138px; border: 1px solid gray;" >
								<div class="mainImg" id="a" style="background-image:url('${ctp}/data/review/${vo.FSName}');"></div>
								<input type="button" value="이미지삭제" class="btn btn-outline-danger" onclick="imgDelete(${vo.orderIdx})"/>
							</div>
						</div>
					</c:if>
					<input type="file" id="file" name="file" class="form-control-file border" onchange="fileUpload(this)" accept=".jpg,.gif,.png,.jpeg" required />
					<span id="file_none" style="display:inline-block; margin-top:10px;">&nbsp;&nbsp;<font color="red">&nbsp;&nbsp;*&nbsp;사진은 1개만 등록 가능하며, 3MB이내 이미지파일만 등록 가능합니다.</font></span>
					<span id="file_ok" style="display:none; margin-top:10px;">&nbsp;&nbsp;<font color="red">등록 가능한 이미지입니다.</font></span>
					<span id="file_already" style="display:none; margin-top:10px;">&nbsp;&nbsp;<font color="red">잘못된 사진파일입니다.(jpg, gif, png, jpeg 확장자만 사용 가능합니다.)</font></span>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<textarea rows="3" name="content" id="content" class="form-control content1" onkeyup="contentCheck()" placeholder="내용을 입력해주세요.(최대 100자)" required>${vo.content}</textarea>
					<span style="color:#aaa;" id="counter">(${contentLen} / 최대 100자)</span>
				</td>
			</tr>
			<tr><td colspan="4" class="p-0"></td></tr>
		</table>
		<div style="width:100%;" class="text-center mb-5">
			<input type="button" value="리뷰수정" onclick="reviewUpdate()" class="btn btn-outline-dark mr-2"/>
			<input type="button" value="다시쓰기" onclick="reviewReset()" class="btn btn-outline-danger"/>
		</div>
		<input type="hidden" name="orderIdx" value="${vo.orderIdx}"/>
		<input type="hidden" name="mid" value="${sMid}"/>
		<input type="hidden" name="name" value="${vo.name}"/>
		<input type="hidden" name="commodity" value="${vo.commodity}"/>
		<input type="hidden" name="fSName" value="${vo.FSName}"/>
		<input type="hidden" name="fileFlag" id="fileFlag"/>
		<input type="hidden" name="pag" value="${pag}"/>
		<input type="hidden" name="pageSize" id="${pageSize}"/>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>