<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>관리자 메인 페이지</title>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<style>
	.contentScroll{
  		overflow-y: scroll;
		}
    .contentScroll::-webkit-scrollbar {
      width: 15px;
    }
    .contentScroll::-webkit-scrollbar-track {
      background-color: transparent;
    }
	</style>
	<script>
	 google.charts.load('current', {'packages':['line']});
   google.charts.setOnLoadCallback(drawChart);

   var chartDateformat 	= 'yyyy년MM월dd일';
   function drawChart() {

     var data = new google.visualization.DataTable();
     data.addColumn('datetime', 'Day');
     data.addColumn('number', '예약 건수');

     data.addRows([
  	 	<c:forEach var="vo" items="${weekReserVOS}">
  	  [new Date("${vo.day}"), ${vo.cnt}],
  		</c:forEach>
     ]);

     var options = {
        chart: {
          title: '${weekReserVOS[0].day} ~ ${weekReserVOS[6].day}',
        },
        focusTarget : 'category',
        width: 400,
        height: 350
      };

     var chart = new google.charts.Line(document.getElementById('linechart_material'));

     chart.draw(data, google.charts.Line.convertOptions(options));
   }
   
   
   
   ////////////////////////
    google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart2);
      function drawChart2() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          <c:forEach var="vo" items="${reserStaticVOS}">
          	[
        		<c:if test="${fn:length(vo.movieTitle) > 10}">"${fn:substring(vo.movieTitle,0,10)}.."</c:if>
          	<c:if test="${fn:length(vo.movieTitle) <= 10}">"${vo.movieTitle}"</c:if>
          	,${vo.cnt}],
          </c:forEach>
        ]);

        var options = {
          title: '상영 중인 영화 예약 비율',
          pieHole: 0.4,
          width: 450,
          height: 350
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
   
	</script>
</head>
<body>
<%-- <jsp:include page="/include/header.jsp"/> --%>
<p><br/></p>
<body id="wrapper">
<div class="d-flex flex-row justify-content-center">
	<div class="content p-4 text-center" style="width: 700px; height: 400px" >
		<div class="row mt-1">
			<div class="col-3"><b>상영관</b></div>
			<div class="col-4"><b>상영관 상태</b></div>
			<div class="col"><b>상영중인 영화</b></div>
		</div>
		<hr/>
		<div class="contentScroll" style="height: 300px;">
			<c:if test="${!empty scheduleVOS}">
			<c:forEach var="vo" items="${scheduleVOS}">
				<div class="row mb-2">
					<div class="col-3">${vo.theaterName}</div>
				  <c:choose>
	       		<c:when test = "${vo.theaterWork == 1}">
		            <div class="col-4"><font color="#3CB371">정 상</font></div>
		        </c:when>
	       		<c:when test = "${vo.theaterWork == 2}">
		            <div class="col-4"><font color="#DEB887">임 시 중 단</font></div>
		        </c:when>
	       		<c:when test = "${vo.theaterWork == 3}">
		            <div class="col-4"><font color="#FFE71A">정 지</font></div>
		        </c:when>
	       		<c:when test = "${vo.theaterWork == 4}">
		            <div class="col-4"><font color="#DF6464">차 단</font></div>
		        </c:when>
    			</c:choose>
					<c:if test="${fn:length(vo.movieTitle) > 13 }">
						<div class="col">${fn:substring(vo.movieTitle,0,13)}..</div>
					</c:if>
					<c:if test="${fn:length(vo.movieTitle) <= 13 }">
						<div class="col">${vo.movieTitle}</div>
					</c:if>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${empty scheduleVOS}">
			<div> 상영중인 영화가 없습니다.(일정을 등록하세요)</div>
		</c:if>
		</div>
	</div>
	<div class="content ml-5 d-flex justify-content-center align-items-center" style="width: 900px; height: 400px">
		<div id="donutchart"></div>
		<div class="mt-3" id="linechart_material"></div>
	</div>
</div>
<div class="d-flex flex-row justify-content-center">
	
</div>
   
</body>
<p><br/></p>
</body>
</html>