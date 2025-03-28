<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>LogBlog</title>
</head>
<body>
    <%
        String userID = null;
        Cookie[] cookies = request.getCookies();
        if(cookies != null) {
            for(Cookie cookie : cookies) {
                if("userID".equals(cookie.getName())) {
                    userID = cookie.getValue();
                    break;
                }
            }
        }
        
        if(userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인이 필요합니다.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
            return;
        }
        
        // 쿠키의 userID로 사용자 정보 조회
        User user = new UserDAO().getUser(userID);
        if(user == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('존재하지 않는 사용자입니다.')");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
            return;
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
        </div>
    </nav>
    
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="padding-top: 20px;">
                <form method="post" action="myPageAction.jsp">
                    <h3 style="text-align: center;">내 정보</h3>
                    <div style="margin-top: 30px;">
                        <div class="form-group">
                            <label>아이디</label>
                            <input type="text" class="form-control" value="<%= user.getUserID() %>" readonly>
                        </div>
                        <div class="form-group">
                            <label>이름</label>
                            <input type="text" class="form-control" name="userName" value="<%= user.getUserName() %>" readonly>
                        </div>
                        <div class="form-group">
                            <label>성별</label>
                            <input type="text" class="form-control" name="userGender" value="<%= user.getUserGender() %>" readonly>
                        </div>
                        <div class="form-group">
                            <label>이메일</label>
                            <input type="email" class="form-control" name="userEmail" value="<%= user.getUserEmail() %>" readonly>
                        </div>
                        <div class="row" style="margin-top: 20px;">
                            <div class="col-xs-4">
                                <button type="button" class="btn btn-primary" onclick="toggleEdit()">수정</button>
                            </div>
                            <div class="col-xs-4">
                                <button type="button" class="btn btn-warning" onclick="changePassword()">비밀번호 변경</button>
                            </div>
                            <div class="col-xs-4 text-right">
                                <button type="submit" class="btn btn-success" id="saveBtn" style="display: none;">저장</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-lg-4"></div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script>
        function toggleEdit() {
            var inputs = document.getElementsByClassName('form-control');
            var saveBtn = document.getElementById('saveBtn');
            
            for(var i = 1; i < inputs.length; i++) {
                if(inputs[i].readOnly) {
                    inputs[i].readOnly = false;
                    inputs[i].style.backgroundColor = '#ffffff';
                    saveBtn.style.display = 'block';
                } else {
                    inputs[i].readOnly = true;
                    inputs[i].style.backgroundColor = '';
                    saveBtn.style.display = 'none';
                }
            }
        }

        function changePassword() {
            location.href = 'changePassword.jsp?userID=' + '<%= userID %>';
        }
    </script>
</body>
</html>