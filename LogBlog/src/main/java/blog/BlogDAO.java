package blog;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class BlogDAO {
  
  private Connection conn;
  private ResultSet rs;
  
  public BlogDAO() {
      try {
          String dbURL = "jdbc:oracle:thin:@192.168.17.132:1521:DB19";
          String dbID = "LogBlog";
          String dbPassword = "1234";
          Class.forName("oracle.jdbc.driver.OracleDriver");
          conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
      } catch (Exception e) {
          e.printStackTrace();
      }
  }
  
  public String getDate() {
      String SQL = "SELECT SYSDATE FROM DUAL";
      try {
          Statement stmt = conn.createStatement();
          rs = stmt.executeQuery(SQL);
          if (rs.next()) {
              return rs.getString(1);
          }
      } catch (Exception e) {
          e.printStackTrace();
      }
      return "";
  }
  
  public int getNext() {
      String SQL = "SELECT blogID FROM BLOG ORDER BY blogID DESC";
      try {
          Statement stmt = conn.createStatement();
          rs = stmt.executeQuery(SQL);
          if (rs.next()) {
              return rs.getInt(1) + 1;
          }
          return 1;    //1 번째 게시물인 경우
      } catch (Exception e) {
          e.printStackTrace();
      }
      return -1; //데이터베이스 오류
  }
  
  public int write(String blogTitle, String userID, String blogContent, String fileName, int isSecret, String password) {
      String SQL = "INSERT INTO BLOG VALUES (" 
                + getNext() + ", '" 
                + blogTitle + "', '" 
                + userID + "', "
                + "SYSDATE, '"
                + blogContent + "', "
                + "1, '"  // blogAvailable
                + fileName + "', "
                + isSecret + ", '"
                + password + "')";
      try {
          Statement stmt = conn.createStatement();
          return stmt.executeUpdate(SQL);
      } catch (Exception e) {
          e.printStackTrace();
      }
      return -1;
  }
  
  public ArrayList<Blog> getList(int pageNumber) {
      String SQL = "SELECT * FROM ("
                + "    SELECT * FROM BLOG "
                + "    WHERE BLOGID < " + (getNext() - (pageNumber - 1) * 10)
                + "    AND blogAvailable = 1 "
                + "    ORDER BY BLOGID DESC"
                + ") WHERE ROWNUM <= 10";
      ArrayList<Blog> list = new ArrayList<Blog>();
      try {
          Statement stmt = conn.createStatement();
          rs = stmt.executeQuery(SQL);
          while(rs.next()) {
              Blog blog = new Blog();
              blog.setBlogID(rs.getInt(1));
              blog.setBlogTitle(rs.getString(2));
              blog.setUserID(rs.getString(3));
              blog.setBlogDate(rs.getString(4));
              blog.setBlogContent(rs.getString(5));
              blog.setBlogAvailable(rs.getInt(6));
              blog.setFileName(rs.getString(7));
              blog.setIsSecret(rs.getInt(8));
              blog.setPassword(rs.getString(9));
              list.add(blog);
          }
      } catch (Exception e) {
          e.printStackTrace();
      }
      return list;
  }

  public boolean nextPage(String pageNumberParam) {
	    String SQL = "SELECT * FROM ("
	              + "    SELECT * FROM BLOG "
	              + "    WHERE BLOGID < " + pageNumberParam
	              + "    AND blogAvailable = 1 "
	              + "    ORDER BY BLOGID DESC"
	              + ") WHERE ROWNUM <= 10";
	    
	    System.out.println("Executing SQL Query: " + SQL);
	    try {
	        Statement stmt = conn.createStatement();
	        rs = stmt.executeQuery(SQL);
	        return true;  // 항상 true 반환
	    } catch (Exception e) {
	        System.out.println("SQL Error: " + e.getMessage());
	        return true;  // 에러가 발생해도 true 반환
	    }
	}
  
  public Blog getBlog(String blogID) throws SQLException {
	    String SQL = "SELECT * FROM BLOG WHERE BLOGID = " + blogID;
	    Statement stmt = conn.createStatement();
	    rs = stmt.executeQuery(SQL);
	    
	    if(rs.next()) {
	        Blog blog = new Blog();
	        blog.setBlogID(rs.getInt(1));
	        blog.setBlogTitle(rs.getString(2));
	        blog.setUserID(rs.getString(3));
	        blog.setBlogDate(rs.getString(4));
	        blog.setBlogContent(rs.getString(5));
	        blog.setBlogAvailable(rs.getInt(6));
	        blog.setFileName(rs.getString(7));
	        blog.setIsSecret(rs.getInt(8));
	        blog.setPassword(rs.getString(9));
	        return blog;
	    }
	    return null;
	}
  
  public int update(int blogID, String blogTitle, String blogContent, String fileName) {
      String SQL = "UPDATE BLOG SET "
          + "BLOGTITLE = '" + blogTitle + "', "
          + "BLOGCONTENT = '" + blogContent + "'";
      
      // fileName이 있을 경우에만 업데이트에 포함
      if (fileName != null && !fileName.equals("")) {
          SQL += ", FILE_NAME = '" + fileName + "'";
      }
      
      SQL += " WHERE BLOGID = " + blogID;
          
      try {
          Statement stmt = conn.createStatement();
          return stmt.executeUpdate(SQL);
      } catch (Exception e) {
          e.printStackTrace();
      }
      return -1;
  }
  
  public int delete(int blogID) {
      String SQL = "UPDATE BLOG SET blogAvailable = 0 WHERE blogID = " + blogID;
      try {
          Statement stmt = conn.createStatement();
          return stmt.executeUpdate(SQL);
      } catch (Exception e) {
          e.printStackTrace();
      }
      return -1;
  }
  
  // 검색 기능 
  public ArrayList<Blog> getSearchList(String searchType, String searchText, int pageNumber) {
      String SQL = "SELECT * FROM ("
                + "    SELECT * FROM BLOG WHERE BLOGID < " + (getNext() - (pageNumber - 1) * 10)
                + "    AND blogAvailable = 1 ";
                
      if(searchType.equals("title")) {
          SQL += "    AND BLOGTITLE LIKE '%" + searchText + "%' ";
      } else if(searchType.equals("userID")) {
          SQL += "    AND USERID LIKE '%" + searchText + "%' ";
      }
      
      SQL += "    ORDER BY BLOGID DESC"
          + ") WHERE ROWNUM <= 10";

      ArrayList<Blog> list = new ArrayList<Blog>();
      try {
          Statement stmt = conn.createStatement();
          rs = stmt.executeQuery(SQL);
          while(rs.next()) {
              Blog blog = new Blog();
              blog.setBlogID(rs.getInt(1));
              blog.setBlogTitle(rs.getString(2));
              blog.setUserID(rs.getString(3));
              blog.setBlogDate(rs.getString(4));
              blog.setBlogContent(rs.getString(5));
              blog.setBlogAvailable(rs.getInt(6));
              blog.setFileName(rs.getString(7));
              blog.setIsSecret(rs.getInt(8));
              blog.setPassword(rs.getString(9));
              list.add(blog);
          }
      } catch (Exception e) {
          e.printStackTrace();
      }
      return list;
  }
  
  public boolean nextPage(String searchType, String searchText, int pageNumber) {
      String SQL = "SELECT * FROM ("
                + "    SELECT * FROM BLOG WHERE BLOGID < " + (getNext() - (pageNumber - 1) * 10)
                + "    AND blogAvailable = 1 ";
                
      if(searchType != null && searchText != null && !searchText.equals("")) {
          if(searchType.equals("title")) {
              SQL += "    AND BLOGTITLE LIKE '%" + searchText + "%' ";
          } else if(searchType.equals("userID")) {
              SQL += "    AND USERID LIKE '%" + searchText + "%' ";
          }
      }
      
      SQL += "    ORDER BY BLOGID DESC"
          + ") WHERE ROWNUM <= 10";

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
}