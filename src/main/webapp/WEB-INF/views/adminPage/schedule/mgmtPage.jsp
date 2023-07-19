<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="${ctp}/js/apiKey.js"></script>
	<script src="${ctp}/fullcalendar/dist/index.global.js"></script>
	<title>상영 일정 관리 페이지</title>
	<style>
		/* 일요일 날짜 빨간색 */
		.fc-day-sun a {
		  color: red;
		  text-decoration: none;
		}
		
		/* 토요일 날짜 파란색 */
		.fc-day-sat a {
		  color: blue;
		  text-decoration: none;
		}
	</style>
	<script>
		'use strict';
		let calendar;
		let scheduleArr=[];
		let colorList=["#A0D468","#D9D951","#87CEFA","#E6E6FA","#FA8072","#F0E68C","#E0FFFF","#E6E6FA","#696969","#FFEBCD"];
		let data=[];
		if(${!empty jsonData}) scheduleArr=${jsonData};
		
		if(scheduleArr.length > 0){
			let colorCnt=0;
			scheduleArr.forEach(function(schedule) {
				let tempDate = schedule.groupId.split("_")
				let endDate = new Date(tempDate[3]);
				
				// 시간 설정을 하지않아 00:00시에 종료 -> 일정 + 1일 하여 화면에 표시 
				endDate.setDate(endDate.getDate()+1);
				
		    data.push({
		    	title:schedule.theaterName+":"+schedule.movieTitle+"("+tempDate[2]+"~"+tempDate[3]+")",
		    	groupId:schedule.groupId,
		    	start:tempDate[2],
		    	end:endDate.getFullYear()+"-"+("0"+(endDate.getMonth()+1)).slice(-2)+"-"+("0"+endDate.getDate()).slice(-2),
		    	backgroundColor: colorList[colorCnt++]
		    })
			});
		} 
		
	
		
		// 이전/다음달 이동을 위한 날짜
		let date= new Date();
		
		// 일정 추가
		function scheduleAdd(startDate,endDate){
			let url="${ctp}/schedule/scheduleInputPage?startDate="+startDate+"&endDate="+endDate;
			window.open(url,"n_win","width=800,height=600");
		}
	
		
		document.addEventListener('DOMContentLoaded', function() {
		    var calendarEl = document.getElementById('calendar');
		    calendar = new FullCalendar.Calendar(calendarEl, {
		    	customButtons:{
		    		prevButton:{
		    			text:'이전달',
		    			icon:'chevron-left',
		    			click:function(){
		    				calendar.prev();
		    			}
		    		},
		    		nextButton:{
		    			text:'다음달',
		    			icon:'chevron-right',
		    			click:function(){
		    				calendar.next();
		    			}
		    		}
		   
		    	},
		    	initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면 (기본 설정: 달)
		    	navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
		    	editable: true,
		    	selectable: true,
		    	nowIndicator: true,
		    	dayMaxEvents: true,	
	        locale: 'ko', // 한국어 설정
	        expandRows: true, // 화면에 맞게 높이 재설정
	        height: '800px', // calendar 높이 설정
	        headerToolbar: {
	        		left: "title",
	            center: 'prevButton today nextButton',
	            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
          },
          /* select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
              var title = prompt('Event Title:');
              if (title) {
                calendar.addEvent({
                  title: title,
                  start: arg.start,
                  end: arg.end,
                  allDay: arg.allDay
                })
              }
              calendar.unselect()
          }, */
					events: data,
					eventClick: function(info) { // 일정 이벤트 클릭 이벤트 삭제 처리
							let groupId = info.event._def.groupId;
							let title = info.event._def.title;
							
							if(!confirm(title+"\n일정을 삭제하시겠습니까?")) return false;
							
							
					  	$.ajax({
					  		type:"post",
					  		url:"${ctp}/schedule/scheduleDelete",
					  		data:{groupId:groupId},
					  		success:function(res){
					  			if(res == 0) alert("일정 삭제 실패");
					  			else{
						  			alert("일정 삭제 완료");
						  			info.event.remove();
					  			}
					  		},
					  		error:function(){
					  			alert("전송 실패");
					  		}
					  	});
					  	
					}, 
					navLinkDayClick: function(date,jsEvent){ //일정 일 클릭시 
						let selectDate = date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0"+date.getDate()).slice(-2);
		    		let url = "${ctp}/schedule/scheduleSelectDate?selectDate="+selectDate;
		    		window.open(url,"n_win","width=800,height=600");
					}
					
			});
			calendar.render();
			date=calendar.getDate();
		});
		
		
		
	</script>
</head>
<body id="wrapper">
	<div class="mb-5" id="top_title">
		<h4 class="m-1 p-0"><b>스케줄 관리</b></h4>
	</div>
		<div id='calendar-container'>
			<div class="d-flex justify-content-end">
				<button type="button" class="btn btn-sm btn-success" onclick="scheduleAdd()">일정 추가</button>
			</div>
			<div id='calendar'></div>    
		</div>
<p><br/></p>
</body>
</html>