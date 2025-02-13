<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="blog.Blog" %>
<%@ page import="blog.BlogDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LogBlog</title>
</head>
<body>
    <%
        String userID = null;
        if(session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        
        // 업로드 경로 설정 - 웹 루트 디렉토리 아래 uploads 폴더
        String uploadDir = request.getServletContext().getRealPath("/uploads");
        File uploadFolder = new File(uploadDir);
        if(!uploadFolder.exists()) {
            uploadFolder.mkdir();
        }
        
        // 파일 업로드 처리
        int maxSize = 100 * 1024 * 1024;  // 100MB
        MultipartRequest multi = new MultipartRequest(request, uploadDir, maxSize, "UTF-8", new DefaultFileRenamePolicy());
        
        // blogID는 URL 파라미터로 전달되므로 multi.getParameter 사용
        int blogID = 0;
        if(multi.getParameter("blogID") != null) {
            blogID = Integer.parseInt(multi.getParameter("blogID"));
        }
        
        if(userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 하세요.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
        }
        
        if(blogID == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 글입니다.')");
            script.println("location.href = 'logblog.jsp'");
            script.println("</script>");
        }
        
        Blog blog = new BlogDAO().getBlog(blogID);
        if(!userID.equals(blog.getUserID())) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('권한이 없습니다.')");
            script.println("location.href = 'logblog.jsp'");
            script.println("</script>");
        } else {
            if(multi.getParameter("blogTitle") == null || multi.getParameter("blogContent") == null
                    || multi.getParameter("blogTitle").equals("") || multi.getParameter("blogContent").equals("")) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안 된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                BlogDAO blogDAO = new BlogDAO();
                String fileName = "";
                if(multi.getFilesystemName("uploadFile") != null) {
                    fileName = multi.getFilesystemName("uploadFile");
                }
                
                int result = blogDAO.update(blogID, multi.getParameter("blogTitle"), 
                    multi.getParameter("blogContent"), fileName);
                
                if (result == -1) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('글 수정에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");
                }
                else {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href = 'logblog.jsp'");
                    script.println("</script>");
                }
            }
        }
    %>
</body>
</html>