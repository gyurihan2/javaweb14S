<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<title>MyPage</title>
	 <style>
    ul{
      list-style-type: none;
    }
    button{
      border: 0px; 
      background-color:  #faf4f4;
    }
    .myPage-info{
        width:960px;
        height: 450px;
        background-color: #faf4f4; 
        border-radius: 30px;
        padding: 15px;
    }
    
    #totalReser, #totalMovie{
    	 cursor:pointer;
    }
    
  .material-symbols-outlined {
    width: 17px;
    height: 20px;
    font-variation-settings:
    'FILL' 0,
    'wght' 400,
    'GRAD' 0,
    'opsz' 20
  }
  
  .material-symbols-outlined {
    width: 17px;
    height: 20px;
    font-variation-settings:
    'FILL' 0,
    'wght' 300,
    'GRAD' 0,
    'opsz' 20
  }
  .contentScroll{
		overflow-y: scroll;
	}
  .contentScroll::-webkit-scrollbar {
    width: 15px;
  }
  .contentScroll::-webkit-scrollbar-track {
    background-color: transparent;
  }
  </style>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js" ></script>
	<script>
		'use script';
		
		function photoChange(){
			let url = "${ctp}/member/photoChangePage";
			window.open(url,"nWin","width=595px,height=280px");
		}
		
		function nickNameChange(){
			let url = "${ctp}/member/nickNameChangePage";
			window.open(url,"nWin","width=595px,height=280px");
		}
		
		let myReserJsonData = ${myReserJsonData};
		console.log(myReserJsonData);
		let today = new Date();
		let reserCnt=myReserJsonData.length; // 총 예약수
		let viewCnt=0; // 내가본 영화
		
		let reserHtml='<div>예약 목록이 없습니다.</div>';
		let viewHtml='';
		
		// 총예약 / 내가본 영화 목록
		if(myReserJsonData.length>0){
			reserHtml='';
			for(let i=0;i<myReserJsonData.length;i++){
				let reserDate= new Date(myReserJsonData[i].playDate+" "+myReserJsonData[i].playTime);
				
				reserHtml +='<div class="d-flex align-items-center m-2" >';
				reserHtml +='<img src="https://image.tmdb.org/t/p/w500'+myReserJsonData[i].moviePoster+'" width="135px" height="135px"/>';
				reserHtml +='<div class="ml-5 d-flex flex-column">';
				reserHtml +='<div><h5>'+myReserJsonData[i].movieName+'</h5></div>';
				reserHtml +='<div>'+myReserJsonData[i].playDate+' '+myReserJsonData[i].playTime+'~'+myReserJsonData[i].endTime+'</div>';
		
				if(today.getTime() > reserDate.getTime()){
					viewCnt++;
					reserHtml +='<div>'+myReserJsonData[i].theaterName+'('+(myReserJsonData[i].adultCnt+myReserJsonData[i].childCnt)+'명)</div>';
					reserHtml +='</div></div><hr/>';
					
					viewHtml +='<div class="d-flex align-items-center m-2" >';
					viewHtml +='<img src="https://image.tmdb.org/t/p/w500'+myReserJsonData[i].moviePoster+'" width="135px" height="135px"/>';
					viewHtml +='<div class="ml-5 d-flex flex-column">';
					viewHtml +='<div><h5>'+myReserJsonData[i].movieName+'</h5></div>';
					viewHtml +='<div>'+myReserJsonData[i].playDate+' '+myReserJsonData[i].playTime+'~'+myReserJsonData[i].endTime+'</div>';
					viewHtml +='<div>'+myReserJsonData[i].theaterName+'('+(myReserJsonData[i].adultCnt+myReserJsonData[i].childCnt)+'명)</div>';
					viewHtml +='</div></div><hr/>';
					
				}
				else{
					reserHtml +='<div>'+myReserJsonData[i].theaterName+'('+(myReserJsonData[i].adultCnt+myReserJsonData[i].childCnt)+'명)';
					reserHtml +='<button type="button" class="btn btn-sm btn-info ml-2" onclick="detailReser('+i+')">상세 보기</button>'
					reserHtml +='<button type="button" class="btn btn-sm btn-warning ml-2" onclick="deleteReser('+i+')">예매 취소</button></div>'
					reserHtml +='</div></div><hr/>';
				}
			}
		}
		
		// 총 예약 리스트 보기
		function totalReserView(){
			$("#totalViewContent").css("display","none");
			$("#totalReserContent").slideToggle(500,function(){
				$("#totalReserContent").slideDown(1000);
			});
				
		}
		// 내가본 영화 리스트 보기
		function totalMovieView(){
			$("#totalReserContent").css("display","none");
			$("#totalViewContent").slideToggle(500,function(){
				$("#totalViewContent").slideDown(1000);
			});
		}
		
		//예약 상세 보기
		function detailReser(index){
			let url="${ctp}/reservation/reserDetailPage?idx="+myReserJsonData[index].reservationIdx;
			window.open(url,"n_win","width=500, height=300");
		}
		
		//예약 취소
		function deleteReser(index){
			let reserDate = new Date(myReserJsonData[index].playDate+" "+myReserJsonData[index].playTime);
			let diffTime = reserDate.getTime()-today.getTime();
			
			if(diffTime/(1000*60) < 10){
				alert("상영하기 10분전에는 예매 취소 불가능 합니다.");
				return false;
			}
			
			let peapleCnt=Number(myReserJsonData[index].adultCnt)+Number(myReserJsonData[index].childCnt)
			
			// 환불 처리 필요
			$.ajax({
				type:"post",
				url:"${ctp}/reservation/reservationCallOff",
				data:{
					idx:myReserJsonData[index].reservationIdx,
					scheduleIdx:myReserJsonData[index].scheduleIdx,
					peapleCnt:peapleCnt
				},
				success:function(res){
					if(res == "-2" || res == "0") alert("예약 취소 실패");
					else{
						alert("예약 취소 되었습니다.");
						location.reload();
					}
				},
				error:function(){
					alert("전송 실패");
				}
			});
		}
		
		$(function(){
			
			$("#totalReser").html(reserCnt+" 건");
			$("#totalMovie").html(viewCnt+" 건");
			$("#totalReserList").html(reserHtml);
			$("#totalViewList").html(viewHtml);
		})
		
		
	</script>
