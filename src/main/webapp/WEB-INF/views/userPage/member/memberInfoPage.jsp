<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js" ></script>
	<title>회원정보 수정</title>
	<jsp:include page="/WEB-INF/views/include/userPage/signScript.jsp"/>
	<style>
		.rows{
			 border-bottom: solid 1px black;
			 height: 85px;
		}
		.dth{
			font-weight: bold;
			font-size:20px;
			background-color: #f8f8f8;
			height: 100%;
		}
				
	</style>
	<script>
 		'use strict';
 		
 		// 비밀번호 변경 버튼
 		function pwdChange(){
 			// 유효성 검사 필요
 			let pwd = $("#pwd").val();
 			if(pwd.trim()==""){
 				alert("비밀번호를 입력 하세요");
 				return false;
 			}
 			
 			$.ajax({
 				type:"post",
 				url:"${ctp}/member/memberPwdChange",
 				data:{pwd:pwd},
 				success:function(res){
 					if(res == "1") alert("비밀번호가 수정 되었습니다.");
 					else alert("비밀번호 수정 실패했습니다.");
 					
 					$("#pwd").val("");
 				},
 				error:function(){
 					alert("전송 실패");
 				}
 			});
 		}
 		
 		// 이름 변경 버튼
 		function nameChange(){
 			
 			let name = $("#name").val();
 			if(name.trim()==""){
 				alert("이름을 입력 하세요");
 				return false;
 			}
 			
 			$.ajax({
 				type:"post",
 				url:"${ctp}/member/memberNameChange",
 				data:{name:name},
 				success:function(res){
 					if(res == "1") alert("이름이 수정 되었습니다.");
 					else alert("이름 수정을 실패했습니다.");
 					
 				},
 				error:function(){
 					alert("전송 실패");
 				}
 			});
 		}
 		
		let preEmail = "${vo.email}";
 		// 이메일 변경 버튼
 		function emailChange(){
 			
 			let email = $("#email").val();
 			
 			// 유효성 검사 필요
 			if(email == preEmail){
 				alert("이미 등록된 이메일 입니다.");
 				return false;
 			}
 			else if(email.trim() == ""){
 				alert("변경할 이메일을 입력하세요");
 				return false;
 			}
 			
 			openLoding();
 			$.ajax({
 				type:"post",
 				url:"${ctp}/member/myPageAuthNumSend",
 				data:{email:email},
 				success:function(res){
 					closeLoading();
 					if(res == "1"){
 						alert("인증번호 발송 되었습니다.\n인증번호를 입력해주세요");
 						$("#authNumContent").slideDown(500);
 					}
 					else alert("인증번호 발송 실패.");
 				},
 				error:function(){
 					alert("전송 실패");
 				}
 			});
 		}
 		
 		// 인증 번호 확인 및  이메일 수정
 		function authNumCheck(){
 			let authNum = $("#authNum").val();
 			let email = $("#email").val();
 			
 			$.ajax({
 				url:"${ctp}/member/memberAuthNumChk",
 				type:"post",
 				data:{
 					authNum:authNum,
 					email:email
 				},
 				success:function(res){
 					if(res=="1"){
 						preEmail=email;
 						alert("이메일이 변경 되었습니다.");
 					}
 					else{
 						alert("인증번호를 확인하세요");
 					}
 				},
 				error:function(){
 					alert("전송 실패");
 				}
 			});
 		}
 		
 		//https://doitdoik.tistory.com/36
 		function openLoding(){
 			let mask ="<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
 			
 			let loading ='<div class="text-center" id="loadingImg" style="position:absolute; top: calc(50% - (200px / 2)); width:100%; z-index:99999999;">';
 			loading +='<div class="spinner-border" role="status">';
 			loading +='<span class="sr-only">Loading...</span>';
 			loading +='</div>';
 			loading +='</div>';
 			
 			$("body").append(mask).append(loading);
 			
 			$('#mask').css({
 	            'width' : "100%",
 	            'height': "100%",
 	            'opacity' :'0.3'
 	    });
 			
 			$('#mask').show();
 			$('#loadingImg').show();
 		}
 		function closeLoading() {
 		    $('#mask, #loadingImg').hide();
 		    $('#mask, #loadingImg').empty(); 
 		}
 		
 		
 		
 		jQuery(function(){
 			
 			//성별 수정
 			$("input[name='gender']").change(function(){
 				let gender = $(this).val();
 				$.ajax({
 					type:"post",
 	 				url:"${ctp}/member/memberGenderChange",
 	 				data:{gender:gender},
 	 				success:function(res){
 	 					if(res == "1") alert("성별이 수정 되었습니다.");
 	 					else alert("성별 수정을 실패했습니다.");
 	 				},
 	 				error:function(){
 	 					alert("전송 실패");
 	 				}
 				});
 				
 			});
 			
 			//성별 수정
 			$("input[name='birthday']").change(function(){
 				let birthday = $(this).val();
 				$.ajax({
 					type:"post",
 	 				url:"${ctp}/member/memberBirthdayChange",
 	 				data:{birthday:birthday},
 	 				success:function(res){
 	 					if(res == "1") alert("생일 수정 되었습니다.");
 	 					else alert("생일 수정 실패했습니다.");
 	 				},
 	 				error:function(){
 	 					alert("전송 실패");
 	 				}
 				});
 			});
 		
 		});//windows.load end
 		
	</script>
