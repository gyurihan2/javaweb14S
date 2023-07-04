<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="${ctp}/ckeditor/ckeditor.js"></script>  
  <title>테마 신규 등록</title>
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
			height: 100%;
		}
		.row * {
			margin-bottom: 5px;
		}		
	</style>
  <script>
  	'use strict';
	  
  	//그림 미리보기
		function previewImg(e){
			//그림파일 체크
			let file = e.files[0];
			
			if(!file.type.match("image.*")){
				alert("업로드파일을 확인하세요(이미지 파일만 가능)");
				return false;
			}
		
			let img = document.createElement("img");
			let reader = new FileReader();
			reader.onload = function(e){
				img.setAttribute("src",e.target.result);
				img.setAttribute("width",135);
				img.setAttribute("height",135);
				img.setAttribute("id","preview");
			}
			reader.readAsDataURL(e.files[0]);
			
			$("#mainImgDemo").html("");
			let PreviewImg = document.querySelector("#mainImgDemo");
			PreviewImg.appendChild(img);
		}
  	
  	// 생성하기
  	function fCheck(){
  		let mainImg = myform.mainImg.value;
  		let images = myform.images.value;
  		
  		//size 확인
  		let fileSize = 0;
  		
  		let cnt = $('#images')[0].files.length;
  		for(let i=0; i<cnt; i++){
  			fileSize += document.getElementById("images").files[i].size;
  		}
  		alert(fileSize);
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
<h3 class="text-center">테마 등록</h3>
<form name="myform" method="post" enctype="multipart/form-data">
	<div class="container">
		<div class="row">
			<div class="col-2 dth">테마 명</div>
			<div class="col">
				<input type="text" name="name" class="form-control"/>
			</div>
			<div class="col-2 dth">입장료</div>
			<div class="col">
				<input type="number" name="price" class="form-control"/>
			</div>
		</div>
		<div class="row align-items-center">
			<div class="col-2 dth">
				대표 이미지
			</div>
			<div class="col" id="mainImgDemo"> 대표이미지를 업로드 하세요</div>
			<div class="col-6">
				<input type="file" class="form-control-file border" name="mainImg" onchange="previewImg(this)">
			</div>
		</div>
		<div class="row align-items-center">
			<div class="col-2 dth">
				이미지
			</div>
			<div class="col">
				<input type="file" class="form-control-file border" name="images" id="images" multiple>
			</div>
		</div>
		<div class="row align-items-center">
			<div class="col-2 dth">설명</div>
			<div class="col">
				<textarea id="CKEDITOR" rows="6" name="content" class="form-control" required></textarea>
		</div>
		</div>
		<div>
			<button type="button" class="btn btn-info" onclick="fCheck()">생성하기</button>
			<button type="button" class="btn btn-danger" onclick="window.close()">취소</button>
		</div>
	</div>
		
</form>
	
<p><br/></P>
</body>
</html>