package board;

import java.sql.Date;

public class BoardLikeBean {
	private int likeIdx;
	private int boardIdx;
	private String userId;
	private Date likedDate;
	public int getLikeIdx() {
		return likeIdx;
	}
	public void setLikeIdx(int likeIdx) {
		this.likeIdx = likeIdx;
	}
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getLikedDate() {
		return likedDate;
	}
	public void setLikedDate(Date likedDate) {
		this.likedDate = likedDate;
	}
}