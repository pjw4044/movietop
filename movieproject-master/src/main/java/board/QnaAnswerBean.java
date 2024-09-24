package board;

import java.sql.Date;

public class QnaAnswerBean {
	private int answerIdx;
	private int qnaIdx;
	private String userId;
	private String title;
	private String detail;
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getPostedDate() {
		return postedDate;
	}
	public void setPostedDate(Date postedDate) {
		this.postedDate = postedDate;
	}
	public int getAnswerIdx() {
		return answerIdx;
	}
	public void setAnswerIdx(int answerIdx) {
		this.answerIdx = answerIdx;
	}
	public int getQnaIdx() {
		return qnaIdx;
	}
	public void setQnaIdx(int qnaIdx) {
		this.qnaIdx = qnaIdx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	
}