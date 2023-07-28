<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>관리자 메인 페이지</title>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script>
	 google.charts.load('current', {'packages':['line']});
     google.charts.setOnLoadCallback(drawChart);

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
          title: '예약 건수',
        },
        width: 550,
        height: 350,
      };

     var chart = new google.charts.Line(document.getElementById('linechart_material'));

     chart.draw(data, google.charts.Line.convertOptions(options));
   }
	</script>
</head>
<body>
<%-- <jsp:include page="/include/header.jsp"/> --%>
<p><br/></p>
<body id="wrapper">
	
<div class="content">
  - 메인 페이지 : 요약 내용(금일 영화관 시간표/ 총 예약수 / 총 매출 / 신규 가입 / 탈퇴 신청 ....)<br/>
  - 상영관 관리 : 현재 상영중인 각 상영관 별로 표시 , 상영관 ON/OFF, <br/>
  - 영화관 일정 관리: 영화일정 달력에 표시, 달력 클릭시(일) 일정 등록 및 수정 삭제(모달창), <br/>
  - 영화 관리: 현재 상영중인 영화정보 출력, 영화 신규 등록, 수정, 삭제, 등록된 영화 확인(모달창) <br/>
  - 회원 관리: 회원 목록표시, 회원 정보 확인, 회원 탈퇴 신청 확인(30일 이후 삭제 처리), 회원 블랙 아웃 처리, <br/>
  - 예약 현황: 금일 예약 현황 표시, 날짜 지정시 예약현황 확인, <br/>
  - 매출 현황: 현재 기준 달의 매출 표시, 금일 매출 표시, 날짜 지정 시 매출 확인,  <br/>
</div>
<div class="d-flex flex-row">
	<div class="content" style="width: 700px; height: 400px" ></div>
	<div class="content ml-5" style="width: 700px; height: 400px">
		<div id="linechart_material"></div>
	</div>
</div>
   
</body>
<p><br/></p>
</body>
</html>