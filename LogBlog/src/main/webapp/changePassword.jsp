<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>LogBlog - 비밀번호 변경</title>
</head>
<body>
    <%
        PrintWriter script = response.getWriter();
        String sessionUserID = (String) session.getAttribute("userID");
        
        // 세션 체크
        if(sessionUserID == null) {
            script.println("<script>");
            script.println("alert('로그인을 하세요.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
            return;
        }
        
        // URL 파라미터 체크
        String paramUserID = request.getParameter("id");
        if(paramUserID != null && !paramUserID.equals(sessionUserID)) {
            script.println("<script>");
            script.println("alert('아이디와 세션이 일치하지 않습니다.')");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
            return;
        }
    %>
    
    <nav class="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="main.jsp">LogBlog</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li><a href="logblog.jsp">게시판</a></li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="padding-top: 20px;">
                <form method="post" action="changePasswordAction.jsp" onsubmit="return validateForm()">
                    <h3 style="text-align: center;">비밀번호 변경</h3>
                    <div class="form-group">
                        <input type="hidden" name="userID" value="<%= sessionUserID %>">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="새 비밀번호" name="newPassword" maxlength="20">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="새 비밀번호 확인" name="confirmPassword" maxlength="20">
                    </div>
                    <div class="row">
                        <div class="col-xs-6">
                            <input type="submit" class="btn btn-primary form-control" value="변경">
                        </div>
                        <div class="col-xs-6">
                            <input type="button" class="btn btn-default form-control" value="취소" onclick="history.back()">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script>
        function validateForm() {
            var newPassword = document.getElementsByName("newPassword")[0].value;
            var confirmPassword = document.getElementsByName("confirmPassword")[0].value;
            
            if(newPassword === "") {
                alert("새 비밀번호를 입력하세요.");
                return false;
            }
            if(confirmPassword === "") {
                alert("새 비밀번호 확인을 입력하세요.");
                return false;
            }
            if(newPassword !== confirmPassword) {
                alert("새 비밀번호가 일치하지 않습니다.");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>