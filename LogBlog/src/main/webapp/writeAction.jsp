<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="blog.BlogDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LogBlog</title>
</head>
<body>
  <%
      // 사용자 로그인 상태 확인
      String userID = null;
      if (session.getAttribute("userID") != null) {
          userID = (String) session.getAttribute("userID");
      }

      // 업로드 경로 설정
      String uploadDir = "/home/cent/Desktop/new-workspace/LogBlog/src/main/webapp/uploads";
      File uploadFolder = new File(uploadDir);
      if (!uploadFolder.exists()) {
          uploadFolder.mkdir();
      }

      // Tomcat 경로 설정 
      String tomcatPath = request.getServletContext().getRealPath("/uploads");
      File tomcatFolder = new File(tomcatPath);
      if (!tomcatFolder.exists()) {
          tomcatFolder.mkdir();
      }

      // 파일 업로드 처리
      int maxSize = 100 * 1024 * 1024;  // 100MB 제한
      MultipartRequest multi = new MultipartRequest(request, uploadDir, maxSize, "UTF-8", new DefaultFileRenamePolicy());

      String fileName = "";
      if (multi.getFilesystemName("uploadFile") != null) {
          fileName = multi.getFilesystemName("uploadFile");

          // 1. 파일 확장자 검증
          String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
          Set<String> allowedExtensions = new HashSet<>(Arrays.asList("jpg", "jpeg", "png", "gif", "webp", "bmp", "txt"));
          
          if (!allowedExtensions.contains(fileExt)) {
              new File(uploadDir + File.separator + fileName).delete();
              PrintWriter script = response.getWriter();
              script.println("<script>");
              script.println("alert('허용되지 않는 파일 형식입니다.');");
              script.println("history.back();");
              script.println("</script>");
              return;
          }

          // 2. Content-Type 검증
          String contentType = multi.getContentType("uploadFile");
          if (contentType == null || !contentType.startsWith("image/")) {
              new File(uploadDir + File.separator + fileName).delete();
              PrintWriter script = response.getWriter();
              script.println("<script>");
              script.println("alert('이미지 파일만 업로드 가능합니다.');");
              script.println("history.back();");
              script.println("</script>");
              return;
          }

          // 3. 실제 이미지 파일 검증
          File uploadedFile = new File(uploadDir + File.separator + fileName);
          try {
              BufferedImage image = ImageIO.read(uploadedFile);
              if (image == null) {
                  uploadedFile.delete();
                  PrintWriter script = response.getWriter();
                  script.println("<script>");
                  script.println("alert('유효하지 않은 이미지 파일입니다.');");
                  script.println("history.back();");
                  script.println("</script>");
                  return;
              }

              // 4. 파일 복사 (변수 이름 충돌 방지)
              File tomcatFile = new File(tomcatPath + File.separator + fileName);
              
              try (InputStream in = new FileInputStream(uploadedFile);
                   OutputStream fileOut = new FileOutputStream(tomcatFile)) {
                  byte[] buffer = new byte[1024];
                  int bytesRead;
                  while ((bytesRead = in.read(buffer)) != -1) {
                      fileOut.write(buffer, 0, bytesRead);
                  }
              }
          } catch (IOException e) {
              uploadedFile.delete();
              PrintWriter script = response.getWriter();
              script.println("<script>");
              script.println("alert('이미지 처리 중 오류가 발생했습니다.');");
              script.println("history.back();");
              script.println("</script>");
              return;
          }
      }

      // 유효성 검사
      if (userID == null) {
          PrintWriter script = response.getWriter();
          script.println("<script>");
          script.println("alert('로그인을 하세요.');");
          script.println("location.href = 'login.jsp';");
          script.println("</script>");
      } else if (multi.getParameter("blogTitle") == null || multi.getParameter("blogContent") == null) {
          PrintWriter script = response.getWriter();
          script.println("<script>");
          script.println("alert('입력이 안 된 사항이 있습니다.');");
          script.println("history.back();");
          script.println("</script>");
      } else if (multi.getParameter("isSecret") != null && multi.getParameter("blogPassword") == null) {
          PrintWriter script = response.getWriter();
          script.println("<script>");
          script.println("alert('비밀글 작성시 비밀번호를 입력해주세요.');");
          script.println("history.back();");
          script.println("</script>");
      } else {
          // 비밀글 여부와 비밀번호 가져오기
          int isSecret = (multi.getParameter("isSecret") != null) ? 1 : 0;
          String password = multi.getParameter("blogPassword");
          
          // 데이터베이스에 글 저장
          BlogDAO blogDAO = new BlogDAO();
          int result = blogDAO.write(multi.getParameter("blogTitle"), userID, 
              multi.getParameter("blogContent"), fileName, isSecret, password);
          
          if (result == -1) {
              PrintWriter script = response.getWriter();
              script.println("<script>");
              script.println("alert('글쓰기에 실패했습니다.');");
              script.println("history.back();");
              script.println("</script>");
          } else {
              PrintWriter script = response.getWriter();
              script.println("<script>");
              script.println("location.href = 'logblog.jsp';");
              script.println("</script>");
          }
      }
  %>
</body>
</html>