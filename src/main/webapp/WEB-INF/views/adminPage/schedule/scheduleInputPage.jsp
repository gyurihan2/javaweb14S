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
	
	function movieSearch(){
		let startDate = $("#startDate").val();
		
		if(startDate == ""){
			alert("상영 시작 일자를 선택하세요");
			return false;
		}
		
		let url = "${ctp}/movie/movieListPage?startDate="+startDate;
		window.open(url,"theater_win","width=800,height=300");
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
	      <input type="text" class="form-control" name="movieTitle" id="movieTitle" readonly/>
	      <input type="hidden" name="movieIdx" id="movieIdx"/>
	      <div class="input-group-prepend ml-2">
	      	<input type="button" class="btn btn-info btn-sm " id="midCheck" value="영화 조회" onclick="movieSearch()" style="border-radius: 10px;"/>
	  		</div>
	    </div>
		</div>
	</div>
	<div>
		<div class="row">
			<div class="col d-flex flex-column">
				<div><img id="main_poster" width="75px"/></div>
				<div>포스터</div>
			</div>
			<div class="col">
				장르 <span id="genres"></span>
			</div>
		</div>
	</div>
</form>
<input type="hidden" name="	" id="movieRuntime"/>
<p><br/></P>
</body>
</html>