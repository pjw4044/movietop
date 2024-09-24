package user;

import java.sql.Date;

public class LikedMovieBean {
	private int likeIdx;
	private int movieIdx;
	private Date likedTime;
	private String userid;
	private String title;
	
	private String poster;
	private int birth;
	private boolean gender;
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
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
	public int getLikeIdx() {
		return likeIdx;
	}
	public void setLikeIdx(int likeIdx) {
		this.likeIdx = likeIdx;
	}
	public int getMovieIdx() {
		return movieIdx;
	}
	public void setMovieIdx(int movieIdx) {
		this.movieIdx = movieIdx;
	}
	public Date getLikedTime() {
		return likedTime;
	}
	public void setLikedTime(Date likedTime) {
		this.likedTime = likedTime;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
}
