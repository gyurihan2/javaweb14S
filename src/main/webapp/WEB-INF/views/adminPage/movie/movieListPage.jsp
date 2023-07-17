<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>영화 조회</title>
  <script src="${ctp}/js/autoComplte.js"></script>
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
		
		.autocomplete {
		  position: relative;
		  display: inline-block;
		}
		
		input {
		  border: 1px solid transparent;
		  background-color: #f1f1f1;
		  padding: 10px;
		  font-size: 16px;
		}
		
		input[type=text] {
		  background-color: #f1f1f1;
		  width: 100%;
		}
		
		.autocomplete-items {
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
  	
		let theaterArr = Object.values(${jsonData});
		let movieList = [];
		for(let i=0; i<theaterArr.length; i++) movieList.push(theaterArr[i].title+"("+theaterArr[i].release_date+")");

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
			
			for(let i=0;i<theaterArr.length;i++){
				if(theaterArr[i].title == movieTitle && theaterArr[i].release_date == release_date) {
					index = i;
					break;
				}
			}
			
			let idx = theaterArr[index].idx;
			console.log(idx);
			document.getElementById(idx).scrollIntoView({behavior: "smooth", block: "start"});
		}
		
		// 영화 선택
		function selectMoive(index){
			let movieIdx = theaterArr[index].idx; 
			let movieRuntime = theaterArr[index].runtime; 
			let movieTitle = theaterArr[index].title; 
			
			opener.document.getElementById("movieIdx").value = movieIdx;
			opener.document.getElementById("movieRuntime").value = movieRuntime;
			opener.document.getElementById("movieTitle").innerHTML = movieTitle;
			opener.document.getElementById("movieTime").innerHTML = movieRuntime+" 분";
			opener.document.getElementById("genres").innerHTML = theaterArr[index].genres;
			opener.document.getElementById("movieTagline").innerHTML=theaterArr[index].tagline;
			opener.document.getElementById("main_poster").setAttribute('src', 'https://image.tmdb.org/t/p/w500'+theaterArr[index].main_poster);
			
			window.close();
		}
  	
  	$(function(){
  		autocomplete(document.getElementById("search"), movieList);
  	});
  </script>
</head>
<body>
<h4 class="text-center">상영 가능한 영화</h4>
<div class="d-flex justify-content-end">
	<div class="d-flex flex-row" style="width: 300px;">
    <div class="input-group-append autocomplete">
    	<input type="text" class="form-control" id="search"  autocomplete="off">
   	</div>
    <div class="input-group-append ">
      <button class="btn btn-primary btn-sm" type="button" onclick="searchScroll()">영화 검색</button>  
     </div>
  </div>
</div>
<c:if test="${!empty vos}">
	<div class="row">
		<div class="col">포 스 터</div>
		<div class="col">아 이 디</div>
		<div class="col">제 목</div>
		<div class="col">장 르</div>
		<div class="col">상 영 시 간</div>
		<div class="col">비 고</div>
	</div>
	<div class="contentScroll" style="height: 450px;">
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<div class="row" id="${vo.idx}">
				<div class="col"><img src="https://image.tmdb.org/t/p/w500${vo.main_poster}" width="60px"/></div>
				<div class="col">${vo.idx}</div>
				<div class="col">${vo.title}</div>
				<div class="col">${vo.genres}</div>
				<div class="col">${vo.runtime }</div>
				<div class="col">
					<button type="button" class="btn btn-sm btn-info" onclick="selectMoive(${st.index})">선택</button>
				</div>
			</div>
		</c:forEach>
	</div>
</c:if>
<p><br/></P>
</body>
</html>