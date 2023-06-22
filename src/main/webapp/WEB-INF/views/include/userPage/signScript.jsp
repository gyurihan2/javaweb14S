<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	span{
		font-size: x-small;
	}
	/* input type number 화살표 제거 */
	input::-webkit-outer-spin-button,
	input::-webkit-inner-spin-button {
	  -webkit-appearance: none;
	  margin: 0;
	}
</style>
<script>
'use strict';
let chkmid=false;

// 유효성 검사
function chkReg(str, reg) {
    return reg.test(str);
}

// input type number 입력값 제한
function numberMaxLength(e){
    if(e.value.length > e.maxLength) e.value = e.value.slice(0, e.maxLength);
}

// 아이디 유효성 처리
function regMid(mid){
    const regExp = /^[\w]{5,19}$/g; //영어 대/소문자, 숫자, '_' 입력 가능
    let status=document.getElementById("regMid");   
    
    if(!regExp.test(mid.value)) return false;  
    return true;
}
//닉네임 유효성
function regNickName(nickName){
    const regExp = /^[\w가-힣]{3,19}$/g; //한글,영어 대/소문자, 숫자, '_' 입력 가능
    let status=document.getElementById("regNickName");
    
    if(!regExp.test(nickName.value)) return false;
    return true;
}

function regPwd(pwd){
    const regExp =  /^(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{5,20}/g;
    let status = document.getElementById("regPwd");

    if(pwd.value == ""){
        status.innerText="";
        return false;
    }
    else if(!regExp.test(pwd.value)){
        status.style.color="red";
        status.style.fontWeight="bold";
        status.innerText="사용 불가합니다.(최소5~15문자(특수문자 1개 이상, 5~20문자))";
        status.focus();
        return false;
    }
    
    status.innerText=""; 
    return true; 
    
}

function chkIdentifiaction(){
    const regExp = /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))-[1-4][0-9]{6}$/g;
    let identify = document.getElementsByName("identifiactionNum");
    let sumIdentify = identify[0].value +"-" +identify[1].value;
    let status=document.getElementById("regIdentifiaction");
   
    if(!regExp.test(sumIdentify)){
        status.style.color="red";
        status.style.fontWeight="bold";
        status.innerText="주민번호를 확인하세요";
        identify[0].focus();
        return false;
    }
    else{
        status.innerText="";
        return true;
    }
}
function chkEmail(){
    const regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    let email = document.getElementById("email").value;
    let status=document.getElementById("regEmail");
   
    if(!regExp.test(email)){
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
function chkPhone(){
    const regExp = /^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;
    let phone = document.getElementsByName("phone");
    console.log(typeof(phone));
    console.log(phone[0].value)
    let sumPhone = phone[0].value+"-"+phone[1].value+"-"+phone[2].value;
    let status=document.getElementById("regPhone");
   
    if(!regExp.test(sumPhone)){
        status.style.color="red";
        status.style.fontWeight="bold";
        status.innerText="핸드폰번호를 확인하세요";
        phone[0].focus();
        return false;
    }
    else{
        status.innerText="";
        return true;
    }
}
</script>