</head>
<body id="wrapper">
<p><br/></p>
<div class="container">
	<div class="text-center">
		<h1>회원정보 수정</h1>
		<p>회원님의 소중한 정보를 안전하게 관리하세요.</p>
	</div>
	<div style="width: 1140px">
		<h4><b>기본정보</b><button type="button" class="btn btn-sm btn-secondary" style="float:right">회원 탈퇴</button></h4>
	</div>
	<hr/>
	<div class="container-xl mt-5 text-center" style="width: 1140px">
		<div class="row rows align-items-center" style="border-top: 2px solid black;">
			<div class="col-2 dth"><div class="mt-4">아이디</div></div>
			<div class="col-4 ">${vo.mid}</div>
			<div class="col-2 dth"><div class="mt-4">비밀번호</div></div>
			<div class="col-4 ">
				<div class="input-group">
				  <div class="input-group-prepend">
					  <input type="password" class="form-control" id="pwd">
				  </div>
			    <button type="button" class="btn btn-outline-info" onclick="pwdChange()">변경하기</button>
				</div>
			</div>
		</div>
		<div class="row rows align-items-center" >
			<div class="col-2 dth"><div class="mt-4">이름</div></div>
			<div class="col-4">
				<div class="input-group">
				  <div class="input-group-prepend">
					  <input type="text" class="form-control" id="name" value="${vo.name}">
				  </div>
			    <button type="button" class="btn btn-outline-info" onclick="nameChange()">변경하기</button>
				</div>
			</div>
			<div class="col-2 dth"><div class="mt-4">성별</div></div>
			<div class="col-4">
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender == '남자'}">checked</c:if>>남자
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" name="gender" value="여자"<c:if test="${vo.gender == '여자'}">checked</c:if>>여자
				  </label>
				</div>
			</div>
		</div>
		<div class="row rows align-items-center">
			<c:set var="identiNums" value="${fn:split(vo.identiNum,'-')}"/>
			<div class="col-2 dth"><div class="mt-4">주민번호</div></div>
			<div class="col-4">
				${identiNums[0]} - * * * * * * *
			</div>
			<c:set var="birthday" value="${fn:substring(vo.birthday,0,10)}"/>
			<div class="col-2 dth"><div class="mt-4">생일</div></div>
			<div class="col-4"><input type="date" name="birthday" value="${birthday}"/></div>
		</div>
		<div class="row rows align-items-center">
			<c:set var="phones" value="${fn:split(vo.phone,'-')}"></c:set>
			<div class="col-2 dth"><div class="mt-4">연락처</div></div>
			<div class="col-4">
				<div class="input-group">
		      <input type="text" class="form-control" value="${phones[0]}" readonly>&nbsp;-&nbsp;
		      <input type="text" class="form-control" id="phone1" value="${phones[1]}">&nbsp;-&nbsp;
		      <input type="text" class="form-control" id="phone2" value="${phones[2]}">
		      <div class="input-group-append">
		        <button type="button" class="btn btn-outline-info" >변경하기</button>
		      </div>
    		</div>
			</div>
			<div class="col-2 dth"><div class="mt-4">이메일</div></div>
			<div class="col-4">
				<div class="input-group">
					<input type="text" class="form-control" id="email" value="${vo.email}"/>
					<div class="input-group-append">
		        <button type="button" class="btn btn-outline-info" onclick="emailChange()">변경하기</button>
		      </div>
		      <div class="input-group" id="authNumContent" style="display: none">
		      	<input type="password" class="form-control" id="authNum" placeholder="인증번호를 입력 하세요"/>
						<div class="input-group-append">
		        <button type="button" class="btn btn-outline-success" onclick="authNumCheck()">인증하기</button>
		      	</div>
		      </div>
				</div>
			</div>
		</div>
		<div class="row rows align-items-center" >
		  	<c:set var="addresses" value="${fn:split(vo.address,'/')}"/>
			<div class="col-2 dth"><div class="mt-4">집주소</div></div>
			<div class="col">
				<div class="input-group" >
	        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" readonly value="${addresses[0]}">
		      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" readonly value="${addresses[1]}">
          <div class="input-group-append">
          	<button type="button" onclick="sample6_execDaumPostcode()" class="btn btn-outline-secondary"> 우편번호 찾기</button>
          </div>
		    </div>
		    <div class="input-group">
	        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control" value="${addresses[2]}">
          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control" readonly value="${addresses[3]}">
	        <div class="input-group-append">
          	<button type="button" class="btn btn-outline-info" style="width: 119px;">수정하기</button>
          </div>
	      </div>
			</div>
		</div>
	</div>
</div>
<p><br/></p>
</body>
</html>