<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <title>영화 상세 보기</title>
  <style>
  .star {
		position: relative;
		font-size: 20px;
		color: #ddd;
	}
	.star span {
		width: 0;
		position: absolute;
		left: 0;
		color:  #ffd400;
		overflow: hidden;
		pointer-events: none;
	}
	
	.material-symbols-outlined {
		font-size:15px;
	  font-variation-settings:
	  'FILL' 0,
	  'wght' 400,
	  'GRAD' 0,
	  'opsz' 48
	}
	#movieListBtn, .videoThumbnail, .moviePhotobtn{
		cursor:pointer;
	}

	</style>
	<script>
		'use strict';
		
		function changeVideo(video){
			document.getElementById("test").src = "https://www.youtube.com/embed/"+video;
		}
		
		let jsonData=${jsonData} == "-1" ? null : ${jsonData};
		let videoArr=[];
		let photoArr=[];
		let photoCnt=0;
		if(jsonData != null) {
			
			if(jsonData.videos != null){
				videoArr=jsonData.videos.split("/");
			}
			if(jsonData.poster_path !=null){
				photoArr=jsonData.poster_path.split("/");
				photoArr.shift();
			}
		}
		
		//포스터  이전 버튼
		function moviePhotoPrev(){
			if(photoCnt-- == 0) photoCnt=photoArr.length-1;
			$("#moviePostList").attr("src","https://image.tmdb.org/t/p/w500/"+photoArr[photoCnt]);
			$("#stilCutTitle").html("스틸컷("+(photoCnt+1)+"/"+photoArr.length+")");
		}
		//포스터 다음  버튼
		function moviePhotoNext(){
			if(photoCnt++ == photoArr.length-1) photoCnt=0;
			$("#moviePostList").attr("src","https://image.tmdb.org/t/p/w500/"+photoArr[photoCnt]);
			$("#stilCutTitle").html("스틸컷("+(photoCnt+1)+"/"+photoArr.length+")");
		}
		
$(function(){
			
			// 트레일러
			if(videoArr.length>0){
				for(let i=0; i<videoArr.length; i++){
					$.ajax({
						type:"get",
						url:"https://noembed.com/embed?url=https://www.youtube.com/watch?v="+videoArr[i],
						success:function(res){
							let resData=JSON.parse(res)
							let html = '<font class="mr-2" size="1em" color="#2A6FB6"><span style="border: 1px solid #2A6FB6"><b>HD</b></span></font>';
							html +='<font size="1em" color="#333333">';
							
							if(resData.title.length >25)html += resData.title.substring(0,25)+"...";
							else html +=resData.title;
							html +='</font>';
							$("#videoTile_"+i).html(html);
						},
						error:function(){
							$("#videoTile_"+i).html("준비중");
						}
					});
					
				}
			}
			
			/*  포스터 */
			if(photoArr.length > 0){
				$("#moviePostList").attr("src","https://image.tmdb.org/t/p/w500/"+photoArr[0]);
			}
			if(photoArr.length <= 1){
				$(".moviePhotobtn").css("display","none");
				if(photoArr.length == 0) {
					$("#moviePostContet").html("<h3 class='text-center'>준비중입니다.</h3>");
				}
			}
		});
		

	/* 통계 */	
		
	google.charts.load("current", {packages:['corechart']});
	
	// 연령대
  function drawChart() {
	  $("#columnchart_values").html("");
	 	
    var data = google.visualization.arrayToDataTable([
      ["Element", "인원", { role: "style" } ],
      <c:forEach var="vo" items="${ageStatisticsVOS}">
      	["${vo.age_group}",${vo.cnt},"#b87333"],
			</c:forEach>
    ]);

    var view = new google.visualization.DataView(data);
    view.setColumns(
    		[0, 1,
       		 { calc: "stringify",
         	 sourceColumn: 1,
	         type: "string",
	         role: "annotation" },
         2]);
    var options = {
      width: 330,
      height: 180,
      bar: {groupWidth: "95%"},
      legend: { position: "none" },
    };
    var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
    chart.draw(view, options); 
	}
	
	// 성별
	google.charts.load('current', {'packages':['corechart']});

	function drawChart2() {
    var data = google.visualization.arrayToDataTable([
      ['Task', 'Hours per Day'],
      ['남자', ${genderRatioVO.male}],
      ['여자', ${genderRatioVO.female}]
    ]);
    
    var options = {
      pieHole: 0.4,
    };

    var chart = new google.visualization.PieChart(document.getElementById('piechart'));

    chart.draw(data, options);
  }
	
  if(${!empty ageStatisticsVOS}) google.charts.setOnLoadCallback(drawChart);
  if(${!empty genderRatioVO}) google.charts.setOnLoadCallback(drawChart2);
	</script>
