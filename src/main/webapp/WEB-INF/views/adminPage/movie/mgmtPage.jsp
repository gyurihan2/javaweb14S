<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="${ctp}/js/apiKey.js"></script>
	<title>영화 관리 페이지</title>
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
        
		.col{
			margin-top : 5px;
			height: 50px;
		}
	 .row_body{
			font-size: 15px;
		} 
		.row_body:hover{
			background-color: #d3d3d3;
		}
		select{
			text-align-last:center;
			vertical-align: middle;
		}
		hr{
			margin-bottom: 10px;
			margin-top: 10px;
		}
		.test{
			margin-left: 70px;
		}
	</style>
	<script>
	'use strict';
	
	let today;
	let map1 = new Map();
	
	const tmdbKey = config.tmdbApiKey;
	const tmdbAuth = config.tmdbApiKeyAuth;
	
	// TMDB Api option
	const options = {
    method: 'GET',
    headers: {
        accept: 'application/json',
        Authorization: 'Bearer '+tmdbAuth
  	}
	};
	//const url = 'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=ko-KR&page=1&region=kr&release_date.gte='+release_date_gte+'&release_date.lte='+release_date_lte+'&sort_by=popularity.desc&watch_region=kr&with_release_type=3'
 	
 	function movieGetChart(){
 		today = new Date();
		//to
		let release_date_lte = today.toISOString().substring(0,10);
		today.setDate(0);
		//from
		let release_date_gte = today.toISOString().substring(0,10);
		console.log(release_date_gte);
		console.log(release_date_lte);
 		$.ajax({
 			type:"get",
 			url:'https://api.themoviedb.org/3/discover/movie?release_date.gte='+release_date_gte+'&release_date.lte='+release_date_lte,
 			data:{
 				api_key:tmdbKey,
 				dataType: "jsonp",
 				contentType: 'application/json',
 				include_adult:false,
 				include_video:false,
 				language:"ko-KR",
 				page:1,
 				region:"kr",
 				sort_by:"popularity.desc",
 				watch_region:"kr",
 				with_release_type:3
 			},
 			success:function(res){
 				
 				let tempHtml = "";
 				for(let i=0;i<10;i++){
 					tempHtml += '<div class="row row_body">';
 					tempHtml += '<div class="col-1">'+(i+1)+'</div>';
 					tempHtml += '<div class="col">'+res.results[i].title+'</div>';
 					tempHtml += '<div class="col-2">'+res.results[i].release_date+'</div>';
 					tempHtml += '<div class="col-2">'+res.results[i].vote_average+'</div>';
 					tempHtml += '</div>	<hr class="mb-2 mt-2"/>';
 				}
 				$("#movieChart").html($("#movieChart").html()+tempHtml);
 				
	  		},
	  		error:function(){
	  			alert("전송 실패");
	  		}
 		});
 	}
 	
	

	function movieChartList(){
		console.log("1:"+test.length);
    console.log("2:"+test[1].title);
		
		let tempHtml = "";
		for(let i=0;i<10;i++){
			let j = test[i];
			tempHtml += '<div class="row row_body">';
			tempHtml += '<div class="col">'+(i+1)+'</div>';
			tempHtml += '<div class="col">'+j.title+'</div>';
			tempHtml += '<div class="col">'+j.release_date+'</div>';
			tempHtml += '<div class="col">'+j.vote_average+'</div>';
			tempHtml += '</div>';
		}
		$("#movieChart").html($("#movieChart").html()+tempHtml); 
	}
	jQuery(function(){
		movieGetChart();
	});	
	
	</script>
