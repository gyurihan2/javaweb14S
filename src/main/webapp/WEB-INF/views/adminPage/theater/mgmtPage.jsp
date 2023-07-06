<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>상영관 관리 페이지</title>
	<style>
		 .theater{
            overflow-y: scroll;
        }
        .theater::-webkit-scrollbar {
          width: 15px;
        }
        .theater::-webkit-scrollbar-track {
          background-color: transparent;
        }
        
		.col{
			margin-top : 5px;
			height: 50px;
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
	</style>
	<script>
		'use strict';
		
	function workChange(idx,name,obj){
		let work = $(obj).val();
		let chk = confirm(name+"상영관 작동 여부를 수정 하시겠습니까?");
		
		if(chk){
			$.ajax({
				type:"post",
				url:"${ctp}/theater/theaterChangWork",
				data:{
					idx:idx,
					work:work
				},
				success:function(res){
					if(res =="1") alert("수정 되었습니다.");
					else alert("수정 실패");	
					
					location.reload();
				},
				error:function(){
					alert("전송 실패");
					location.reload();
				}
			});
		}
		else{
			location.reload();
		}
		
	} 
	
	function displayChange(idx,name,obj){
		let display = $(obj).val();
		let chk = confirm(name+"를 메인화면 출력 여부를 수정 하시겠습니까?");
		
		if(chk){
			$.ajax({
				type:"post",
				url:"${ctp}/theater/themaChangeDisplay",
				data:{
					idx:idx,
					display:display
				},
				success:function(res){
					if(res =="1") alert("수정 되었습니다.");
					else alert("수정 실패");	
					
					location.reload();
				},
				error:function(){
					alert("전송 실패");
					location.reload();
				}
			});
		}
		else{
			location.reload();
		}
		
	} 
	
	</script>
</head>
<body id="wrapper">
	<div class="mb-5" id="top_title">
		<h4 class="m-1 p-0"><b>상영관 관리</b>	</h4>
	</div>
	<p></p>
	<div class="d-flex flex-row test">
		<!-- 상영관 설정 -->
		<div class="content mt-5 p-3 text-center theater" style="height: 700px;width: 750px;" >
			<div class="d-flex flex-row-reverse mb-3">
				<div class="p-2"><input type="button" value="상영관 추가" class="btn btn-info btn-sm"/></div>
			</div>
			<c:if test="${!empty theaterVOS}">
				<div class="row row_head ">
					<div class="col"><b>이름</b></div>
					<div class="col"><b>테마</b></div>
					<div class="col"><b>좌석수</b></div>
					<div class="col"><b>가격</b></div>
					<div class="col"><b>상태</b></div>
				</div>
				<hr/>
				<c:forEach var="vo" items="${theaterVOS}">
					<div class="row row_body align-items-center">
						<div class="col" onclick="window.open('${ctp}/theater/theaterDetailPage?idx=${vo.idx}','nWin','width=800px,height=800px')">${vo.name} 상영관</div>
						<div class="col" >${vo.thema}</div>
						<div class="col" >${vo.seat}</div>
						<div class="col" >${vo.price}</div>
						<div class="col">
							<div class="form-group">
							  <select class="form-control workPre" id="display${vo.idx}" onchange="workChange('${vo.idx}','${vo.name}',this)">
							    <option value="1" <c:if test="${vo.work==1 }">selected</c:if>>오픈</option>
							    <option value="2" <c:if test="${vo.work==2 }">selected</c:if>>임시 중단</option>
							    <option value="3" <c:if test="${vo.work==3 }">selected</c:if>>중지</option>
							    <option value="4" <c:if test="${vo.work==4 }">selected</c:if>>차단</option>
							  </select>
							</div>
						</div>
					</div>
					<hr class="mb-2 mt-2"/>
				</c:forEach>
			</c:if>
			<c:if test="${empty theaterVOS}">
				<div class="text-center"> 내역이 없습니다.</div>
			</c:if>
		</div>
		<!-- 테마 설정 -->
		<div class="content mt-5 ml-4 p-2 text-center" style="width: 700px; height: 500px">
			<div class="mt-2">
				<input type="button" value="테마 추가" class="btn btn-info btn-sm" onclick="window.open('${ctp}/theater/themaInputPage','nWin','width=800 height=1000')" style="float: right;"/>
			</div>
			<br/>
			<c:if test="${!empty themaVOS}">
				<div class="row row_head mt-3">
					<div class="col"><b>메인 이미지</b></div>
					<div class="col"><b>테마명</b></div>
					<div class="col"><b>가격</b></div>
					<div class="col"><b>메인화면 표시</b></div>
				</div>
				<hr/>
				<c:forEach var="vo" items="${themaVOS}">
					<div class="row row_body align-items-center">
						<div class="col" onclick="window.open('${ctp}/theater/themaDetailPage?idx=${vo.idx}','nWin','width=1030px,height=800px')">
							<img src="${ctp}/thema/image/${vo.mainImg}" width="70px" height="50px">
						</div>
						<div class="col">${vo.name}</div>
						<div class="col">${vo.price}</div>
						<div class="col">
							<div class="form-group">
							  <select class="form-control workPre" id="work${vo.idx}" onchange="displayChange('${vo.idx}','${vo.name}',this)">
							    <option value="YES" <c:if test="${vo.display=='YES' }">selected</c:if>>YES</option>
							    <option value="NO" <c:if test="${vo.display=='NO' }">selected</c:if>>NO</option>
							  </select>
							</div>
						</div>
					</div>
					<hr class="mb-2 mt-2"/>
				</c:forEach>
			</c:if>
			<c:if test="${empty themaVOS}">
				<div class="text-center"> 내역이 없습니다.</div>
			</c:if>
		</div>
	</div>
<p><br/></p>
</body>
</html>