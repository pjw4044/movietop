package movie;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.BoardBean;
import universal.DBConnectionMgr;
import user.MovieMemberMgr;

public class MessageMgr {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp2/src/main/webapp/movieproject/fileupload/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;//20MB

	
	
	public MessageMgr() {
		pool = DBConnectionMgr.getInstance();		
	}
	//보낸 쪽지 db에 저장
	public boolean insertMessage(HttpServletRequest req, String userId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		MovieMemberMgr mgr = new MovieMemberMgr();
		boolean flag = false;
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
			String content = multi.getParameter("content");
			con = pool.getConnection();
			sql = "insert message(sender,recipient,title,content, regdate, ref) ";
			sql += "values( ?, ?, ?, ?, now(), ?)";
			pstmt = con.prepareStatement(sql);
			String takeName= multi.getParameter("takeName");
			String recipient =mgr.getUserId(takeName);
			if(recipient !=null) {
			pstmt.setString(1, userId);
			pstmt.setString(2, recipient);
			pstmt.setString(3, multi.getParameter("subject"));
			pstmt.setString(4, content);
			pstmt.setInt(5, getTotalCount(recipient)+1);
			pstmt.executeUpdate();
			flag = true;
			}else {
				flag = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//message Total Count : 총 쪽지수
		public int getTotalCount(String userId) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
					//검색이 아닌 경우
					sql = "select count(*) from message where recipient = ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, userId);
				
				rs = pstmt.executeQuery();
				if(rs.next())
					totalCount = rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
		
		//limit 시작번호, 가져올 개수
		public Vector<MessageBean> getBoardList(String userId, int start, int cnt){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MessageBean> mlist = new Vector<MessageBean>();
			MovieMemberMgr memMgr = new MovieMemberMgr();
			try {
				con = pool.getConnection();
					//검색이 아닌 경우
					sql = "select * from message where recipient = ? order by idx desc limit ?, ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, userId);
					pstmt.setInt(2, start);
					pstmt.setInt(3, cnt);
				
				rs = pstmt.executeQuery();
				//쪽지함 확인 시 닉네임으로 표기되어야함
				while(rs.next()) {
					MessageBean bean = new MessageBean();
					String sender = memMgr.getUserNm(rs.getString("sender"));
					String recipient = memMgr.getUserNm(rs.getString("recipient"));
					bean.setSender(sender);
					bean.setRecipient(recipient);
					bean.setTitle(rs.getString("title"));
					bean.setContent(rs.getString("content"));
					bean.setRegDate(rs.getString("regdate"));
					bean.setRef(rs.getInt("ref"));
					mlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return mlist;
		}
		//Board Get : 게시물 한개 읽어오기(13개 컬럼 리턴)
		public MessageBean getMessage(String userId , int idx) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MessageBean bean = new MessageBean();
			MovieMemberMgr memMgr = new MovieMemberMgr();
			
			try {
				con = pool.getConnection();
				sql = "select * from message where recipient = ? and  ref = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, userId);
				pstmt.setInt(2, idx);
				rs = pstmt.executeQuery();
				if(rs.next()) {

					bean.setIdx(rs.getInt("idx"));
					
					String sender = memMgr.getUserNm(rs.getString("sender"));
					String recipient = memMgr.getUserNm(rs.getString("recipient"));
					bean.setSender(sender);
					bean.setRecipient(recipient);	
					bean.setTitle(rs.getString("title"));
					bean.setContent(rs.getString("content"));
					bean.setRegDate(rs.getString("regDate"));
					bean.setRef(rs.getInt("ref"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
		
		
		//쪽지 삭제
		public void deleteMessage(String userId, int ref) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
		
				con = pool.getConnection();
				sql = "delete from message where ref = ? and recipient = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setString(2, userId);
				int cnt = pstmt.executeUpdate();
				minusRef(userId, ref);

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		public void minusRef(String userId, int ref) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update message set ref = ref -1 where recipient = ? and ref > ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, userId);
				pstmt.setInt(2, ref);
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
}
