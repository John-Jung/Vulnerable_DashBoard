<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
    String fileName = request.getParameter("filename"); 
    if (fileName == null || fileName.trim().equals("")) {
        out.println("<script>alert('파일명이 없습니다'); history.back();</script>");
        return;
    }
    
    // 확장자 체크 - 가장 마지막 점(.)의 위치 찾기
    int lastDotIndex = fileName.lastIndexOf(".");
    if (lastDotIndex <= 0) {
        out.println("<script>alert('확장자가 없습니다'); history.back();</script>");
        return;
    } else {
        // 파일 확장자 검증 - 점이 있는 경우에만 실행
        String extension = fileName.substring(lastDotIndex);
        if (!extension.matches("\\.(jpg|jpeg|png|gif|pdf|txt)$")) {
            out.println("<script>alert('이미지 파일만 다운로드 가능합니다'); history.back();</script>");
            return;
        }
    }

    String uploadDir = "/home/cent/Desktop/new-workspace/LogBlog/src/main/webapp/uploads";
    String filePath = uploadDir + "/" + fileName;
    
    // NULL byte가 있는 경우 처리
    if(filePath.indexOf("\0") != -1) {
        filePath = filePath.substring(0, filePath.indexOf("\0"));
    }

    try {
        FileInputStream fis = new FileInputStream(filePath);
        OutputStream outStream = response.getOutputStream();
        
        String mimeType = getServletContext().getMimeType(filePath);
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        
        response.setContentType(mimeType);
        String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);
        
        byte[] buffer = new byte[4096];
        int bytesRead;
        
        while ((bytesRead = fis.read(buffer)) != -1) {
            outStream.write(buffer, 0, bytesRead);
        }
        outStream.flush();
        fis.close();
    } catch (Exception e) {
        out.println("<script>alert('파일이 존재하지 않습니다'); history.back();</script>");
    }
%>