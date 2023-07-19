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
		
		let movieArr = [];
		let themaArr = ${jsonData2};
		let randomSu="";
		
		
		
		function changeImgHall(hall){
		   document.getElementById('hallImgSrc').src = "${ctp}/thema/image/"+hall;
		}

			let movieHallCnt=0;
			let statusTime;

		function moviehall(){
			document.getElementById('hallImgSrc').src= "${ctp}/thema/image/"+themaArr[movieHallCnt++].mainImg;
	    if(movieHallCnt == themaArr.length) movieHallCnt=0;
		}

		function movieHallAutoStart(){
	    moviehall();
	    statusTime = setTimeout(movieHallAutoStart,3000);
		}
		function movieHallAutoStop(){
	    clearTimeout(statusTime);
		}
		
		function movieChartPrevious(){
		    startPage--;
		    if(startPage == 0) document.getElementById("moviePrevious").style.visibility="hidden";
		    if(startPage >= 0) document.getElementById("movieNext").style.visibility="visible";
		    
		    let movieChart = document.getElementsByName("movieChartImg");
		    let moviename = document.getElementsByName("movieChartName");
		    let start = startPage*4;
		    for(let i=0;i<4;i++){
		        if(movieArr[start].title != null){
		            if( movieChart[i].style.display =="none") movieChart[i].style.display="block"
		            movieChart[i].src= "https://image.tmdb.org/t/p/w500"+movieArr[start].main_poster;
		            moviename[i].innerText=movieArr[start].title;
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
		        if(movieArr.length > start){
		        	movieChart[i].src="https://image.tmdb.org/t/p/w500"+movieArr[start].main_poster;
			        moviename[i].innerText=movieArr[start].title;
		        	start++;
		        }
		        else{
		            movieChart[i].style.display="none";
		            moviename[i].innerText="";
		            console.log("aaa");
		            start++;
		            
		        }
		    }
		}
		
		function videoPlay(){
			randomSu = Math.floor(Math.random() * movieArr.length + 1);
			console.log("---");
			console.log(movieArr[randomSu-1].videos);
			if(movieArr[randomSu-1].videos != null){
				let video = movieArr[randomSu-1].videos.split("/");
				$("#test").attr("src","https://www.youtube.com/embed/"+video[0]+"?autoplay=1&mute=1&playlist="+video[0]+"&loop=1&modestbranding=1");
			}
			else{
				videoPlay();
			}
		}
		
		$(function(){
			if(${fn:length(vos)} <= 4){
				document.getElementById("movieNext").style.visibility="hidden";
			}
			
			if(${!empty jsonData}){
				movieArr=${jsonData};
				videoPlay();
			}
			
		 movieHallAutoStart();
		    hall_lists.addEventListener('mouseout',()=>{
		        movieHallAutoStart();
		    });
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
		<c:if test="${!empty vos}">
    	<iframe  width="889" height="500" id="test" frameborder="0" allowfullscreen></iframe>
		</c:if>
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
            <div class="col-2  text-right" id="movieAllView"><button onclick="location.href='${ctp}/reservation/reservationMainPage';"><b>예약하기</b></button></div>
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
                <a href="#"><img name="movieChartImg" src="https://image.tmdb.org/t/p/w500${vos[index].main_poster}"></a>
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
                    <img id="hallImgSrc" src="${ctp}/thema/image/${themaVOS[0].mainImg}">
                </div>
                <div id="hall_lists" onmouseover=movieHallAutoStop()>
									<ul id="hall_list">
										<c:forEach var="vo" items="${themaVOS}">
											<li id="${vo.mainImg}" onmouseover='changeImgHall("${vo.mainImg}")'><a href="#"><strong>${vo.name}</strong><span>${vo.hashTag }</a></span></li>
										</c:forEach>
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