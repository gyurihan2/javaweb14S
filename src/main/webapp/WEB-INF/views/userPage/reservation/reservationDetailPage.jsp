<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>예약 상세 보기</title>
</head>
<body>
<h4>예약 상세 보기</h4>
<div class="myPage-info d-flex flex-column" >
	<div class="d-flex align-items-center m-2" >
		<img src="https://image.tmdb.org/t/p/w500${vo.moviePoster}" width="135px" height="135px"/>
		<div class="ml-5 d-flex flex-column">
			<div><h5>${vo.movieName}(${vo.theaterName} : ${vo.themaName})</h5></div>
			<div>시작 시간: ${vo.playTime} 종료시간: ${vo.endTime}</div>
			<div>좌석 정보:${vo.seatInfo} (어른:${vo.adultCnt} / 어린이:${vo.childCnt})</div>
		</div>
	</div>
</div>

<p><br/></P>
</body>
</html>