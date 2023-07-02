<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<style>
	
	</style>
	
</head>
<jsp:include page="/WEB-INF/views/include/userPage/homepageScript.jsp"/>
<body >
<div class="container" id="wrapper">
	<h1>
		Hello world! test
	</h1>
	<P>  The time on the server is ${serverTime}. </P>
	<table class="table table-hover">
		<tr class="text-dark table-dark">
			<th>1</th>
			<th>2</th>
			<th>3</th>
			<th>4</th>
			<th>5</th>
		</tr>
	</table>
</div>
</body>
</html>
