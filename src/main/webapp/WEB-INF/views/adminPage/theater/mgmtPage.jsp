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
		.col{
			margin-bottom: 10px;
		}
		/* .row_body{
			border-bottom: solid 1px black;
		} */
		.row_body:hover{
			background-color: #d3d3d3;
		}
		select{
			text-align-last:center;
			vertical-align: middle;
		}
	</style>
	<script>
		'use strict';
		
	function workChange(idx,name,obj){
		let work = $("#work"+idx).val();
		
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
	
	</script>
</head>
<body id="wrapper">
	<div class="mb-5" id="top_title">
		<h4 class="m-1 p-0"><b>상영관 관리</b>	</h4>
	</div>
	<p></p>
	
	<div class="content container-xl mt-5 p-3 text-center">
		<div class="d-flex flex-row-reverse mb-3">
			<div class="p-2"><input type="button" value="상영관 추가" class="btn btn-info btn-sm" data-toggle="modal" data-target="#theaterCreateModal"/></div>
		</div>
		<c:if test="${!empty vos}">
			<div class="row row_head">
				<div class="col"><b>이름</b></div>
				<div class="col"><b>테마</b></div>
				<div class="col"><b>좌석수</b></div>
				<div class="col"><b>가격</b></div>
				<div class="col"><b>상태</b></div>
			</div>
			<hr/>
			<c:forEach var="vo" items="${vos}">
				<div class="row row_body align-items-center">
					<div class="col" onclick="window.open('${ctp}/theater/theaterDetailPage?idx=${vo.idx}','nWin','width=800px,height=800px')">${vo.name} 상영관</div>
					<div class="col" onclick="window.open('${ctp}/theater/theaterDetailPage?idx=${vo.idx}','nWin','width=800px,height=800px')">${vo.thema}</div>
					<div class="col" onclick="window.open('${ctp}/theater/theaterDetailPage?idx=${vo.idx}','nWin','width=800px,height=800px')">${vo.seat}</div>
					<div class="col" onclick="window.open('${ctp}/theater/theaterDetailPage?idx=${vo.idx}','nWin','width=800px,height=800px')">${vo.price}</div>
					<div class="col">
						<div class="form-group">
						  <select class="form-control workPre" id="work${vo.idx}" onchange="workChange('${vo.idx}','${vo.name}',this)">
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
		<c:if test="${empty vos}">
			<div class="text-center"> 내역이 없습니다.</div>
		</c:if>
	</div>
<p><br/></p>
</body>
</html>