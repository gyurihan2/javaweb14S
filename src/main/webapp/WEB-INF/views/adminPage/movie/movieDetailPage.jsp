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
  					
  					prePoster = $(this).val();
  				},
  				error:function(){
  					alert("전송 실패");
  				}
  			});
  			
  			
  		});
  	
  	});
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
		<button type="button" class="btn btn-info mr-3">업데이트 요청(API)</button>
		<button type="button" class="btn btn-danger">삭제</button>
	</div>
<p><br/></P>
</body>
</html>