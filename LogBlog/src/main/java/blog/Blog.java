package blog;

public class Blog {

	private int blogID;
	private String blogTitle;
	private String userID;
	private String blogDate;
	private String blogContent;
	private int blogAvailable;
	private String fileName;  // 추가된 필드
	private int isSecret;          // 추가
    private String password;       // 추가
	
	public int getBlogID() {
		return blogID;
	}
	public void setBlogID(int blogID) {
		this.blogID = blogID;
	}
	public String getBlogTitle() {
		return blogTitle;
	}
	public void setBlogTitle(String blogTitle) {
		this.blogTitle = blogTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBlogDate() {
		return blogDate;
	}
	public void setBlogDate(String blogDate) {
		this.blogDate = blogDate;
	}
	public String getBlogContent() {
		return blogContent;
	}
	public void setBlogContent(String blogContent) {
		this.blogContent = blogContent;
	}
	public int getBlogAvailable() {
		return blogAvailable;
	}
	public void setBlogAvailable(int blogAvailable) {
		this.blogAvailable = blogAvailable;
	}
	public String getFileName() {
        return fileName;
    }
	public void setFileName(String fileName) {
        this.fileName = fileName;
    }
	// 기존 getter/setter 유지
    public int getIsSecret() {
        return isSecret;
    }
    public void setIsSecret(int isSecret) {
        this.isSecret = isSecret;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    
    
}
