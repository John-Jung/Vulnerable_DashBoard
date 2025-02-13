<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>LogBlog</title>
<script>
// 전역 함수로 선언하여 window.opener에서 접근 가능하게 함
function handleVerificationResult(success) {
    if(success) {
        document.getElementById('verificationResult').innerText = '인증 성공';
        document.getElementById('newPasswordFields').style.display = 'block';
    } else {
        document.getElementById('verificationResult').innerText = '인증 실패';
    }
}
</script>
</head>
<body>
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
                <li><a href="main.jsp">메안</a></li>
                <li><a href="logblog.jsp">게시판</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle"
                    data-toggle="dropdown" role="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span>
                    </a>
                    
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="padding-top: 20px;">
                <form method="post" action="findPasswordAction.jsp" target="_blank">
                    <h3 style="text-align: center;">비밀번호 찾기</h3>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="아이디" name="userID" required>
                    </div>
                    <div class="form-group">
                        <input type="email" class="form-control" placeholder="이메일" name="userEmail" required>
                    </div>
                    <input type="hidden" name="action" value="sendVerification">
                    <input type="submit" class="btn btn-primary form-control" value="인증번호 받기">
                </form>
                
                <form method="post" action="findPasswordAction.jsp" target="_blank" style="margin-top: 10px;">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="인증번호" name="verificationCode" required>
                    </div>
                    <div id="verificationResult" style="text-align: center; margin: 10px 0;"></div>
                    <input type="hidden" name="action" value="verifyCode">
                    <input type="submit" class="btn btn-primary form-control" value="확인">
                </form>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>