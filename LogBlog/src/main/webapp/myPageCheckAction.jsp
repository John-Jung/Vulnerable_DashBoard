<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userPassword" />
<%
    String userID = null;
    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    
    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(userID, user.getUserPassword());
    
    if(result == 1) {
        response.sendRedirect("myPage.jsp");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀렸습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>