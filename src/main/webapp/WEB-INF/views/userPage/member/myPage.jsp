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
		
		
		
	</script>
</head>
<body id="wrapper">
<p><br/></p>
<div class="container">
	<h2 class="mb-5">My Page</h2>
	<div class="myPage-info pt-5">
    <!-- 1row-->
    <div class="d-flex align-items-center">
    	<span style=" border-radius: 70%; overflow: hidden; cursor : pointer;" onclick="photoChange()">
    		<img src="${ctp}/member/image/${vo.photo}" width="135px" height="135px" onerror=this.src="${ctp}/member/image/noImage.jpg"/>
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
          <li><strong>예매 내역</strong><span>&nbsp;&nbsp;건</span></li>
          <li><strong>내가 본 영화</strong><span>&nbsp;&nbsp;건</span></li>
          <li><strong>내가 쓴 평점</strong><span>&nbsp;&nbsp;건</span></li>
        </ul>
      </div>
    </div>
    <!-- 2row-->
    
  
    <div class="d-flex align-items-center mt-4">
      <div>
        <h4>POINT 점수&nbsp;&nbsp;<button><span class="material-symbols-outlined">
          add_box
        </span></button></h4>
        <ul>
          <li><strong>사용가능 포인트: </strong> <span><em><fmt:formatNumber value="${vo.point}" pattern="#,###"/> </em>점</span></li>
        </ul>
        <div><h4>VIP 점수</h4>
          <ul>
            <li><strong>누적 점수: </strong> <span><em> <fmt:formatNumber value="${vo.totPoint}" pattern="#,###"/> </em>점</span></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
<p><br/></p>
</body>
</html>