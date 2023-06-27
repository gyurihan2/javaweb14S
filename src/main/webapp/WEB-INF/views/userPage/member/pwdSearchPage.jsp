<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script>

	function chkEmail(email){
	    const regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			
	    if(!regExp.test(email)) return false;
	    else return true;
	}
	
	function userCheck(){
		let mid = $("#mid").val();
		let identiNum = $("#identiNum1").val()+"-"+$("#identiNum2").val();
		let email = $("#email").val();
		
		// 유효성 검사
		if(mid == ""){
			alert("아이디를 입력하세요");
			$("#mid").focus();
			return false;
		}
		else if($("#identiNum1").val() == "" || $("#identiNum2").val() == ""){
			alert("주민번호 입력하세요");
			$("#identiNum1").focus();
			return false;
		}
		else if(email == ""){
			alert("이메일을 입력하세요");
			$("#email").focus();
			return false;
		}
		else if(!chkEmail(email)){
			alert("이메일 형식을 확인하세요");
			$("#email").focus();
			return false;
		}
		
		let startTime=10;
		$.ajax({
			url:"${ctp}/member/authNumSend",
			type:"POST",
			data:{
				mid:mid,
				identiNum:identiNum,
				email:email
			},
			success:function(res){
				
				if(res == "0") alert("유저 정보가 없습니다.");
				else if(res == "-1") alert("이메일 전송 실패");
				else if(res == "1"){
					
					countDown();
					$("#mid").attr("readonly",true);
					$("#indetiNum1").attr("readonly",true);
					$("#indetiNum2").attr("readonly",true);
					$("#email").attr("readonly",true);
					alert("이메일 발송 되었습니다.\n 인증번호를 확인하세요");
					
					$("#authForm").show();
				}
			},
			error:function(){
				alert("전송 실패");
			}
		});
		
	}
	
	
	// 참고: https://mongwani.tistory.com/15418897
	let timer;
	let startTime;
	function countDown(){
		startTime=300;
		function shwoRemaining(){
			
			if(startTime == 0){
				clearInterval(timer);
				return;
			}
			
			startTime--;
			let min = String(Math.floor((startTime / 60) % 60 )).padStart(2, "0"); // 분
			let sec = String(Math.floor(startTime % 60)).padStart(2, "0"); // 초
			$("#timer").html(min+":"+sec);
		}
		
		clearInterval(timer);
		timer=setInterval(shwoRemaining,1000)
	}
	
	function changePwd() {
		let imsiAuth = $("#imsiAuth").val();
		
		if($("#authForm").css("display")=="none"){
			alert("인증번호를 발급 받으세요");
			return false;
		}
		else if(imsiAuth == ""){
			alert("인증번호를 입력하세요");
			return false;
		}
		else if(startTime == 0){
			alert("인증번호 만료 시간이 지났습니다.\n인증번호를 다시 받으세요");
			return false;
		}
		
		myform.submit();
		
	}
	

</script>
</head>
<body>
<div class="container">
  <div class="modal-dialog">
	  <div class="modal-content p-4">
		  <h2 class="text-center">비밀번호 찾기</h2>
		  <p class="text-center">(회원 정보를 입력해 주세요)</p>
		  <form name="myform" method="post">
		    <div class="input-group mt-2">
	      <div class="input-group-prepend">
	      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>&nbsp;&nbsp;&nbsp;아이디</b></span>
	      </div>
	      <input type="text" class="form-control" id="mid" name="mid" placeholder="아이디를 입력하세요."  required autofocus />
	    </div>
		    <div class="input-group mt-2 mb-4">
		      <div class="input-group-prepend">
		      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>주민 번호</b></span>
		      </div>
        	<input type="number" class="form-control mr-1"  id="identiNum1" name="identiNum1" maxlength=6 required/>
        	&nbsp;-
	        <div class="input-group-prepend ml-2">
	          <input type="number" class="form-control ml-1" id="identiNum2" name="identiNum2" maxlength=7 required style="-webkit-text-security: disc; width: 190px"/>
	        </div>
	    	</div>
	    	<div class="input-group mt-4">
	      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;">
	      		<b>&nbsp;&nbsp;이메일</b>
	      	</span>
		      <input type="text" class="form-control" name="email" id="email" placeholder="이메일를 입력하세요." required/>
		      <div class="input-group-prepend ml-2">
		      	<input type="button" class="btn btn-info btn-sm " value="인증번호 받기" onclick="userCheck()" style="border-radius: 10px;"/>
	    		</div>
	    	</div>
				<div class="input-group mt-4" style="display:none" id="authForm">
					<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;">
	      		<b>&nbsp;&nbsp;인증번호</b>
	      	</span>
	      	<input type="password" class="form-control" name="imsiAuth" id="imsiAuth"/>
	      	<div class="input-group-prepend ml-2">
		      	<span>인증만료시간: </span>
		      	<span id="timer" style="color: red"></span>
	    		</div>
				</div>	    	
		    <div class="form-group text-center mt-2">
		    	<button type="button" class="btn btn-primary mr-1" onclick="changePwd()">인증하기</button>
		    	<button type="button" class="btn btn-warning mr-1" onclick="location.reload()">다시입력</button>
		    </div>
		    <input type="hidden" name="identiNum"/>
		  </form>
	  </div>
  </div>
</div>
</body>
</html>