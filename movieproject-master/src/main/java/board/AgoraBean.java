package board;

import java.sql.Date;

public class AgoraBean {
	private int agoraIdx;
	private String userId;
	private int movieIdx;
	private String agoraTitle;
	private String agoraDetail;
	private Date postedDate;
	private String filename;
	private int filesize;
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	public Date getPostedDate() {
		return postedDate;
	}
	public void setPostedDate(Date postedDate) {
		this.postedDate = postedDate;
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
	public int getMovieIdx() {
		return movieIdx;
	}
	public void setMovieIdx(int movieIdx) {
		this.movieIdx = movieIdx;
	}
	public String getAgoraTitle() {
		return agoraTitle;
	}
	public void setAgoraTitle(String agoraTitle) {
		this.agoraTitle = agoraTitle;
	}
	public String getAgoraDetail() {
		return agoraDetail;
	}
	public void setAgoraDetail(String agoraDetail) {
		this.agoraDetail = agoraDetail;
	}
}