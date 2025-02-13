<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>LogBlog</title>
<script>
function validateFileExtension() {
    var fileInput = document.querySelector('input[type="file"]');
    if(fileInput.files.length > 0) {
        var fileName = fileInput.files[0].name;
        var allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp', 'txt']; 
        var isValid = false;
        
        var firstExt = "." + fileName.split('.')[1];
        
        allowedExtensions.forEach(function(ext) {
            if(firstExt.toLowerCase() === ext) {
                isValid = true;
            }
        });
        
        if(!isValid) {
            alert('이미지 파일만 업로드 가능합니다.');
            fileInput.value = '';
            return false;
        }
        return true;
    }
    return true;
}

function validateForm(event) {
    // 제목과 내용 입력 필드 가져오기
    var title = document.querySelector('input[name="blogTitle"]').value;
    var content = document.querySelector('textarea[name="blogContent"]').value;

    // `<script>` 태그 검증 로직
    var scriptTagPattern = /<\s*script.*?>.*?<\s*\/\s*script\s*>/gi;
    if (scriptTagPattern.test(title) || scriptTagPattern.test(content)) {
        alert('잘못된 입력입니다. 스크립트 태그는 사용할 수 없습니다.');
        event.preventDefault(); // 폼 제출 방지
        return false;
    }

    if (!validateFileExtension()) {
        event.preventDefault();
        return false;
    }

    // 비밀글 체크 시 비밀번호 확인
    var isSecret = document.getElementById('isSecret').checked;
    var password = document.getElementById('blogPassword').value;

    if (isSecret && !password) {
        alert('비밀글 작성 시 비밀번호를 입력해주세요.');
        event.preventDefault();
        return false;
    }
    return true;
}


function togglePassword() {
    var passwordField = document.getElementById('blogPassword');
    var isSecret = document.getElementById('isSecret').checked;
    passwordField.disabled = !isSecret;
    if(!isSecret) {
        passwordField.value = '';
    }
}
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
        <!-- 네비게이션 바 코드는 동일 -->
    </nav>
    <div class="container">
        <div class="row">
            <form method="post" action="writeAction.jsp" enctype="multipart/form-data" onsubmit="return validateForm(event)">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <thead>
                        <tr>
                            <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="text" class="form-control" placeholder="글 제목" name="blogTitle" maxlength="50"></td>
                        </tr>
                        <tr>
                            <td><textarea class="form-control" placeholder="글 내용" name="blogContent" maxlength="2048" style="height: 150px"></textarea></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <label>
                                        <input type="checkbox" id="isSecret" name="isSecret" onchange="togglePassword()"> 비밀글로 작성
                                    </label>
                                </div>
                                <input type="password" class="form-control" id="blogPassword" name="blogPassword" placeholder="비밀번호" disabled>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="file" name="uploadFile" onchange="validateFileExtension()"></td>
                        </tr>
                    </tbody>
                </table>
                <input type="submit" class="btn btn-primary pull-right" value="글쓰기">
            </form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>