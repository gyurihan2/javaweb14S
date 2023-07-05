<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <title>상영관 테마 상세 정보</title>
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
	  
  	
  	// 수정 하기
  	function fCheck(){
  		
  		//myform.submit();
  	}
  </script>
  <script>
  	$(function(){
		 	CKEDITOR.replace("content",{
						height : 400,    	 	
	        	filebrowserUploadUrl : "${ctp}/ckeditor/themaContentUpload", /*파일(이미지) 업로드 시 경로*/
	        	uploadUrl : "${ctp}/ckeditor/themaContentUpload"/*여러 파일을 드래그앤드랍해서 올리기*/
	    });
  	})
 	</script>
</head>
<body>
<div class="container">
  <div class="text-center mb-5"><h2>${vo.name} 상영관 상세 보기</h2></div>
	<div class="container">
		<div class="row align-items-center">
			<div class="col-2"></div>
			<div class="col-3 dth">대표 이미지</div>
			<div class="col">
				<img src="${ctp}/thema/image/${vo.mainImg}" width="200px" height="120px">
			</div>
		</div>
		<div>
			<input type="button" value="대표이미지 변경">
			<input type="button" value="이미지 추가">
			<input type="button" value="이미지 삭제">
		</div>
		<c:set var="imageArr" value="${fn:split(vo.images,'/')}"/>
		<c:set var="fNameArr" value="${fn:split(vo.imgFName,'/')}"/>
		<div class="d-flex flex-row" id="imageDemo" style="overflow-x: scroll;">
			<c:forEach var="imgFName" items="${fNameArr}" varStatus="st">
				<div class="p-2">
					<img src="${ctp}/thema/image/${imgFName}" width="200px" height="120px">
					<br/>
					<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="checkbox" class="form-check-input" value="${imgFName}">${imageArr[st.index]}
				  </label>
					</div>
				</div>
			</c:forEach>
		</div>
		<form name="myform"  method="post" action="${ctp}/theater/themaInputPage" enctype="multipart/form-data">
			<div class="row">
				<div class="col-2 dth">테마 명</div>
				<div class="col">
					<input type="text" name="name" class="form-control" value="${vo.name}"/>
				</div>
				<div class="col-2 dth">입장료</div>
				<div class="col">
					<input type="number" name="price" class="form-control" value="${vo.price}" step="1000"/>
				</div>
			</div>
			<div class="row">
				<div class="col-2 dth">해시태그</div>
				<div class="col">
					<input type="text" name="hashTag" class="form-control" value="${vo.hashTag}"/>
				</div>
				<div class="col-3 dth">메인페이지 출력 여부</div>
				<div class="col">
					<div class="custom-control custom-radio custom-control-inline">
				    <input type="radio" class="custom-control-input" id="displayYes" name="display" value="YES" <c:if test="${vo.display == 'YES' }">checked</c:if>>
				    <label class="custom-control-label" for="displayYes">YES</label>
	  			</div>
				  <div class="custom-control custom-radio custom-control-inline">
				    <input type="radio" class="custom-control-input" id="displayNo" name="display" value="NO" <c:if test="${vo.display == 'NO' }">checked</c:if>>
				    <label class="custom-control-label" for="displayNo">NO</label>
				  </div>
				</div>
			</div>
			<div class="row align-items-center">
				<div class="col-2 dth">설명</div>
				<div class="col">
					<textarea id="CKEDITOR" rows="6" name="content" class="form-control" required>${vo.content}</textarea>
			</div>
			</div>
			<div>
				<button type="submit" class="btn btn-info" >수정하기</button>
				<button type="button" class="btn btn-danger" onclick="window.close()">취소</button>
			</div>
		</form>
	</div>
</div>
<p><br/></P>
</body>
</html>