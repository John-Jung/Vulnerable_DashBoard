# 프로젝트 개요

주요 취약점 (파일 업로드, 다운로드, 불충분한 인증/인가, 프로세스 검증 누락, XSS, CSRF, SQL Injection) 실습을 위한 웹 애플리케이션

---

## 🛠️ 개발 환경

- **OS**: CentOS 7
- **Database**: Oracle DB 19
- **WAS**: Tomcat 9
- **Frontend**: JSP, HTML, CSS
- **Backend**: JSP + JSTL + JDBC
- **Architecture**: MVC 패턴 (`*action.jsp`로 Controller 역할)


## 📦 사용 라이브러리

프로젝트에서 사용한 주요 라이브러리

| 라이브러리 명                | 설명                                                                                      |
|----------------------------|-----------------------------------------------------------------------------------------|
| **HikariCP-5.1.0.jar**      | 고성능 JDBC 커넥션 풀 라이브러리. 데이터베이스 커넥션 관리 성능을 최적화하는 데 사용            |
| **activation-1.1.jar**      | JavaBeans Activation Framework. MIME 타입 처리를 위해 이메일 발송 및 파일 업로드에서 사용      |
| **cos.jar**                 | O'Reilly 제공 파일 업로드 라이브러리. `MultipartRequest` 클래스를 통해 JSP에서 파일 업로드 기능 |
| **javax.mail-1.6.2.jar**    | JavaMail API. 이메일 발송 기능 구현 시 사용                                                     |
| **json-simple-1.1.1.jar**   | JSON 파싱 및 생성 라이브러리. 서버와 클라이언트 간 JSON 데이터 처리 시 사용                 |
| **ojdbc8.jar**              | Oracle JDBC 드라이버. Oracle DB 19와 JDBC 연결을 위한 드라이버                             |
| **slf4j-api-2.0.9.jar**     | Simple Logging Facade for Java. 다양한 로깅 프레임워크와 연결할 수 있는 로깅 API                  |



---

## 📌 주요 기능

### 1. 관리자 페이지
- 관리자 전용 로그인
- 회원 관리 및 게시판 관리 기능 제공

### 2. 로그인
- 일반 사용자 로그인 기능
- 세션 기반 인증 처리

### 3. 회원가입
- 신규 사용자 회원가입 기능
- 입력 정보 검증 및 중복 체크

### 4. 내 정보 페이지
- 사용자 본인 정보 확인 기능 제공

### 5. 내 정보 수정
- 사용자 본인 정보 수정 기능 지원

### 6. 게시판 기능
- 게시글 작성
- 게시글 수정
- 게시글 삭제
- 게시글 목록 조회

### 7. 파일 업로드 기능
- 게시판 글 작성 시 파일 첨부 가능
- **`cos.jar` 라이브러리의 `MultipartRequest` 클래스를 이용하여 파일 업로드 처리**
- 업로드된 파일은 지정된 서버 디렉토리에 저장

---

## ※ 특이사항

- centOS 7 설치 후 명령어 사용을 위한 kakao yum repository을 설치

https://velog.io/@wearetheone/centOS-7-%EC%98%A4%EB%9D%BC%ED%81%B4-%EC%84%A4%EC%B9%98-%EB%B0%A9%EB%B2%95