</head>
<body id="wrapper">
<p><br/></p>
<div class="container">
	<h2 class="mb-5">My Page</h2>
	<div class="myPage-info pt-5" style="height:350px;">
    <!-- 1row-->
    <div class="d-flex align-items-center">
    	<span style=" border-radius: 70%; overflow: hidden; cursor : pointer;" onclick="photoChange()">
    		<img src="${ctp}/member/image/${vo.photo}" width="135px" height="135px" onerror='this.src="${ctp}/member/image/noImage.jpg"'/>
    	</span>
      <div class="ml-5" style="display: inline-block;">
        <div>
          <strong>${vo.name}</strong>&nbsp;<em>${vo.mid}</em>&nbsp;&nbsp;&nbsp;&nbsp;<span> 닉네임 : <i>${vo.nickName}</i></span>
          <button type="button" onclick="nickNameChange()"><span class="material-symbols-outlined">
            border_color
          </span></button>
        </div>
        <hr/>
        <c:set var="levelUpDates" value="${fn:split(vo.levelUpDate,'-')}"/>
        <div>
          <p class="" style="margin-bottom:4px;color: #342929; font-size: 20px; line-height: 20px;">            
            고객님은  ${levelUpDates[0]}년 ${levelUpDates[1]}월 <strong class="txt-purple">${sStrLevel}</strong> 입니다.
          </p>
          <button class="btn btn-info bnt-sm mt-4" onclick="location.href='${ctp}/member/memberPwdChkPage';"><span>회원정보 수정</span></button>
        </div>
      </div>
      <div class="ml-2 text-cneter ml-3" style="display: inline-block;">
        <h4 class="ml-4">나의 예매 내역</h4>
        <ul>
          <li><strong>총 예매 내역</strong>&nbsp;&nbsp;<span id="totalReser" onclick="totalReserView()">0 건</span></li>
          <li><strong>내가 본 영화</strong>&nbsp;&nbsp;<span id="totalMovie" onclick="totalMovieView()">0 건</span></li>
          <li><strong>내가 쓴 평점</strong>&nbsp;&nbsp;<span id="totalReview">0 건</span></li>
        </ul>
      </div>
    </div>
    <hr/>
    <!-- 2row-->
    <div class="d-flex flex-row align-items-center justify-content-center mt-4">
      <div>
        <h4>POINT 점수&nbsp;&nbsp;<button><span class="material-symbols-outlined">
          add_box
        </span></button></h4>
          <strong>사용가능 포인트: </strong> <span><em><fmt:formatNumber value="${vo.point}" pattern="#,###"/> </em>점</span>
      </div>
      <div class="ml-3">
      	<h4>VIP 점수</h4>
        <strong>누적 점수: </strong> <span><em> <fmt:formatNumber value="${vo.totPoint}" pattern="#,###"/> </em>점</span>
      </div>
    </div>
  </div>
</div>
<div class="container mt-3" id="totalReserContent" style="display: none;">
	<div class="myPage-info d-flex flex-column"> 
		<h4 class="text-left">총 예약 목록</h4>
		<div class="contentScroll"  id="totalReserList" style="height: 390px;">
		</div>
	</div>
</div>
<div class="container mt-3" id="totalViewContent" style="display: none;" >
	<div class="myPage-info d-flex flex-column" >
		<h4 class="text-left">내가 본 영화</h4>
		<div class="contentScroll"  id="totalViewList" style="height: 390px;">
		</div>
	</div>
</div>
<p><br/></p>
</body>
</html>