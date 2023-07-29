<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>messageBuplicationLogin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	'use strict';
  	let chk = confirm("기존 로그인된 유저를 로그아웃 하시겠습니까?");
  	if(chk){
  		location.href="${ctp}/member/buplicationLoginDisconnect?sessionId=${dupliLoginSession}";
  	}
  	else location.href="${ctp}/";
  </script>
</head>
<body>
</body>
</html>