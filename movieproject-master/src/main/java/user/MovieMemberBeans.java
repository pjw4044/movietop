package user;

public class MovieMemberBeans {
	
	private String userid;
	private String usernn;
	private String userpwd;
	private int birth;
	private boolean gender;
	private boolean admin;
	
	public boolean isAdmin() {
		return admin;
	}
	public void setAdmin(boolean admin) {
		this.admin = admin;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsernn() {
		return usernn;
	}
	public void setUsernn(String usernn) {
		this.usernn = usernn;
	}
	public String getUserpwd() {
		return userpwd;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public int getBirth() {
		return birth;
	}
	public void setBirth(int birth) {
		this.birth = birth;
	}
	public boolean isGender() {
		return gender;
	}
	public void setGender(boolean gender) {
		this.gender = gender;
	}
	
	
	
	
}