</head>
<body id="wrapper">
	<div class="mb-5" id="top_title">
		<h4 class="m-1 p-0"><b>영화 관리</b></h4>
	</div>
	<p></p>
	<h4>영화 순위</h4>
	<div class=" content container text-center contentScroll">
		<div class="" style="height: 300px;">
			<div id="movieChart">
				<div class="row row_head">
					<div class="col-1">순위</div>
					<div class="col">타이틀</div>
					<div class="col-2">개봉일</div>
					<div class="col-2">평점</div>
				</div>
			</div>
		</div>
	</div>
	<div class="d-flex flex-row test">
		<!-- 영ㅇ화 설정 -->
		<div class="content mt-5 p-3 text-center contentScroll" style="height: 700px;width: 750px;" >
			<div class="d-flex flex-row-reverse mb-3">
				<div class="p-2"><input type="button" value="영화 조회" class="btn btn-info btn-sm" onclick="window.open('${ctp}/movie/movieSearchPage','nWin','width=800 height=700')"/></div>
			</div>
			<c:if test="${!empty theaterVOS}">
				<div class="row row_head ">
					<div class="col"><b>이름</b></div>
					<div class="col"><b>테마</b></div>
					<div class="col"><b>좌석수</b></div>
					<div class="col"><b>가격</b></div>
					<div class="col"><b>상태</b></div>
				</div>
				<hr/>
				<c:forEach var="vo" items="${theaterVOS}">
					<div class="row row_body align-items-center">
						<div class="col" onclick="window.open('${ctp}/theater/theaterDetailPage?idx=${vo.idx}','nWin','width=800px,height=500px')">${vo.name}</div>
						<div class="col" >${vo.themaName}</div>
						<div class="col" >${vo.seat}</div>
						<div class="col" >${vo.themaPrice}</div>
						<div class="col">
							<div class="form-group">
							  <select class="form-control workPre" id="display${vo.idx}" onchange="workChange('${vo.idx}','${vo.name}',this)">
							    <option value="1" <c:if test="${vo.work==1 }">selected</c:if>>오픈</option>
							    <option value="2" <c:if test="${vo.work==2 }">selected</c:if>>임시 중단</option>
							    <option value="3" <c:if test="${vo.work==3 }">selected</c:if>>중지</option>
							    <option value="4" <c:if test="${vo.work==4 }">selected</c:if>>차단</option>
							  </select>
							</div>
						</div>
					</div>
					<hr class="mb-2 mt-2"/>
				</c:forEach>
			</c:if>
			<c:if test="${empty theaterVOS}">
				<div class="text-center"> 내역이 없습니다.</div>
			</c:if>
		</div>
		<!-- 테마 설정 -->
		<div class="content mt-5 ml-4 p-2 text-center contentScroll" style="width: 700px; height: 500px">
			<div class="mt-2">
				<input type="button" value="테마 추가" class="btn btn-info btn-sm" onclick="window.open('${ctp}/theater/themaInputPage','nWin','width=800 height=1000')" style="float: right;"/>
			</div>
			<br/>
			<c:if test="${!empty themaVOS}">
				<div class="row row_head mt-3">
					<div class="col"><b>메인 이미지</b></div>
					<div class="col"><b>테마명</b></div>
					<div class="col"><b>가격</b></div>
					<div class="col"><b>메인화면 표시</b></div>
				</div>
				<hr/>
				<c:forEach var="vo" items="${themaVOS}">
					<div class="row row_body align-items-center">
						<div class="col" onclick="window.open('${ctp}/theater/themaDetailPage?idx=${vo.idx}','nWin','width=1030px,height=800px')">
							<img src="${ctp}/thema/image/${vo.mainImg}" width="70px" height="50px">
						</div>
						<div class="col">${vo.name}</div>
						<div class="col">${vo.price}</div>
						<div class="col">
							<div class="form-group">
							  <select class="form-control workPre" id="work${vo.idx}" onchange="displayChange('${vo.idx}','${vo.name}',this)">
							    <option value="YES" <c:if test="${vo.display=='YES' }">selected</c:if>>YES</option>
							    <option value="NO" <c:if test="${vo.display=='NO' }">selected</c:if>>NO</option>
							  </select>
							</div>
						</div>
					</div>
					<hr class="mb-2 mt-2"/>
				</c:forEach>
			</c:if>
			<c:if test="${empty themaVOS}">
				<div class="text-center"> 내역이 없습니다.</div>
			</c:if>
		</div>
	</div>
<p><br/></p>
</body>
</html>