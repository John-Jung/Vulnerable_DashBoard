package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;

public class UserDAO {
    
    private Connection conn;
    private ResultSet rs;
    
    public UserDAO() {
        try {
            // Oracle 19c 서버의 IP 주소로 변경
        	String dbURL = "jdbc:oracle:thin:@192.168.17.132:1521:DB19";
            String dbID = "LogBlog";
            String dbPassword = "1234";
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public int login(String userID, String userPassword) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String SQL = "SELECT userPassword FROM USER_TABLE WHERE userID = '" + userID + "'";
        
        try {
            conn = DBConnectionPool.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(SQL);
            
            if(rs.next()) {
                if(rs.getString(1).equals(userPassword))
                    return 1; // 로그인 성공
                else
                    return 0; // 비밀번호 불일치
            }
            return -1; // 아이디가 없음
        } catch (Exception e) {
            e.printStackTrace();
            return -2; // 데이터베이스 오류
        } finally {
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(conn != null) conn.close(); // 커넥션 풀에 반환
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public int join(User user) {
        String SQL = "INSERT INTO USER_TABLE VALUES ('" 
                  + user.getUserID() + "', '" 
                  + user.getUserPassword() + "', '" 
                  + user.getUserName() + "', '" 
                  + user.getUserGender() + "', '" 
                  + user.getUserEmail() + "')";
        try {
            Statement stmt = conn.createStatement();
            return stmt.executeUpdate(SQL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    
    //마이페이지에서 불러올때 사용하는 메소드
    public User getUser(String userID) { 
        String SQL = "SELECT * FROM USER_TABLE WHERE userID = '" + userID + "'";
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery(SQL);
            if(rs.next()) {
                User user = new User();
                user.setUserID(rs.getString("userID"));
                user.setUserName(rs.getString("userName"));
                user.setUserGender(rs.getString("userGender"));
                user.setUserEmail(rs.getString("userEmail"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
        //마이 페이지에서 회원정보를 수정할 때
    public int updateUser(String userID, String userName, String userGender, String userEmail) {
        String SQL = "UPDATE USER_TABLE SET userName = '" + userName + "', "
                  + "userGender = '" + userGender + "', "
                  + "userEmail = '" + userEmail + "' "
                  + "WHERE userID = '" + userID + "'";
        try {
            Statement stmt = conn.createStatement();
            return stmt.executeUpdate(SQL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    
    //비밀번호를 찾을때
    public int updatePassword(String userID, String newPassword) {
        String SQL = "UPDATE USER_TABLE SET userPassword = '" + newPassword + "' WHERE userID = '" + userID + "'";
        try {
            Statement stmt = conn.createStatement();
            return stmt.executeUpdate(SQL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    
    // UserDAO에 추가할 메서드
    public boolean isAdmin(String userID) {
        String SQL = "SELECT userID FROM USER_TABLE WHERE userID = '" + userID + "' AND userID = 'admin'";
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery(SQL);
            if(rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    	//유저 권한을 가져오는 메서드
    public String getUserRole(String userID) {
        String SQL = "SELECT USERROLE FROM USER_TABLE WHERE USERID = '" + userID + "'";
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery(SQL);
            if(rs.next()) {
                return rs.getString("USERROLE");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
}