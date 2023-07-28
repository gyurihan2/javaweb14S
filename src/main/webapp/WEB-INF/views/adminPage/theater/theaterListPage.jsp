<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>상영관 조회</title>
  <style>
  	.scrollerContet{
    	overflow-y: scroll;
    }
    .scrollerContet::-webkit-scrollbar {
      width: 15px;
    }
    .scrollerContet::-webkit-scrollbar-track {
      background-color: transparent;
    }
  </style>
  <script>
  	'use strict';
  	
  	function selectTheater(index){
  		let theaterArr = Object.values(${jsonStr});
  		opener.document.getElementById("theater").value = theaterArr[index].name;
  		opener.document.getElementById("theaterIdx").value = theaterArr[index].idx;
  		opener.document.getElementById("leftSeat").value = theaterArr[index].seat;
  		window.close();
  	}
  </script>
</head>
<body>
<h4>사용 가능한 상영관</h4>
<div class="d-flex flex-column text-center" style=" width:730px; margin: auto;">
	<c:if test="${!empty vos}">
		<div class="row mb-2 ">
			<div class="col"><b>상 영 관 코 드</b></div>
			<div class="col"><b>상 영 관 명</b></div>
			<div class="col"><b>테 마</b></div>
			<div class="col"><b>좌 석 수</b></div>
			<div class="col"><b>상 태</b></div>
			<div class="col"><b>비 고</b></div>
		</div>
		<div class="scrollerContet" style="height: 300px">
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<div class="row ">
					<div class="col">${vo.idx}</div>
					<div class="col">${vo.name}</div>
					<div class="col">${vo.themaName}</div>
					<div class="col">${vo.seat}</div>
					<div class="col">
						<c:if test="${vo.work == 1}">사 용 가 능</c:if>
						<c:if test="${vo.work == 2}">점 검 중</c:if>
						<c:if test="${vo.work == 3}">중 지</c:if>
						<c:if test="${vo.work == 4}">차 단</c:if>
					</div>
					<div class="col">
						<c:if test="${vo.work != 4}">
							<button type="button" class="btn btn-sm btn-info" onclick="selectTheater(${st.index})">선택</button>
						</c:if>
						<c:if test="${vo.work == 4}"><font color="red">선택 불가</font></c:if>
					</div>
				</div>
				<hr/>
			</c:forEach>
		</div>
	</c:if>
</div>
<p><br/></P>
</body>
</html>