/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.98
 * Generated at: 2025-01-09 07:22:51 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import user.UserDAO;
import user.User;
import java.io.PrintWriter;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import java.util.Random;

public final class findPasswordAction_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(7);
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.mail");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.mail.internet");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(7);
    _jspx_imports_classes.add("java.io.PrintWriter");
    _jspx_imports_classes.add("user.User");
    _jspx_imports_classes.add("java.util.Properties");
    _jspx_imports_classes.add("java.util.Random");
    _jspx_imports_classes.add("user.UserDAO");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
 request.setCharacterEncoding("UTF-8"); 
      out.write('\n');
      user.User user = null;
      user = (user.User) _jspx_page_context.getAttribute("user", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (user == null){
        user = new user.User();
        _jspx_page_context.setAttribute("user", user, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.introspecthelper(_jspx_page_context.findAttribute("user"), "userID", request.getParameter("userID"), request, "userID", false);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.introspecthelper(_jspx_page_context.findAttribute("user"), "userEmail", request.getParameter("userEmail"), request, "userEmail", false);
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<meta charset=\"UTF-8\">\n");
      out.write("<title>LogBlog</title>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    ");

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
    
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
