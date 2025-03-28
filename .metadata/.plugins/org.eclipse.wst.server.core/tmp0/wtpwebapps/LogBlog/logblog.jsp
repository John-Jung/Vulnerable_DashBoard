<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="blog.BlogDAO" %>
<%@ page import="blog.Blog" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>LogBlog</title>
<style type="text/css">
   a, a:hover {
   color: #000000;
   text-decoration: none;
   }
    .footer {
       position: fixed;
       left: 0;
       bottom: 0;
       width: 100%;
       background-color: #f8f9fa;
       text-align: center;
       padding: 15px;
       font-size: 14px;
       border-top: 1px solid #ddd;
   }
   /* 푸터와 컨텐츠가 겹치지 않도록 여백 추가 */
   body {
       margin-bottom: 60px;
   }
</style>
</head>
<body>
   <%
       String userID = null;
       if(session.getAttribute("userID") != null){
           userID = (String) session.getAttribute("userID");
       }
       
       String pageNumberParam = request.getParameter("pageNumber");
       int pageNumber = 1;
       
       if(pageNumberParam != null) {
    	    try {
    	        // 첫 번째 숫자만 추출 - 공백을 제거하고 처리
    	        String firstNumber = pageNumberParam.trim().split(" ")[0];  // 공백으로 split하여 첫 번째 토큰 사용
    	        pageNumber = Integer.parseInt(firstNumber);
    	    } catch (Exception e) {
    	        pageNumber = 1;
    	    }
       }

       String searchType = request.getParameter("searchType");
       String searchText = request.getParameter("searchText");
   %>

   <nav class="navbar navbar-default">
       <div class="navbar-header">
           <button type="button" class="navbar-toggle collapsed"
               data-toggle="collapse" data-target="#bs-example-navbar-collpase-1"
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
               <li class="active"><a href="logblog.jsp">게시판</a></li>
           </ul>
           <%
               if(userID == null) {
           %>
           <ul class="nav navbar-nav navbar-right">
               <li class="dropdown">
                   <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span>
                   </a>
                   
                   <ul class="dropdown-menu">
                       <li ><a href="login.jsp">로그인</a></li>
                       <li><a href="join.jsp">회원가입</a></li>
                   </ul>
               </li>
           </ul>
           <%
               } else {
           %>
           <ul class="nav navbar-nav navbar-right">
               <li class="dropdown">
                   <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span>
                   </a>
                   
                   <ul class="dropdown-menu">
                       	<li><a href="logoutAction.jsp">로그아웃</a></li>
   						<li><a href="myPageCheck.jsp">마이 페이지</a></li>
                   </ul>
               </li>
           </ul>
           <%
               }
           %>
       </div>
   </nav>
   <div class="container">
       <div class="row">
           <!-- 검색 폼 -->
           <div class="col-lg-4" style="margin-bottom: 20px;">
               <form action="logblog.jsp" method="get" class="form-inline">
                   <select name="searchType" class="form-control">
                       <option value="title" <%= searchType != null && searchType.equals("title") ? "selected" : "" %>>제목</option>
                       <option value="userID" <%= searchType != null && searchType.equals("userID") ? "selected" : "" %>>작성자</option>
                   </select>
                   <input type="text" name="searchText" class="form-control" placeholder="검색어를 입력하세요" 
                          value="<%= searchText != null ? searchText : "" %>">
                   <button type="submit" class="btn btn-primary">검색</button>
               </form>
           </div>

			<% 
    if(searchText != null && !searchText.equals("")) { 
        String filtered = searchText;
        // HTML 엔티티가 포함된 경우만 실행 가능하도록
        if(searchText.contains("&lt;") || searchText.contains("&#")) {
            // HTML 엔티티가 포함된 경우는 그대로 출력
%>
            <script>
                var decodedText = document.createElement('textarea');
                decodedText.innerHTML = '<%= filtered %>';
                document.write('검색어: ' + decodedText.value);
            </script>
<%
        } else {
            // 일반 텍스트나 <script> 태그는 HTML 엔티티로 변환만 하고 실행하지 않음
            filtered = searchText.replace("<", "&lt;")
                               .replace(">", "&gt;");
%>
            <div>검색어: <%= filtered %></div>
<%
        }
    }
%>

           <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
               <thead>
                   <tr>
                       <th style="background-color: #eeeeee; text-align: center;">번호</th>
                       <th style="background-color: #eeeeee; text-align: center;">제목</th>
                       <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                       <th style="background-color: #eeeeee; text-align: center;">작성일</th>
                   </tr>
               </thead>
               <tbody>
                   <%
					    BlogDAO blogDAO = new BlogDAO();
					    ArrayList<Blog> list;
					    
					    // 검색 파라미터 확인
					    
					    // 검색어가 있으면 검색 결과를, 없으면 전체 목록을 가져옴
					    if(searchType != null && searchText != null && !searchText.equals("")) {
					        list = blogDAO.getSearchList(searchType, searchText, pageNumber);
					    } else {
					        list = blogDAO.getList(pageNumber);
					    }
					    
					    for(int i = 0; i < list.size(); i++){
				   %>
                   <tr>
                       <td><%= list.get(i).getBlogID() %></td>
                       <td><a href="view.jsp?blogID=<%= list.get(i).getBlogID() %>"><%= list.get(i).getBlogTitle() %></a></td>
                       <td><%= list.get(i).getUserID() %></td>
                       <td><%= list.get(i).getBlogDate().substring(0, 11) + list.get(i).getBlogDate().substring(11, 13) + "시" + list.get(i).getBlogDate().substring(14, 16) + "분" %></td>
                   </tr>
                   <% 
                       }
                   %>
               </tbody>
           </table>
           
           <!-- 페이지네이션 -->
           <div style="text-align: center;">
               <%
                   if(pageNumber != 1) {
                       String prevUrl = "logblog.jsp?pageNumber=" + (pageNumber - 1);
                       if(searchType != null && searchText != null) {
                           prevUrl += "&searchType=" + searchType + "&searchText=" + searchText;
                       }
               %>
                   <a href="<%= prevUrl %>" class="btn btn-success btn-arraw-left">이전</a>
               <%
                   }
                   if(blogDAO.nextPage(pageNumberParam)) {
                       String nextUrl = "logblog.jsp?pageNumber=" + (pageNumber + 1);
                       if(searchType != null && searchText != null) {
                           nextUrl += "&searchType=" + searchType + "&searchText=" + searchText;
                       }
               %>
                   <a href="<%= nextUrl %>" class="btn btn-success btn-arraw-left">다음</a>
               <%
                   }
               %>
               <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
           </div>
       </div>
   </div>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
   
   <!-- Footer 추가 -->
   <footer class="footer">
       <div class="container">
           <span>관리자에게 문의: <a href="mailto:sungwuk98@gmail.com">sungwuk98@gmail.com</a></span>
       </div>
   </footer>
</body>
</html>