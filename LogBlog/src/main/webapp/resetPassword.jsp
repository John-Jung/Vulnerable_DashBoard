<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String status = request.getParameter("status");
    if(status == null) {
        response.sendRedirect("findPassword.jsp");
        return;
    }

    String message = "";
    if(status.equals("fail")) {
        message = "인증번호가 일치하지 않습니다.";
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>LogBlog</title>
</head>
<body>
    <nav class="navbar navbar-default">
        <!-- 네비게이션 바 코드는 동일 -->
    </nav>
    
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="padding-top: 20px;">
                <% if(!message.equals("")) { %>
                    <div class="alert alert-danger" style="margin-bottom: 20px;">
                        <%= message %>
                    </div>
                    <form method="get" action="findPassword.jsp">
                        <input type="submit" class="btn btn-primary form-control" value="돌아가기">
                    </form>
                <% } else if(status.equals("success")) { %>
                    <form method="post" action="findPasswordAction.jsp">
                        <h3 style="text-align: center;">새 비밀번호 설정</h3>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="새 비밀번호" name="newPassword" required>
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="새 비밀번호 확인" name="confirmPassword" required>
                        </div>
                        <input type="hidden" name="action" value="changePassword">
                        <input type="submit" class="btn btn-primary form-control" value="비밀번호 변경">
                    </form>
                <% } %>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>