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
		
		let url = "${ctp}/theater/theaterListPage?startDate="+startDate+"&endDate="+endDate;
		window.open(url,"theater_win","width=800,height=300");
	}
	
	// 영화 조회
	function movieSearch(){
		let startDate = $("#startDate").val();
		
		if(startDate == ""){
			alert("상영 시작 일자를 선택하세요");
			return false;
		}
		
		let url = "${ctp}/movie/movieListPage?startDate="+startDate;
		window.open(url,"theater_win","width=800,height=300");
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
		fileBox += '<div class="d-flex justify-content-center" id="screenOreder_'+cnt+'" >';
		fileBox += '<div>'+cnt+' 회차</div>';
		fileBox += '<input type="time" name="order" id="order'+cnt+'" min='+nextOrderMinTime+' value='+nextOrderTime+' />';
		fileBox += '</div>';
		$("#screenOrderContent").append(fileBox);
		
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
<form method="post" name="myform">
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
	      <input type="text" class="form-control" name="theater" id="theater" readonly/>
	      <input type="hidden" name="theaterIdx" id="theaterIdx"/>
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
	<div id="movieBrief">
		<div class="row d-flex align-items-center" style="height: 150px">
			<div class="col d-flex flex-column">
				<div><img id="main_poster" width="75px"/></div>
				<div>포스터</div>
			</div>
			<div class="col align-self-center">
				제목: <span id="movieTitle"></span>
			</div>
			<div class="col">
				상영시간: <span id="movieTime"></span>
			</div>
		</div>
		<div class="row">
			<div class="col">
				태그: <span id="movieTagline"></span>
			</div>
			<div class="col">
				장르: <span id="genres"></span>
			</div>
		</div>
	</div>
	<div id="screenOrderList">
		<div class="d-flex flex-column" id="screenOrderContent">
			<div class="text-center"> 상영일정
				<button type="button" class="btn btn-sm btn-info" onclick="sreenOrderAdd()">일정 추가</button>
				<button type="button" class="btn btn-sm btn-warning" onclick="sreenOrderDelete()">삭제</button>
			</div>
			<div class="d-flex justify-content-center"  id="screenOreder_1">
				<div>1 회차 :</div>
				<div><input type="time" name="order" id="order1"  min="07:55:00" max="23:55" value="08:00" /></div>
			</div>
		</div>
	</div>
</form>
<input type="hidden" name="	" id="movieRuntime"/>
<p><br/></P>
</body>
</html>