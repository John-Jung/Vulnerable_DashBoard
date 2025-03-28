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
<style>
.modal-container {
   display: none;
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background: rgba(0, 0, 0, 0.5);
   z-index: 1000;
}

.modal-content {
   position: relative;
   background: white;
   width: 90%;
   height: 90%;
   margin: 2% auto;
   padding: 20px;
   border-radius: 5px;
   box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.close-btn {
   position: absolute;
   right: 10px;
   top: 10px;
   font-size: 24px;
   cursor: pointer;
   color: #666;
   z-index: 1001;
}

.close-btn:hover {
   color: #000;
}

.modal-iframe {
   width: 100%;
   height: calc(100% - 20px);
   border: none;
   margin-top: 10px;
}

.btn-spacing {
   margin-right: 5px;
}

.error-message {
   padding: 20px;
   margin: 20px;
   border: 1px solid #ff0000;
   background-color: #ffebeb;
}
</style>
</head>
<body>
   <%
   String userID = null;
   String userRole = request.getParameter("userRole");
   String password = request.getParameter("password");
   Blog blog = null;

   try {
       if(session.getAttribute("userID") != null) {
           userID = (String) session.getAttribute("userID");
       }
       
       String blogID = request.getParameter("blogID");
       if (blogID == null || blogID.trim().isEmpty()) {
           throw new Exception("유효하지 않는 글입니다.");
       }
       
       BlogDAO blogDAO = new BlogDAO();
       blog = blogDAO.getBlog(blogID);
       
       // blog가 null이면 바로 에러를 던집니다
       if(blog == null) {  
           throw new Exception("존재하지 않는 글입니다.");
       }
       
       // 비밀글 접근 권한 체크
       if(blog.getIsSecret() == 1) {
           if(userRole != null && userRole.equals("guest")) {
               if(password == null || !password.equals(blog.getPassword())) {
                   throw new Exception("비밀번호가 일치하지 않습니다.");
               }
           }
       }
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
                       <li><a href="login.jsp">로그인</a></li>
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
           <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
               <thead>
                   <tr>
                       <th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기 양식</th>
                   </tr>
               </thead>
               <tbody>
                   <tr>
                       <td style="width: 20%;">글 제목</td>
                       <td colspan="2"><%= blog.getBlogTitle() %></td>
                   </tr>
                   <tr>
                       <td>작성자</td>
                       <td colspan="2"><%= blog.getUserID() %></td>
                   </tr>
                   <tr>
                       <td>작성일자</td>
                       <td colspan="2"><%= blog.getBlogDate().substring(0, 11) + blog.getBlogDate().substring(11, 13) + "시" + blog.getBlogDate().substring(14, 16) + "분" %></td>
                   </tr>
                   <tr>
                       <td>내용</td>
                       <td colspan="2" style="min-height: 200px; text-align: left">
                           <div id="content-container">
                               <%= blog.getBlogContent() %>
                           </div>
                       </td>
                   </tr>
                   <%
                   if(blog.getFileName() != null && !blog.getFileName().isEmpty()) {
                   %>
                   <tr>
                       <td>파일</td>
                       <td colspan="2">
                           <a href="uploads/<%= blog.getFileName() %>"><%= blog.getFileName() %></a>
                           <br>
                           <a href="download.jsp?filename=<%= blog.getFileName() %>" class="btn btn-info btn-sm">다운로드</a>
                           <button onclick="showFileModal('<%= blog.getFileName() %>')" class="btn btn-info btn-sm">미리보기</button>
                       </td>
                   </tr>
                   <%
                   }
                   %>
               </tbody>
           </table>
           <a href="logblog.jsp" class="btn btn-primary btn-spacing">목록</a>
           <%
           if (userID != null && userID.equals(blog.getUserID())){
           %>
               <a href="update.jsp?blogID=<%= blog.getBlogID() %>" class="btn btn-primary btn-spacing">수정</a>
               <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?blogID=<%= blog.getBlogID() %>" class="btn btn-primary btn-spacing">삭제</a>
           <% } %>
           <button class="btn btn-info btn-spacing" onclick="showLawModal()">게시판 규정</button>
           <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
       </div>
   </div>
   <%
   } catch (Exception e) {
       // 에러 메시지와 스택 트레이스를 화면에 출력
       out.println("<div class='container'><div class='error-message'>");
       out.println("<h3>오류가 발생했습니다:</h3>");
       out.println("<pre>");
       e.printStackTrace(new PrintWriter(out));
       out.println("</pre>");
       out.println("<a href='logblog.jsp' class='btn btn-primary'>목록으로 돌아가기</a>");
       out.println("</div></div>");
   }
   %>

   <!-- 게시판 규정 모달 -->
   <div id="lawModal" class="modal-container">
       <div class="modal-content">
           <span class="close-btn" onclick="hideLawModal()">&times;</span>
           <iframe src="logbloglaw.jsp" class="modal-iframe"></iframe>
       </div>
   </div>

   <!-- 파일 미리보기 모달 -->
   <div id="fileModal" class="modal-container">
       <div class="modal-content">
           <span class="close-btn" onclick="hideFileModal()">&times;</span>
           <iframe id="fileViewer" class="modal-iframe"></iframe>
       </div>
   </div>

   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
   <script>
   // 모달 관련 함수들
   function showLawModal() {
       document.getElementById('lawModal').style.display = 'block';
   }

   function hideLawModal() {
       document.getElementById('lawModal').style.display = 'none';
   }

   function showFileModal(filename) {
       document.getElementById('fileViewer').src = 'view_file.jsp?filename=' + encodeURIComponent(filename);
       document.getElementById('fileModal').style.display = 'block';
   }

   function hideFileModal() {
       document.getElementById('fileModal').style.display = 'none';
       document.getElementById('fileViewer').src = '';
   }

   // 모달 외부 클릭시 닫기
   window.onclick = function(event) {
       if (event.target.className === 'modal-container') {
           event.target.style.display = 'none';
           if (event.target.id === 'fileModal') {
               document.getElementById('fileViewer').src = '';
           }
       }
   }

   // 컨텐츠 내 iframe 처리
   document.addEventListener('DOMContentLoaded', function() {
       const contentContainer = document.getElementById('content-container');
       if (contentContainer) {
           const iframes = contentContainer.getElementsByTagName('iframe');
           Array.from(iframes).forEach(iframe => {
               const iframeSrc = iframe.getAttribute('src');
               
               const modalContainer = document.createElement('div');
               modalContainer.className = 'modal-container';
               
               const modalContent = document.createElement('div');
               modalContent.className = 'modal-content';
               
               const closeBtn = document.createElement('span');
               closeBtn.innerHTML = '&times;';
               closeBtn.className = 'close-btn';
               closeBtn.onclick = function() {
                   modalContainer.style.display = 'none';
               };
               
               const modalIframe = document.createElement('iframe');
               modalIframe.src = iframeSrc;
               modalIframe.className = 'modal-iframe';
               
               modalContent.appendChild(closeBtn);
               modalContent.appendChild(modalIframe);
               modalContainer.appendChild(modalContent);
               document.body.appendChild(modalContainer);
               
               const button = document.createElement('button');
               button.textContent = '페이지 보기';
               button.className = 'btn btn-info';
               button.onclick = function() {
                   modalContainer.style.display = 'block';
               };
               
               iframe.parentNode.replaceChild(button, iframe);
           });
       }
   });
   </script>
</body>
</html>