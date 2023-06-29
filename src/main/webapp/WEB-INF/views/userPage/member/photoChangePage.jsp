<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원 이미지 변경</title>
  <script>
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
			
			$(".imgDemo").html("");
			let PreviewImg = document.querySelector(".imgDemo");
			PreviewImg.appendChild(img);
		}
		
		//이미지 변경 버튼
		function changePhoto(){
			let maxSize= 1024 * 1204 * 10;
			let file = $("#file").val();
			let ext = file.substring(file.lastIndexOf(".")).toUpperCase();
			
			if(file == "" || file == null){
  			alert("업로드할 파일을 선택해주세요");
  			return false;
	  	}
			else if(ext == "JPG" && ext == "GIF" && ext =="PNG"){
	  			alert("업로드 가능한 파일은 그림파일만 가능합니다.");
	  			return false;
	  	}
			else if(file.size > maxSize){
  			alert("업로드할 파일의 용량은 최대 10Mbyte입니다.");
  			return false;
  		}
			else myform.submit();
			
		}
		
		window.addEventListener('beforeunload', function(event) {
			  opener.location.reload();
		});
  </script>
</head>
<body style="background-color:#faf4f4">
<h3 class="mt-0 p-2 text-white" style="background-color: #707070;"><b>나의 프로필 이미지 수정</b></h3>
<p></P>
<div class="m-2 p-2" style="width: 560px; background-color: #e9e9e8;">
	<div style="display: inline-block;">
		<span class="imgDemo" style=" border-radius: 70%; overflow: hidden;">
  		<img src="${ctp}/member/image/${vo.photo}" width="135px" height="135px"/>
  	</span>
  	<div class="text-center mt-2"><strong>프로필 이미지</strong></div>
  	
  </div>
	<div class="ml-5" style="display: inline-block;">
    <div>
      <strong>${vo.name}</strong>&nbsp;(<em>${vo.mid}</em>)&nbsp;&nbsp;&nbsp;&nbsp;<span> 닉네임 : <i>${vo.nickName}</i></span>
    </div>
    <hr/>
    <div>
    	<form name="myform" method="post" enctype="multipart/form-data">
      	<input type="file" name="file" id="file" class="mb-2 form-control-file border" onchange="previewImg(this)"/>
    	</form>
      <button class="btn btn-info bnt-sm mt-4" onclick="changePhoto()"><span>프로필 이미지 변경</span></button>
      <br/>
    </div>
  </div>
</div>
<p><br/></P>
</body>
</html>