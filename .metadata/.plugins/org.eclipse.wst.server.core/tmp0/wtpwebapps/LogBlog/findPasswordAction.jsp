<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.Random" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LogBlog</title>
</head>
<body>
    <%
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();
        PrintWriter script = response.getWriter();
        
        if(action != null && action.equals("sendVerification")) {
            // 사용자 존재 여부 확인
            User foundUser = userDAO.getUser(user.getUserID());
            if(foundUser != null && foundUser.getUserEmail().equals(user.getUserEmail())) {
                // 인증번호 생성 (6자리)
                Random rand = new Random();
                String verificationCode = String.format("%06d", rand.nextInt(1000000));
                
                // 세션에 인증번호 저장
                session.setAttribute("verificationCode", verificationCode);
                session.setAttribute("verifiedUserID", user.getUserID());
                
                // 이메일 발송 설정
                String host = "smtp.gmail.com";
                final String username = "sungwuk98@gmail.com";  // 발신용 Gmail 주소
                final String password = "hlbf qxuo ocuo guvl";     // Gmail 앱 비밀번호
                int port = 587;
                
                // 이메일 속성 설정
                Properties props = new Properties();
                props.put("mail.smtp.host", host);
                props.put("mail.smtp.port", port);
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.ssl.protocols", "TLSv1.2");
                
                try {
                    // 세션 생성
                    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(username, password);
                        }
                    });
                    
                    // 메시지 생성
                    Message message = new MimeMessage(mailSession);
                    message.setFrom(new InternetAddress(username));
                    message.setRecipients(
                        Message.RecipientType.TO,
                        InternetAddress.parse(foundUser.getUserEmail())
                    );
                    message.setSubject("LogBlog 비밀번호 찾기 인증번호");
                    message.setText("안녕하세요,\n\n"
                        + "LogBlog 비밀번호 찾기 인증번호입니다.\n\n"
                        + "인증번호: " + verificationCode + "\n\n"
                        + "이 인증번호를 입력하여 비밀번호 재설정을 완료해주세요.\n\n"
                        + "감사합니다.\nLogBlog 팀");
                    
                    // 이메일 발송
                    Transport.send(message);
                    
                    script.println("<script>");
                    script.println("alert('인증번호가 이메일로 전송되었습니다.');");
                    script.println("window.close();");  // 새 창 닫기
                    script.println("</script>");
                    
                } catch(MessagingException e) {
                    script.println("<script>");
                    script.println("alert('이메일 발송 중 오류가 발생했습니다. 다시 시도해주세요.');");
                    script.println("window.close();");  // 새 창 닫기
                    script.println("</script>");
                    e.printStackTrace();
                }
            } else {
                script.println("<script>");
                script.println("alert('아이디 또는 이메일이 일치하지 않습니다.');");
                script.println("window.close();");  // 새 창 닫기
                script.println("</script>");
            }
        }
        else if(action != null && action.equals("verifyCode")) {
            String inputCode = request.getParameter("verificationCode");
            String savedCode = (String)session.getAttribute("verificationCode");
            
            if(savedCode != null && savedCode.equals(inputCode)) {
                response.sendRedirect("resetPassword.jsp?status=success");
            } else {
                response.sendRedirect("resetPassword.jsp?status=fail");
            }
        }
        else if(action != null && action.equals("changePassword")) {
            String savedUserID = (String)session.getAttribute("verifiedUserID");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            if(!newPassword.equals(confirmPassword)) {
                script.println("<script>");
                script.println("alert('새 비밀번호가 일치하지 않습니다.');");
                script.println("window.close();");
                script.println("</script>");
                return;
            }
            
            int result = userDAO.updatePassword(savedUserID, newPassword);
            if(result == 1) {
                // 비밀번호 변경 성공 시 세션 정보 삭제
                session.removeAttribute("verificationCode");
                session.removeAttribute("verifiedUserID");
                
                script.println("<script>");
                script.println("alert('비밀번호가 성공적으로 변경되었습니다.');");
                script.println("window.opener.location.href = 'login.jsp';");  // 부모 창을 로그인 페이지로
                script.println("window.close();");  // 새 창 닫기
                script.println("</script>");
            } else {
                script.println("<script>");
                script.println("alert('비밀번호 변경에 실패했습니다.');");
                script.println("window.close();");  // 새 창 닫기
                script.println("</script>");
            }
        }
    %>
</body>
</html>