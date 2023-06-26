<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script>
	function chkReg(str, reg) {
    	return reg.test(str);
	}
	
	function chkEmail(email){
	    const regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	    
	    let status=document.getElementById("regEmail");

	    if(!regExp.test(email.value)){
	        status.style.color="red";
	        status.style.fontWeight="bold";
	        status.innerText="이메일 형식을 확인하세요";
	        email.focus();
	        return false;
	    }
	    else{
	        status.innerText="";
	        return true;
	    }
	}
	
	function searchMid(){
	
		if(myform.name.value== ""){
			alert("회원 이름을 입력하세요");
			myform.name.focus();
			return false;
		}
		else if(!chkEmail(myform.email)) {
			alert("이메일 형식을 확인하세요");
			myform.email.focus();
			return false;
		}
		else if(myform.identiNum1.value=="" || myform.identiNum2.value==""){
			alert("주민번호를 입력하세요");
			myform.identiNum1.focus();
			return false;
		}
		
		let identiNum = myform.identiNum1.value+"-"+myform.identiNum2.value;
		myform.identiNum.value = identiNum;
		
		myform.submit();
	}
	


	jQuery(function(){
		if(${!empty mid}){
			$("#searchRes").css("display","block");
			$("#searchRes").html("<font color='green'>아이디 검색 성공 : <b>${mid}</b></font>");
		}
		else if(${!empty sw}){
			$("#searchRes").css("display","block");
			$("#searchRes").html("<font color='red'><b>아이디 검색 실패</b></font>");
		}
		
		$("#email").change(function(){
			 	chkEmail(this);
	
	    });
	});
</script>
</head>
<body>
<div class="container">
  <div class="modal-dialog">
	  <div class="modal-content p-4">
		  <h2 class="text-center">아이디 찾기</h2>
		  <p class="text-center">(회원 정보를 입력해 주세요)</p>
		  
		  <form name="myform" method="post">
		    <div class="input-group mt-2">
	      <div class="input-group-prepend">
	      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>&nbsp;&nbsp;&nbsp;성명</b></span>
	      </div>
	      <input type="text" class="form-control" id="name" name="name" placeholder="성명을 입력하세요."  required />
	    </div>
		    <div class="input-group mt-4">
		      <div class="input-group-prepend">
		      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>Email</b></span>
		      </div>
	        <input type="text" class="form-control" id="email" name="email" placeholder="Email을 입력하세요." required />
	    	</div>
	    	<span id="regEmail" class="ml-3"></span>
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
		    <div class="form-group text-center">
		    	<c:if test="${empty mid}">
			    	<button type="button" class="btn btn-primary mr-1" onclick="searchMid()">아이디 찾기</button>
		    	</c:if>
		    	<c:if test="${!empty mid}">
			    	<button type="button" class="btn btn-info mr-1" onclick="location.href='${ctp}/PwdSearchPage.mem'">비밀번호 찾기</button>
		    	</c:if>
		    	<button type="reset" class="btn btn-warning mr-1">다시입력</button>
		    </div>
		    <input type="hidden" name="identiNum"/>
		  </form>
		  <div id="searchRes" style="display:none"></div>
	  </div>
  </div>
</div>
</body>
</html>