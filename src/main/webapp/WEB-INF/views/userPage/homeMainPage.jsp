<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>MainPage</title>
	<script>
		'use script';
		let startPage=0;
		let endPage=Math.floor(${fn:length(vos)}/4);
		
		let mainImagesStr = '${mainImagesStr}';
		let titleStr = '${titleStr}';
		let mainImgesArr = mainImagesStr.split("/");
		let titleArr = titleStr.split("/");
		
		function movieChartPrevious(){
		    startPage--;
		    if(startPage == 0) document.getElementById("moviePrevious").style.visibility="hidden";
		    if(startPage >= 0) document.getElementById("movieNext").style.visibility="visible";
		    
		    let movieChart = document.getElementsByName("movieChartImg");
		    let moviename = document.getElementsByName("movieChartName");
		    let start = startPage*4;
		    for(let i=0;i<4;i++){
		        if(titleArr[start] != null){
		            if( movieChart[i].style.display =="none") movieChart[i].style.display="block"
		            
		            movieChart[i].src= "${ctp}/images/movieChart/"+mainImgesArr[start];
		            moviename[i].innerText=titleArr[start];
		            start++;
		        }
		        
		    }
		}

		function movieChartNext(){
		    startPage++;
		   
		    if(startPage == endPage) document.getElementById("movieNext").style.visibility="hidden";
		    if(startPage > 0) document.getElementById("moviePrevious").style.visibility="visible";

		    let movieChart = document.getElementsByName("movieChartImg");
		    let moviename = document.getElementsByName("movieChartName");
		    let start = startPage*4;
		    for(let i=0;i<4;i++){
		        if(titleArr[start] != null){
		        	movieChart[i].src="${ctp}/images/movieChart/"+mainImgesArr[start];
			        moviename[i].innerText=titleArr[start];
		        	start++;
		        }
		        else{
		            movieChart[i].style.display="none";
		            moviename[i].innerText="";
		            start++;
		            
		        }
		    }
		}
		
		$(function(){
			if(${fn:length(vos)} <= 4){
				document.getElementById("movieNext").style.visibility="hidden";
			}
		});
		
	</script>
</head>
<jsp:include page="/WEB-INF/views/include/userPage/homepageScript.jsp"/>
<body id="wrapper">
<p><br/></p>
<div class="container-fluid text-center" style="background: radial-gradient(rgb(54, 52, 52), black); height: 500px;">
<!-- 메인 영화 예고편 -->
	<div class="row">
	<div class="col ">
    	<!-- <iframe width="889" height="500" src="https://www.youtube.com/embed/d2VN6NNa9BE?" title="YouTube video player" frameborder="0" 
    	allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen"></iframe> -->
	</div>
	</div>
</div>
<!-- 영화 목록 -->
<div class="container-fluid  p-3 mainContainer">
  <div class="row">
    <div class="col">
      <div class="container-xl" id="movieContets">
        <div class="row">
            <div class="col-4  text-left" id="movieStaus">
                <button type="button" class="btn btn-light text-secondary font-weight-bold">상영 영화</button>
                <!-- <button type="button" class="btn btn-light text-secondary font-weight-bold">상영예정</button> -->
            </div>
            <div class="col "></div>
            <div class="col-2  text-right" id="movieAllView"><button onclick="location.href='${ctp}/ReservationPage.res';"><b>예약하기</b></button></div>
        </div>
        <div class="row mt-3">
            <div class="col align-self-center"> <!--왼쪽 공백-->
               <button class="btn" type="button" onclick="movieChartPrevious()" style="visibility: hidden;" id="moviePrevious">
                   <p><i class="fas fa-long-arrow-left fa-4x" style="color: #363535;"></i></p>
               </button>  
            </div>
            <c:forEach var="index" begin="0" end="3">
            	<c:if test="${!empty vos[index] }">
            		<div class="col text-center moviecontent movienext" >
                <a href="#"><img name="movieChartImg" src="${ctp}/images/movieChart/${vos[index].mainImg}"></a>
                <br/><span name="movieChartName">${vos[index].title}</span>
            		</div>
            	</c:if>
            </c:forEach>
            <div class="col align-self-center movienext"><!--오른쪽 공백-->   
                <button class="btn" type="button" onclick="movieChartNext()" id="movieNext">
                    <p><i class="fas fa-long-arrow-right fa-4x" style="color: #363535;"></i></p>
                </button>  
            </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- 특별관 목록 -->
<div class="container-fluid  p-3 mainContainer">
	<div class="row mt-5">
      <div class="col">
        <div class="specialhall_list">
          <div id="specialhall">
            <div><h2>특별관</h2></div>
              <div id="specialhall_content">
                <div id="hall_imags" style="float: left; padding-top: 10px;">
                    <img id="hallImgSrc" src="${ctp}/theater/imax.png">
                </div>
                <div id="hall_lists" onmouseover=movieHallAutoStop()>
									<ul id="hall_list">
										<li id="imax" onmouseover=changeImgHall(this)><a href="#"><strong>IMAX</strong><span>#대형스크린 #최고의몰입감</a></span></li>
										<li id="4dx" onmouseover=changeImgHall(this)><a href="#"><strong>4DX</strong><span>#모션 시트 #오감체험</span></li></a>
										<li id="screenx" onmouseover=changeImgHall(this)><a href="#"><strong>SCREENX </strong><span>#3면 확장스크린 #270도스크린</span></li></a>
										<li id="primium" onmouseover=changeImgHall(this)><a href="#"><strong>PREMIUM </strong><span>#리클라이너#최고급 좌석</span></a>
										</li>
									</ul> 
                </div>
              </div>
          </div>
        </div>
      </div>
  </div>
</div>
<p><br/></p>
</body>
</html>