<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>error500</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<p><br/></P>
<div class="container">
  <h2>현재 시스템 사정상 서비스가 중단 되었습니다. (500 에러:서버 트래픽 과부하, Timeout, 구문오류)</h2>
  <div class="d-flex justify-content-center mt-2">
  	<img src="${ctp}/emoticon/imageReady.gif">
  </div>
  <div class="d-flex justify-content-end"><a href="${ctp}" class="btn btn-success">돌아가기</a></div>
</div>
<p><br/></P>
</body>
</html>