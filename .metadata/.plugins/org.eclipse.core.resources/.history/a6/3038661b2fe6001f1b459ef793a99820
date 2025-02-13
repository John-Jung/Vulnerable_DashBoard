<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>LogBlog</title>
<style>
   .nav-container {
       margin-bottom: 20px;
   }
   .nav-item {
       margin-right: 10px;
       padding: 5px;
   }
</style>
<script>
//해시 기반 네비게이션
function checkHash() {
    const hash = window.location.hash.slice(1);
    if (hash) {
        // 특수문자 필터링
        if(hash.includes(':') || hash.includes('(') || hash.includes(')')) {
            console.log("특수문자가 포함되어 있어 차단됩니다.");
            return;
        }

        // about이나 features인 경우 컨텐츠만 변경
        if(hash === 'about') {
            document.getElementById('mainContent').innerHTML = `
                <div class="jumbotron">
                    <h1>웹 사이트 소개</h1>
                    <p>LogBlog 웹사이트의 상세 소개입니다.</p>
                </div>
            `;
            return;
        } 
        else if(hash === 'features') {
            document.getElementById('mainContent').innerHTML = `
                <div class="jumbotron">
                    <h1>주요 기능</h1>
                    <p>LogBlog의 주요 기능들을 소개합니다.</p>
                </div>
            `;
            return;
        }
        // about이나 features가 아닌 경우에만 location.href 실행
        window.location.href = decodeURIComponent(hash);
    }
}

// 해시 변경 이벤트 리스너
window.addEventListener('hashchange', checkHash);
window.onload = checkHash;
</script>
</head>
<body>
   <%
   	String userID = null;
   	if(session.getAttribute("userID") != null){
   		userID = (String) session.getAttribute("userID");
   	}
   %>
   <nav class="navbar navbar-default">
   	<div class="navbar-header">
   		<button type="button" class="navbar-toggle collapsed"
   			data-toggle="collapse" data-target="#bs-example-navbar-collpase-1"
   			aria-expanded="false">
   			<span class="icon-bar"></span>
   			<span class="icon-bar"></span>
   			<span class="icon-bar"></span>
   			</button>
   			<a class="navbar-brand" href="main.jsp">LogBlog</a>
   	</div>
   	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
   		<ul class="nav navbar-nav">
   			<li class="active"><a href="main.jsp">메인</a></li>
   			<li><a href="logblog.jsp">게시판</a></li>
   		</ul>
   		<%
   			if(userID == null) {
   		%>
   		<ul class="nav navbar-nav navbar-right">
   			<li class="dropdown">
   				<a href="#" class="dropdown-toggle"
   				data-toggle="dropdown" role="button" aria-haspopup="true"
   				aria-expanded="false">접속하기<span class="caret"></span>
   				</a>
   				
   				<ul class="dropdown-menu">
   					<li ><a href="login.jsp">로그인</a></li>
   					<li><a href="join.jsp">회원가입</a></li>
   				</ul>
   			</li>
   		</ul>
   		<%
   			} else {
   		%>
   		<ul class="nav navbar-nav navbar-right">
   			<li class="dropdown">
   				<a href="#" class="dropdown-toggle"
   				data-toggle="dropdown" role="button" aria-haspopup="true"
   				aria-expanded="false">회원관리<span class="caret"></span>
   				</a>
   				<ul class="dropdown-menu">
   					<li><a href="logoutAction.jsp">로그아웃</a></li>
   					<li><a href="myPageCheck.jsp">마이 페이지</a></li>
   				</ul>
   			</li>
   		</ul>
   		<%
   			}
   		%>
   	</div>
   </nav>

   <!-- 해시 기반 네비게이션 메뉴 -->
   <div class="container">
       <div class="nav-container">
           <a href="#about" class="nav-item">소개</a>
           <a href="#features" class="nav-item">주요기능</a>
       </div>
       <div>현재 섹션: </div>
       <div id="currentSection"></div>
       
       <!-- 메인 컨텐츠 영역 -->
       <div id="mainContent">
           <div class="jumbotron">
               <h1>웹 사이트 소개</h1>
               <p>LogBlog 게시판 입니다.</p>
               <p><a class="btn btn-primary btn-pull" href="#about" role="button">자세히 알아보기</a></p>
           </div>
       </div>
   </div>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
</body>
</html>