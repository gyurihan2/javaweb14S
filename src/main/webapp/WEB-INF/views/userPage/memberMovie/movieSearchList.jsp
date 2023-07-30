<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>영화 리스트</title>
 <style>
  .star {
		position: relative;
		font-size: 20px;
		color: #ddd;
	}
	.star span {
		width: 0;
		position: absolute;
		left: 0;
		color:  #ffd400;
		overflow: hidden;
		pointer-events: none;
	}
	.moviePoster{
		cursor:pointer
	}
</style>
<script>
	'use strict';
	
	function movieDetail(idx){
		location.href="${ctp}/memberMovie/movieDetail?idx="+idx;
	}
</script>
</head>
<body id="wrapper">
<div class="container-xl" style="width: 1300px">
	<h3 class="ml-3 mt-4">검색 영화 리스트</h3>
	<hr/>
  <c:if test="${!empty vos }">
  	<div class="row">
	  	<c:forEach var="vo" items="${vos}">
	  		<div class="ml-4 mb-5" style="width:200px;">
	  			<div class="d-flex flex-column justify-content-center">
		  			<img src="https://image.tmdb.org/t/p/w500${vo.main_poster}" class="moviePoster" onclick="movieDetail('${vo.idx}')" width="197px" height="260px;" style="margin: auto;"/>
		  			<div class="text-center">
		  				<c:if test="${fn:length(vo.title) > 8  }">
		  					<c:set var="temp" value="${fn:substring(vo.title,0,8)}"/>
			  				<font size="2.5em"><strong>${temp}...</strong></font>
		  				</c:if>
		  				<c:if test="${fn:length(vo.title) <= 6 }">
			  				<font size="2.5em"><strong>${vo.title}</strong></font>
		  				</c:if>
	  				</div>
	  				<c:set var="average" value="${fn:substring(vo.vote_average,0,3)}"/>
	  				<c:set var="averageArr" value="${fn:split(vo.vote_average,'.')}"/>
  					<div class="d-flex flex-row align-items-center justify-content-center">
							<span class="star">★★★★★
								<c:if test="${average-averageArr[0]+0.5 >= 1 }">
			        		<span style="width:${((averageArr[0]-1)*10)+10}%">★★★★★</span>
								</c:if>
								<c:if test="${average-averageArr[0]+0.5 < 1 }">
			        		<span style="width:${((averageArr[0]-1)*10)}%">★★★★★</span>
								</c:if>
	    				</span>
	    				<span><font size="1.3em">(${average}/${vo.vote_count}명)</font></span>
  					</div>
  					<div class="text-center"><font size="2em">${vo.release_date} 개봉</font></div>
	  			</div>
  			</div>
	  	</c:forEach>
  	</div>
  </c:if>
  <c:if test="${empty vos }">
  	<h3 class="text-center mt-5">검색 결과가 없습니다....</h3>
  </c:if>
</div>
<p><br/></P>
</body>
</html>