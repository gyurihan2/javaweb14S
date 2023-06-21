<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js" ></script>
	<title>회원가입페이지</title>
	<jsp:include page="/WEB-INF/views/include/userPage/signScript.jsp"/>
	<script>
	  //  회원가입 버튼
    function submitOk() {
			let dupulMid = $("#dupulMid").css("display");
			let dupulNickName = $("#dupulNickName").css("display");
			let statusPwd = regPwd(myform.pwd[0]);
    	
    	let statusNickName = $("#nickName").val();
    	let statusName = $("#name").val();
    	let statusEmail = $("#email1").val();
    	
    	let identiNum1= $("#identiNum1").val();
    	let identiNum2= $("#identiNum2").val();
    	let identiNum = identiNum1 + "-" + identiNum2;
    	
    	let email1 = myform.email1.value;
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	
    	let phone1 = myform.phone1.value;
    	let phone2 = myform.phone2.value;
    	let phone3 = myform.phone3.value;
    	
    	let phone = phone1+"-"+phone2+"-"+phone3;
    	
    	// 유효성 검사 필요
    	let postcode1 = myform.postcode.value == "" ? " " : myform.postcode.value;
			let roadAddress1 = myform.roadAddress.value == "" ? " " : myform.roadAddress.value;
			let detailAddress1 = myform.detailAddress.value == "" ? " " : myform.detailAddress.value;
			let extraAddress1 = myform.extraAddress.value == "" ? " " : myform.extraAddress.value;
			let address1 = postcode1 + "/" + roadAddress1 + "/"+detailAddress1+"/"+extraAddress1;
    	
			if(dupulMid == "none"){
				alert("아이디 중복 체크 확인하세요");
				myform.mid.focus();
				return false;
			}
		
			else if(dupulNickName == "none"){
				alert("닉네임 중복 체크 확인하세요");
				myform.nickName.focus();
				return false;
			}
		
			else if(!statusPwd){
				alert("비밀번호를 확인하세요");
				$("#pwd").focus();
				return false;
			}
			else if(statusNickName == ""){
				alert("닉네임을 확인하세요")
				$("#nickName").focus();
				return false;
			}
			else if(statusName == ""){
				alert("이름을 확인하세요")
				$("#name").focus();
				return false;
			}
			else if(statusEmail == ""){
				alert("이메일을 확인하세요")
				$("#email").focus();
				return false;
			}
			
			myform.identiNum.value=identiNum;
			myform.phone.value= phone;
			myform.address1.value = postcode1 + "/" + roadAddress1 + "/"+detailAddress1+"/"+extraAddress1;
    	myform.email.value = email;
      //alert("통과");
			myform.submit();
		}
	 
     
		 // 아이디 중복 체크
		function idCheck(mid) {
			let url = "${ctp}/SignUpIdChk.mem?mid="+mid.value;
			
			if(mid.value.trim() == "") {
				alert("아이디를 입력하세요!");
				myform.mid.focus();
				return false;
			}
			else if(mid.value.indexOf("admin")==0){
				alert("사용할수없는 아이디 입니다.");
				myform.mid.focus();
				return false;
			}
			else if(!regMid(mid)){
				alert(mid.value+"아이디 입력 형식을 확인하세요!");
				myform.mid.focus();
				return false;
			}
			else {
				window.open(url,"nWin","width=580px,height=250px");
			}
		}
		 // 닉네임 중복 체크
		function nickNameCheck(nickName) {
			let url = "${ctp}/SignUpNickNameChk.mem?nickName="+nickName.value;
			
			if(nickName.value.trim() == "") {
				alert("닉네임를 입력하세요!");
				myform.nickName.focus();
				return false;
			}
			else if(nickName.value.indexOf("admin")==0){
				alert("사용할수없는 닉네임 입니다.");
				myform.mid.focus();
				return false;
			}
			else if(!regNickName(nickName)){
				alert(nickName.value+"닉네임 입력 형식을 확인하세요!");
				myform.nickName.focus();
				return false;
			}
			else {
				window.open(url,"nWin","width=580px,height=250px");
			}
		}
	
		// document.ready
		jQuery(function(){
			
			$("#mid").change(function(){
			  regMid(this);
			});
			
			$("#pwd1").change(function(){
			  regPwd(this);
			});
			
			$("#nickName").change(function(){
				regNickName(this);
			});
			
			// 중복 체크 클릭 이벤트
			$("#midCheck").click(function(){
				idCheck(myform.mid);
			});
			$("#nickNameCheck").click(function(){
				nickNameCheck(myform.nickName);
			});
			
			// 아이디 중복 확인 후 다시 수정한 경우
      $("#mid").change(function(){
          regMid(this);
          $("#dupulMid").css("display","none");
      });
    	// 닉네임 중복 확인 후 다시 수정한 경우
      $("#nickName").change(function(){
          $("#dupulNickName").css("display","none");
          $("#regNickName").text("");
      });
		});
 
	</script>
