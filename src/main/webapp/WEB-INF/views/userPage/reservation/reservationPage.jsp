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
		.material-symbols-outlined{
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
		.divHover:hover{
			background:#cdcdcd;
			cursor: pointer;
		}
		
		.clickAction{
			background:#cdcdcd;
		}
</style>
<script>
	'use strict';
	
	let today = new Date();
	let selectedDate;
	let scheduleArr=[];
	let dataIndex;
	
	function selectDate(obj,date,index){
		console.log(date.substring(0,10));
		selectedDate = new Date(date.substring(0,10));
		dataIndex=index;
		
		$('.selectDateList').removeClass("clickAction");
		obj.className += ' clickAction';
		
		$.ajax({
			type:"post",
			url:"${ctp}/schedule/scheduleSelectDate",
			data:{selectDate:date.substring(0,10)},
			success:function(res){
				let temp='';
				
				if(res == "") temp="상영 일정이 없습니다.";
				else{
					scheduleArr= JSON.parse(res);
					console.log(scheduleArr);
					
					for(let i=0; i<scheduleArr.length;i++){
						temp+='<div class="divHover selectMovieList" onclick="selectMovie(this,'+i+')">';
						temp+= "("+scheduleArr[i].themaName+":"+scheduleArr[i].theaterName+")"+scheduleArr[i].movieTitle;
						temp+="</div>";
					}
				}
				
				// 초기화
				$("#reserTheater").html("");
				$("#reserMovie").html("");
				$("#reserTime").html("");
				$("#main_poster").removeAttr("src");
				
				$("#theaterIdx").val("");
				$("#movieIdx").val("");
				$("#movieTitle").val("");
				$("#screenOrder").val("");
				$("#playTime").val("");
				
				// 화면 표시
				$("#screenOrderContent").fadeOut('slow');
				$("#movieSelectContent").css("display","none");
				$("#movieSelectContent").html(temp);
				$("#movieSelectContent").fadeIn('slow');
				$("#reserDate").html(date);
				
				$("#playDate").val(date.substring(0,10));
			},
			error:function(){
				alert("전송실패");
			}
		});
	}
	
	// 영화 선택시 
	function selectMovie(obj,arrIndex){
		$('.selectMovieList').removeClass("clickAction");
		obj.className += ' clickAction';
		
		let temp='';
		for(let i=0; i<scheduleArr[arrIndex].screenOrder.length;i++){
			
			if(dataIndex == 0){
				let todayMs = today.getTime();
				let startMs = new Date(selectedDate.getFullYear()+"-"+(selectedDate.getMonth()+1)+"-"+selectedDate.getDate()+" "+scheduleArr[arrIndex].playTime[i]);
				let endMs = new Date(selectedDate.getFullYear()+"-"+(selectedDate.getMonth()+1)+"-"+selectedDate.getDate()+" "+scheduleArr[arrIndex].endTime[i]);
				
				if(todayMs > startMs.getTime() && todayMs<endMs.getTime()){
					temp+='<div onclick="alert(\'이미 상영중인 영화 입니다.\')">';
					temp += (i+1)+"회 :"+scheduleArr[arrIndex].playTime[i].substring(0,5)+" (<font color='#C9BC46'>상영 중</font>)";
				}
				else if(todayMs < startMs.getTime()){
					temp+='<div class="divHover sreenOrderList" onclick="selectScreenOrder(this,'+arrIndex+','+i+')">';
					temp+= (i+1)+"회 :"+scheduleArr[arrIndex].playTime[i].substring(0,5)+" (<font color='#3CB371'>예약 가능</font> / 예약 가능 좌석 수:"+scheduleArr[arrIndex].leftSeat[i]+")";
				}
				else if(todayMs > startMs.getTime()){
					temp+='<div onclick="alert(\'상영 종료된 영화입니다.\')">';
					temp += (i+1)+"회 :"+scheduleArr[arrIndex].playTime[i].substring(0,5)+" (<font color='#DF6464'>상영 종료</font>)";
				}
			}
			else {
				temp+='<div class="divHover sreenOrderList" onclick="selectScreenOrder(this,'+arrIndex+','+i+')">';
				temp+= (i+1)+"회 :"+scheduleArr[arrIndex].playTime[i].substring(0,5)+"(<font color='#3CB371'>예약 가능</font>)";
			}
			
			temp+="</div>";
		}
		
		// 초기화
		$("#reserTime").html("");
		$("#playTime").val("");
		$("#screenOrder").val("");
		
		// 화면 표시 및 값 입력
		$("#screenOrderContent").css("display","none");
		$("#screenOrderContent").html(temp);
		$("#screenOrderContent").fadeIn('slow');
		$("#reserTheater").html(scheduleArr[arrIndex].theaterName);
		$("#reserMovie").html(scheduleArr[arrIndex].movieTitle);
		$("#main_poster").attr("src","https://image.tmdb.org/t/p/w500"+scheduleArr[arrIndex].main_poster);
		
		$("#theaterIdx").val(scheduleArr[arrIndex].theaterIdx);
		console.log(scheduleArr[arrIndex].theaterIdx);
		$("#movieIdx").val(scheduleArr[arrIndex].movieIdx);
		$("#movieTitle").val(scheduleArr[arrIndex].movieTitle);
		
	}
	// 상영 시간 선택시 
	function selectScreenOrder(obj,arrIndex,screenOrder){
		$('.sreenOrderList').removeClass("clickAction");
		obj.className += ' clickAction';
		
		$("#reserTime").html(scheduleArr[arrIndex].playTime[screenOrder].substring(0,5) +" ~ " + scheduleArr[arrIndex].endTime[screenOrder].substring(0,5));
		
		$("#screenOrder").val(screenOrder);
		$("#playTime").val(scheduleArr[arrIndex].playTime[screenOrder].substring(0,5) +" ~ " + scheduleArr[arrIndex].endTime[screenOrder].substring(0,5))
		
	}
	
	function nextReser(){
		let theaterIdx = $("#theaterIdx").val();
		let movieIdx = $("#movieIdx").val();
		let movieTitle = $("#movieTitle").val();
		let screenOrder = $("#screenOrder").val();
		let playDate = $("#playDate").val();
		let playTime = $("#playTime").val();
		
		$.ajax({
			type:"post",
			url:"${ctp}/reservation/reservationGetSeat",
			data:{
				playDate:playDate,
				screenOrder:screenOrder,
				theaterIdx:theaterIdx,
				movieIdx:movieIdx
			},
			success:function(){
				alert("전송 완료");
			},
			error:function(){
				alert("전송 실패");
			}
		});
		
		
	}
	
</script>  
</head>
<body>
<p><br/></P>
<div class="container-xl text-center  p-0" style="width:1010px;height: 500px; background-color: #FBF8EE">
  <div class="d-flex justify-content-start" style="height: 100%">
  	<!-- 날짜 선택 -->
  	<div class="d-flex flex-column">
  		<div class=" ml-1" style="width: 200px;  background-color: #333333"><font color="#E2E2E2">날짜</font></div>
  		<c:forEach var="vo" items="${dateVOS}" varStatus="st">
  			<div><button class="btn btn-outline-dark selectDateList" type="button" onclick="selectDate(this,'${vo}','${st.index}')">${vo}</button></div>
  		</c:forEach>
  	</div>
  	<!-- 영화 선택 -->
  	<div class="d-flex flex-column" >
  		<div class=" ml-1" style="width: 400px;  background-color: #333333;"><font color="#E2E2E2">영화</font></div>
  		<div class="ml-2" id="movieSelectContent" style="text-align: left; display: none;" ></div>
  	</div>
  	<!-- 영화 회차 선택 -->
  	<div class="d-flex flex-column" >
  		<div class=" ml-1" style="width: 400px;  background-color: #333333"><font color="#E2E2E2">시간</font></div>
  		<div id="screenOrderContent" style=" display: none"></div>
  	</div>
  </div>
</div>
<!-- 요약 정보 -->
<div style="background-color: #1D1D1C; height: 150px">
	<div class="container-xl text-center d-flex justify-content-start p-0" style="width:1010px; height: 100%">
		<div class="d-flex flex-column " style="width: 140px;  height:100%;">
  		<div class="mt-4" >
				<button class="p-0 ml-2 text-center" type="button" style="border: 1px solid #E2E2E2; ">
					<span class="material-symbols-outlined" style="transform: rotate( 180deg );">arrow_forward_ios</span>
				</button>
  		</div>
  	</div>
  	<!-- 영화 이미지 -->
		<div class="d-flex justify-content-center mr-1 " style="width: 150px; height:100%; background-color: #333333">
			<div><img id="main_poster" width="100px"/></div>
  	</div>
		<div class="d-flex flex-column">
  		<div class="" style="width: 500px;  background-color: #333333"><font color="#E2E2E2">예약 정보</font></div>
  		<div style="color: #808080;">일시: <span id="reserDate"></span></div>
  		<div style="color: #808080;">상영관: <span id="reserTheater"></span></div>
  		<div style="color: #808080;">영화: <span id="reserMovie"></span></div>
  		<div style="color: #808080;">시간: <span id="reserTime"></span></div>
  	</div>
		<div class="d-flex flex-column " style="width: 140px;  height:100%;">
  		<div class="mt-4" >
				<button class="p-0 ml-2 text-center" type="button" style="border: 1px solid #E2E2E2;" onclick="nextReser()">
					<span class="material-symbols-outlined">arrow_forward_ios</span>
				</button>
  		</div>
  	</div>
	</div>
</div>
<input type="hidden" name="theaterIdx" id="theaterIdx">
<input type="hidden" name="movieIdx" id="movieIdx">
<input type="hidden" name="movieTitle" id="movieTitle">
<input type="hidden" name="screenOrder" id="screenOrder">
<input type="hidden" name="playDate" id="playDate">
<input type="hidden" name="playTime" id="playTime">
<p><br/></P>
</body>
</html>