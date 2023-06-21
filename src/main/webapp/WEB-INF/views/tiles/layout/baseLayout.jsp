<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <!-- <title>baseLayout</title> -->
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
  html {
    margin:0;
    padding:0;
    height:100%;
	}
	#wrapper {
		position:relative;
		min-height:100%;
	}
  </style>
</head>
<body>
<tiles:insertAttribute name="header"/>
<p><br/></P>
<tiles:insertAttribute name="body"/>
<p><br/></P>
<p><br/></p>
<tiles:insertAttribute name="footer"/>
</body>
</html>