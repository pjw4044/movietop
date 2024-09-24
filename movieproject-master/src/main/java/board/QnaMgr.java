package board;

import java.io.File;
import java.sql.*;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import universal.*;

public class QnaMgr {
	DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/eclipse-workspace/movieProject/src/main/webapp/board/boardfileupload/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;//20MB
	public QnaMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public Vector<QnaBoardBean> getQnaBoardList(String keyField, String keyWord)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<QnaBoardBean> vlist=new Vector<QnaBoardBean>();
		try {
			con = pool.getConnection();
			sql = "select * from QNABOARD";
			if(keyWord==null || keyWord.trim().equals(""))
				pstmt = con.prepareStatement(sql);
			else
			{
				sql+=" where "+keyField+" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				QnaBoardBean bean=new QnaBoardBean();
				bean.setQnaIdx(rs.getInt(1));
				bean.setUserId(rs.getString(2));
				bean.setTitle(rs.getString(3));
				bean.setDetail(rs.getString(4));
				bean.setPostedDate(rs.getDate(5));
				bean.setSecret(rs.getBoolean(6));
				bean.setFilename(rs.getString(7));
				bean.setFilesize(rs.getInt(8));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public int getQnaCount(String keyField, String keyWord)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from QNABOARD";
			if(keyWord==null || keyWord.trim().equals(""))
				pstmt = con.prepareStatement(sql);
			else
			{
				sql+=" where "+keyField+" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			rs = pstmt.executeQuery();
			if(rs.next())
				count=rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	public QnaBoardBean getQna(int qnaIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		QnaBoardBean bean=new QnaBoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from QNABOARD where QNAIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qnaIdx);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				bean.setQnaIdx(rs.getInt(1));
				bean.setUserId(rs.getString(2));
				bean.setTitle(rs.getString(3));
				bean.setDetail(rs.getString(4));
				bean.setPostedDate(rs.getDate(5));
				bean.setSecret(rs.getBoolean(6));
				bean.setFilename(rs.getString(7));
				bean.setFilesize(rs.getInt(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	public void insertQna(QnaBoardBean bean)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert QNABOARD(QNAIDX, USERID, TITLE, DETAIL) values (?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getQnaIdx());
			pstmt.setString(2, bean.getUserId());
			pstmt.setString(3, bean.getTitle());
			pstmt.setString(4, bean.getDetail());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void insertQna(HttpServletRequest req)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()/*존재하지 않는다면*/)
				dir.mkdirs();//상위폴더가 없어도 생성
				//mkdir : 상위폴더가 없으면 생성불가
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
							ENCODING, new DefaultFileRenamePolicy());
			String filename = null;
			int filesize = 0;
			if(multi.getFilesystemName("filename")!=null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			String content = multi.getParameter("DETAIL");
			String contentType = multi.getParameter("contentType");
			if(contentType.equals("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			String secretTest=multi.getParameter("ISSECRET");
			sql = "insert QNABOARD(USERID, TITLE, DETAIL, POSTEDDATE, ISSECRET, FILENAME, FILESIZE) values (?,?,?,now(),?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("USERID"));
			pstmt.setString(2, multi.getParameter("TITLE"));
			pstmt.setString(3, content);
			pstmt.setBoolean(4, (secretTest!=null && secretTest.equals("true")));
			pstmt.setString(5, filename);
			pstmt.setInt(6, filesize);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void deleteQna(int qnaIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			QnaBoardBean bean=getQna(qnaIdx);
			String filename = bean.getFilename();
			if(filename!=null&&!filename.equals("")) {
				File f = new File(SAVEFOLDER+filename);
				if(f.exists())
					UtilMgr.delete(SAVEFOLDER+filename);
			}
			sql = "delete from QNABOARD where QNAIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qnaIdx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public boolean hasAnswer(int qnaIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select * from QNAANSWER where QNAIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qnaIdx);
			rs = pstmt.executeQuery();
			if(rs.next())
				flag=true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	public QnaAnswerBean getAnswer(int qnaIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		QnaAnswerBean bean=new QnaAnswerBean();
		try {
			con = pool.getConnection();
			sql = "select * from QNAANSWER where QNAIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qnaIdx);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				bean.setAnswerIdx(rs.getInt(1));
				bean.setQnaIdx(qnaIdx);
				bean.setUserId(rs.getString(3));
				bean.setTitle(rs.getString(4));
				bean.setDetail(rs.getString(5));
				bean.setPostedDate(rs.getDate(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	public void insertAnswer(QnaAnswerBean bean)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert QNAANSWER(QNAIDX, ADMINID, TITLE, DETAIL) values (?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getQnaIdx());
			pstmt.setString(2, bean.getUserId());
			pstmt.setString(3, bean.getTitle());
			pstmt.setString(4, bean.getTitle());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void insertAnswer(HttpServletRequest req)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()/*존재하지 않는다면*/)
				dir.mkdirs();//상위폴더가 없어도 생성
				//mkdir : 상위폴더가 없으면 생성불가
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
							ENCODING, new DefaultFileRenamePolicy());
			String content = multi.getParameter("DETAIL");
			String contentType = multi.getParameter("contentType");
			if(contentType.equals("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			sql = "insert QNAANSWER(QNAIDX, USERID, TITLE, DETAIL, POSTEDDATE) values (?,?,?,?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("QNAIDX"));
			pstmt.setString(2, multi.getParameter("USERID"));
			pstmt.setString(3, multi.getParameter("TITLE"));
			pstmt.setString(4, content);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void updateAnswer(HttpServletRequest req)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()/*존재하지 않는다면*/)
				dir.mkdirs();//상위폴더가 없어도 생성
				//mkdir : 상위폴더가 없으면 생성불가
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
							ENCODING, new DefaultFileRenamePolicy());
			String content = multi.getParameter("DETAIL");
			String contentType = multi.getParameter("contentType");
			if(contentType.equals("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			sql = "update QNAANSWER set TITLE = ?, DETAIL = ?, POSTEDDATE = now() where QNAIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("TITLE"));
			pstmt.setString(2, content);
			pstmt.setString(3, multi.getParameter("orignum"));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}