</head>
<body id="wrapper">
<p><br/></p>
<div class="container">
	<div class="row justify-content-center">
		<form name="myform" method="post" action="${ctp}/MemberJoinOk.mem" class="was-validated bordered" style="width:500px">
	    <h2>회 원 가 입</h2>
	    <br/>
	    <div class="input-group">
	      <div class="input-group-prepend">
	      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>&nbsp;&nbsp;아이디</b></span>
	      </div>
	      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
	      <div class="input-group-prepend ml-2">
	      	<input type="button" class="btn btn-info btn-sm " id="midCheck" value="아이디 중복체크" style="border-radius: 10px;"/>
    		</div>
	    </div>
	    <span class="ml-3" id="regMid"></span>
	    <div class="input-group mt-2">
	      <div class="input-group-prepend">
	      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>비밀 번호</b></span>
	      </div>
	      <input type="password" class="form-control" id="pwd1" placeholder="비밀번호를 입력하세요." name="pwd" required />
	    </div>
	   	<span class="ml-2" id="regPwd"></span>
	    <div class="input-group mt-2">
	      <div class="input-group-prepend">
	      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>닉네임</b></span>
	      </div>
	      <input type="text" class="form-control" id="nickName" name="nickName" placeholder="별명을 입력하세요."  required />
	      <div class="input-group-prepend ml-2">
	      	<input type="button" class="btn btn-info btn-sm " id="nickNameCheck"  value="닉네임 중복체크" style="border-radius: 10px;"/>
    		</div>
	    </div>
	    <span class="ml-3" id="regNickName"></span>
	    <div class="input-group mt-2">
	      <div class="input-group-prepend">
	      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>성명</b></span>
	      </div>
	      <input type="text" class="form-control" id="name" name="name" placeholder="성명을 입력하세요."  required />
	    </div>
	    <div class="input-group mt-4">
	      <div class="input-group-prepend">
	      	<span class="input-group-text bg-white text-dark" style="border:0 solid black; width: 90px;"><b>주민 번호</b></span>
	      </div>
          <input type="number" class="form-control mr-1" placeholder="주민번호 입력하세요." id="identiNum1" name="identiNum1" maxlength=6 required />
          <div class="input-group-prepend ml-2">
            -<input type="number" class="form-control ml-1" id="identiNum2" name="identiNum2" maxlength=7 required style="-webkit-text-security: disc; width: 190px"/>
          </div>
	    </div>
	   
	   
	   
	    <div class="form-group">
	      <div class="form-check-inline">
	        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
	        <label class="form-check-label">
	          <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
	        </label>
	      </div>
	      <div class="form-check-inline">
	        <label class="form-check-label">
	          <input type="radio" class="form-check-input" name="gender" value="여자">여자
	        </label>
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="birthday">생일</label>
	      <input type="date" name="birthday" class="form-control"/>
	    </div>
	    <div class="form-group">
	      <div class="input-group mb-3">
	        <div class="input-group-prepend">
	          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
	        </div>
          <input type="number" name="phone1" value="010" class="form-control text-center" readonly style="width:100px;"/>-
	        <input type="number" name="phone2" size=4 maxlength=4 class="form-control"/>-
	        <input type="number" name="phone3" size=4 maxlength=4 class="form-control"/>
	      </div>
	    </div>
	     <div class="form-group">
	      <label for="email1">Email address:</label>
	      <span class="ml-3" id="regEmail"></span>
	        <div class="input-group mb-3">
	          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
	          <div class="input-group-append">
	            <select name="email2" class="custom-select">
	              <option value="naver.com" selected>naver.com</option>
	              <option value="hanmail.net">hanmail.net</option>
	              <option value="hotmail.com">hotmail.com</option>
	              <option value="gmail.com">gmail.com</option>
	              <option value="nate.com">nate.com</option>
	              <option value="yahoo.com">yahoo.com</option>
	            </select>
	          </div>
	        </div>
	    </div>
	    <div class="form-group">
	      <label for="address">주소</label>
	      <input type="hidden" name="address" id="address">
	      <div class="input-group mb-1">
	        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" readonly>
	        <div class="input-group-append">
	          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
	        </div>
	      </div>
	      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" readonly>
	      <div class="input-group mb-1">
	        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
	        <div class="input-group-append">
	          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control" readonly>
	        </div>
	      </div>
	    </div>
	    <div class="text-center">
		    <button type="button" class="btn btn-secondary" id="memberJoin" onclick="submitOk()">회원가입</button> &nbsp;
		    <button type="button" class="btn btn-secondary" onclick="">돌아가기</button>
	    </div>
	    <input type="hidden" name="phone"/>
	    <input type="hidden" name="email"/>
	    <input type="hidden" name="address1"/>
	    <input type="hidden" name="identiNum"/>
	  </form>
	</div>
</div>
<p><br/></p>
</body>
</html>