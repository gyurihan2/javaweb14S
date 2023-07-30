<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>title</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<p><br/></P>
<div class="container">
  <h2> 현재 제공되지 않는 페이지 입니다. (404 에러)</h2>
  <div class="d-flex justify-content-center mt-2">
  	<img src="${ctp}/emoticon/imageReady.gif">
  </div>
  <div class="d-flex justify-content-end"><a href="${ctp}" class="btn btn-success">돌아가기</a></div>
  
</div>
<p><br/></P>
</body>
</html>