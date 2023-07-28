<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="${ctp}/js/apiKey.js"></script>
	<script src="${ctp}/js/autoComplte.js"></script>
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
		
		.autocomplete {
		  position: relative;
		  display: inline-block;
		}
		.autocomplete-items {
			font-size:5px;
		  position: absolute;
		  border: 1px solid #d4d4d4;
		  border-bottom: none;
		  border-top: none;
		  z-index: 99;
		  /*position the autocomplete items to be the same width as the container:*/
		  top: 100%;
		  left: 0;
		  right: 0;
		}
		
		.autocomplete-items div {
		  padding: 10px;
		  cursor: pointer;
		  background-color: #fff; 
		  border-bottom: 1px solid #d4d4d4; 
		}
		
		/*when hovering an item:*/
		.autocomplete-items div:hover {
		  background-color: #e9e9e9; 
		}
		
		/*when navigating through the items using the arrow keys:*/
		.autocomplete-active {
		  background-color: DodgerBlue !important; 
		  color: #ffffff; 
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
		
		//from
 		let setDate = new Date(today.setDate(today.getDate()-10));
		let release_date_gte = setDate.toISOString().substring(0,10);
		
		$("#movieChartTitle").html($("#movieChartTitle").html()+" <em>("+release_date_gte+" ~ "+release_date_lte+")</em>");
 		$.ajax({
 			type:"get",
 			url:'https://api.themoviedb.org/3/discover/movie?release_date.gte='+release_date_gte+'&release_date.lte='+release_date_lte,
 			data:{
 				api_key:tmdbKey,
 				dataType: "json",
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
 		
	//등록된 영화 상세 보기
	function movieDeatil(idx){
		let url="${ctp}/movie/movieDetailPage?idx="+idx;
		
		window.open(url,"nWin","width=1200, height=800");
	}
	
	// 영화 삭제
	function movieDelete(idx,title){
		if(!confirm(title+"을 삭제 하시겠습니까?")) return false;
		
		$.ajax({
			type:"post",
			url:"${ctp}/movie/movieDelete",
			data:{
				idx:idx
			},
			success:function(res){
				if(res == 1){
					alert("삭제 완료");
					location.reload();
				}
				else alert("삭제 실패");
			},
			error:function(){
				alert("전송 실패");
			}
		});
	}
	
	let movieList=[];
	let movieJsonData=[];
	// 영화 검색 후 스크롤 이동
		function searchScroll(){
			let search = $("#search").val();
			let movieTitle =  search.substring(0,search.length-12);
			let release_date = search.substring(search.length-11,search.length-1);
			
			if(search==""){
				alert("검색할 영화를 입력하세요");
				return false;
			}
			let index=-1;
			
			for(let i=0;i<movieJsonData.length;i++){
				if(movieJsonData[i].title == movieTitle && movieJsonData[i].release_date == release_date) {
					index = i;
					break;
				}
			}
			console.log(movieJsonData)
			let idx = movieJsonData[index].idx;
			console.log(idx);
			document.getElementById(idx).scrollIntoView({behavior: "smooth", block: "start"});
			$("#search").val("");
		}
	
	
	// 자동완성
	
	if(${!empty movieJsonData}){
		movieJsonData=${movieJsonData};
		console.log(movieJsonData);
		for(let i=0;i<movieJsonData.length;i++) movieList.push(movieJsonData[i].title+"("+movieJsonData[i].release_date+")");
	}
	
	jQuery(function(){
		movieGetChart();
		autocomplete(document.getElementById("search"), movieList);
	});	
	
	</script>
</head>
<body id="wrapper">
	<div class="mb-5" id="top_title">
		<h4 class="m-1 p-0"><b>영화 관리</b></h4>
	</div>
	<p></p>
	<div class="content .flex-column text-center" style="height: 300px; width: 1200px; margin: auto;">
		<div class="mt-2 pt-1"><h4  id="movieChartTitle">TMDB 영화 순위</h4></div>
		<div class="row row_head">
			<div class="col-1"><b>순위</b></div>
			<div class="col"><b>타이틀</b></div>
			<div class="col-2"><b>개봉일</b></div>
			<div class="col-2"><b>평점</b></div>
		</div>
		<div class="contentScroll" style="height: 200px;">
			<div id="movieChart">
			</div>
		</div>
	</div>
	<div class="d-flex flex-row">
		<!-- 영화 설정 -->
		<div class="content mt-5 p-3 text-center" style="height: 700px;width: 750px;" >
			<div class="d-flex justify-content-end mb-1">
				<div class="flex-fill text-center"><h4 class="pl-5">등록된 영화</h4></div>
				<div class=""><input type="button" value="영화 추가 요청(TMDB)" class="btn btn-success btn-sm" onclick="location.href='${ctp}/movie/movieSearchPage'"/></div>
			</div>
			<div class="d-flex justify-content-end mb-3	">
				<div class="d-flex flex-row" style="width: 300px;">
			    <div class="input-group-append autocomplete">
			    	<input type="text" class="form-control" id="search"  autocomplete="off">
			   	</div>
			    <div class="input-group-append ">
			      <button class="btn btn-primary btn-sm" type="button" onclick="searchScroll()">영화 검색</button>  
			     </div>
  			</div>
			</div>
			<c:if test="${!empty movieVOS}">
				<div class="row row_head ">
					<div class="col"><b>메인포스터</b></div>
					<div class="col"><b>제목</b></div>
					<div class="col"><b>개봉일</b></div>
					<div class="col"><b>비고</b></div>
				</div>
				<hr/>
				<div class="contentScroll" style="height: 500px;">
				<c:forEach var="vo" items="${movieVOS}">
					<div class="row row_body align-items-center" id="${vo.idx}" style="height: 150px">
						<div class="col"><img src="https://image.tmdb.org/t/p/w500${vo.main_poster}" width="60px"/></div>
						<div class="col" onclick="movieDeatil(${vo.idx})">${vo.title}</div>
						<div class="col" >${vo.release_date}</div>
						<div class="col" >
							<button class="btn btn-sm btn-danger" onclick="movieDelete('${vo.idx}','${vo.title}')">삭제</button>
						</div>
					</div>
					<hr class="mb-2 mt-2"/>
				</c:forEach>
				</div>
			</c:if>
			<c:if test="${empty movieVOS}">
				<div class="text-center mt-5"> <font color="red">등록된 영화가 없습니다.</font></div>
			</c:if>
		</div>
		<!-- 상영 일정 설정 -->
		<div class="content mt-5 ml-4 p-2 text-center contentScroll" style="width: 700px; height: 500px">
				준비중입니다.
		</div>
	</div>
<p><br/></p>
</body>
</html>