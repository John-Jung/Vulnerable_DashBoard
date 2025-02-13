<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>LogBlog 관리자 인증</title>
</head>
<body>
    <%
    String userID = null;
    String userRole = null;
    
    // 쿠키에서 userID와 userRole 확인
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie cookie : cookies){
            if("userID".equals(cookie.getName())){
                userID = cookie.getValue();
            }
            if("userRole".equals(cookie.getName())){
                userRole = cookie.getValue();
            }
        }
    }
    
    // admin 체크
    if(userID == null || !"ADMIN".equals(userRole)) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('관리자만 접근 가능합니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
        return;
    }

    // 이미 2차 인증이 완료되었는지 확인
    String adminAuthenticated = null;
    if(cookies != null){
        for(Cookie cookie : cookies){
            if("adminAuthenticated".equals(cookie.getName())){
                adminAuthenticated = cookie.getValue();
            }
        }
    }
    
    if("true".equals(adminAuthenticated)) {
        response.sendRedirect("admin.jsp");
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
                <li class="active"><a href="admin.jsp">관리자</a></li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="padding-top: 20px;">
                <form method="post" action="adminCheckAction.jsp">
                    <h3 style="text-align: center;">관리자 2차 인증</h3>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="관리자 비밀번호" name="adminPassword" maxlength="20">
                    </div>
                    <input type="submit" class="btn btn-primary form-control" value="인증">
                </form>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>