</head>
<body id="wrapper">
	<div class="container-xl mt-5" style="width: 1000px">
		
		<c:if test="${!empty movieVO}">
			<div class="d-flex flex-row">
				<div>
					<img src="https://image.tmdb.org/t/p/w500${movieVO.main_poster}" width="185px" height="260px">
				</div>
				<div class="d-flex flex-column flex-fill ml-5">
					<div>
						<span><font size="5em"><strong>${movieVO.title}</strong></font></span>
						<c:if test="${!empty scheduleVO}">
							<span class="ml-3" style="border: 0.5px solid #3E82A4"><font size="2em" color="#3E82A4"><b>현재 상영중</b></font></span>
						</c:if>
					</div>
					<div>
						<font color="#666666" size="1em">${movieVO.tagline}</font>
					</div>
					<div class="d-flex flex-row align-items-center mt-3">
						<c:set var="average" value="${fn:substring(movieVO.vote_average,0,3)}"/>
	  				<c:set var="averageArr" value="${fn:split(movieVO.vote_average,'.')}"/>
	  				<c:if test="${average != 0.0 }">
		  				<span class="star">★★★★★
								<c:if test="${average-averageArr[0]+0.5 >= 1 }">
			        		<span style="width:${((averageArr[0]-1)*10)+10}%">★★★★★</span>
								</c:if>
								<c:if test="${average-averageArr[0]+0.5 < 1 }">
			        		<span style="width:${((averageArr[0]-1)*10)}%">★★★★★</span>
								</c:if>
	    				</span>
	    				<span><font size="1.3em">(${average}/${movieVO.vote_count}명)</font></span>
	    			</c:if>
	    			<c:if test="${average == 0.0 }">
	    				<span><font size="1.3em">(리뷰 참여 이력이 없습니다.)</font></span>
	    			</c:if>
					</div>
					<div>
						<font size="2em">예매율 ....</font>
					</div>
					<hr/>
					<div>
						<font size="2em">배우: ${movieVO.actor}</font>
					</div>
					<div>
						<font size="2em">장르: ${movieVO.genres} / 상영시간: ${movieVO.runtime}분 </font>
					</div>
				</div>
			</div>
			<div class="d-flex flex-row justify-content-center mt-5">
				<c:set var="overview" value="${fn:replace(movieVO.overview,'. ','.<br/>')}"/>
				${overview}
			</div>
			<!-- 통계 -->
			<div class="d-flex justify-content-center text-center mb-5 mt-3">
				<div style="width: 900px; height:250px;">
					<table class="table">
						<tr>
							<th style="width: 50%; border-right: 2px solid #F6F6F6;">성별 예매 분포</th>
							<th style="width: 50%;">연령별 예매 분포</th>
						</tr>
						<tr style="border-bottom: 2px solid #F6F6F6;">
							<td style="width: 50%; height: 230px; border-right: 2px solid #F6F6F6;">
								 <div class="d-flex justify-content-center" id="piechart" style="width: 100%; height: 100%;">예약 이력이 없습니다.</div>
							</td>
							<td style="width: 50%; height: 230px;">
								<div class="d-flex justify-content-center" id="columnchart_values">
									예약 이력이 없습니다.
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 트레일러 -->
			<div class="d-flex mt-4 align-items-center" style="width: 900px; height:40px; margin: auto; background-color: #F6F6F6">
				<font color="#333333" size="3em"><span class="ml-2"><b>트레일러</b></span></font>
			</div>
			<c:if test="${movieVO.videos != null}">
				<c:set var="videoArr" value="${fn:split(movieVO.videos,'/')}"/>
				<div class="d-flex justify-content-center mt-2" style="margin: auto;">
					<div><iframe id="test" src="https://www.youtube.com/embed/${videoArr[0]}" width="500" height="300" allowfullscreen></iframe></div>
				</div>
				<div class="row" id="videoList" style="margin-left: 50px;">
					<c:forEach var="video" items="${videoArr}" varStatus="st">
						<div class="d-flex flex-column m-3">
							<img class="videoThumbnail" src="https://img.youtube.com/vi/${video}/0.jpg" onclick="changeVideo('${video}')" width="230" height="200">
							<div id="videoTile_${st.index}" style="width: 230">비디오 제목</div>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${movieVO.videos == null}">
				<h3 class='text-center'>준비중입니다.</h3>
			</c:if>
			<!-- 스틸컷 -->
			<div class="d-flex mt-4 align-items-center" style="width: 900px; height:40px; margin: auto; background-color: #F6F6F6">
				<c:set var="videoArr" value="${fn:split(movieVO.videos,'/')}"/>
				<font color="#333333" size="3em"><span class="ml-2" id="stilCutTitle"><b>스틸컷</b></span></font>
			</div>
			<div class="d-flex flex-row justify-content-center">
	      <div class="row mt-3">
	        <div class="col align-self-center"> <!--왼쪽 공백-->
          	<span class="material-symbols-outlined moviePhotobtn" onclick="moviePhotoPrev()" style="font-size: 110px">chevron_left</span>
	        </div>
	        <!-- 이미지 -->
	       	<div id="moviePostContet"><img id="moviePostList" width="400" height="500" alt="tes"/></div>
	        <div class="col align-self-center movienext"><!--오른쪽 공백-->   
            <span class="material-symbols-outlined moviePhotobtn" onclick="moviePhotoNext()" style="font-size: 110px">chevron_right</span>
	        </div>
	    	</div>
			</div>
		</c:if>
		<c:if test="${empty movieVO}">
			<h3>영화 정보가 없습니다...</h3>
		</c:if>
	</div>
<p><br/></P>
</body>
</html>