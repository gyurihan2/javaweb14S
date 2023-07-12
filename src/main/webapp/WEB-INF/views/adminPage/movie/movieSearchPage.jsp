<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
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
  
  #dth{
  	font-size:15px;
		background-color: #f8f8f8;
		height: 100%;
  }
  .col{
  	font-size: 15px;
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
	
	.material-symbols-outlined {
		cursor:pointer;
		font-size: 48px;
	  font-variation-settings:
	  'FILL' 0,
	  'wght' 400,
	  'GRAD' 0,
	  'opsz' 48
		}

</style>
<script>
	'use script';
	
	
	const tmdbKey = config.tmdbApiKey;
	const googleApiKey = config.googleApiKey;

	const imgSrc = "https://image.tmdb.org/t/p/w500";
	const vidioSrc = "https://www.youtube.com/embed";
	
	let url="https://api.themoviedb.org/3/discover/movie";
	
	let totalPage=0;
	let page=1;
	
	let today = new Date();
	let searchYear= today.getFullYear();
	
	let data;
	
	// 영화 전체 리스트
	function movieList(data){
		
		if(data == null){
			data={
				api_key:tmdbKey,
				dataType: "json",
				contentType: 'application/json',
				include_adult:false,
				include_video:true,
				language:"ko-KR",
				page:page,
				//primary_release_year:"2023",
				"primary_release_date.lte":searchYear+"-12-31",
				region:"kr",
				sort_by:"primary_release_date.desc",
				watch_region:"kr",
				with_release_type:3	
			};
		}
		
		$.ajax({
			type:"get",
			url:url,
			data:data,
			success:function(res){
				totalPage=res.total_pages;
				$("#totPage").html(totalPage);
				$("#curPage").val(page);
			},
			error:function(){
				alert("전송 실패");
			}
		}).then(res =>{
			
			let tempHtml = "";
			for(let i = 0; i<res.results.length;i++){
				let chkboxValue = (page-1) * 20 + (i+1); 
				tempHtml += '<div class="d-flex align-items-center row_body text-center" onclick="movieDetail('+res.results[i].id+')">';
				//tempHtml += '<div class="col-1 pl-2"><div><input type="checkbox" onchange="test(this,'+chkboxValue+')"></div></div>';
				if(res.results[i].poster_path == null) tempHtml +='<div class="col">이미지 준비중</div>'
				else tempHtml += '<div class="col"><img src="'+imgSrc+res.results[i].poster_path+'" width="50"></div>';
				tempHtml += '<div class="col">'+res.results[i].title+'</div>';
				tempHtml += '<div class="col-2">'+res.results[i].release_date+'</div>';
				tempHtml += '<div class="col-2">'+res.results[i].vote_average+'</div>';
				tempHtml += '</div>	<hr class="mb-2 mt-2"/>';
			}
			$("#movieList").html(tempHtml);
		});
	}
	
	movieList();

	// 영화 리스트 페이지 이전 버튼
	function prevMovie(){
		if(--page > 0) {
			if(data != null) data.page=page;
			movieList(data);
			$("#next").css("display","block");
		}
		
		if(page == 1) $("#prev").css("display","none");
	}
	// 영화 리스트 다음 버튼
	function nextMovie(){
		
		if(page++ <= totalPage) {
			if(data != null) data.page=page;
			movieList(data);
			$("#prev").css("display","block");
		}
		
		if(page == totalPage) $("#next").css("display","none");
	}
	
	//영화 조건 검색
	function requireSearch(){
		$("#prev").css("display","none");
		$("#next").css("display","inline");
		
		let sort = $("#sortBy").val();
		let date_gte = $("#relaseFrom").val();
		let date_lte = $("#relaseTo").val();
		
		let fromDate = new Date(date_gte);
		let toDate = new Date(date_lte);
		
		if(fromDate > toDate){
			alert("날짜 범위를 다시 선택하세요");
			return false;
		}
		page=1;
		url="https://api.themoviedb.org/3/discover/movie";
		
		data={
			api_key:tmdbKey,
			dataType: "json",
			contentType: 'application/json',
			include_adult:true,
			include_video:true,
			language:"ko-KR",
			page:page,
			"primary_release_date.gte":date_gte,
			"primary_release_date.lte":date_lte,
			region:"kr",
			sort_by:sort,
			watch_region:"kr",
			with_release_type:3			
		}
		
		movieList(data);
	}
	
	// 페이지 이동 버튼
	function pageMove(){
		let movePage = $("#curPage").val();
		
		if(movePage == page){
			alert("동일한 페이지 입니다.");
			return false;
		}
		else if(movePage == 0){
			alert("0페이지는 없습니다.");
			return false;
		}
		else if(movePage > totalPage){
			alert("입력 가능한 페이지를 넘었습니다.")
			return false;
		}
		page = movePage;
		if(data != null) data.page = movePage;
		movieList(data);
	}
	
	//영화 이름 검색
	function movieNameSearch(){
		$("#prev").css("display","none");
		$("#next").css("display","inline");
		
		let keyword = $("#movieKeyword").val();
		if(keyword == ""){
			alert("검색할 영화 이름을 입력하세요");
			return false;
		}
		page = 1;
		url = "https://api.themoviedb.org/3/search/movie"
		
		data={
				api_key:tmdbKey,
				dataType: "json",
				contentType: 'application/json',
				query:keyword,
				include_adult:false,
				language:"ko-KR",
				page:page,
				region:"kr"
			};
		
		movieList(data);		
	}
	
	let movieDetailArr=[];
	let movieDetailTemp="";
	let moviePosterStr="";
	let movicCastingStr="";	
	// 영화 상세 보기
	function movieDetail(id){
		// 영화 상세 정보 요청(기본적인 정보)
		$.ajax({
			type:"get",
			url:'https://api.themoviedb.org/3/movie/'+id,
			data:{
				api_key:tmdbKey,
				dataType: "json",
				async:false,
				contentType: 'application/json',
				append_to_response:"videos",
				language:"ko-KR"
			},
			success:function(res){
				console.log(res);
				$("#title").html(res.title);
				$("#tagline").html(res.tagline);
				$("#original_title").html(res.original_title);
				let genres = "";
				res.genres.forEach(function(genre){
					genres += genre.name+"/"
				});
				$("#genres").html(genres);
				$("#runtime").html(res.runtime + " 분");
				$("#original_language").html(res.original_language);
				$("#release_date").html(res.release_date);
				
				let companies = "";
				res.production_companies.forEach(function(company){
					companies+=company.name+"/"
				});
				$("#production_companies").html(companies);
				
				$("#overview").html(res.overview);
				$("#vote_average").html(res.vote_average +" 점");
				$("#vote_count").html(res.vote_count + " 명");
				
				movieDetailTemp="";
				movieDetailTemp={
					id:res.id,
					title:res.title,
					tagline:res.tagline,
					original_title:res.original_title,
					genres:genres,
					runtime:res.runtime,
					original_language:res.original_language,
					release_date:res.release_date,
					production_companies:companies,
					overview:res.overview,
					vote_average:res.vote_average,
					vote_count:res.vote_count
				};
				
			},
			error:function(){
				alert("전송 실패");
			}
		});
		//영화 크레딧(감독 배우 정보) 요청
		$.ajax({
			type:"get",
			url:"https://api.themoviedb.org/3/movie/"+id+"/credits",
			data:{
				api_key:tmdbKey,
				async:false
			},
			success:function(res){
				movicCastingStr="";
				for(let i=0; i<res.cast.length; i++){
					movicCastingStr += res.cast[i].original_name;
					if(res.cast[i].character != "") movicCastingStr += "("+res.cast[i].character+")/";
					else movicCastingStr += "/"
					
					if(i == 9) break;
				}
				
				// 영어 -> 한글 
				$.ajax({
					type:"post",
					url:"https://translation.googleapis.com/language/translate/v2",
					data:{
						key:googleApiKey,
						q:movicCastingStr,
						target:"ko"
					},
					success:function(res){
						movicCastingStr = res.data.translations[0].translatedText;
						$("#actor").html(movicCastingStr);
						movieDetailTemp.actor=movicCastingStr;
					},
					error:function(a){
						alert("전송실패:");
					}
				});
			},
			error:function(a){
				alert("전송실패");
			}
		});
		
		
		//포스터 요청
		$.ajax({
			type:"get",
			url:"https://api.themoviedb.org/3/movie/"+id+"/images",
			data:{
				api_key:tmdbKey,
				include_image_language:"ko,null"
			},
			success:function(res){
				moviePosterStr="";
				$("#poster_path").html("");
				
				if(res.posters.length == 0 ){
					moviePosterStr = "이미지 준비중입니다.";
					$("#poster_path").html("이미지 준비중입니다.");
				}
				else{
					for(let i=0; i< res.posters.length; i++){
						moviePosterStr += res.posters[i].file_path+"/";
						$("#poster_path").html($("#poster_path").html() + '<img class="ml-1" src="https://image.tmdb.org/t/p/w500'+res.posters[i].file_path+'" width=150 />');
						if(i==9) break;
					}
					movieDetailTemp.poster_path=moviePosterStr;
				}
			},
			error:function(err){
				alert("전송 실패");
			}
		});
		
		// 트레일러 요청
		$.ajax({
			type:"get",
			url:"https://api.themoviedb.org/3/movie/"+id+"/videos",
			data:{
				api_key:tmdbKey,
				language:"ko-KR"
			},
			success:function(res){
				$("#videos").html("");
				if(res.results.length == 0){
					$("#videos").html("등록된 트레일러가 없습니다.");
				}
				else{
					let cnt = 0;
					let videos="";
					for(let i=(res.results.length-1); i>=0; i--){
						let temp = '<div class="mr-2"><iframe width="380" height="250"src="';
						temp += vidioSrc+"/"+res.results[i].key;
						temp += '"></iframe></div>';
						$("#videos").html($("#videos").html() + temp);
						videos += res.results[i].key +"/";
						if(++cnt == 9) break;
					}
					movieDetailTemp.videos = videos;
				}
				
			},
			error:function(err){
				alert("전송 실패");
			}
		});
		
		$("#movieDetail").css("display","none");
		$("#movieDetail").slideDown(500);
	}
	
	function movieSelect(){
		if(movieDetailArr != null){
			for(let i=0; i<movieDetailArr.length;i++){
				if(movieDetailArr[i].id == movieDetailTemp.id){
					alert("이미 올려둔 영화입니다.");
					return false;
				}
			}
		}
		
		movieDetailArr.push(movieDetailTemp);
		console.log(movieDetailArr);
		let temp = "";
		for(let i=0;i<movieDetailArr.length;i++){
			temp += '<div class="row mb-2">';
			temp += '<div class="col">'+movieDetailArr[i].id+'</div>';
			temp += '<div class="col">'+movieDetailArr[i].title+'</div>';
			temp += '<div class="col"><button type="button" class="btn btn-sm btn-warning" onclick="movieUnSelect('+i+')">취소</button></div>';
			temp += '</div>'
		}
		$("#movieSelected").html(temp);
	}
</script>
<body id="wrapper">
  <h4>영화 검색 및 추가</h4>
  <div class="d-flex flex-column">
	  <div class="d-flex flex-row-reverse">
		  <div class="d-flex flex-row mb-3">
		  	<div class="p-2"> 영화 검색</div>
				<div class="p-2 form-inline">
		  		<input type="text" class="form-control mr-sm-2" id="movieKeyword"  placeholder="Search">
	   	  	<button type="button" class="btn btn-sm btn-primary "  onclick="movieNameSearch()">Search</button>
	   	  	<button type="button" class="btn btn-sm btn-warning ml-2"  onclick="location.reload()">초기화</button>
		  	</div>
		  </div>
		</div>
		<div class="d-flex flex-row-reverse">
			<div class="d-flex flex-row mb-3">
				<div class="p-2" id="releaseDateForm">
						<span>form</span>
						<span><input type="date" id="relaseFrom"></span>
						<span>to</span>
						<span><input type="date" id="relaseTo"></span>
				</div>
	  		<div class="p-2">정렬 기준 </div>
	  		<div class="p-2">
					<select id="sortBy" class="custom-select">
			    <option value="popularity.desc">인기순(desc)</option>
			    <option value="popularity.asc">인기순(asc)</option>
			    <option value="primary_release_date.desc">날짜기준(desc)</option>
			    <option value="primary_release_date.asc">날짜기준(asc)</option>
			  </select>
				</div>
				<div class="p-2"><button type="button" class="btn btn-sm btn-info" onclick="requireSearch()">조건 조회</button></div>
			</div>
		</div>
	</div>
	<div class="d-flex align-items-center">
		<div style="width: 69px;"><span class="material-symbols-outlined" id="prev" onclick="prevMovie()" style="display: none;">arrow_back_ios</span></div>
		<div class="text-center content" style="width: 800px">  
			<div class="row dth m-3" id="dth">
				<!-- <div class="col-1"></div> -->
				<div class="col"><b>메인 이미지</b></div>
				<div class="col"><b>영화 제목</b></div>
				<div class="col-2"><b>개봉일</b></div>
				<div class="col-2"><b>평점</b></div>
		  </div>
			<div class=" contentScroll flex-fill" id="movieList" style="height: 300px"></div>
			<div class="mt-3 p-2">
				<input type="number" id="curPage" style="width: 50px"> / <span id="totPage" style="width: 50px"></span> 
				<input type="button" class="btn btn-sm btn-info" value="이동" onclick="pageMove()"/>
			</div>
		</div>
		<div style="width: 69px;"><span class="material-symbols-outlined mr-5" id="next" onclick="nextMovie()">arrow_forward_ios</span></div>
		<!-- 영화 추가 리스트 -->
		<div class="text-center content" style="width: 800px">
			<div class="row">
		  	<div class="col dth">영화 ID</div>
		  	<div class="col dth">영화 제목</div>
		  	<div class="col dth">비고</div>
	  	</div>
	  	<hr/>
			<div class="d-flex flex-column mb-3 contentScroll" style="height: 300px;">
			  <div class="p-2">
			  	
			  </div>
			  
			  <div class="p-2" id="movieSelected">
			  	추가할 영화를 올려주세요
			  </div>
			</div>
		</div>
	</div>
	<!-- 영화 상세 정보 -->
		<div class="text-center content mt-4 p-2 contentScroll" id="movieDetail" style="width: 1200px; display: none; margin: auto;">
		<div class="d-flex justify-content-end">
			<button type="button" class="btn btn-info" onclick="movieSelect()">영화 올리기</button>
		</div>
		<div class="p-3">
			<div class="row">
				<div class="col-2" id="dth">포스터</div>
				<div class="col d-flex flex-row m-2" id="poster_path" style="overflow-x: scroll;"></div>
			</div>
			<div class="row">
				<div class="col-2" id="dth">트레일러</div>
				<div class="col d-flex flex-row m-2" id="videos" style="overflow-x: scroll;"></div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-2" id="dth"><b>제목</b></div>
				<div class="col" id="title"></div>
				<div class="col-2" id="dth"><b>원제</b></div>
				<div class="col" id="original_title"></div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-2" id="dth"><b>태그</b></div>
				<div class="col" id="tagline"></div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-2" id="dth"><b>상영시간</b></div>
				<div class="col" id="runtime"></div>
				<div class="col-2" id="dth"><b>원어</b></div>
				<div class="col" id="original_language"></div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-2" id="dth"><b>개봉일</b></div>
				<div class="col" id="release_date"></div>
				<div class="col-2" id="dth"><b>평점</b></div>
				<div class="col" id="vote_average"></div>
				<div class="col-2" id="dth"><b>평점 참여 수</b></div>
				<div class="col" id="vote_count"></div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-2" id="dth"><b>장르</b></div>
				<div class="col" id="genres"></div>
			</div>
			<hr/>
			<hr/>
			<div class="row">
				<div class="col-2" id="dth"><b>배우</b></div>
				<div class="col" id="actor"></div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-2" id="dth"><b>배급사</b></div>
			<div class="col" id="production_companies"></div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-2" id="dth"><b>소개</b></div>
				<div class="col" id="overview"></div>
			</div>
		</div>  
	</div>
<p><br/></P>
</body>
</html>