<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="blog.BlogDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 삭제</title>
</head>
<body>
    <%
        String userID = null;
        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }

        int blogID = 0;
        if (request.getParameter("blogID") != null) {
            blogID = Integer.parseInt(request.getParameter("blogID"));
        }

        if (userID == null) { // 로그인 확인
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인이 필요합니다.');");
            script.println("location.href = 'login.jsp';");
            script.println("</script>");
        } else if (blogID == 0) { // blogID가 유효하지 않을 경우
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 게시글입니다.');");
            script.println("location.href = 'logblog.jsp';");
            script.println("</script>");
        } else {
            BlogDAO blogDAO = new BlogDAO();
            int result = blogDAO.delete(blogID); // blogID로 게시글 삭제 수행
            if (result == 1) { // 삭제 성공
                response.sendRedirect("logblog.jsp"); // 게시판 목록 페이지로 이동
            } else { // 삭제 실패
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('게시글 삭제에 실패했습니다.');");
                script.println("history.back();");
                script.println("</script>");
            }
        }
    %>
</body>
</html>
