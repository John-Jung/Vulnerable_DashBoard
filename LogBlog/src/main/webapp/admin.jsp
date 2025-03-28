<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>LogBlog 관리자</title>
</head>
<body>
   <%
    // 세션 생성 시간 체크
    long creationTime = session.getCreationTime();
    long currentTime = System.currentTimeMillis();
    long sessionDuration = (currentTime - creationTime) / 1000; // 초 단위로 변환
    
    if (sessionDuration > 700) { // 1분(60초) 초과
        session.invalidate(); // 세션 무효화
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('세션이 만료되었습니다!');");
        script.println("location.href = 'main.jsp';");
        script.println("</script>");
        return;
    }

    String userID = null;
    String userRole = null;
    String adminAuthenticated = null;
    
    // 쿠키에서 userID, userRole, adminAuthenticated 확인
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie cookie : cookies){
            if("userID".equals(cookie.getName())){
                userID = cookie.getValue();
            }
            if("userRole".equals(cookie.getName())){
                userRole = cookie.getValue();
            }
            if("adminAuthenticated".equals(cookie.getName())){
                adminAuthenticated = cookie.getValue();
            }
        }
    }
    
    // admin 체크
    if(userID == null || !"ADMIN".equals(userRole)) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('관리자만 접근 가능합니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
        return;
    }

    // 2차 인증 체크
/*     if(!"true".equals(adminAuthenticated)) {
        response.sendRedirect("adminCheck.jsp");
        return;
    } */
    %>
   <!-- 나머지 HTML 코드는 동일 -->
   <nav class="navbar navbar-default">
   	<div class="navbar-header">
   		<button type="button" class="navbar-toggle collapsed"
   			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
   			aria-expanded="false">
   			<span class="icon-bar"></span>
   			<span class="icon-bar"></span>
   			<span class="icon-bar"></span>
   		</button>
   		<a class="navbar-brand" href="main.jsp">LogBlog</a>
   	</div>
   	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
   		<ul class="nav navbar-nav">
   			<li><a href="main.jsp">메인</a></li>
   			<li><a href="logblog.jsp">게시판</a></li>
            <li class="active"><a href="admin.jsp">관리자</a></li>
   		</ul>
   		<ul class="nav navbar-nav navbar-right">
   			<li class="dropdown">
   				<a href="#" class="dropdown-toggle"
   				data-toggle="dropdown" role="button" aria-haspopup="true"
   				aria-expanded="false">회원관리<span class="caret"></span>
   				</a>
   				<ul class="dropdown-menu">
   					<li><a href="logoutAction.jsp">로그아웃</a></li>
   				</ul>
   			</li>
   		</ul>
   	</div>
   </nav>
   
   <div class="container">
       <h2>사용자 현황</h2>
       <div class="row">
           <table class="table table-striped">
               <thead>
                   <tr>
                       <th>아이디</th>
                       <th>이름</th>
                       <th>성별</th>
                       <th>이메일</th>
                       <th>권한</th>
                   </tr>
               </thead>
               <tbody>
                   <%
                       Connection conn = null;
                       Statement stmt = null;
                       ResultSet rs = null;
                       
                       try {
                           String dbURL = "jdbc:oracle:thin:@192.168.17.132:1521:DB19";
                           String dbID = "LogBlog";
                           String dbPassword = "1234";
                           Class.forName("oracle.jdbc.driver.OracleDriver");
                           conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
                           
                           String SQL = "SELECT * FROM USER_TABLE ORDER BY USERID";
                           stmt = conn.createStatement();
                           rs = stmt.executeQuery(SQL);
                           
                           while(rs.next()) {
                   %>
                   <tr>
                       <td><%= rs.getString("USERID") %></td>
                       <td><%= rs.getString("USERNAME") %></td>
                       <td><%= rs.getString("USERGENDER") %></td>
                       <td><%= rs.getString("USEREMAIL") %></td>
                       <td><%= rs.getString("USERROLE") %></td>
                   </tr>
                   <%
                           }
                       } catch(Exception e) {
                           e.printStackTrace();
                       } finally {
                           try {
                               if(rs != null) rs.close();
                               if(stmt != null) stmt.close();
                               if(conn != null) conn.close();
                           } catch(Exception e) {
                               e.printStackTrace();
                           }
                       }
                   %>
               </tbody>
           </table>
       </div>
   </div>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
</body>
</html>