<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LogBlog</title>
</head>
<body>
    <%
        String userID = null;
        if(session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        
        // 로그인 체크
        if(userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 하세요.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
            return;
        }
        
        // 새 비밀번호 파라미터 확인
        if(request.getParameter("newPassword") == null || request.getParameter("newPassword").equals("")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호를 입력해주세요.')");
            script.println("history.back()");
            script.println("</script>");
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        String newPassword = request.getParameter("newPassword");
        
        // 비밀번호 변경 실행
        int result = userDAO.updatePassword(userID, newPassword);
        
        PrintWriter script = response.getWriter();
        if(result == -1) {
            script.println("<script>");
            script.println("alert('비밀번호 변경에 실패했습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            script.println("<script>");
            script.println("alert('비밀번호가 변경되었습니다.')");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
    %>
</body>
</html>