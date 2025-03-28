<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" /> 
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LogBlog</title>
</head>
<body>
   <%
       // 이미 로그인된 경우 체크
       String userID = null;
       if(session.getAttribute("userID") != null){
           userID = (String) session.getAttribute("userID");
       }
       if(userID != null) {
           PrintWriter script = response.getWriter();
           script.println("<script>");
           script.println("alert('이미 로그인이 되어있습니다.')");
           script.println("location.href = 'main.jsp'");
           script.println("</script>");
       }
       
       UserDAO userDAO = new UserDAO();
       int result = userDAO.login(user.getUserID(), user.getUserPassword());
       
       if (result == 1){
           // 세션에 사용자 ID 저장
           session.setAttribute("userID", user.getUserID());
           
           // 사용자 정보 쿠키 설정 - 필수적인 정보만 저장
           Cookie idCookie = new Cookie("userID", user.getUserID());
           Cookie roleCookie = new Cookie("userRole", userDAO.getUserRole(user.getUserID()));
           
           idCookie.setHttpOnly(true); // XSS 방지
           roleCookie.setHttpOnly(true);
           
           idCookie.setPath("/");
           roleCookie.setPath("/");
           
           response.addCookie(idCookie);
           response.addCookie(roleCookie);
           
           PrintWriter script = response.getWriter();
           script.println("<script>");
           script.println("location.href = 'main.jsp'");
           script.println("</script>");
       }
       else if (result == 0){
           PrintWriter script = response.getWriter();
           script.println("<script>");
           script.println("alert('비밀번호가 틀립니다.')");
           script.println("history.back()");
           script.println("</script>");
       }
       else if (result == -1){
           PrintWriter script = response.getWriter();
           script.println("<script>");
           script.println("alert('존재하지 않는 아이디입니다.')");
           script.println("history.back()");
           script.println("</script>");
       }
       else if (result == -2){
           PrintWriter script = response.getWriter();
           script.println("<script>");
           script.println("alert('데이터베이스 오류가 발생했습니다.')");
           script.println("history.back()");
           script.println("</script>");
       }
   %>
</body>
</html>