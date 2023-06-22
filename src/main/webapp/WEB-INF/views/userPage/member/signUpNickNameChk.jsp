<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>닉네임중복체크페이지</title>
	<script>
	'use strict';
    
    // 닉네임 사용 버튼
    function sendCheck() {
    	//부모창에 값 넣기
    	opener.window.document.myform.nickName.value = '${nickName}';
    	$(opener.document).find("#name").focus();
    	
    	// 중복 확인 상태창
    	$(opener.document).find("#dupulNickName").css("display","inline");
    	window.close();
    }
    
    function nickNameCheck() {
    	let nickName = childForm.nickName.value;
    	
    	if(nickName.trim() == "") {
    		alert("닉네임를 입력하세요!");
    		childForm.nickName.focus();
    	}
    	else {
    		childForm.submit();
    	}
    }
    
    jQuery(function(){
    	if(${res} == 1){
    		$("#nickName").val("${param.nickName}");
    	}
    	
    });
	
	</script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h3>닉네임 체크폼</h3>
  <form name="childForm">
	  <c:if test="${res == 1}">
	    <h4><font color="blue"><b>${nickName}</b>는 사용 가능합니다.</font></h4>
	    <p>
	    	<input type="text" name="nickName" id="nickName"/>
	    	<input type="button" value="닉네임 사용" onclick="sendCheck()" class="btn btn-success btn-sm"/>
	    	<input type="button" value="닉네임 재검색" onclick="nickNameCheck()" class="btn btn-primary btn-sm"/>
	    	<input type="button" value="창닫기" onclick="window.close()" class="btn btn-secondary btn-sm"/>
	    </p>
	  </c:if>
	  <c:if test="${res != 1}">
	    <h4><font color="red"><b>${nickName}</b>는 이미 사용중인 닉네임입니다.</font></h4>
	    	<p>
	    	  <input type="text" name="nickName" id="nickName"/>
	    	  <input type="button" value="아이디 재검색" onclick="nickNameCheck()" class="btn btn-success btn-sm"/>
	    	  <input type="button" value="창닫기" onclick="window.close()" class="btn btn-secondary btn-sm"/>
	    	</p>
	  </c:if>
  </form>
</div>
<p><br/></p>
</body>
</html>