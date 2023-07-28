<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>일정 등록</title>
</head>
<script>
	'use strict';
	
	// 상영관 조회
	function theaterSerch(){
		let startDate = $("#startDate").val();
		let endDate = $("#endDate").val();
		
		if(startDate == "" || endDate == ""){
			alert("상영일자를 선택하세요");
			return false;
		}
		
		var popupX = Math.ceil(( window.screen.width - 900 )/2);
		var popupY= Math.ceil(( window.screen.height - 450 )/2); 
		let url = "${ctp}/theater/theaterListPage?startDate="+startDate+"&endDate="+endDate;
		window.open(url,"theater_win","width=900,height=450,top="+popupY+",left="+popupX);
		
	}
	
	// 영화 조회
	function movieSearch(){
		let startDate = $("#startDate").val();
		
		if(startDate == ""){
			alert("상영 시작 일자를 선택하세요");
			return false;
		}
		
		var popupX = Math.ceil(( window.screen.width - 900 )/2);
		var popupY= Math.ceil(( window.screen.height - 450 )/2); 
		let url = "${ctp}/movie/movieListPage?startDate="+startDate;
		window.open(url,"theater_win","width=800,height=600,top="+popupY+",left="+popupX);
	}
	
	// 영화 screenOrder 추가
	function sreenOrderAdd(){
		let cnt = $("input[name=order]").length;
		let playTime = Number($("#movieRuntime").val());
		
		if(playTime%10 != 0) playTime = playTime+(10-(playTime%10));
		
		// 이전 시간 값 
		let orderval = $("#order"+cnt).val();
		
		if(orderval==""){
			alert("이전 일정의 시간을 정하세요");
			return false;
		}
		
		// 시간 계산을 위한 값 세팅
		let date = new Date('2012-05-17 '+ orderval);
		
		// 다음 영화 상영될 시간의 min값 
		date.setMinutes(date.getMinutes() + playTime+5);
		let nextOrderMinTime = ("0"+date.getHours()).slice(-2)+":"+("0"+date.getMinutes()).slice(-2);
		
		// 다음 영화 상영될 시간 + 휴게시간(5+15분)
		date.setMinutes(date.getMinutes() +15);
		let nextOrderTime = ("0"+date.getHours()).slice(-2)+":"+("0"+date.getMinutes()).slice(-2);
		
		cnt++;
		
		let fileBox = '';
		fileBox += '<div class="d-flex justify-content-center mb-1" id="screenOreder_'+cnt+'" >';
		fileBox += '<div>'+cnt+' 회차&nbsp;&nbsp;</div>';
		fileBox += '<input type="time" name="order" id="order'+cnt+'" min='+nextOrderMinTime+' value='+nextOrderTime+' />';
		fileBox += '</div>';
		$("#screenOrderContent").append(fileBox);
		
	}
	
	//영화 screenOrder 삭제
	function sreenOrderDelete(){
		let cnt = $("input[name=order]").length;
		$("#screenOreder_"+cnt).remove();
	}
	
	// 일정 추가
	function insertSchedule(){
		let startDate = $("#startDate").val();
		let endDate = $("#endDate").val();
		let theaterIdx = $("#theaterIdx").val();
		let movieIdx = $("#movieIdx").val();
		let order = $("#order1").val();

		
		if(startDate == ""){
			alert("상영 시작일을 입력하세요");
			return false;
		}
		else if(endDate == ""){
			alert("상영 종료일을 입력하세요");
			return false;
		}
		else if(theaterIdx == ""){
			alert("상영관을 선택하세요");
			return false;
		}
		else if(movieIdx == ""){
			alert("상영 영화를 선택하세요");
			return false;
		}
		else if(order == ""){
			alert("첫번째 상영 순서 시간을 입력하세요");
			return false;
		}
		
		
		let i = myform.submit();
		console.log(i);
	}
	
	
	$(function(){
		let today = new Date();
		let todatFomat = today.getFullYear()+"-"+("0"+(today.getMonth()+1)).slice(-2)+"-"+("0"+today.getDate()).slice(-2);
		
		$("#startDate").attr("min",todatFomat);
		
		$("#endDate").on("click",function(){
			if($("#startDate").val() == ""){
				alert("상영일을 먼저 선택 하세요.");
				return false;
			}
		});
		
		$("#startDate").on("change",function(){
			$("#endDate").attr("min",$("#startDate").val());
			$("#endDate").val("");
		});
		
	});
</script>
<body>
<h4 class="text-center">일정 등록</h4>
<form method="post" name="myform" action="${ctp}/schedule/scheduleInput">
	<div class="d-flex flex-column"></div>
	<div class="row text-center">
		<div class="col-2">상 영 일</div>
		<div class="col"><input type="date" class="form-control" name="startDate" id="startDate"/></div>
		<div class="col-2">상 영 종 료 일</div>
		<div class="col"><input type="date" class="form-control" name="endDate" id="endDate"/></div>
	</div>
	<div class="row text-center">
		<div class="col-2">상 영 관</div>
		<div class="col">
			<div class="input-group">
	      <input type="text" class="form-control" id="theater" readonly/>
	      <input type="hidden" name="theaterIdx" id="theaterIdx"/>
	      <input type="hidden" name="leftSeat" id="leftSeat"/>
	      <div class="input-group-prepend ml-2">
	      	<input type="button" class="btn btn-info btn-sm " id="midCheck" value="상영관 조회" onclick="theaterSerch()" style="border-radius: 10px;"/>
	  		</div>
	    </div>
		</div>
		<div class="col-2">영 화</div>
		<div class="col">
			<div class="input-group">
	      <input type="hidden" name="movieIdx" id="movieIdx"/>
	      <div class="input-group-prepend ml-2">
	      	<input type="button" class="btn btn-info btn-sm " id="midCheck" value="영화 조회" onclick="movieSearch()" style="border-radius: 10px;"/>
	  		</div>
	    </div>
		</div>
	</div>
	<div class="" id="movieBrief" style="display: none;">
		<div class="d-flex flex-row align-items-center" style="height: 250px;">
			<div>
				<div><img id="main_poster" width="100px"/></div>
			</div>
			<div class="d-flex flex-column flex-fill ml-3">
				<div class="row">
					<div class="col"><b>제목:</b> <span id="movieTitle"></span></div>
					<div class="col"><b>상영시간:</b> <span id="movieTime"></span>
						<input type="hidden" name="runtime" id="movieRuntime"/>
					</div>
				</div>
				<div class="row">
					<div class="col"><b>태그:</b> <span id="movieTagline"></span></div>
				</div>
				<div class="row">
					<div class="col"><b>장르:</b> <span id="genres"></span></div>
				</div>
			</div>
		</div>
		<div  id="screenOrderList">
			<div class="d-flex flex-column" id="screenOrderContent">
				<div class="text-center"> 상영일정
					<button type="button" class="btn btn-sm btn-info" onclick="sreenOrderAdd()">일정 추가</button>
					<button type="button" class="btn btn-sm btn-warning" onclick="sreenOrderDelete()">삭제</button>
				</div>
				<div class="d-flex justify-content-center mt-2 mb-1"  id="screenOreder_1">
					<div>1 회차&nbsp;&nbsp;</div>
					<div><input type="time" name="order" id="order1" /></div>
				</div>
			</div>
		</div>
	</div>
	<div class="text-center mt-3">
		<button type="button" class="btn btn-success btn-sm" onclick="insertSchedule()">추가하기</button>
		<button type="button" class="btn btn-warning btn-sm" onclick="window.close()">취소</button>
	</div>
</form>
<p><br/></P>
</body>
</html>