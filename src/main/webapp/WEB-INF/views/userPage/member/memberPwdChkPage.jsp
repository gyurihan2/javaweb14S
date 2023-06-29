<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원 인증</title>
  <script>
  	'use strict';
  	
  	function pwdCheck(){
  		let pwd = $("#pwd").val();
  		
  		if(pwd == ""){
  			alert("비밀번호를 입력하세요");
  			return false;
  		}
  		
  		$.ajax({
  			type:"post",
  			url:"${ctp}/member/memberPwdChkPage",
  			data:{pwd:pwd},
  			success:function(res){
  				if(res == "1"){
  					alert("인증 되었습니다.");
  					location.href="${ctp}/member/memberInfoPage"
  				}
  				else alert("인증 실패");
  			},
  			error:function(){
  				alert("전송 오류");
  			}
  		});
  		
  	}
  </script>
</head>
<body id="wrapper">
<p><br/></P>
<div class="container">
  <div class="text-center">
  	<h2>회원정보 수정</h2>
  	<p>회원님의 소중한 정보를 안전하게 관리하세요.</p>
  </div>
  <div class="mt-5 p-5 text-center" style="width: 1060px; height: 416px; background-color: #f8f8f8; margin-left: 25px;">
  	<div>
  		<img src="${ctp}/emoticon/cgvPwd.PNG" width="120px" height="120px">
  	</div>
  	<div>
  		<h3>회원정보를 수정하시려면 비밀번호를 입력하셔야 합니다.</h3>
  		<p>회원님의 개인정보 보호를 위한 본인 확인 절차이오니, 로그인 시 사용하시는 비밀번호를 입력해주세요.</p>
  	</div>
  	<div class="text-center mt-5">
  		<form>
  			<input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력 해주세요" style="width: 330px">
  			<div class="mt-3">
	  			<input type="button" class="btn btn-sm btn-secondary" value="취소" style="width: 160px"/>
	  			<input type="button" class="btn btn-sm btn-success" value="확인" onclick="pwdCheck()" style="width: 160px"/>
  			</div>
  		</form>
  	</div>
  </div>
</div>
<p><br/></P>
</body>
</html>