<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
	.sidenav {
	  height: 100%;
	  width: 250px;
	  position: fixed;
	  z-index: 1;
	  top: 0;
	  left: 0;
	  background-color: #000000;
	  overflow-x: hidden;
	  padding-top: 20px;
	}
	
	.sidenav a:hover,.dropdown-btn:hover {
	  color: #f1f1ff;
	}
	
	#wrapper {
	  margin-left: 250px; /* Same as the width of the sidenav */
	  font-size: 20px; /* Increased text to enable scrolling */
	  padding: 0px 10px;
	  background-color: #fbfbfb;
	}
	.content{
		box-shadow: 2px 2px 2px 2px #E2E2E2;
		border-radius: 30px;
		background-color: #ffffff;
	}
	#top_title{
		background-color: #ffffff;
		height: 40px;
	}
	/* Style the sidenav links and the dropdown button */
	.sidenav a, .dropdown-btn {
	  padding: 6px 8px 6px 16px;
	  text-decoration: none;
	  font-size: 16px;
	  color: #818181;
	  display: block;
	  border: none;
	  background: none;
	  width: 100%;
	  text-align: left;
	  cursor: pointer;
	  outline: none;
	}
	/* Add an active class to the active dropdown button */
	.active {
	  background-color: skyblue;
	  color: white;
	}
	/* Dropdown container (hidden by default). Optional: add a lighter background color and some left padding to change the design of the dropdown content */
	.dropdown-container {
	  display: none;
	  background-color: #262626;
	  padding-left: 8px;
	}
	
	/* Optional: Style the caret down icon */
	.fa-caret-down {
	  padding-left: 15px;
	}
</style>
<script>
$(function(){
	
	var dropdown = document.getElementsByClassName("dropdown-btn");
	var i;

	for (i = 0; i < dropdown.length; i++) {
	  dropdown[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var dropdownContent = this.nextElementSibling;
	    if (dropdownContent.style.display === "block") {
	      dropdownContent.style.display = "none";
	    } else {
	      dropdownContent.style.display = "block";
	    }
	  });
	}
});
</script>
<div class="sidenav">
  <div class="sidenav">
  <a href="${ctp}/admin/mainPage"><i class="fa fa-fw fa-home"></i> Home</a>
  <button class="dropdown-btn">
  	<i class="fa fa-cogs" aria-hidden="true"></i>
  	management
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="${ctp}/admin/theater/mgmtPage">상영관 관리</a>
    <a href="${ctp}/admin/movie/mgmtPage">영화 관리</a>
    <a href="${ctp}/admin/scheduleMgmtPage">영화 일정 관리</a>
  </div>
  <a href="#clients"><i class="fa fa-fw fa-user"></i> Clients</a>
  <button class="dropdown-btn">
  	<i class="fa fa-bar-chart" aria-hidden="true"></i>
  	통계 
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="#">예약 현황</a>
    <a href="#">매출 현황</a>
  </div>
 <a href="${ctp}/"><i class="fa fa-sign-out" aria-hidden="true"></i>종료</a>
 </div>
</div>
  



