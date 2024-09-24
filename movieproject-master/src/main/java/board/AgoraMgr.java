package board;

import java.io.File;
import java.sql.*;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import universal.*;

public class AgoraMgr {
	DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/eclipse-workspace/movieProject/src/main/webapp/board/boardfileupload/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;//20MB
	public AgoraMgr()
	{
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public Vector<AgoraBean> getAgoraList(String keyField, String keyWord)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AgoraBean> vlist=new Vector<AgoraBean>();
		try {
			con = pool.getConnection();
			sql="select * from AGORA";
			if(!(keyWord.trim().equals("")||keyWord==null))
			{
				sql+=" where "+keyField+" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			else
				pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				AgoraBean bean=new AgoraBean();
				bean.setAgoraIdx(rs.getInt(1));
				bean.setUserId(rs.getString(2));
				bean.setMovieIdx(rs.getInt(3));
				bean.setAgoraTitle(rs.getString(4));
				bean.setAgoraDetail(rs.getString(5));
				bean.setPostedDate(rs.getDate(6));
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
	public AgoraBean getAgora(int agoraIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		AgoraBean bean=new AgoraBean();
		try {
			con = pool.getConnection();
			sql = "select * from AGORA where AGORAIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, agoraIdx);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				bean.setAgoraIdx(rs.getInt(1));
				bean.setUserId(rs.getString(2));
				bean.setMovieIdx(rs.getInt(3));
				bean.setAgoraTitle(rs.getString(4));
				bean.setAgoraDetail(rs.getString(5));
				bean.setPostedDate(rs.getDate(6));
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
	public int getAgoraCount(String keyField, String keyWord)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql="select count(*) from AGORA";
			if(!(keyWord.trim().equals("")||keyWord==null))
			{
				sql+=" where "+keyField+" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			else
				pstmt = con.prepareStatement(sql);
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
	public int getCommentCount(int agoraIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from AGORADISCUSS where AGORAIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, agoraIdx);
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
	public Vector<AgoraDiscussBean> getAgoraDiscuss(int agoraIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AgoraDiscussBean> vlist=new Vector<AgoraDiscussBean>();
		try {
			con = pool.getConnection();
			sql = "select * from AGORADISCUSS where AGORAIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, agoraIdx);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				AgoraDiscussBean bean=new AgoraDiscussBean();
				bean.setDiscussIdx(rs.getInt(1));
				bean.setAgoraIdx(agoraIdx);
				bean.setUserId(rs.getString(3));
				bean.setDetail(rs.getString(4));
				bean.setPostedDate(rs.getDate(5));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public void insertAgoraDiscuss(AgoraDiscussBean bean)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert AGORADISCUSS(DISCUSSIDX, AGORAIDX, USERID, DETAIL, POSTEDDATE) values (?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getDiscussIdx());
			pstmt.setInt(2, bean.getAgoraIdx());
			pstmt.setString(3, bean.getUserId());
			pstmt.setString(4, bean.getDetail());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void deleteAgoraDiscuss(int discussIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from AGORADISCUSS where DISCUSSIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, discussIdx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void deleteAgoraDiscussAtAgora(int agoraIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from AGORADISCUSS where AGORAIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, agoraIdx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void createAgora(AgoraBean bean)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert AGORA(AGORAIDX, USERID, MOVIEIDX, AGORATITLE, AGORADETAIL, POSTEDDATE) values (?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getAgoraIdx());
			pstmt.setString(2, bean.getUserId());
			pstmt.setInt(3, bean.getMovieIdx());
			pstmt.setString(4, bean.getAgoraTitle());
			pstmt.setString(5, bean.getAgoraDetail());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	public void createAgora(HttpServletRequest req)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
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
			//////////////////////////////////////////
			con = pool.getConnection();
			sql = "insert AGORA(USERID, MOVIEIDX, AGORATITLE, AGORADETAIL, POSTEDDATE, FILENAME, FILESIZE) values (?,?,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("USERID"));
			pstmt.setString(2, multi.getParameter("MOVIEIDX"));
			pstmt.setString(3, multi.getParameter("TITLE"));
			pstmt.setString(4, content);
			pstmt.setString(5, filename);
			pstmt.setInt(6, filesize);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void deleteAgora(int agoraIdx)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			AgoraBean abean=getAgora(agoraIdx);
			String filename = abean.getFilename();
			if(filename!=null&&!filename.equals("")) {
				File f = new File(SAVEFOLDER+filename);
				if(f.exists())
					UtilMgr.delete(SAVEFOLDER+filename);
			}
			sql = "delete from AGORA where AGORAIDX = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, agoraIdx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
}