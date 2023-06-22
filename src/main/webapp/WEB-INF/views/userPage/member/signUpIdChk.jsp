<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>아이디중복체크페이지</title>
	<script>
	'use strict';
    
    // 아이디 사용 버튼
    function sendCheck() {
    	//부모창에 값 넣기
    	opener.window.document.myform.mid.value = '${mid}';
    	$(opener.document).find("#pwd").focus();
    	
    	// 중복 확인 상태창
    	$(opener.document).find("#dupulMid").css("display","inline");
    	window.close();
    }
    
    function idCheck() {
    	let mid = childForm.mid.value;
    	
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요!");
    		childForm.mid.focus();
    	}
    	else {
    		childForm.submit();
    	}
    }
    
    jQuery(function(){
    	if(${res} == 1){
    		$("#mid").val("${param.mid}");
    	}
    	
    });
	
	</script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h3>아이디 중복 확인</h3>
  <form name="childForm">
	  <c:if test="${res == 1}">
	    <h4><font color="blue"><b>${mid}</b>는 사용 가능합니다.</font></h4>
	    <p>
	    	<input type="text" name="mid" id="mid"/>
	    	<input type="button" value="아이디 사용" onclick="sendCheck()" class="btn btn-success btn-sm"/>
	    	<input type="button" value="아이디 재검색" onclick="idCheck()" class="btn btn-primary btn-sm"/>
	    	<input type="button" value="창닫기" onclick="window.close()" class="btn btn-secondary btn-sm"/>
	    </p>
	  </c:if>
	  <c:if test="${res != 1}">
	    <h4><font color="red"><b>${mid}</b>는 이미 사용중인 아이디입니다.</font></h4>
	    	<p>
	    	  <input type="text" name="mid"/>
	    	  <input type="button" value="아이디 재검색" onclick="idCheck()" class="btn btn-success btn-sm"/>
	    	  <input type="button" value="창닫기" onclick="window.close()" class="btn btn-secondary btn-sm"/>
	    	</p>
	  </c:if>
  </form>
</div>
<p><br/></p>
</body>
</html>