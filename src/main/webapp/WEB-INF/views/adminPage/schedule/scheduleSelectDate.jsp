<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>상세 일정</title>
  <script>
  	'use strict';
  	let scheduleArr=[];
		if(${!empty jsonData}) scheduleArr = ${jsonData};
		console.log(scheduleArr);
		let today = new Date();
		let selectDate= new Date("${param.selectDate}");
		
		
		let temp='';
		for(let i=0; i<scheduleArr.length;i++){
			temp +='<div class="row text-center">';
			temp +='<div class="col">'+scheduleArr[i].theaterName+'('+scheduleArr[i].movieTitle+')'+'</div>';
			temp +='</div>';
			temp +='<div class="d-flex flex-row justify-content-evenly align-items-center">';
			temp +='<div><img src="https://image.tmdb.org/t/p/w500'+scheduleArr[i].main_poster+'" width="180px"></div>';
			temp +='<div class="d-flex flex-column" style="width: 100%">';
			temp +='<div class="d-flex justify-content-around">';
			temp +='<div>회차</div>';
			temp +='<div>시작 시간</div>';
			temp +='<div>종료 시간</div>';
			temp +='<div>남은 좌석수</div>';
			temp +='<div>상태</div>';
			temp +='</div>';
			
			
			
			for(let j=0;j<scheduleArr[i].playTime.length;j++){
				temp +='<div class="d-flex justify-content-around">';
				temp +='<div>'+(j+1)+' 회차</div>';
				temp +='<div>'+scheduleArr[i].playTime[j]+'</div>';
				temp +='<div>'+scheduleArr[i].endTime[j]+'</div>';
				temp +='<div>'+scheduleArr[i].leftSeat[j]+'</div>';
				
				if(today.getFullYear() == selectDate.getFullYear() &&today.getMonth() == selectDate.getMonth() 
						&&today.getDate() == selectDate.getDate()){
					let todayMs = today.getTime();
					let startMs = new Date(selectDate.getFullYear()+"-"+(selectDate.getMonth()+1)+"-"+selectDate.getDate()+" "+scheduleArr[i].playTime[j]);
					let endMs = new Date(selectDate.getFullYear()+"-"+(selectDate.getMonth()+1)+"-"+selectDate.getDate()+" "+scheduleArr[i].endTime[j]);
					
					if(todayMs > startMs.getTime() && todayMs<endMs.getTime()) temp +='<div><font color="#3CB371"><b>상영중</b></font></div>';
					else if(todayMs < startMs.getTime())temp +='<div><font color="#C9BC46"><b>상영 대기중</b></font></div>';
					else if(todayMs > startMs.getTime()) temp +='<div><font color="#DF6464"><b>상영 종료</b></font></div>';
				}
				else if(today < selectDate){
					temp +='<div><font color="#DF6464"><b>상영 준비중</b></font></div>';
				}
				else{
					temp +='<div><font color="#C9BC46"><b>상영 완료</b></font></div>';
				}
				temp +='</div>';
			}
			temp +='</div></div>';
		}
		
		
		$(function(){
			
			$("#test").html(temp);
		})
		
		
  </script>
</head>
<body>
	<h4 class="text-center">${param.selectDate} 일정</h4>
	<hr/>
	<div class="container">
<!-- 		<div class="row text-center">
			<div class="col">1상영관(제목)</div>
		</div>
		<div class="d-flex flex-row justify-content-evenly align-items-center">
			<div><img src="https://image.tmdb.org/t/p/w500/nQsWPG020kSWdOl3EhFXRNE2s0n.jpg" width="180px"></div>
			<div class="d-flex flex-column" style="width: 100%">
				<div class="d-flex justify-content-around">
					<div>회차</div>
					<div>시작 시간</div>
					<div>남은 좌석수</div>
					<div>상태</div>
				</div>
				<div>1</div>
				<div>1</div>
				<div>1</div>
				<div>1</div>
				<div>1</div>
				<div>1</div>
			</div>
		</div> -->

		<div id="test"></div>
	</div>
<p><br/></P>
</body>
</html>