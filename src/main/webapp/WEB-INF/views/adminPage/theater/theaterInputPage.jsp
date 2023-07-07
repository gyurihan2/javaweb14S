<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>상영관 신규 등록</title>
    <style>
		.row{
			border-bottom: solid 1px black;
		 	margin-top: 20px;
		 	margin-bottom: 20px;
		}
		.dth{
			font-weight: bold;
			font-size:15px;
			background-color: #f8f8f8;
			/* border-right : 1px solid rgba(0, 0, 0, 0.1); */
			height: 100%;
		}
		.row * {
			margin-bottom: 5px;
		}		
	</style>
	<script>
		'use strict';
		
		// 테마 선택 시
		function themaSelect(obj){
			
			$('#previewThema').css('display', 'none');
			let Arrindex = obj.value;
			
			var arrValues = new Array();
			arrValues = Object.values(${json});
			
			let img = document.createElement("img");
			img.setAttribute("src","${ctp}/thema/image/"+arrValues[Arrindex].mainImg);
			img.setAttribute("width",150);
			img.setAttribute("height",120);
			
			$("#themaImg").html("");
			let PreviewImg = document.querySelector("#themaImg");
			PreviewImg.appendChild(img);
			
			$("#themaPrice").html("<b>입장료</b>: " + arrValues[Arrindex].price+"원");
			$("#themaHashTag").html("<b>HashTage</b>: " + arrValues[Arrindex].hashTag);
			$("#themaIdx").val(arrValues[Arrindex].idx);
			
			$("#previewThema").slideDown(500);
			
		}
		
		// 생성 버튼
		function fCheck(){
			let name = $("#name").val();
			let seat = $("#seat").val();
			let themaIdx = $("#themaIdx").val();
			
			if(name==""){
				alert("상영관 이름을 입력하세요");
				return false;
			}
			else if(seat == ""){
				alert("좌석수를 입력하세요");
				return false;
			}
			else if(themaIdx == ""){
				alert("상영관 테마를 선택하세요");
				return false;
			}
			
			myform.submit();
			
		}
		
	</script>
</head>
<body>
<h3 class="text-center">상영관 등록</h3> 
<form name="myform"  method="post">
	<div class="container">
		<div class="row">
			<div class="col-2 dth">상영관 명</div>
			<div class="col">
				<input type="text" name="name" id="name" class="form-control"/>
			</div>
			<div class="col-2 dth">좌석수</div>
			<div class="col">
				<input type="number" name="seat" id="seat" class="form-control" value="100" step="10"/>
			</div>
		</div>
		<div class="row">
			<div class="col-2 dth">테마</div>
			<div class="col">
				<c:if test="${!empty vos}">
		  		<select class="custom-select align-self-start" onchange="themaSelect(this)">
			  		<option selected> Select </option>
		  			<c:forEach var="vo" items="${vos}" varStatus="st">
					    <option value="${st.index}">${vo.name}</option>
		  			</c:forEach>
			  	</select>
	  		</c:if>
	  		<c:if test="${empty vos}">테마를 추가하세요</c:if>
			</div>
			<div class="col-2 dth">
				작동 상태
			</div>
			<div class="col">
				<select name="work" id="work" class="custom-select align-self-start">
					<option value="1">오픈</option>
					<option value="2">임시중지</option>
					<option value="3" selected>중지</option>
					<option value="4">차단</option>
			  </select>
			</div>
		</div>
		<div class="d-flex flex-row mb-3" id="previewThema" style="display: none;">
			<div class="p-2" id="themaImg"></div>
			<div>
				<div class="d-flex flex-column mb-3">
					<div class="p-2" id="themaPrice"></div>
					<div class="p-2" id="themaHashTag"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="d-flex justify-content-center">
		<button type="button" class="btn btn-success mr-2" onclick="fCheck()">추가하기</button>
		<button type="button" class="btn btn-warning mr-2" onclick="window.close()">취소</button>
	</div>
	<input type="hidden" name="themaIdx" id="themaIdx"/>
</form>
<p><br/></P>
</body>
</html>