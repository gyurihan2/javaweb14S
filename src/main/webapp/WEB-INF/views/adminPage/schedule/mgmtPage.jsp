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
		document.addEventListener('DOMContentLoaded', function() {
		    var calendarEl = document.getElementById('calendar');
		    calendar = new FullCalendar.Calendar(calendarEl, {
		    	customButtons:{
		    		mydataButton:{
		    			text:'test',
		    			//icon:'chevron-left',
		    			//bootstrapFontAwesome:'fa-solid fa-car',
		    			click:function(){
		    				alert("하하하");
		    				//calendar.prev();
		    				//calendar.next();
		    				
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
	        		left: "title mydataButton",
	            center: 'prev today next',
	            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
          },
          eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
              console.log(obj);
          },
          eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
            console.log(obj);
          },
          eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
            console.log(obj);
          },
          select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
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
          },
	        events: [
        		{	
          		idx: 0, // extendedProps.idx 접근 가능
          		aaa: "1111",
              title: '첫번째 일정',
              start: '2023-07-02',
              classNames: [ 'classAddtest' ], // event 영역 class 추가
              backgroundColor: 'red',
              borderColor: 'red',
              textColor: 'black',
          	},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
							idx:"test",
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
        		{
          		title: '두번째 일정',
              start: '2023-07-15',
              end: '2023-07-28',
						},
	          {
          		title: '페이지 이동 이벤트 호출',
              url: 'https://naver.com',
              start: '2023-07-01',
						},
					], // 이벤트
	       eventClick: function(info) {
	        	console.log(info);
	        	alert('Event info : ' + JSON.stringify(info.event));
	        	info.event.remove();
	          	
          	// url 커스텀 이동
            info.jsEvent.preventDefault(); // 클릭이벤트 후처리 방지

          	if (info.event.url) {
            	window.open("https://fullcalendar.io/docs/eventClick");
					}
				}, // 일정 이벤트 클릭 이벤트 callback
			});
			calendar.render();
		});
		
		$(function(){
			 // 왼쪽 버튼을 클릭하였을 경우
		      $(".fc-prev-button").click(function() {
		          var date = jQuery("#calendar").fullCalendar("getDate");
		          //convertDate(date);
		          console.log(date)
		      });
		});
		
	</script>
</head>
<body id="wrapper">
	<div class="mb-5" id="top_title">
		<h4 class="m-1 p-0"><b>스케줄 관리</b></h4>
	</div>
		<div id='calendar-container'>
		<div id='calendar'></div>    
	</div>
<p><br/></p>
</body>
</html>