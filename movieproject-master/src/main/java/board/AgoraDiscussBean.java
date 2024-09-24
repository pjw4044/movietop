package board;

import java.sql.Date;

public class AgoraDiscussBean {
	private int discussIdx;
	private int agoraIdx;
	private String userId;
	private String detail;
	private Date postedDate;
	public Date getPostedDate() {
		return postedDate;
	}
	public void setPostedDate(Date postedDate) {
		this.postedDate = postedDate;
	}
	public int getDiscussIdx() {
		return discussIdx;
	}
	public void setDiscussIdx(int discussIdx) {
		this.discussIdx = discussIdx;
	}
	public int getAgoraIdx() {
		return agoraIdx;
	}
	public void setAgoraIdx(int agoraIdx) {
		this.agoraIdx = agoraIdx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
}