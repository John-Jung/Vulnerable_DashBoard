<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%
    // 관리자 비밀번호 설정 (실제로는 DB에서 가져오거나 더 안전한 방법으로 저장해야 함)
    final String ADMIN_PASSWORD = "admin";
    
    String adminPassword = request.getParameter("adminPassword");
    
 // 디버깅을 위한 콘솔 출력
    System.out.println("입력된 비밀번호: " + adminPassword);
    System.out.println("저장된 비밀번호: " + ADMIN_PASSWORD);
    System.out.println("비밀번호 길이 - 입력: " + (adminPassword != null ? adminPassword.length() : "null"));
    System.out.println("비밀번호 길이 - 저장: " + ADMIN_PASSWORD.length());
    
    
    if(ADMIN_PASSWORD.equals(adminPassword)) {
        // 인증 성공 시 쿠키 생성
        Cookie adminAuth = new Cookie("adminAuthenticated", "true");
        adminAuth.setMaxAge(1800); // 30분
        adminAuth.setPath("/");
        response.addCookie(adminAuth);
        
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'admin.jsp'");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('관리자 비밀번호가 일치하지 않습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>