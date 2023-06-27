<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<script>
	'use strict';
	function changePwd() {
		let pwd1 = $("#pwd1").val();
		let pwd2 = $("#pwd2").val();
		
		if(!regPwd(pwd1)){
			alert("비밀번는 최소 5자이상(특수문자 하나이상 포함)")
			$("#pwd1").focus();
			return false
		}
		else if(pwd1 != pwd2){
			alert("비밀번호가 일치하지 않습니다.");
			$("#pwd2").focus();
			return false
		}
		
		myform.submit();

	}
	
	function regPwd(pwd){
	    const regExp =  /^(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{5,20}/g;

	    if(!regExp.test(pwd)) return false;
	    return true; 
	}
</script>
</head>
<body>
<div class="container">
  <div class="modal-dialog">
	  <div class="modal-content p-4">
		  <h2 class="text-center"> 비밀번호 변경</h2>
		  <p class="text-center">(${param.mid}님 변경할 비밀번호를 입력해 주세요)</p>
		  <form name="myform" method="post">
		    <div class="input-group mt-2">
	      <div class="input-group-prepend">
	      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>비밀번호</b></span>
	      </div>
	      <input type="password" class="form-control" id="pwd1" name="pwd1" placeholder="비밀번호를 입력하세요."  required autofocus />
	    </div>
		    <div class="input-group mt-2 mb-4">
		      <div class="input-group-prepend">
		      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>비밀번호<br/>확인</b></span>
		      </div>
        	<input type="password" class="form-control mr-1"  id="pwd2" name="pwd2" required/>
	    	</div>
		    <div class="form-group text-center mt-2">
		    	<button type="button" class="btn btn-primary mr-1" onclick="changePwd()">변경하기</button>
		    </div>
		  </form>
	  </div>
  </div>
</div>
</body>
</html>