<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원 닉네임 변경</title>
  <script>
		'use strict';
		
		//닉네임 유효성
		function regNickName(nickName){
		    const regExp = /^[\w가-힣]{3,19}$/g; //한글,영어 대/소문자, 숫자, '_' 입력 가능
		    
		    if(!regExp.test(nickName)) return false;
		    return true;
		}
		let sw=0;
		
		// 닉네임 중복 확인
		function nickNameChk(){
			let nickName = $("#nickName").val();
			if(nickName == ""){
				alert("닉네임을 입력하세요");
				return false;
			}
			else if(!regNickName(nickName)){
				alert("닉네임을 입력 형식을 확인하세요");
				return false;
			}
			else{
				$.ajax({
					type:"post",
					url:"${ctp}/member/nickNameChk",
					data:{
						nickName:nickName
					},
					success:function(res){
						if(res == "1"){
							alert("사용 가능한 닉네임 입니다.");
							sw=1;
						}
						else if(res =="2") alert("이전 닉네임과 동일합니다.")
						else alert("사용 불가능한 닉네임 입니다.");
					},
					error:function(){alert("전송 실패");}
				});
			}
		}
		
		function changeNickName(){
			if(sw == 0){
				alert("닉네임 중복 체크를 하세요");
				return false;
			}
			myform.submit();
		}
		
		window.addEventListener('beforeunload', function(event) {
			  opener.location.reload();
		});
		
		
		jQuery(function(){
			$("#nickName").change(function(){
				 sw=0;
			});
		});
  </script>
</head>
<body style="background-color:#faf4f4">
<h3 class="mt-0 p-2 text-white" style="background-color: #707070;"><b>나의 닉네임 수정</b></h3>
<p></P>
<div class="m-2 p-2" style="width: 560px; background-color: #e9e9e8;">
	<div>
		<h4>${vo.name}님</h4> 사용중인 닉네임 : ${vo.nickName}
	</div>
  <div class="d-flex justify-content-center">
  	<form name="myform" method="post">
    	<div class="input-group mt-2">
	      <div class="input-group-prepend">
	      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;">
	      		<i class="fa-solid fa-check" id="dupulNickName" style="color: #55c37f; display:none"></i>
	      		<b>&nbsp;&nbsp;닉네임</b>
	      	</span>
	      </div>
	      <input type="text" class="form-control" id="nickName" name="nickName" placeholder="변경할 닉네임을 입력하세요."  required />
	      <div class="input-group-prepend ml-2">
	      	<input type="button" class="btn btn-info btn-sm " id="nickNameCheck"  value="닉네임 중복체크" onclick="nickNameChk()" style="border-radius: 10px;"/>
	  		</div>
    	</div>
    	<button type="button" class="btn btn-success bnt-sm mt-2" onclick="changeNickName()"><span>닉네임 변경</span></button>
  	</form>
    <br/>
  </div>
</div>
<p><br/></P>
</body>
</html>