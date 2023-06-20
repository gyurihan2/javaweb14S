<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%-- <jsp:include page="/WEB-INF/views/include/bs4.jsp"/> --%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
.topMenu {
  background-color: #f1f1f1;
  padding: 30px;
  text-align: center;
}

#mainMenu {
  overflow: hidden;
  background-color: #333;
  z-index: 100;
}

#mainMenu a {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

#mainMenu a:hover {
  background-color: #ddd;
  color: black;
}

#mainMenu a.active {
  background-color: #04AA6D;
  color: white;
}

.content {
  padding: 16px;
}

.sticky {
  position: fixed;
  top: 0;
  width: 100%;
}

.sticky + .content {
  padding-top: 60px;
}

</style>
<script>
    $(function(){
		var navbar = document.getElementById("mainMenu");
		var sticky = navbar.offsetTop;
        window.onscroll = function() {myFunction()};
        
		function myFunction() {
		  if (window.pageYOffset >= sticky) {
		    navbar.classList.add("sticky")
		  } else {
		    navbar.classList.remove("sticky");
		  }
		}
    });
</script>
<div class="topMenu">
	<div class="container-xl top_title  pt-3 pb-0">
    <div class="row align-items-end">
        <div class="d-inline-flex "><a href="${ctp}"><img src="${ctp}/topMenu/logo.png" style="width:117px; height:53px;"></a></div>
        <div class="d-inline-flex ">CULTUREPLEX</div>
        <div class="col-5"></div>
        <!-- 로그인 메뉴 -->
        <div class="navbar boreder pb-0">
					<div class="mr-3">
	      	<c:choose>
	      		<c:when test="${!empty sMid}">
	            	<a href="${ctp}/member/loginOutOk" class="text-secondary">
	              	<img src="${ctp}/topMenu/login.png" style="width: 26px; height:26px;"><br/>로그아웃
	              </a>
	      		</c:when>
	      		<c:otherwise>
	            	<a href="${ctp}/member/loginPage" class="text-secondary">
	            		<img src="${ctp}/topMenu/login.png" style="width: 26px; height:26px;"><br/>로그인
	            	</a>
	      		</c:otherwise>
	      	</c:choose>
	      </div>
	      <div class="mr-3">
	      	<a href="${ctp}/member/myPageMain" class="text-secondary"><img src="${ctp}/topMenu/mycgv.png" style="width:26px; height:26px;"><br/>MY CGV</a>
	      </div>
       	<c:if test="${empty sMid }">
        	<div class="mr-3">
          	<a href="${ctp}/member/signUpPage" class="text-secondary"><img src="${ctp}/topMenu/register.png" style="width:26px; height:26px;"><br/>회원가입</a>
        	</div>
       	</c:if>
       	<c:if test="${sLevel == 100}">
       		<div class="mr-3">
	          <a href="${ctp}/member/mainPage" class="text-secondary"><img src="${ctp}/topMenu/register.png" style="width:26px; height:26px;"><br/>관리자 페이지</a>
       		</div>
       	</c:if>
        <c:if test="${!empty sMid }">
        	<div>
            ${sNickName}님 <br/>로그인중입니다.
        	</div>
        </c:if>
        </div>
    </div>
</div>
</div>

<div id="mainMenu">
	<div class="container-xl" style="width: 1140px">
	   	<div class="row align-items-center">
	        <div class="col">
	            <nav class="navbar navbar-expand-xl">
	                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
	                <span class="navbar-toggler-icon "></span>
	                </button>
	                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
	                    <div class="navbar-nav">
	                        <a class="nav-link" href="#">영화</a>
	                        <a class="nav-link" href="${ctp}/ReservationPage.res">예매</a>
	                        <a class="nav-link" href="#">상영관</a>
	                        <a class="nav-link" href="#">공지사항</a>
	                    </div>
	                </div>
	            </nav>
	        </div>
	        <div class="col">
	            <nav class="navbar navbar-expand-xl justify-content-end">
	                  <input class="form-control me-2" type="search" placeholder="영화 검색" style="width: 200px">
	                  <button class="btn btn-outline-success" type="submit">Search</button>
	            </nav>
	        </div>
	    </div>  
	</div>
</div>