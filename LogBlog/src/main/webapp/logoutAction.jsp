<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LogBlog</title>
</head>
<body>
    <%
        // 세션 속성만 제거하고 세션 자체는 유지
        session.removeAttribute("userID");
        
        // 사용자 관련 쿠키 제거
        Cookie[] cookies = request.getCookies();
        if(cookies != null) {
            for(Cookie cookie : cookies) {
                if("userID".equals(cookie.getName()) || "userRole".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }
        }
    %>
    <script>
        location.href = 'main.jsp';
    </script>
</body>
</html>