<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>로그인페이지</title>
</head>
<body id="wrapper">
<p><br/></p>
<div class="container">
	 <div class="modal-dialog">
	  <div class="modal-content p-4">
		  <h2 class="text-center">회원 로그인</h2>
		  <p class="text-center">(회원 아이디와 비밀번호를 입력해 주세요)</p>
		  
		  <form name="myform" method="post" class="was-validated">
		    <div class="form-group">
		      <label for="mid">회원 아이디</label>
		      <input type="text" class="form-control" name="mid" id="mid" value="${cMid}" placeholder="Enter ID" required autofocus />
		      <div class="valid-feedback">Ok!!!</div>
		    </div>
		    <div class="form-group">
		      <label for="pwd">비밀번호</label>
		      <input type="password" class="form-control" name="pwd" id="pwd" placeholder="Enter Password" required />
		      <div class="valid-feedback">Ok!!!</div>
		    </div>
		    <div class="form-group text-center">
		    	<button type="submit" class="btn btn-primary mr-1">로그인</button>
		    	<button type="button" onclick="location.href='${ctp}/member/signUpPage';" class="btn btn-success">회원가입</button>
		    </div>
		    <div class="row text-center" style="font-size:12px">
		      <span class="col"><input type="checkbox" name="idSave" id="idSave" ${cIdSave=="on" ? "checked":""}/>아이디 저장</span>
		      <span class="col">
		        [<a href="${ctp}/member/idSearchPage" onclick="window.open(this.href,'nWin','width=580px,height=450px'); return false;">아이디찾기</a>] /
		        [<a href="${ctp}/member/pwdSearchPage" onclick="window.open(this.href,'nWin','width=580px,height=450px'); return false;">비밀번호찾기</a>]
		      </span>
		    </div>
		  </form>
	  </div>
  </div>
</div>
<p><br/></p>
</body>
</html>