<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
  <title>예약 페이지</title>
  <style>
		.material-symbols-outlined {
			color:#E2E2E2;
			background-color:#434343;
			font-size:70px;
			vertical-align:middle;
		  font-variation-settings:
		  'FILL' 0,
		  'wght' 400,
		  'GRAD' 0,
		  'opsz' 48
		}
</style>
  
</head>
<body>
<p><br/></P>
<div class="container-xl text-center  p-0" style="width:1010px;height: 500px; background-color: #FBF8EE">
  <div class="d-flex justify-content-start" style="height: 100%">
  	<div class="d-flex flex-column">
  		<div class=" ml-1" style="width: 200px;  background-color: #333333"><font color="#E2E2E2">날짜</font></div>
  		<c:forEach var="vo" items="${dateVOS}">
  			<div><button class="btn btn-outline-dark" type="button" onclick="">${vo}</button></div>
  		</c:forEach>
  	</div>
  	<div class="d-flex flex-column">
  		<div class=" ml-1" style="width: 400px;  background-color: #333333"><font color="#E2E2E2">영화</font></div>
  		<div>하하하하</div>
  	</div>
  	<div class="d-flex flex-column">
  		<div class=" ml-1" style="width: 400px;  background-color: #333333"><font color="#E2E2E2">시간</font></div>
  		<div>하하하하</div>
  	</div>
  </div>
</div>
<div style="background-color: #1D1D1C; height: 150px">
	<div class="container-xl text-center d-flex justify-content-start p-0" style="width:1010px; height: 100%">
		<div class="d-flex flex-column " style="width: 140px;  height:100%;">
  		<div class="mt-4" >
				<button class="p-0 ml-2 text-center" type="button" style="border: 1px solid #E2E2E2; ">
					<span class="material-symbols-outlined">arrow_back_ios</span>
				</button>
  		</div>
  	</div>
		<div class="d-flex align-items-center" style="width: 200px; height:100%; background-color: #333333">
  		<div class=" ml-1" ><font color="#E2E2E2">영화이미지</font></div>
  		<div>영화제목</div>
  	</div>
		<div class="d-flex flex-column">
  		<div class="" style="width: 500px;  background-color: #333333"><font color="#E2E2E2">날짜</font></div>
  		<div>하하하하</div>
  	</div>
  	<div class="d-flex flex-column">
  		<div class=" ml-1" style="width: 140px;  background-color: #333333"><font color="#E2E2E2">날짜</font></div>
  		<div>하하하하</div>
  	</div>
	</div>
</div>
<p><br/></P>
</body>
</html>