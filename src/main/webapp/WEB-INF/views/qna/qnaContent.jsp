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
	<title>Mood Ritual - Q&A</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		// Q&A삭제
		function qnaDelete(idx, flag) {
			let pag = '${pag}';
			let pageSize = '${pageSize}';
			let ans = confirm("해당 문의글을 삭제하시겠습니까?");
			if(ans) {
				location.href="${ctp}/qna/qnaDelete?idx="+idx+"&pag="+pag+"&pageSize="+pageSize+"&flag="+flag;
			}
		}
		
		// Q&A수정
		function qnaUpdate(idx, flag) {
			let pag = '${pag}';
			let pageSize = '${pageSize}';
			location.href="${ctp}/qna/qnaUpdate?idx="+idx+"&pag="+pag+"&pageSize="+pageSize+"&flag="+flag;
		}
		
		// 답변 입력 저장처리(aJax처리)
	    function replyCheck() {
	    	let content = $("#content").val();
	    	if(content.trim() == "") {
	    		alert("답변을 입력해주세요.");
	    		$("#content").focus();
	    		return false;
	    	}
	    	let query = {
	    		qnaIdx : ${vo.idx},
	    		mid      : '${sMid}',
	    		name	 : '${sName}',
	    		content  : content,
	    	}
	    	
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/qna/qnaReplyInput",
	    		data  : query,
	    		success:function(data) {
	    			if(data == "1") {
	    				alert("답변을 등록하였습니다.");
	    				location.reload();
	    			}
	    			else {
	    				alert("답변 입력실패!");
	    			}
	    		},
	    		error : function() {
	    			alert("전송오류!");
	    		}
	    	});
	    }
		
	    // 댓글 삭제(ajax처리)
	    function replyDelCheck(idx, qnaIdx) {
	    	let ans = confirm("해당 답변을 삭제하시겠습니까?");
	    	
	    	if(!ans) return false;
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/qna/qnaReplyDeleteOk",
	    		data  : {
	    			idx : idx,
	    			qnaIdx : qnaIdx
	    			},
	    		success:function() {
	    			alert("해당 답변글이 삭제되었습니다.")
		    		location.reload();
	    		},
	    		error : function() {
	    			alert("전송 실패!!!");
	    		}
	    	});
	    }
	    
		// 답변글(부모댓글의 댓글)
		function insertReply(idx, level, levelOrder, name) {
			let insReply = '';
			insReply += '<div class="container p-0 m-0">';
			insReply += '<table class="p-0" style="width:100%">';
			insReply += '<tr>';
			insReply += '<td colspan="5" class="p-0 text-left" style="border-top:none">';
			insReply += '<div>';
			insReply += '<input type="hidden" name="name" value="${sName}" />';
			insReply += '</div>';
			insReply += '</td>';
			insReply += '</tr>';
			insReply += '<tr>';
			insReply += '<td colspan="4" class="text-center p-0" width="85%">';
			insReply += '<textarea rows="3" class="form-control mt-1 mb-1" name="content" id="content'+idx+'">';
			insReply += '@'+name+'\n';
			insReply += '</textarea>';
			insReply += '</td>';
			insReply += '<td class="p-0 text-center" width="15%">';
			insReply += '<input type="button" value="답글달기" class="btn btn-dark btn-sm" onclick="replyCheck2('+idx+','+level+','+levelOrder+')"/>';
			insReply += '</td>';
			insReply += '</tr>';
			insReply += '</table>';
			insReply += '</div>';
			
			$("#replyBoxOpenBtn"+idx).hide();
			$("#replyBoxCloseBtn"+idx).show();
			$("#replyBox"+idx).html(insReply);
			$("#replyBox"+idx).slideDown(500);
		}

	    // 대댓글 입력폼 닫기 처리
	    function closeReply(idx) {
	    	$("#replyBoxOpenBtn"+idx).show();
	    	$("#replyBoxCloseBtn"+idx).hide();
	    	$("#replyBox"+idx).slideUp(500);
	    }
	    
	 	// 댓글 저장하기(대댓글)
	    function replyCheck2(idx, level, levelOrder) {
	    	let qnaIdx = "${vo.idx}";
	    	let mid = "${sMid}";
	    	let name = "${sName}";
	    	let content = "content" + idx;
	    	let contentVal = $("#" + content).val();
	    	
	    	if(contentVal.trim() == "") {
	    		alert("댓글을 입력해주세요.");
	    		$("#" + content).focus();
	    		return false;
	    	}
	    	
	    	let query = {
	    			qnaIdx	  : qnaIdx,
	    			mid       : mid,
	    			name	  : name,
	    			content   : contentVal,
	    			level     : level,
	    			levelOrder: levelOrder
	    	}
	    	
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/qna/qnaReplyInput2",
	    		data : query,
	    		success:function() {
	    			alert("댓글을 등록하였습니다.");
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송오류!");
	    		}
	    	});
	    }
	 
	 	// 목록으로
	 	function qnaList() {
	 		let pag = '${pag}';
	 		let pageSize = '${pageSize}';
	 		let flag = '${flag}';
	 		if('${flag}'=='mypage') {
	 			location.href = '${ctp}/member/mypageView?pag='+pag+'&pageSize='+pageSize+'&flag='+flag;
	 		}
	 		else {
		 		location.href = '${ctp}/qna/qnaList?pag='+pag+'&pageSize='+pageSize+'&flag='+flag;
	 		}
	 	}
	</script>
	<style>
		#mainTable td {
			text-align:left;
		}
		.btn-dark:hover {
			background-color: white;
			color: black;
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
<div class="container" style="padding-top:100px; min-height:767px; margin-bottom:80px;">
	<div style="margin:auto;" class="mb-3 text-center">
		<img src='${ctp}/images/qna.png' width="50px" height="50px" style="margin-bottom:10px;"/>&nbsp;<font size="6pt"><b>Question and Answer</b></font>
	</div>
	<table class="table mb-2 text-center" id="mainTable">
		<tr>
			<th width="20%" height="50px">질문유형</th>
			<td>${vo.qnaType}</td>
		</tr>
		<tr>
			<th width="20%" height="50px">제목</th>
			<td>${vo.title}</td>
		</tr>
		<tr>
			<th height="50px">작성자</th>
			<td>${vo.name}</td>
		</tr>
		<tr>
			<th height="50px">작성일</th>
			<td>
				<c:set var="wDate" value="${fn:split(vo.WDate,' ')}"/>
				<c:set var="wDate1" value="${fn:split(wDate[0],'-')}"/>
				<c:set var="wDate2" value="${fn:split(wDate[1],':')}"/>
				${wDate1[0]}년 ${wDate1[1]}월 ${wDate1[2]}일 ${wDate2[0]}시 ${wDate2[1]}분
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding:30px; height:300px; vertical-align:top !important;">${fn:replace(vo.content,newLine,"<br/>")}</td>
		</tr>
		<tr><td colspan="2" class="p-0"></td></tr>
	</table>
	<div class="text-center mt-3">
		<input type="button" value="목록으로" class="btn btn-outline-dark" onclick="qnaList()"/>
		<c:if test="${vo.adChk != 'yes'|| sLevel == '1'}">
			<c:if test="${vo.mid == sMid}"><input type="button" value="문의글수정" class="btn btn-outline-info" onclick="qnaUpdate('${vo.idx}','${flag}')"/></c:if>
			<input type="button" value="문의글삭제" class="btn btn-outline-danger" onclick="qnaDelete('${vo.idx}','${flag}')"/>
		</c:if>
	</div>
	<!-- 답변출력 -->
	<table class="table mt-5 mb-0 text-center">
		<tr>
			<th width="10%">번호</th>
			<th width="20%">작성자</th>
			<th width="35%">내용</th>
			<th width="20%">댓글날짜</th>
			<th width="15%">기타</th>
		</tr>
		<c:if test="${replyVosSize >= 1}">
		<tr>
			<c:forEach var="replyVo" items="${replyVos}" varStatus="st">
				<c:if test="${replyVo.deleteSw=='no'}">
					<tr>
						<td>${st.count}</td>
						<td class="text-left">
							<c:if test="${replyVo.level <= 0}">		<!-- 부모댓글의 경우는 들여쓰지 하지 않는다. -->
								${replyVo.name}
							</c:if>
							<c:if test="${replyVo.level > 0}">		<!-- 부모댓글의 경우는 들여쓰지 하지 않는다. -->
								<c:forEach var="i" begin="1" end="${replyVo.level}">&nbsp;&nbsp;&nbsp;</c:forEach>
								<img src="${ctp}/images/reply.jpg" style="margin-bottom:5px;"/>${replyVo.name}
							</c:if>
							<c:if test="${sMid == replyVo.mid || sLevel == 1}">
								<a href="javascript:replyDelCheck(${replyVo.idx},${replyVo.qnaIdx})" title="삭제하기"><span class="glyphicon glyphicon-remove"></span></a>
							</c:if>
						</td>
						<td class="text-left">
							${fn:replace(replyVo.content,newLine,"<br/>")}
						</td>
						<td>
							<c:set var="replyWdate" value="${fn:split(replyVo.WDate,' ')}"/>
							<c:set var="replyWdate1" value="${fn:split(replyWdate[0],'-')}"/>
							<c:set var="replyWdate2" value="${fn:split(replyWdate[1],':')}"/>
							${replyWdate1[0]}년 ${replyWdate1[1]}월 ${replyWdate1[2]}일 ${replyWdate2[0]}시 ${replyWdate2[1]}분
						</td>
						<td>
							<input type="button" value="답글" onclick="insertReply('${replyVo.idx}','${replyVo.level}','${replyVo.levelOrder}','${replyVo.name}')" id="replyBoxOpenBtn${replyVo.idx}" class="btn btn-dark btn-sm"/>
							<input type="button" value="닫기" onclick="closeReply('${replyVo.idx}')" id="replyBoxCloseBtn${replyVo.idx}" class="btn btn-danger btn-sm" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td colspan="5" class="m-0 p-0" style="border-top:none;"><div id="replyBox${replyVo.idx}"></div></td>
					</tr>
					<!-- <tr><td colspan="5" class="p-0"></td></tr> -->
				</c:if>
				<%-- <c:if test="${replyVo.deleteSw == 'yes' and (!empty replyVos[st.count].level and (replyVos[st.index].level < replyVos[st.count].level))}"> --%>
				<c:if test="${replyVo.deleteSw == 'yes'}">
					<tr><td>${st.count}</td><td class="text-left" colspan="4"><div class="mt-2 mb-2"><font size="2pt"><b>해당글이 삭제되었습니다.</b></font></div></td></tr>
				</c:if>
			</c:forEach>
		</tr>
		</c:if>
		<c:if test="${replyVosSize == 0}">
			<tr><td colspan="5" height="100px">답변이 없습니다.</td></tr>
		</c:if>
		<c:if test="${sLevel!=1}"><tr><td colspan="5" class="p-0"></td></tr></c:if>
	</table>
	<c:if test="${sLevel==1}">
		<!-- 답변입력 -->
		<form name="myForm" method="post">
			<table class="table mb-2 text-center">
				<tr>
					<td style="width:100%" class="text-center">
						<textarea rows="3" name="content" id="content" class="form-control" placeholder="답변을 입력하세요."></textarea>
						<input type="button" value="답변등록" onclick="replyCheck()" class="btn btn-outline-dark btn-sm mt-2"/>
					</td>
				</tr>
			</table>
		</form>
	</c:if>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>