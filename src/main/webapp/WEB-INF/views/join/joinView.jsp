<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mood Ritual - 회원가입</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js"></script>
	<script>
		'use strict';
		let submitFlag = 0;
	  	
		// 유효성검사
		function joinCheck() {
			let regMid = /^[a-zA-Z0-9]{4,20}$/;
			let regPwd = /(?=.*[a-zA-Z0-9]).{4,20}/;
			let regName = /^[가-힣a-zA-Z]+$/;
			let regTel = /\d{3}-\d{3,4}-\d{4}$/g;
			let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			let regAddress = /[,]/g;
			
			let mid = $("#mid").val();
			let pwd = $("#pwd").val();
			let pwdCheck = $("#pwdCheck").val();
			let question = $("#question").val();
			let pwdAnswer = $("#pwdAnswer").val();
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
			
			// 전송전에 이메일을 하나로 묶어서 준비한다.
			let email1 = myForm.email1.value;
	    	let email2 = myForm.email2.value;
			let email = email1 + '@' + email2;
			
			// 월과 일에 1자리수 숫자가 입력되면 앞에 0을 붙여서 넘긴다.
			let yy = myForm.yy.value;
			let intmm = myForm.mm.value;
	  		let mm = String(intmm).padStart(2,'0');
			let intdd = myForm.dd.value;
	  		let dd = String(intdd).padStart(2,'0');
	  		
	  		let birthday = yy + "-" + mm + "-" + dd;
	  		
	  		let mailCheck = document.getElementById('mailCheck').checked;
	  		let ck1 = document.getElementById('ck1').checked;
	  		let ck2 = document.getElementById('ck2').checked;
	  		
	  		// 입력정보 유효성검사
	  		if(!regMid.test(mid)) {
				alert("아이디를 확인해주세요!");
				myForm.mid.focus();
				return false;
		  	}
	  		else if(!regPwd.test(pwd)) {
				alert("비밀번호를 확인해주세요!");
				myForm.pwd.focus();
				return false;
			}
	  		else if(pwd != pwdCheck) {
	  			alert("비밀번호를 확인해주세요!");
				myForm.pwdCheck.focus();
				return false;
	  		}
			else if(!regName.test(name)) {
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
				alert("\' , \'는 사용할 수 없습니다.");
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
			else if(!regEmail.test(email)) {
				alert("이메일을 확인해주세요!");
				myForm.email1.focus();
				return false;
			}
			else if(ck1 == false) {
				alert("약관이용에 동의해주세요!");
				return false;
			}
			else if(ck2 == false) {
				alert("개인정보 수집 및 이용에 동의해주세요!");
				return false;
			}
			else {
				submitFlag = 1;
			}
			// 전송전에 모든 체크가 끝나서 submitFlag가 1이되면 서버로 전송한다.
	    	if(submitFlag == 1) {
	    		let midFlag = $("#midFlag").val();
	    		let emailFlag = $("#emailFlag").val();
	    		if(midFlag == "no") {
	    			alert("아이디가 중복되었습니다.");
	    			myForm.mid.focus();
	    			return false;
	    		}
	    		else if(emailFlag == "no") {
	    			alert("이메일이 중복되었습니다.");
	    			myForm.email1.focus();
	    			return false;
	    		}
	    		else {
		  			// 묶여진 필드(email/tel)를 폼태그안에 hidden태그의 값으로 저장시켜준다.
		  			myForm.address.value = address;
		  			myForm.tel.value = tel;
		  			myForm.email.value = email;
		  			myForm.birthday.value = birthday;
		  			
		  			myForm.submit();
	    		}
	    	}
	    	else {
	    		alert("회원가입에 실패하였습니다.");
	    	}
		}
		
		
		// mid중복체크(ajax 실시간처리)
		function midCheck() {
			let regMid = /^[a-zA-Z0-9]{4,20}$/;
			let mid = myForm.mid.value;
			
			$.ajax({
        		type : "post",
        		url  : "${ctp}/join/joinIdCheck",
        		data : {mid : mid},
        		success:function(res) {
        			if(mid.trim() == "") {
        				$('#mid_none').css("display","inline-block");
                        $('#mid_ok').css("display","none"); 
                        $('#mid_already').css("display","none");
                        myForm.midFlag.value = "no";
        			}
        			else if(res != 1 && regMid.test(mid)){ 	// res가 1이 아니면서 regMid에 해당하면 사용가능
                        $('#mid_none').css("display","none");
                        $('#mid_ok').css("display","inline-block"); 
                        $('#mid_already').css("display","none");
                        myForm.midFlag.value = "yes";
                    }
        			else { 			// res가 1일 경우 사용불가
        				$('#mid_none').css("display","none");
                        $('#mid_ok').css("display", "none");
                        $('#mid_already').css("display","inline-block");
                        myForm.midFlag.value = "no";
                    }
        		},
        		error : function() {
        			alert("전송오류!");
        		}
        	});
		}
		
    	// email중복체크(ajax 실시간처리)
		function emailCheck() {
			let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			let email1 = myForm.email1.value;
	    	let email2 = myForm.email2.value;
			let email = email1 + '@' + email2;
			let emailFlag = $("#emailFlag").val();
			
			$.ajax({
        		type : "post",
        		url  : "${ctp}/join/joinEmailCheck",
        		data : {email : email},
        		success:function(res) {
        			if(email1.trim() == "") {
        				$('#email_none').css("display","inline-block");
                        $('#email_ok').css("display","none"); 
                        $('#email_already').css("display","none");
                        myForm.emailFlag.value = "no";
        			}
        			else if(res != 1 && regEmail.test(email)) { 	// res가 1이 아니면서 regEmail에 해당하면 사용가능
                        $('#email_none').css("display","none");
                        $('#email_ok').css("display","inline-block"); 
                        $('#email_already').css("display","none");
                        myForm.emailFlag.value = "yes";
                    }
        			else { 			// res가 1일 경우 사용불가
        				$('#email_none').css("display","none");
                        $('#email_ok').css("display", "none");
                        $('#email_already').css("display","inline-block");
                        myForm.emailFlag.value = "no";
                    }
        		},
        		error : function() {
        			alert("전송오류!");
        		}
        	});
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/menu.jsp"/>
<div class="container" style="padding-top:150px;">
	<form name="myForm" method="post">
		<table class="table table-bordered" style="margin-bottom:30px;">
			<tr>
				<td style="width:20%">아이디<font color="red">&nbsp;*</font></td>
				<td>
					<div style="width:30%; float:left; margin-right:10px;">
						<input type="text" class="form-control" oninput="midCheck()" id="mid" name="mid" placeholder="아이디를 입력하세요." autofocus />
					</div>
					<span id="mid_none" style="display:inline-block;">&nbsp;&nbsp;<font color="red">아이디를 작성해주세요.</font></span>
					<span id="mid_ok" style="display:none;">&nbsp;&nbsp;<font color="red">사용 가능한 아이디입니다.</font></span>
					<span id="mid_already" style="display:none;">&nbsp;&nbsp;<font color="red">사용할 수 없습니다. 다른 아이디를 사용해주세요.</font></span>
					&nbsp;(영문대소문자/숫자 4~20자)
				</td>
			</tr>
			<tr>
				<td>비밀번호<font color="red">&nbsp;*</font></td>
				<td>
					<div style="width:30%; float:left; margin-right:10px;">
						<input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요."/>
					</div>
					&nbsp;(영문대소문자/숫자 4~20자)
				</td>
			</tr>
			<tr>
				<td>비밀번호 확인<font color="red">&nbsp;*</font></td>
				<td>
					<div style="width:30%;">
						<input type="password" class="form-control" id="pwdCheck" name="pwdCheck" placeholder="비밀번호를 다시 입력하세요."/>
					</div>
				</td>
			</tr>
			<tr>
				<td>이름<font color="red">&nbsp;*</font></td>
				<td>
					<div style="width:30%; float:left; margin-right:10px;">
						<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요."/>
					</div>
					&nbsp;(한글/영문대소문자)
				</td>
			</tr>
			<tr>
				<td>주소<font color="red">&nbsp;*</font></td>
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
				<td>휴대전화<font color="red">&nbsp;*</font></td>
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
				<td>이메일<font color="red">&nbsp;*</font></td>
				<td style="height:68.5px;">
					<div class="input-group mb-3" style="width:40%; float:left;">
						<input type="text" class="form-control mr-2" oninput="emailCheck()" placeholder="Email을 입력하세요." id="email1" name="email1" required />
						<div class="input-group-append">
							<select name="email2" id="email2" class="custom-select mr-2" onchange="emailCheck()">
								<option value="naver.com" selected>naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="nate.com">nate.com</option>
								<option value="yahoo.com">yahoo.com</option>
							</select>
						</div>
					</div>
					<span id="email_none" style="display:inline-block;">&nbsp;&nbsp;<font color="red">이메일을 작성해주세요.</font></span>
					<span id="email_ok" style="display:none;">&nbsp;&nbsp;<font color="red">사용 가능한 이메일입니다.</font></span>
					<span id="email_already" style="display:none;">&nbsp;&nbsp;<font color="red">사용할 수 없습니다. 다른 이메일을 사용해주세요.</font></span>
				</td>
			</tr>
			</table>
			<table class="table table-bordered" style="margin-bottom:30px;">
			<tr>
				<td style="width:20%">성별</td>
				<td>
					<div class="form-group">
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="gender" value="남자">남자
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="gender" value="여자">여자
							</label>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td>
					<div class="form-inline">
						<input type="text" class="form-control" id="yy" name="yy" maxlength=4 style="width:10%;" placeholder="년(4자)"/>&nbsp;&nbsp;
						<div style="float:left; width:10%;">
							<select id="mm" name="mm" class="custom-select form-control" style="width:100%;">
								<option>월</option>
								<c:forEach var="i" begin="1" end="12">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
						</div>&nbsp;&nbsp;
						<input type="text" class="form-control" id="dd" name="dd" maxlength=2 style="width:10%;" placeholder="일"/>
					</div>
				</td>
			</tr>
			<tr>
				<td>메일 수신여부</td>
				<td>
					<span class="col pl-0"><input type="checkbox" name="mailCheck" id="mailCheck" /> 동의함</span><br/>
					쇼핑몰에서 제공하는 이벤트 소식을 MAIL을 통해 받으실 수 있습니다.
				</td>
			</tr>
		</table>
		이용약관 동의(필수)
		<div class="agreeArea" style="margin-bottom:30px;">
			<div class="agree mb-3">
			    <jsp:include page="/WEB-INF/views/include/agree1.jsp"/>
			</div>
			이용약관에 동의하십니까?<font color="red">&nbsp;*</font> <span class="col"><input type="checkbox" name="ck1" id="ck1" /> 동의함</span>
		</div>
		개인정보 수집 및 이용 동의(필수)
		<div class="agreeArea" style="margin-bottom:30px;">
			<div class="agree mb-3">
				<jsp:include page="/WEB-INF/views/include/agree2.jsp"/>
			</div>
			개인정보 수집 및 이용에 동의하십니까?<font color="red">&nbsp;*</font> <span class="col"><input type="checkbox" name="ck2" id="ck2" /> 동의함</span>
		</div>
		<div class="text-center" style="margin-bottom:100px;">
			<input type="button" value="회원가입" onclick="joinCheck()" class="btn btn-outline-dark" style="width:150px;"/>
			<input type="button" value="취소" onclick="location.href='${ctp}/'" class="btn btn-outline-dark" style="width:150px;"/>
		</div>
    	<input type="hidden" name="address" id="address">
    	<input type="hidden" name="tel" id="tel"/>
		<input type="hidden" name="email" id="email"/>
    	<input type="hidden" name="birthday" id="birthday">
    	<input type="hidden" name="midFlag" id="midFlag">
    	<input type="hidden" name="emailFlag" id="emailFlag">
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>