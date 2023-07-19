<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>영화 상세 보기</title>
  <script src="${ctp}/js/apiKey.js"></script>
  <style>
		.dth_wide{
			font-weight: bold;
			font-size:20px;
			text-align: center;
			background-color: #f8f8f8;
			height: 40px;
			margin-bottom: 25px;
			padding: 5px;
		}
		
		.dth{
			font-weight: bold;
			font-size:20px;
			margin:10px;
			background-color: #f8f8f8;
		}
  </style>
  <script>
  	'use strict';
  	
  	const tmdbKey = config.tmdbApiKey;
		const googleApiKey = config.googleApiKey;
  	
  	$(function(){
  		var prePoster = $("input[name='poster']:checked").val();
  		
  		// 포스터 클릭시
  		$("input[name='poster']").click(function() {
  			
  			if(!confirm("변경하시겠습니까?")) {
  				$(this).prop('checked', false);
  				$("input[name='poster']:radio[value='"+prePoster+"']").prop('checked', true);
  				return false;
  			}
  			
  			$.ajax({
  				type:"post",
  				url:"${ctp}/movie/movieMainImageChange",
  				data:{
  					idx:"${vo.idx}",
  					posterSrc:"/"+$(this).val()
  				},
  				success:function(res){
  					if(res == "1") alert("수정 되었습니다.");
  					else alert("수정 실패");
  				},
  				error:function(){
  					alert("전송 실패");
  				}
  			});
  		});
  	
  	});
  	
  	let movieData="";
  	// 업데이트 데이터 요청(api)
  	function movieUpdate(){
  		
  		let id="${vo.idx}";
  		
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
				
				let genres = "";
				res.genres.forEach(function(genre){
					genres += genre.name+"/"
				});
				genres = genres.substring(0,genres.length-1);
				
				let companies = "";
				res.production_companies.forEach(function(company){
					companies+=company.name+"/"
				});
				
				companies = companies.substring(0,companies.length-1);
				
				movieData={
					idx:res.id,
					main_poster:res.poster_path,
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
				return false;
			}
		});
	
		let movicCastingStr="";	
		//영화 크레딧(배우 정보) 요청
		$.ajax({
			type:"get",
			url:"https://api.themoviedb.org/3/movie/"+id+"/credits",
			data:{
				api_key:tmdbKey,
				async:false
			},
			success:function(res){
				movicCastingStr="";
				console.log(res);
				for(let i=0; i<res.cast.length; i++){
					movicCastingStr += res.cast[i].original_name;
					if(res.cast[i].character != "") movicCastingStr += "("+res.cast[i].character+")/";
					else movicCastingStr += "/"
					if(i == 9) break;
				}
				movicCastingStr = movicCastingStr.substring(0,movicCastingStr.length-1);
				
				// 영어 -> 한글 
				$.ajax({
					type:"post",
					url:"https://translation.googleapis.com/language/translate/v2",
					async:false,
					data:{
						key:googleApiKey,
						q:movicCastingStr,
						target:"ko"
					},
					success:function(res){
						movicCastingStr = res.data.translations[0].translatedText;
						movieData.actor=movicCastingStr;
						
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
		
			let moviePosterStr="";
			//포스터 요청
			$.ajax({
				type:"get",
				url:"https://api.themoviedb.org/3/movie/"+id+"/images",
				data:{
					api_key:tmdbKey,
					include_image_language:"ko,null"
				},
				success:function(res){
					
					for(let i=0; i< res.posters.length; i++){
						moviePosterStr += res.posters[i].file_path;
						$("#poster_path").html($("#poster_path").html() + '<img class="ml-1" src="https://image.tmdb.org/t/p/w500'+res.posters[i].file_path+'" width=150 />');
						if(i==4) break;
					}
					if(moviePosterStr.indexOf(movieData.main_poster) != -1) movieData.poster_path=moviePosterStr;
					else if(movieData.main_poster != null) movieData.poster_path = movieData.main_poster + moviePosterStr;
					
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
					let cnt = 0;
					let videos="";
					for(let i=(res.results.length-1); i>=0; i--){
						videos += res.results[i].key +"/";
						if(cnt++ == 5) break;
					}
					videos = videos.substring(0,videos.length-1);
					movieData.videos = videos;
				},
				error:function(err){
					alert("전송 실패");
				}
			}).then(()=>{
				let json = JSON.stringify(movieData)
				console.log(json);
				$.ajax({
					type:"post",
					url:"${ctp}/movie/movieUpdate",
					data:{
						idx:"${vo.idx}",
						jsonData:json
					},
					success:function(res){
						if(res == "-1") alert("아이디가 일치 하지 않습니다\n 삭제 후 다시 등록해주세요");
						else if(res == 0) alert("업데이트 실패");
						else {
							alert("업데이트 완료");
							location.reload();
						}
					},
					error:function(){
						alert("전송 실패");
					}
				});
			});
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
					window.close();
				}
				else alert("삭제 실패");
			},
			error:function(){
				alert("전송 실패");
			}
		});
	}
  	
  </script>
</head>
<body>
	<div class="text-center">
		<h4><b>영화 상세 보기</b></h4>
	</div>
	<div class="container text-center " style="border: 1px solid;">
		<div class="d-flex flex-column mt-2">
			<div class="d-flex justify-content-end">
				<p>평 점(API)</p>
				<div>${vo.vote_average}점(${vo.vote_count}명)</div>
				<div class="">평점</div>
				<div>${vo.rating}점</div>
				<div>누적 관객</div>
				<div>${vo.totalView}명</div>
			</div>
			<p></p>
			<div class="dth_wide">
				포스터
			</div>
			<div>
				<c:if test="${!empty vo.poster_path}">
					<c:set var="posterArr" value="${fn:split(vo.poster_path,'/')}"/>
					<c:forEach var="poster" items="${posterArr}" varStatus="st">
						<label class="form-check-label">
							<img src="https://image.tmdb.org/t/p/w500/${poster}" width="100px" name="poster"/>
							<input type="radio" class="form-check-input" name="poster" value="${poster}" <c:if test="${fn:contains(vo.main_poster,poster)}">checked</c:if>>
						</label>
					</c:forEach>
				</c:if>
				<c:if test="${empty vo.poster_path}">
					이미지 준비중
				</c:if>
			</div>
			<hr/>
			<div class="dth_wide">
				트레일러
			</div>
			<div class="d-flex flex-row" style="width: 800px; overflow-x: scroll; margin: auto;">
				<c:if test="${!empty vo.videos}">
					<c:set var="videoArr" value="${fn:split(vo.videos,'/')}"/>
					<c:forEach var="video" items="${videoArr}" varStatus="st">
						<div class="mr-3">
							<iframe src="https://www.youtube.com/embed/${video}" width="380" height="250"></iframe>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty vo.videos}">
					트레일러 준비중
				</c:if>
			</div>
			<hr/>
			<div class="dtable">
				<div class="row align-items-center">
					<div class="col-2 dth">영 화 코 드</div>
					<div class="col">${vo.idx}</div>
					<div class="col-2 dth">영 화 제 목</div>
					<div class="col">${vo.title}</div>
				</div>
				<hr/>
				<div class="row align-items-center">
					<div class="col-2 dth">개 봉 일</div>
					<div class="col">${vo.release_date}</div>
					<div class="col-2 dth">장 르</div>
					<div class="col">${vo.genres}</div>
				</div>
				<hr/>
				<div class="row align-items-center">
					<div class="col-2 dth">원 제</div>
					<div class="col ">${vo.original_title}</div>
					<div class="col-2 dth">태 그</div>
					<div class="col ">${vo.tagline}</div>
				</div>
				<hr/>
			<div class="row align-items-center">
				<div class="col-2 dth">원 어</div>
				<div class="col ">${vo.original_language}</div>
				<div class="col-2 dth">상 영 시 간</div>
				<div class="col ">${vo.runtime}</div>
			</div>
			<hr/>
			<div class="row align-items-center">
				<div class="col-2 dth">배 우</div>
				<div class="col ">${vo.actor}</div>
			</div>
			<hr/>
			<div class="row align-items-center">
				<div class="col-2 dth">배 급 사</div>
				<div class="col ">${vo.production_companies}</div>
			</div>
			<hr/>
			<div class="row align-items-center">
				<div class="col-2 dth">소 개</div>
				<div class="col ">${vo.overview}</div>
			</div>
			</div>
			
		</div>
		<p></p>
	</div>
	<div class="d-flex justify-content-center mt-3">
		<button type="button" class="btn btn-info mr-3" onclick="movieUpdate()">업데이트 요청(API)</button>
		<button type="button" class="btn btn-danger" onclick="movieDelete('${vo.idx}','${vo.title}')">삭제</button>
	</div>
<p><br/></P>
</body>
</html>