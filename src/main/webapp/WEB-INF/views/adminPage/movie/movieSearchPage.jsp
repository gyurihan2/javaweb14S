<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>영화 검색 페이지</title>
  <script src="${ctp}/js/apiKey.js"></script>
</head>
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
      
	#dth .col,.col-2{
		margin-top : 5px;
		height: 15px;
	}
	#movieList .col{
		margin-top : 5px;
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
	.content{
		box-shadow: 2px 2px 2px 2px #E2E2E2;
		border-radius: 30px;
		background-color: #ffffff;
	}
</style>
<script>
	'use script';
	
	const tmdbKey = config.tmdbApiKey;
	const imgSrc = "https://image.tmdb.org/t/p/w500"
	let totalPage=0;
	
	$.ajax({
		type:"get",
		url:'https://api.themoviedb.org/3/discover/movie',
		data:{
			api_key:tmdbKey,
			dataType: "jsonp",
			contentType: 'application/json',
			include_adult:true,
			include_video:true,
			language:"ko-KR",
			page:1,
			region:"kr",
			sort_by:"popularity.desc",
			watch_region:"kr",
			with_release_type:3
		},
		success:function(res){
			let tempHtml = "";
			totalPage=res.total_pages;
			console.log(res);
			for(let i = 0; i<res.results.length;i++){
				tempHtml += '<div class="d-flex align-items-center m-2 row_body" onclick="movieDetail('+res.results[i].id+')">';
				tempHtml += '<div class="col-1"><div><input class="form-check-input" type="checkbox"></div></div>';
				tempHtml += '<div class="col"><img src="'+imgSrc+res.results[i].poster_path+'" width="100"></div>';
				tempHtml += '<div class="col">'+res.results[i].title+'</div>';
				tempHtml += '<div class="col-2">'+res.results[i].release_date+'</div>';
				tempHtml += '<div class="col-2">'+res.results[i].vote_average+'</div>';
				tempHtml += '</div>	<hr class="mb-2 mt-2"/>';
			}
			$("#movieList").html(tempHtml);
			
		},
		error:function(){
			alert("전송 실패");
		}
	});
	
	
	let movieDetail1=[];
	let moviePosters=[];
	function movieDetail(id){
		
		$.ajax({
			type:"get",
			url:'https://api.themoviedb.org/3/movie/'+455476,
			data:{
				api_key:tmdbKey,
				dataType: "json",
				async:false,
				contentType: 'application/json',
				append_to_response:"videos",
				language:"ko-KR"
			},
			success:function(res){
				let tempHtml = "";
				movieDetail1=res;
				resolve(res);
			},
			error:function(){
				alert("전송 실패");
			}
		});
		
		//영화 포스터 이미지
	}
	
	
	function test1(){
		console.log(movieDetail1);
	}
</script>
<body>
	<input type="button" onclick="test1()">
  <h4>영화 검색 및 추가</h4>
  <div class="d-flex flex-row-reverse">
	  <div class="p-2 form-inline">
	  	<input class="form-control mr-sm-2" type="text" placeholder="Search">
   	  <button class="btn btn-sm btn-primary " type="submit">Search</button>
	  </div>
	  <div class="p-2"><button type="button" class="btn btn-sm btn-info">상영 예정</button></div>
	  <div class="p-2"><button type="button" class="btn btn-sm btn-info">전체리스트</button></div>
	</div>
  
	
	<div class="text-center content ml-4" style="width: 800px">  
		<div class="row dth m-2">
			<div class="col-1"></div>
			<div class="col">메인 이미지</div>
			<div class="col">영화 제목</div>
			<div class="col-2">개봉일</div>
			<div class="col-2">평점</div>
	  </div>
		<div class=" contentScroll flex-fill" id="movieList" style="height: 400px"></div>
	</div>
	<div class="text-center content ml-4 mt-2" style="width: 800px">  
		
	</div>
<p><br/></P>
</body>
</html>