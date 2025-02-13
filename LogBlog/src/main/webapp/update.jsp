<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="blog.Blog" %>
<%@ page import="blog.BlogDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>LogBlog</title>
</head>
<body>
    <%
        String userID = null;
        if(session.getAttribute("userID") != null){
            userID = (String) session.getAttribute("userID");
        }
        
        int blogID = 0;
        if(request.getParameter("blogID") != null) {
            blogID = Integer.parseInt(request.getParameter("blogID")); 
        }
        
        Blog blog = new BlogDAO().getBlog(blogID);
    %>
    <nav class="navbar navbar-default">
        <!-- 이전 네비게이션 바 코드는 동일하게 유지 -->
    </nav>
    <div class="container">
        <div class="row">
            <form method="post" action="updateAction.jsp?blogID=<%= blogID %>" enctype="multipart/form-data">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <thead>
                        <tr>
                            <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="text" class="form-control" placeholder="글 제목" name="blogTitle" maxlength="50" value="<%= blog.getBlogTitle() %>"></td>
                        </tr>
                        <tr>
                            <td><textarea class="form-control" placeholder="글 내용" name="blogContent" maxlength="2048" style="height: 350px"><%= blog.getBlogContent() %></textarea></td>
                        </tr>
                        <tr>
                            <td><input type="file" name="uploadFile"></td>
                        </tr>
                    </tbody>
                </table>
                <input type="submit" class="btn btn-primary pull-right" value="글수정">
            </form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>