<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>messageCloseChk.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	'use strict';
  	let msg = "${msg}";
  	let url = "${ctp}${url}";
  	
  	let chk = confirm(msg+"\n 계속 진행 하시겠습니까?");
  	if(chk){
  		location.href=url;
  	}
  	else window.close();
  </script>
</head>
<body>
<p><br/></P>
<div class="container">
  
</div>
<p><br/></P>
</body>
</html>