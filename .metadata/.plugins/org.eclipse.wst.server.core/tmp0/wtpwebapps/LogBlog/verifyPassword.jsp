<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="blog.BlogDAO" %>
<%@ page import="blog.Blog" %>
<%
    String userID = null;
    if(session.getAttribute("userID") != null){
        userID = (String) session.getAttribute("userID");
    }

    int blogID = Integer.parseInt(request.getParameter("blogID"));
    String password = request.getParameter("password");

    BlogDAO blogDAO = new BlogDAO();
    Blog blog = blogDAO.getBlog(blogID);

    // 사용자 권한 확인
    String userRole = "guest";
    if(userID != null) {
        if(userID.equals(blog.getUserID())) {
            userRole = "user";
        } else if(userID.equals("admin")) { // 관리자 ID 확인
            userRole = "admin";
        }
    }

    // HTTP 헤더에 사용자 권한 추가
    response.setHeader("User-Role", userRole);

    // 비밀번호 검증 또는 권한 확인
    if(blog.getPassword().equals(password) || userRole.equals("user") || userRole.equals("admin")) {
        out.print("success");
    } else {
        out.print("fail");
    }
%>