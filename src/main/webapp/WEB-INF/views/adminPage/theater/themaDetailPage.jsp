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
  	
  	// 메인 이미지 변경 버튼
  	function mainImgChange(){
  		let preMainImg="${vo.mainImg}";
  		let imgArr = imagesCheckBox();
  		
  		if(imgArr.length == 0){
  			alert("변경할 메인 이미지를 선택하세요.");
  			return false;
  		}
  		else if(imgArr.length > 1){
  			alert("메인 이미지는 하나만 선택 가능합니다.");
  			return false;
  		}
  		else if(imgArr[0] == preMainImg){
  			alert("이미 설정된 메인 이미지입니다.\n다른 이미지를 선택하세요");
  			return false;
  		}
  		
  		$.ajax({
  			type:"post",
  			url:"${ctp}/theater/themaMainImageChange",
  			data:{
  				idx:${vo.idx},
  				mainImg:imgArr[0]
  			},
  			success:function(res){
  				if(res == 1){
  					alert("메인 이미지가 수정 되었습니다.");
  					location.reload();
  				}
  				else alert("메인 이미지 수정 실패");
  			},
  			error:function(){
  				alert("전송 실패");
  			}
  		});
  	}
  	
  	//images 체크박스 확인
  	function imagesCheckBox(){
  		let chkArr=[];
  		$("input[name=images]:checked").each(function() {
  			chkArr.push($(this).val());
  		});
  		return chkArr;
  	}
  	
  	// image 추가 버튼
  	function imagesInsert(){
  		//size 확인
  		let fileSize = 0;
  		let maxFileSize=1024*1024*5;
  		
  		let cnt = $('#imagesAddFile')[0].files.length;
  		
  		for(let i=0; i<cnt; i++){
  			fileSize += document.getElementById("imagesAddFile").files[i].size;
  			
  			let file = document.getElementById("imagesAddFile").files[i];
  			if(!file.type.match("image.*")){
				alert("업로드파일을 확인하세요(이미지 파일만 가능)");
				return false;
				}
  		}
  		
  		if(cnt == 0){
  			alert("이미지 파일을 업로드 하세요");
  			return false;
  		}
  		else if(fileSize > maxFileSize){
  			alert("이미지 최대 업로드 가능한 사이즈는 5MB입니다.");
  			return false;
  		}
  		
  		imagesInputForm.submit();
  	}
  	
  	// 테마 이미지 삭제
  	function imageDelete(){
  		let imgArr = imagesCheckBox();
  		
  		if(imgArr.length == 0){
  			alert("삭제할 이미지를 선택하세요");
  		}
  		
  		$.ajax({
  			type:"post",
  			url:"${ctp}/theater/themaImageDelete",
  			data:{
  				idx:${vo.idx},
  				imgArr:imgArr
  			},
  			success:function(res){
  				if(res == "1"){
  					alert("선택한 이미지 삭제 완료되었습니다.");
  					location.reload();
  				}
  				else alert("선택한 이미지 삭제 실패");
  			},
  			error:function(){
  				alert("전송 실패");
  			}
  		});
  	}
  	
  	// 테마 삭제
  	function themaDelete(){
  		let chk = confirm("${vo.name} 테마를 삭제 하시겠습니까?");
  		
  		if(!chk) return false;
  		
  		$.ajax({
  			type:"post",
  			url:"${ctp}/theater/themaDelete",
  			data:{idx:${vo.idx}},
  			success:function(res){
  				if(res == "1"){
  					alert("삭제 되었습니다.");
  					window.close();
  				}
  				else alert("삭제 실패.")
  					
  			},
  			error:function(){
  				alert("전송 실패");
  			}
  		});
  	}
  	
  </script>
  <script>
  	$(function(){
		 	CKEDITOR.replace("content",{
						height : 400,    	 	
	        	filebrowserUploadUrl : "${ctp}/ckeditor/themaContentUpload", /*파일(이미지) 업로드 시 경로*/
	        	uploadUrl : "${ctp}/ckeditor/themaContentUpload"/*여러 파일을 드래그앤드랍해서 올리기*/
	    });
		 	
		 	$("#fileUploadShow").on("click",function(){
	         $("#fileUplod").slideToggle(500);
	     });
		 	
		 
		 	$(".custom-file-input").on("change", function() {
		 			let fileName =  $(this).val().split("\\").pop();
				  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
				});
  	})

  	window.addEventListener('beforeunload', function(event) {
		  opener.location.reload();
		});
  	
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
		<div class="d-flex flex-row-reverse">
			<input type="button" class="btn btn-sm btn-danger mr-2" value="이미지 삭제" onclick="imageDelete()">
			<input type="button" id="fileUploadShow" class="btn btn-sm btn-success mr-2" value="이미지 추가">
			<input type="button" class="btn btn-sm btn-info mr-2" value="대표이미지 변경" onclick="mainImgChange()">
		</div>
		<c:set var="imageArr" value="${fn:split(vo.images,'/')}"/>
		<c:set var="fNameArr" value="${fn:split(vo.imgFName,'/')}"/>
		<div class="d-flex flex-row" id="imageDemo" style="overflow-x: scroll;">
			<c:if test="${vo.images !=''}">
				<c:forEach var="imgFName" items="${fNameArr}" varStatus="st">
					<div class="p-2">
						<img src="${ctp}/thema/image/${imgFName}" width="200px" height="120px" >
						<br/>
						<div class="form-check-inline">
					  <label class="form-check-label">
					    <input type="checkbox" class="form-check-input" name="images" value="${imgFName}">${imageArr[st.index]}
					  </label>
						</div>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${vo.images=='' }">등록된 이미지가 없습니다.</c:if>
		</div>
		<div class="mt-2" id="fileUplod" style="display: none;">
			<form name="imagesInputForm" method="post" action="${ctp}/theater/themaImageAdd" enctype="multipart/form-data">
			  <div class="d-flex flex-row-reverse">
				  <div class="ml-2"> <button class="btn btn-success" type="button" onclick="imagesInsert()">추가하기</button></div>
			  	<div class="custom-file" style="width: 800px"> 
			      <input type="file" class="custom-file-input" id="imagesAddFile" name="imagesAddFile" multiple>
			      <label class="custom-file-label" for="imagesAddFile">Choose file</label>
		    	</div>
				</div>
				<input type="hidden" name="idx" value="${vo.idx}">
			</form>
		</div>
		<p><br/></p>
		<p><br/></p>
		<hr/>
		<form name="myform"  method="post" action="${ctp}/theater/themMainContentUpdate">
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
				<button type="button" class="btn btn-warning" onclick="window.close()">취소</button>
				<button type="button" class="btn btn-danger" onclick="themaDelete()">테마 삭제</button>
			</div>
			<input type="hidden" name="idx" value="${vo.idx}">
		</form>
	</div>
</div>
<p><br/></P>
</body>
</html>