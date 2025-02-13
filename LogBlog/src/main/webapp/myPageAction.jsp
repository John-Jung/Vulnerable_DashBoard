<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
        
        if(userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 하세요.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
        } else {
            String userName = request.getParameter("userName");
            String userGender = request.getParameter("userGender");
            String userEmail = request.getParameter("userEmail");
            
            if(userName == null || userGender == null || userEmail == null
                || userName.equals("") || userGender.equals("") || userEmail.equals("")) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안 된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                UserDAO userDAO = new UserDAO();
                int result = userDAO.updateUser(userID, userName, userGender, userEmail);
                if(result == -1) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('회원정보 수정에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");
                } else {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('회원정보가 수정되었습니다.')");
                    script.println("location.href = 'myPage.jsp'");
                    script.println("</script>");
                }
            }
        }
    %>
</body>
</html>